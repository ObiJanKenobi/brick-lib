import 'package:brick_lib/model/rebrickable_part_list_item.dart';
import 'package:brick_lib/request/request.dart';
import 'package:dio/dio.dart';

class GetSetPartsResult {
  GetSetPartsResult(this.items, this.hasNext);
  final List<RebrickablePartListItem> items;
  final bool hasNext;
}

class GetSetParts extends Request<GetSetPartsResult?> {
  @override
  String get path => '/lego/sets/$setNum/parts/';

  @override
  Map<String, dynamic>? get queryParams => {"page": page, "page_size": pageSize, "inc_color_details": 1};

  final String setNum;
  final int page;
  final int pageSize;

  GetSetParts(this.setNum, {this.page = 1, this.pageSize = 1000});

  @override
  GetSetPartsResult? handleResponse(Response response) {
    final List<dynamic> results = response.data?["results"] ?? [];
    final next = response.data?["next"];
    final items = results.map((e) => RebrickablePartListItem.fromJson(e as Map<String, dynamic>)).toList();
    return GetSetPartsResult(items, next != null);
  }
}
