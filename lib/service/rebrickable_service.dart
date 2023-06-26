import 'dart:io';

import 'package:brick_lib/logger.dart';
import 'package:brick_lib/model/rebrickable_part.dart';
import 'package:brick_lib/model/rebrickable_part_list.dart';
import 'package:brick_lib/request/GetPartDetail.dart';
import 'package:brick_lib/request/GetPartDetailFromList.dart';
import 'package:brick_lib/request/GetUserPartLists.dart';
import 'package:brick_lib/request/login_request.dart';
import 'package:brick_lib/request/request.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class RebrickableService {
  final Logger log = getLogger("RebrickableService");

  Future<String?> login(username, password) async {
    log.i("Getting usertoken");
    try {
      final String? token = await LoginRequest(username, password).send();

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

  Future<List<RebrickablePartList>?> getUserPartLists(String userToken) async {
    try {
      final results = await GetUserPartLists(userToken).send();

      return results;
    } catch (e) {
      log.e(e);
      return null;
    }
  }
}
