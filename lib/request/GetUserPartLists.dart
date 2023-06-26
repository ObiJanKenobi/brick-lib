import 'package:brick_lib/model/rebrickable_part_list.dart';
import 'package:brick_lib/request/request.dart';
import 'package:dio/dio.dart';

class GetUserPartLists extends Request<List<RebrickablePartList>?> {
  @override
  String get path => '/users/$userToken/partlists/';

  final String userToken;

  GetUserPartLists(this.userToken);

  @override
  List<RebrickablePartList>? handleResponse(Response response) {
    final List<dynamic> results = response.data?["results"];
    return results.map((e) => RebrickablePartList.fromJson(e as Map<String, dynamic>)).toList() ?? [];
  }
}
