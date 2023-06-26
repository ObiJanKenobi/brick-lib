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
    for (var i = 0; i < content.length; i++) {
      //
      if (i == 0) {
        continue;
      }

      final line = content[i];
      final parts = line.split(",");

      if (line.isEmpty || parts.isEmpty) continue;

      final item = BrickPart(
          part: parts[0],
          color: parts[1],
          quantity: int.parse(parts[2]),
          colorName: "",
          gobricksColor: "",
          bricklinkColor: "",
          bricklinkId: "",
          rgb: "FFFFFF",
          goBrickPart: "",
          name: "");

      if (legoToGoBricksMap.containsKey(item.part)) {
        item.goBrickPart = legoToGoBricksMap[item.part]!;
      }
      BrickColor? color;

      try {
        color = colors.firstWhere((clr) => clr.rebrickableColor == item.color);
      } catch (e) {
        print(e);
      }

      if (color != null) {
        item.colorName = color.name;
        item.gobricksColor = color.legoColor;
        item.bricklinkColor = color.bricklinkColor;
        item.rgb = color.rgb;
      }

      parsed.add(item);
    }

    await _fetchDetails(parsed);

    return parsed;
  }

  List<String> exportParts(List<BrickPart> parts) {
    final list = parts.map((e) => "${e.part},${e.color},${e.quantity}").toList();
    list.insert(0, HEADER_PARTS);
    return list;
  }

  _loadColors() async {
    String data = await rootBundle.loadString('packages/brick_lib/assets/color_table.csv');
    List<String> contentColors = data.split("\r\n");

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
    List<String> bricks = data.split("\r\n");

    // Build gobricks map
    for (var i = 0; i < bricks.length; i++) {
      final line = bricks[i];
      if (line.isEmpty) continue;
      final parts = line.split(",");

      legoToGoBricksMap[parts[0]] = parts[1];
    }
  }

  _fetchDetails(List<BrickPart> parts) async {
    final rbIds = parts.map((e) => e.part).toList();
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
