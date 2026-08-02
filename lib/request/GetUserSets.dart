import 'package:brick_lib/model/rebrickable_set.dart';
import 'package:brick_lib/request/request.dart';
import 'package:dio/dio.dart';

class GetUserSetsResult {
  GetUserSetsResult(this.items, this.hasNext);
  final List<RebrickableUserSet> items;
  final bool hasNext;
}

class GetUserSets extends Request<GetUserSetsResult?> {
  @override
  String get path => '/users/$userToken/sets/';

  @override
  Map<String, dynamic>? get queryParams => {
        "page": page,
        "page_size": pageSize,
        if (setNum != null) "set_num": setNum,
      };

  final String userToken;
  final int page;
  final int pageSize;

  /// Restricts the result to a single set. Used to read back a set's real
  /// quantity right after adding it, instead of pulling the whole collection.
  final String? setNum;

  GetUserSets(this.userToken, {this.page = 1, this.pageSize = 500, this.setNum});

  @override
  GetUserSetsResult? handleResponse(Response response) {
    final List<dynamic> results = response.data?["results"] ?? [];
    final next = response.data?["next"];
    final items = results.map((e) => RebrickableUserSet.fromJson(e as Map<String, dynamic>)).toList();
    return GetUserSetsResult(items, next != null);
  }
}
