import 'package:brick_lib/model/rebrickable_part_list.dart';
import 'package:brick_lib/model/rebrickable_part_list_item.dart';
import 'package:brick_lib/request/request.dart';
import 'package:dio/dio.dart';

class GetUserPartsByPartNum extends Request<List<RebrickablePartListItem>?> {
  @override
  String get path => '/users/$userToken/allparts/';

  @override
  get queryParams => {"part_num": part, 'color_id': colorId?.join(","), 'part_cat_id': partCategoryId};

  final String userToken;
  final String? part;
  final int? partCategoryId;
  final List<String>? colorId;

  GetUserPartsByPartNum(this.userToken, {this.part, this.colorId, this.partCategoryId});

  @override
  List<RebrickablePartListItem>? handleResponse(Response response) {
    final List<dynamic> results = response.data?["results"];
    return results.map((e) => RebrickablePartListItem.fromJson(e as Map<String, dynamic>)).toList() ?? [];
  }
}
