import 'package:brick_lib/model/rebrickable_color.dart';
import 'package:brick_lib/request/request.dart';
import 'package:dio/dio.dart';

class GetColors extends Request<List<RebrickableColor>> {
  @override
  String get path => '/lego/colors/?ordering=$ordering&page_size=$pageSize';

  final String ordering;
  final int pageSize;

  GetColors({this.ordering = "name", this.pageSize = 300});

  @override
  List<RebrickableColor> handleResponse(Response response) {
    final List<dynamic> results = response.data?["results"];
    return results.map((e) => RebrickableColor.fromJson(e as Map<String, dynamic>)).toList();
  }
}
