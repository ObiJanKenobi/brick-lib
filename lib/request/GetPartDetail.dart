import 'package:brick_lib/model/rebrickable_part.dart';
import 'package:brick_lib/request/request.dart';
import 'package:dio/dio.dart';

class GetPartDetail extends Request<RebrickablePart?> {
  @override
  String get path => '/lego/parts/$partNum';

  final String partNum;

  GetPartDetail(this.partNum);

  @override
  RebrickablePart? handleResponse(Response response) {
    return RebrickablePart?.fromJson(response.data as dynamic);
  }
}
