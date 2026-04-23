import 'package:brick_lib/model/rebrickable_part_list_item.dart';
import 'package:brick_lib/request/request.dart';
import 'package:dio/dio.dart';

class GetUserPartsResult {
  GetUserPartsResult(this.items, this.hasNext);
  final List<RebrickablePartListItem> items;
  final bool hasNext;
}

class GetUserPartsByPartNum extends Request<GetUserPartsResult?> {
  @override
  String get path => '/users/$userToken/allparts/';

  @override
  get queryParams => {
        "part_num": part,
        // Rebrickable's /allparts endpoint only accepts ONE color_id. Pass multiples
        // via separate calls and merge; see RebrickableService.getUserParts.
        'color_id': colorId,
        'part_cat_id': partCategoryId,
        'page': page,
        'page_size': pageSize,
      };

  final String userToken;
  final String? part;
  final int? partCategoryId;
  final String? colorId;
  final int page;
  final int pageSize;

  GetUserPartsByPartNum(
    this.userToken, {
    this.part,
    this.colorId,
    this.partCategoryId,
    this.page = 1,
    this.pageSize = 1000,
  });

  @override
  GetUserPartsResult? handleResponse(Response response) {
    final List<dynamic> results = response.data?["results"] ?? [];
    final next = response.data?["next"];
    final items = results.map((e) => RebrickablePartListItem.fromJson(e as Map<String, dynamic>)).toList();
    return GetUserPartsResult(items, next != null);
  }
}
