import 'package:brick_lib/model/rebrickable_set.dart';
import 'package:brick_lib/request/request.dart';
import 'package:dio/dio.dart';

/// Full-text search over the Rebrickable set catalogue.
///
/// `search` matches both set numbers and names, so "75192" and "millennium
/// falcon" both work. This is catalogue data, not user data — it needs the API
/// key only, no user token.
class SearchSets extends Request<List<RebrickableSet>> {
  @override
  String get path => '/lego/sets/';

  @override
  Map<String, dynamic>? get queryParams => {
        'search': query,
        'page_size': pageSize,
        'ordering': '-year',
      };

  final String query;
  final int pageSize;

  SearchSets(this.query, {this.pageSize = 30});

  @override
  List<RebrickableSet> handleResponse(Response response) {
    final List<dynamic> results = response.data?['results'] ?? [];
    return results
        .map((e) => RebrickableSet.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
