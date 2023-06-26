import 'dart:convert';
import 'dart:io';

import 'package:brick_lib/util/debug.dart';

// import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';

enum RequestMethod { GET, POST, DELETE, DOWNLOAD }

const RB_API_KEY = "7b423bf9ee261e028961b243162b9499";
const API_URL = "https://rebrickable.com/api/v3";

abstract class Request<T> {
  abstract final String path;
  final RequestMethod method = RequestMethod.GET;
  final dynamic payload = {};
  final Map<String, dynamic>? queryParams = {};
  final String contentType = "application/json";
  final Map<String, String> headers = {};
  final String? downloadPath = null;
  final int timeoutInSeconds = 30;

  @nonVirtual
  String get debugName => "[${runtimeType.toString()}]";

  // String get debugName => "R[${method.name}]-[${neatType.name}]-[$path]";

  @nonVirtual
  bool _busy = false;

  @nonVirtual
  get busy => _busy;

  @nonVirtual
  bool _initialized = false;

  @nonVirtual
  Dio? _dio;

  String get requestUrl => API_URL + path;

  bool get useAuth => true;

  @nonVirtual
  Future<void> _initialize() async {
    Debug.request("Initalizing $debugName.");

    if (_initialized) {
      Debug.request("$debugName already initialized!");
      return;
    }

    _busy = true;

    Dio dio = await getDio();

    dio.options.contentType = contentType;

    headers.forEach((key, value) {
      dio.options.headers[key] = value;
    });

    dio.options.receiveDataWhenStatusError = true;

    if (!Debug.debugEnabled) {
      dio.options.connectTimeout = timeoutInSeconds * 1000;
      dio.options.receiveTimeout = timeoutInSeconds * 1000;
      dio.options.sendTimeout = timeoutInSeconds * 1000;
    }
    _dio = dio;
    _initialized = true;
    _busy = false;
  }

  /// Override this method to manipulate the Dio before sending
  void setup(Dio dio) {}

  /// Override this method to handle errors or provide a more detailed errorMessage
  void onError(Object e) {
    try {
      String stackTrace = "\n${(e as Error?)?.stackTrace}";
      Debug.request("$debugName failed with: ${e.toString()}", force: true);
    } catch (_) {
      String stackTrace = "\n${(e as DioError?)?.stackTrace}";
      Debug.request("$debugName failed with: ${e.toString()}", force: true);
    }
  }

  /// Override this method to manipulate or preprocess the return value of [send]
  T handleResponse(Response response) => response.data;

  @nonVirtual
  Future<T?> send() async {
    if (_busy) {
      Debug.request("Send $debugName failed. Already busy!");
      return null;
    }

    await _initialize();
    setup(_dio!);

    Debug.request("Sending $debugName\n$curl");

    _busy = true;

    Response? response;
    // By default all statusCodes != 200 will throw errors.
    final options = Options(validateStatus: (status) => true);

    switch (method) {
      case RequestMethod.GET:
        response = await _dio!.get(requestUrl, options: options, queryParameters: queryParams);
        break;
      case RequestMethod.POST:
        response = await _dio!.post(requestUrl, data: payload, options: options);
        break;
      case RequestMethod.DELETE:
        response = await _dio!.delete(requestUrl, data: payload, options: options);
        break;
      case RequestMethod.DOWNLOAD:
        if (downloadPath == null) {
          Debug.request("$debugName failed with: No downloadPath set!", force: true);
          return null;
        }
        response = await _dio!.download(requestUrl, downloadPath, data: payload, options: options);
        break;
      default:
        _busy = false;
        Debug.request("$debugName failed with: Invalid method [$method]!", force: true);
        return null;
    }

    int statusCode = response.statusCode ?? -1;
    Debug.request("$debugName finished with [$statusCode]");

    if (statusCode != 200) {
      throw ArgumentError(response.statusMessage, statusCode.toString());
    }
    // switch (statusCode) {
    //   // FIXME: Redirect, OtherStatusCodes?
    // }

    _busy = false;
    final d = response.data;
    try {
      final code = d["code"];
      final message = d["message"];
      if (code != null && message != null) {
        Debug.requestResponse("$debugName response: [$code]: [$message]", force: true);
      } else {
        Debug.requestResponse("$debugName response: ${json.encode(d)}");
      }
    } catch (e) {
      Debug.requestResponse("$debugName failed response: $d\n${e.toString()}");
    }

    if (response.headers['set-cookie'] != null) {
      Debug.request("$debugName has set-cookie ${response.headers['set-cookie']}\n${curl}", force: true);
    }

    _dio!.close();
    return handleResponse(response);
  }

  @nonVirtual
  String get curl {
    final String m = "--request ${method.name} \\";
    final String url = "--url '$requestUrl' \\";
    String body;
    try {
      body = "--data '${json.encode(payload)}'";
    } catch (e) {
      body = "--data 'NONREADABLE'";
    }

    String header = "";
    _dio!.options.headers.forEach((key, value) => header += "--header '$key: $value' \\\n");
    return "curl $m\n$url\n$header$body";
  }
}

///
/// Liefert eine Dio Instanz mit Cookie Provider
/// async ist nötig für persistente Cookies. Um an das App Dir zu kommen
///
Future<Dio> getDio() async {
  Dio dio = Dio();

  dio.options.headers['Authorization'] = "key $RB_API_KEY";

  return dio;
}
