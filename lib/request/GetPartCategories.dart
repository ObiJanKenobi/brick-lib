import 'package:brick_lib/model/rebrickable_part_category.dart';
import 'package:brick_lib/request/request.dart';
import 'package:dio/dio.dart';

class GetPartCategories extends Request<List<RebrickablePartCategory>> {
  @override
  String get path => '/lego/part_categories/?ordering=$ordering';

  final String ordering;

  GetPartCategories({this.ordering = "name"});

  @override
  List<RebrickablePartCategory> handleResponse(Response response) {
    final List<dynamic> results = response.data?["results"];
    return results.map((e) => RebrickablePartCategory.fromJson(e as Map<String, dynamic>)).toList();
  }
}
