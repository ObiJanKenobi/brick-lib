import 'dart:io';

import 'package:brick_lib/logger.dart';
import 'package:brick_lib/model/rebrickable_color.dart';
import 'package:brick_lib/model/rebrickable_part.dart';
import 'package:brick_lib/model/rebrickable_part_category.dart';
import 'package:brick_lib/model/rebrickable_part_list.dart';
import 'package:brick_lib/model/rebrickable_set.dart';
import 'package:brick_lib/model/rebrickable_moc.dart';
import 'package:brick_lib/request/AddUserSet.dart';
import 'package:brick_lib/request/GetBuildMatch.dart';
import 'package:brick_lib/request/GetColors.dart';
import 'package:brick_lib/request/GetPartCategories.dart';
import 'package:brick_lib/request/GetPartColor.dart';
import 'package:brick_lib/request/GetPartDetail.dart';
import 'package:brick_lib/request/GetPartDetailFromList.dart';
import 'package:brick_lib/request/GetPartsInList.dart';
import 'package:brick_lib/request/GetSetAlternates.dart';
import 'package:brick_lib/request/GetSetParts.dart';
import 'package:brick_lib/request/GetUserPartLists.dart';
import 'package:brick_lib/request/GetUserPartsByPartNum.dart';
import 'package:brick_lib/request/GetUserSets.dart';
import 'package:brick_lib/request/SearchSets.dart';
import 'package:brick_lib/request/login_request.dart';
import 'package:brick_lib/request/request.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../model/rebrickable_part_list_item.dart';

class RebrickableService {
  final Logger log = getLogger("RebrickableService");

  static final excludedPartCategories = [42, 4, 45, 50, 41, 62, 64, 63, 66, 57, 17, 24, 43];
  static final excludedColors = [
    1134,
    1133,
    1132,
    1131,
    1130,
    1129,
    1128,
    1127,
    1126,
    1125,
    1124,
    1123,
    1122,
    1121,
    1120,
    1119,
    1118,
    1117,
    1116,
    1115,
    1114,
    1113,
    1112,
    1111,
    1110,
    1109,
    1108,
    1107,
    1106,
    1105,
    1104,
    1090,
    1087,
    1078,
    1075,
    1076,
    1079,
    1101,
    1074,
    450,
    1077,
    1012,
    1064,
    1032,
    1018,
    1021,
    1022,
    1016,
    1039,
    1044,
    1040,
    1042,
    1045,
    1041,
    1043,
    1049,
    1047,
    1046,
    1048,
    1029,
    1014,
    1015,
    1026,
    1027,
    1035,
    1028,
    1031,
    1025,
    1036,
    1030,
    1038,
    1024,
    1023,
    1033,
    1020,
    1034,
    1019,
    1017,
    1037,
    1013,
  ];

  String? _userToken;

  String? get userToken => _userToken;

  bool get loggedIn => _userToken != null;

  void restoreToken(String token) {
    _userToken = token;
  }

  void logout() {
    _userToken = null;
  }

  Future<String?> login(username, password) async {
    log.i("Getting usertoken");
    try {
      final String? token = await LoginRequest(username, password).send();

      if (token == null) {
        throw Error();
      }
      _userToken = token;

      return token;
    } catch (e) {
      log.e(e.toString());
    }
    return null;
  }

