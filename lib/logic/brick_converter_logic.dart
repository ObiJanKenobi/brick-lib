import 'dart:async';
import 'dart:io';

import 'package:brick_lib/logger.dart';
import 'package:brick_lib/model/brick_color.dart';
import 'package:brick_lib/model/brick_part.dart';
import 'package:brick_lib/service/rebrickable_service.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:collection/collection.dart';

const String HEADER_PARTS = "Part,Color,Quantity";
const String HEADER_STUDIO = "BLItemNo,ElementId,LdrawId";

class BrickConverterLogic {
  final Logger log = getLogger("BrickConverterLogic");
  late List<BrickColor> _colors;

  RebrickableService get service => GetIt.I.get<RebrickableService>();

  List<BrickColor> get colors => _colors;

  Map<String, String> legoToGoBricksMap = {};

  Future<void> load() async {
    await _loadColors();
    await _loadGoBricks();
  }

  Future<List<BrickPart>> parseParts(List<String> content) async {
    final List<BrickPart> parsed = [];
    if (content.isEmpty) return parsed;

    final header = content.first.trim();
    final isStudio = header.startsWith(HEADER_STUDIO);

    for (var i = 1; i < content.length; i++) {
      final line = content[i];
      if (line.trim().isEmpty) continue;

      final fields = _parseCsvLine(line);
      if (fields.isEmpty) continue;

      final BrickPart? item =
          isStudio ? _parseStudioRow(fields) : _parseRebrickableRow(fields);
      if (item == null) continue;

      parsed.add(item);
    }

    await _enrich(parsed);

    return parsed;
  }

  /// Applies the GoBricks mapping and colour metadata to every part, then
  /// fetches Rebrickable details in a single batch. Shared by the CSV and
  /// LDraw ([parseLdr]) import paths.
  Future<void> _enrich(List<BrickPart> parsed) async {
    for (final item in parsed) {
      if (legoToGoBricksMap.containsKey(item.part)) {
        item.goBrickPart = legoToGoBricksMap[item.part]!;
      }
      _applyColorMetadata(item);
    }

    await _fetchDetails(parsed);
  }

  /// Parses a LEGO Studio / LDraw model into a flat, de-duplicated part list.
  ///
  /// [lines] are the contents of an LDraw file — typically `model.ldr` pulled
  /// out of a Studio `.io` archive. That file is an MPD: a main model plus
  /// named submodels, each introduced by a `0 FILE <name>` line. Submodels can
  /// be placed more than once, so quantities are multiplied as they expand.
  /// LDraw colour 16 ("inherit") on a part resolves to the colour the submodel
  /// was placed with.
  ///
  /// LDraw part numbers and colour ids line up with Rebrickable's — the same
  /// assumption the Studio-CSV path already makes (see [_parseStudioRow]) — so
  /// the flattened parts feed straight into the shared [_enrich] step.
  Future<List<BrickPart>> parseLdr(List<String> lines) async {
    final counts = _expandLdr(lines);

    final parsed = <BrickPart>[];
    counts.forEach((key, qty) {
      final sep = key.lastIndexOf('|');
      parsed.add(BrickPart(
        part: key.substring(0, sep),
        color: key.substring(sep + 1),
        quantity: qty,
        colorName: "No Color/Any Color",
        gobricksColor: "",
        bricklinkColor: "",
        bricklinkId: "",
        rgb: "FFFFFF",
        goBrickPart: "",
        name: "",
      ));
    });

    await _enrich(parsed);

    return parsed;
  }

  // Splits an LDraw MPD document into named subfiles, then expands the main
  // model into a {"<part>|<color>": quantity} map. Part+colour is the key
  // because a single design appears in many colours across a build.
  Map<String, int> _expandLdr(List<String> lines) {
    final subfiles = <String, List<String>>{};
    final order = <String>[];
    String? current;

    for (final raw in lines) {
      final line = raw.replaceFirst('﻿', '').trim();
      if (line.toLowerCase().startsWith('0 file ')) {
        // Submodel names are matched case-insensitively: Studio is inconsistent
        // about casing between the FILE header and the reference to it.
        current = line.substring(7).trim().toLowerCase();
        subfiles[current] = [];
        order.add(current);
      } else if (current != null) {
        subfiles[current]!.add(line);
      }
    }

    // A plain, single-model .ldr with no FILE headers: treat the whole file as
    // the model.
    if (order.isEmpty) {
      final body = lines.map((l) => l.replaceFirst('﻿', '').trim()).toList();
      subfiles['__main__'] = body;
      order.add('__main__');
    }

    final counts = <String, int>{};

    void expand(String name, String parentColor, int multiplier, Set<String> stack) {
      final body = subfiles[name];
      if (body == null || stack.contains(name)) return; // guard cyclic refs
      final nextStack = {...stack, name};

      for (final line in body) {
        if (!line.startsWith('1 ')) continue;
        final f = line.split(RegExp(r'\s+'));
        // 1 <colour> x y z + 9-element rotation matrix + <file> = 15 tokens.
        if (f.length < 15) continue;

        // Colour 16 means "inherit from the placing submodel".
        final color = f[1] == '16' ? parentColor : f[1];
        // The referenced file is the last field; join in case of spaces.
        final ref = f.sublist(14).join(' ').trim();
        final refKey = ref.toLowerCase();

        if (subfiles.containsKey(refKey)) {
          expand(refKey, color, multiplier, nextStack);
        } else {
          final partNum = _ldrPartNumber(ref);
          if (partNum.isEmpty) continue;
          final key = '$partNum|$color';
          counts[key] = (counts[key] ?? 0) + multiplier;
        }
      }
    }

    expand(order.first, '16', 1, <String>{});

    return counts;
  }

