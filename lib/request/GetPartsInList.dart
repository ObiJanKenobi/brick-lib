import 'package:brick_lib/model/rebrickable_part_list_item.dart';
import 'package:brick_lib/request/request.dart';
import 'package:dio/dio.dart';

class GetPartsInList extends Request<List<RebrickablePartListItem>?> {
  @override
  String get path => '/users/$userToken/partlists/$listId/parts/';

  @override
  // TODO: implement queryParams
  Map<String, dynamic>? get queryParams => {"page_size": pageSize, "inc_color_details": 0};

  final int pageSize;
  final String userToken;
  final int listId;

  GetPartsInList(this.userToken, this.listId, {this.pageSize = 1000});

  @override
  List<RebrickablePartListItem>? handleResponse(Response response) {
    final List<dynamic> results = response.data?["results"];
    return results.map((e) => RebrickablePartListItem?.fromJson(e as Map<String, dynamic>)).toList() ?? [];
  }
}