  Future<RebrickablePart?> getPartDetail(String partNum) async {
    log.i("Getting part detail for $partNum");
    try {
      final RebrickablePart? part = await GetPartDetail(partNum).send();

      return part;
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  Future<List<RebrickablePart>?> getPartsDetail(List<String> parts) async {
    try {
      final results = await GetPartDetailFromList(parts).send();

      return results;
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  Future<List<RebrickablePartList>?> getUserPartLists() async {
    assert(_userToken != null);
    try {
      final results = await GetUserPartLists(_userToken!).send();

      return results;
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  Future<List<RebrickablePartListItem>?> getUserParts({
    String? partNum,
    String? colorId,
    int? partCategoryId,
    void Function(int page, int itemsSoFar, bool hasMore)? onPage,
  }) async {
    assert(_userToken != null);
    final all = <RebrickablePartListItem>[];
    var page = 1;
    while (true) {
      try {
        final result = await _retry(() => GetUserPartsByPartNum(
              _userToken!,
              part: partNum,
              colorId: colorId,
              partCategoryId: partCategoryId,
              page: page,
            ).send());
        if (result == null) return null;
        all.addAll(result.items);
        onPage?.call(page, all.length, result.hasNext);
        if (!result.hasNext) break;
        page++;
      } catch (e) {
        log.e(e);
        return all.isEmpty ? null : all;
      }
    }
    return all;
  }

  static const _defaultSpacing = Duration(milliseconds: 250);
  DateTime? _lastRequestAt;

  Future<void> _throttle(Duration spacing) async {
    final now = DateTime.now();
    if (_lastRequestAt != null) {
      final sinceLast = now.difference(_lastRequestAt!);
      if (sinceLast < spacing) {
        await Future.delayed(spacing - sinceLast);
      }
    }
    _lastRequestAt = DateTime.now();
  }

  Future<T?> _retry<T>(
    Future<T?> Function() fn, {
    int attempts = 5,
    Duration spacing = _defaultSpacing,
  }) async {
    Object? last;
    for (var i = 0; i < attempts; i++) {
      await _throttle(spacing);
      try {
        return await fn();
      } catch (e) {
        last = e;
        final msg = e.toString();
        final isRateLimit = msg.contains('429') || msg.contains('Too Many Requests');
        log.w('Request failed (attempt ${i + 1}/$attempts)${isRateLimit ? " [rate limited]" : ""}: $e');
        if (i < attempts - 1) {
          final baseMs = isRateLimit ? 2000 : 500;
          await Future.delayed(Duration(milliseconds: baseMs * (1 << i)));
        }
      }
    }
    throw last ?? Exception('retry exhausted');
  }

  Future<List<RebrickableUserSet>> getUserSets() async {
    assert(_userToken != null);
    final all = <RebrickableUserSet>[];
    var page = 1;
    while (true) {
      final result = await _retry(() => GetUserSets(_userToken!, page: page).send());
      if (result == null) break;
      all.addAll(result.items);
      if (!result.hasNext) break;
      page++;
    }
    return all;
  }

  /// Alternate builds for a set - MOCs whose parts are all contained in it.
  ///
  /// Note there is no MOC inventory endpoint in the API, so the parts of an
  /// alternate cannot be imported automatically; [RebrickableMoc.mocUrl] is the
  /// way to reach the part list.
  Future<List<RebrickableMoc>> getSetAlternates(String setNum) async {
    final all = <RebrickableMoc>[];
    var page = 1;
    while (true) {
      final result = await _retry(() => GetSetAlternates(setNum, page: page).send());
      if (result == null) break;
      all.addAll(result.items);
      if (!result.hasNext) break;
      page++;
    }
    return all;
  }

  /// Rebrickable's Build Match for [setNum] against the user's whole
  /// collection. Returns null when unavailable (not logged in, or the endpoint
  /// rejects a MOC number) - callers should treat that as "unknown", not an
  /// error.
  Future<BuildMatch?> getBuildMatch(String setNum) async {
    if (_userToken == null) return null;
    try {
      return await GetBuildMatch(_userToken!, setNum).send();
    } catch (e) {
      log.w('getBuildMatch($setNum) unavailable: $e');
      return null;
    }
  }

  /// Reads a single set out of the user's collection, or null if it is not in
  /// there. Cheaper than [getUserSets] when only one set is of interest.
  Future<RebrickableUserSet?> getUserSet(String setNum) async {
    assert(_userToken != null);
    final result = await _retry(
      () => GetUserSets(_userToken!, setNum: setNum, pageSize: 1).send(),
    );
    return result?.items.firstOrNull;
  }

  /// Searches the set catalogue by number or name. Returns an empty list
  /// rather than throwing, so a typo in a search box is not an error state.
  Future<List<RebrickableSet>> searchSets(String query, {int pageSize = 30}) async {
    if (query.trim().isEmpty) return [];
    try {
      final results = await _retry(() => SearchSets(query.trim(), pageSize: pageSize).send());
      return results ?? [];
    } catch (e) {
      log.w('searchSets("$query") failed: $e');
      return [];
    }
  }

  /// Adds [setNum] to the logged-in user's Rebrickable collection.
  ///
  /// Throws if the call fails, so callers can surface the reason - unlike the
  /// read paths, a silent failure here would leave the user thinking the set
  /// was added.
  Future<void> addUserSet(
    String setNum, {
    int quantity = 1,
    bool includeSpares = true,
  }) async {
    assert(_userToken != null);
    // Deliberately not routed through _retry: this POST is not idempotent -
    // adding a set already in the collection bumps its quantity - so retrying
    // a call that timed out after the server had created it would add twice.
    await _throttle(_defaultSpacing);
    final ok = await AddUserSet(
      _userToken!,
      setNum,
      quantity: quantity,
      includeSpares: includeSpares,
    ).send();
    if (ok != true) {
      throw StateError('Adding $setNum to the Rebrickable collection failed');
    }
  }

  Future<PartColorInfo?> getPartColor(String partNum, int colorId) async {
    try {
      return await _retry(() => GetPartColor(partNum, colorId).send());
    } catch (e) {
      log.w('getPartColor($partNum, $colorId) failed: $e');
      return null;
    }
  }

  Future<List<RebrickablePartListItem>> getSetParts(String setNum) async {
    final all = <RebrickablePartListItem>[];
    var page = 1;
    while (true) {
      final result = await _retry(
        () => GetSetParts(setNum, page: page).send(),
        spacing: const Duration(milliseconds: 500),
      );
      if (result == null) break;
      all.addAll(result.items);
      if (!result.hasNext) break;
      page++;
    }
    return all;
  }

  Future<List<RebrickablePartListItem>> getPartListItems(int listId) async {
    assert(_userToken != null);
    final all = <RebrickablePartListItem>[];
    var page = 1;
    while (true) {
      final result = await _retry(() => GetPartsInList(_userToken!, listId, page: page).send());
      if (result == null) break;
      all.addAll(result.items);
      if (!result.hasNext) break;
      page++;
    }
    return all;
  }

  Future<List<RebrickablePartCategory>> getPartCategories() async {
    try {
      final results = await GetPartCategories().send();

      return results!.whereNot((e) => excludedPartCategories.contains(e.id)).toList();
    } catch (e) {
      log.e(e);
      return [];
    }
  }

  Future<List<RebrickableColor>> getColors() async {
    try {
      final results = await GetColors().send();

      return results!.whereNot((e) => excludedColors.contains(e.id)).toList();
    } catch (e) {
      log.e(e);
      return [];
    }
  }
}
