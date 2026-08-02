import 'package:brick_lib/model/rebrickable_moc.dart';
import 'package:brick_lib/request/request.dart';
import 'package:dio/dio.dart';

class GetSetAlternatesResult {
  GetSetAlternatesResult(this.items, this.hasNext);
  final List<RebrickableMoc> items;
  final bool hasNext;
}

/// MOCs that are alternate builds of a set - "all parts in the MOC can be
/// found in the Set". Catalogue data, so the API key alone is enough.
class GetSetAlternates extends Request<GetSetAlternatesResult?> {
  @override
  String get path => '/lego/sets/$setNum/alternates/';

  @override
  Map<String, dynamic>? get queryParams => {
        "page": page,
        "page_size": pageSize,
        "ordering": "-num_parts",
      };

  final String setNum;
  final int page;
  final int pageSize;

  GetSetAlternates(this.setNum, {this.page = 1, this.pageSize = 100});

  @override
  GetSetAlternatesResult? handleResponse(Response response) {
    final List<dynamic> results = response.data?["results"] ?? [];
    final next = response.data?["next"];
    final items = results
        .map((e) => RebrickableMoc.fromJson(e as Map<String, dynamic>))
        .toList();
    return GetSetAlternatesResult(items, next != null);
  }
}
