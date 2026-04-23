import 'package:brick_lib/request/request.dart';
import 'package:dio/dio.dart';

class PartColorInfo {
  PartColorInfo({this.imgUrl, this.rgb, this.name});
  final String? imgUrl;
  final String? rgb;
  final String? name;
}

class GetPartColor extends Request<PartColorInfo?> {
  @override
  String get path => '/lego/parts/$partNum/colors/$colorId/';

  final String partNum;
  final int colorId;

  GetPartColor(this.partNum, this.colorId);

  @override
  PartColorInfo? handleResponse(Response response) {
    final data = response.data as Map<String, dynamic>?;
    if (data == null) return null;
    return PartColorInfo(
      imgUrl: data['part_img_url'] as String?,
      rgb: data['rgb'] as String?,
      name: data['color_name'] as String?,
    );
  }
}