  // "s\3069b.dat" -> "3069b": drops any directory prefix and a trailing
  // .dat/.ldr extension.
  String _ldrPartNumber(String ref) {
    var name = ref.replaceAll('\\', '/');
    final slash = name.lastIndexOf('/');
    if (slash != -1) name = name.substring(slash + 1);
    final lower = name.toLowerCase();
    if (lower.endsWith('.dat') || lower.endsWith('.ldr')) {
      name = name.substring(0, name.length - 4);
    }
    return name.trim();
  }

  BrickPart? _parseRebrickableRow(List<String> fields) {
    if (fields.length < 3) return null;
    return BrickPart(
        part: fields[0],
        color: fields[1],
        quantity: int.parse(fields[2]),
        colorName: "No Color/Any Color",
        gobricksColor: "",
        bricklinkColor: "",
        bricklinkId: "",
        rgb: "FFFFFF",
        goBrickPart: "",
        name: "");
  }

  // Studio CSV columns:
  // 0:BLItemNo 1:ElementId 2:LdrawId 3:PartName 4:BLColorId
  // 5:LDrawColorId 6:ColorName 7:ColorCategory 8:Qty 9:Weight
  BrickPart? _parseStudioRow(List<String> fields) {
    if (fields.length < 9) return null;
    final ldrawId = fields[2].trim();
    // Skip trailing "Total qty" / blank summary rows that have no LdrawId.
    if (ldrawId.isEmpty) return null;

    final partNum = ldrawId.toLowerCase().endsWith('.dat')
        ? ldrawId.substring(0, ldrawId.length - 4)
        : ldrawId;

    final qtyStr = fields[8].trim();
    final qty = int.tryParse(qtyStr);
    if (qty == null) return null;

    String colorId = fields[5].trim();
    // Fallback: if LDraw id isn't a known Rebrickable color, try mapping
    // through the BL color id via the color table.
    if (!_colors.any((c) => c.rebrickableColor == colorId)) {
      final blColorId = fields[4].trim();
      final mapped = _colors.firstWhereOrNull((c) => c.bricklinkColor == blColorId);
      if (mapped != null) colorId = mapped.rebrickableColor;
    }

    return BrickPart(
        part: partNum,
        color: colorId,
        quantity: qty,
        colorName: fields[6].isNotEmpty ? fields[6] : "No Color/Any Color",
        gobricksColor: "",
        bricklinkColor: fields[4],
        bricklinkId: fields[0],
        rgb: "FFFFFF",
        goBrickPart: "",
        name: fields[3]);
  }

  void _applyColorMetadata(BrickPart item) {
    final color = colors.firstWhereOrNull((clr) => clr.rebrickableColor == item.color);
    if (color != null) {
      item.colorName = color.name;
      item.gobricksColor = color.legoColor;
      item.bricklinkColor = color.bricklinkColor;
      item.rgb = color.rgb;
    }
  }

  // Minimal RFC-4180-ish CSV row parser: handles "" escapes and commas inside
  // double-quoted fields. Does not handle embedded newlines, which Studio's
  // export does not produce.
  List<String> _parseCsvLine(String line) {
    final out = <String>[];
    final buf = StringBuffer();
    var inQuotes = false;
    for (var i = 0; i < line.length; i++) {
      final ch = line[i];
      if (inQuotes) {
        if (ch == '"') {
          if (i + 1 < line.length && line[i + 1] == '"') {
            buf.write('"');
            i++;
          } else {
            inQuotes = false;
          }
        } else {
          buf.write(ch);
        }
      } else {
        if (ch == ',') {
          out.add(buf.toString());
          buf.clear();
        } else if (ch == '"' && buf.isEmpty) {
          inQuotes = true;
        } else {
          buf.write(ch);
        }
      }
    }
    out.add(buf.toString());
    return out;
  }

  List<String> exportParts(List<BrickPart> parts) {
    final list = parts.map((e) => "${e.part},${e.color},${e.quantity}").toList();
    list.insert(0, HEADER_PARTS);
    return list;
  }

  _loadColors() async {
    String data = await rootBundle.loadString('packages/brick_lib/assets/color_table.csv');
    List<String> contentColors = data.split("\n");

    _colors = [];

    for (var i = 0; i < contentColors.length; ++i) {
      if (i == 0) continue;
      final line = contentColors[i];
      if (line.isEmpty) continue;
      final parts = line.split(",");

      final color = BrickColor(
          legoColor: parts[0],
          bricklinkColor: parts[1],
          rebrickableColor: parts[2],
          goBrickColor: parts[3],
          lddName: parts[4],
          name: parts[5],
          rgb: parts[6]);
      _colors.add(color);
    }
  }

  _loadGoBricks() async {
    String data = await rootBundle.loadString('packages/brick_lib/assets/gobrick_conversion_table.csv');
    List<String> bricks = data.split("\n");

    // Build gobricks map
    for (var i = 0; i < bricks.length; i++) {
      final line = bricks[i];
      if (line.isEmpty) continue;
      final parts = line.split(",");

      legoToGoBricksMap[parts[0]] = parts[1];
    }
  }

  _fetchDetails(List<BrickPart> parts) async {
    final rbIds = parts.map((e) => e.part!).toList();
    final details = await service.getPartsDetail(rbIds);

    details?.forEach((detail) {
      final partsForDetail = parts.where((e) => e.part == detail.partNum).toList();
      if (detail.externalIds["BrickLink"] != null && partsForDetail?.isNotEmpty == true) {
        partsForDetail.forEach((part) {
          part.details = detail;
          part.name = detail.name;
          part.bricklinkId = detail.externalIds["BrickLink"][0];
        });
      }
    });
  }
}
