import 'dart:io';

import 'package:brick_lib/logger.dart';
import 'package:brick_lib/model/rebrickable_part.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

const RB_API_KEY = "7b423bf9ee261e028961b243162b9499";
const API_URL = "https://rebrickable.com/api/v3";

class RebrickableService {
  final Logger log = getLogger("RebrickableService");

  Future<RebrickablePart?> getPartDetail(String partNum) async {
    Dio dio = await getDio();

    log.i("Getting details for part $partNum");
    final String serviceurl = "$API_URL/lego/parts/$partNum";

    try {
      final Response resp = await dio.get(
        serviceurl,
      );

      return RebrickablePart.fromJson(resp.data);
    } catch (e) {
      DioError error = e as DioError;
      final Response? resp = error.response;
      print(resp?.data);
      return null;
    }
  }

  Future<List<RebrickablePart>?> getPartsDetail(List<String> parts) async {
    Dio dio = await getDio();

    log.i("Getting details for parts $parts");
    const String serviceurl = "$API_URL/lego/parts/";

    try {
      final Response<dynamic> resp = await dio.get(serviceurl, queryParameters: {"part_nums": parts.join(',')});

      final List<dynamic> results = resp.data?["results"];

      return results?.map((e) => RebrickablePart.fromJson(e)).toList();
    } catch (e) {
      DioError error = e as DioError;
      final Response? resp = error.response;
      print(resp?.data);
      return null;
    }
  }
}

///
/// Liefert eine Dio Instanz mit Cookie Provider
/// async ist nötig für persistente Cookies. Um an das App Dir zu kommen
///
Future<Dio> getDio() async {
  Dio dio = Dio();

  dio.interceptors
      .add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
    //Set the token to headers
    options.headers[HttpHeaders.authorizationHeader] = "key $RB_API_KEY";

    return handler.next(options); //continue
  }));

  return dio;
}
