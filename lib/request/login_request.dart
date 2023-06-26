import 'dart:io';

import 'package:brick_lib/request/request.dart';
import 'package:dio/dio.dart';

class LoginRequest extends Request<String?> {
  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => '/users/_token/';

  @override
  String get contentType => 'application/x-www-form-urlencoded';

  @override
  get payload => {"username": username, "password": password};

  final String username;
  final String password;

  LoginRequest(this.username, this.password);

  @override
  String? handleResponse(Response response) {
    final String token = response.data["user_token"];
    return token;
  }
}
