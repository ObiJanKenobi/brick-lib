import 'package:brick_lib/model/rebrickable_part.dart';
import 'package:brick_lib/request/request.dart';
import 'package:dio/dio.dart';

class GetPartDetailFromList extends Request<List<RebrickablePart>?> {
  @override
  String get path => '/lego/parts/';

  @override
  get queryParams => {"part_nums": parts.join(',')};

  final List<String> parts;

  GetPartDetailFromList(this.parts);

  @override
  List<RebrickablePart>? handleResponse(Response response) {
    final List<dynamic> results = response.data?["results"];

    return (results)?.map((e) => RebrickablePart?.fromJson(e as Map<String, dynamic>)).toList() ?? [];
  }
}
