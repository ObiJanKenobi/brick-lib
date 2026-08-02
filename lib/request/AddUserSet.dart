import 'package:brick_lib/request/request.dart';
import 'package:dio/dio.dart';

/// Adds a set to the logged-in user's Rebrickable collection.
///
/// `POST /users/{user_token}/sets/` takes form-encoded fields and answers
/// 201 Created, so [isSuccess] has to widen the default 200-only check.
/// Adding a set that is already in the collection increments its quantity
/// rather than erroring.
class AddUserSet extends Request<bool> {
  @override
  RequestMethod get method => RequestMethod.POST;

  @override
  String get path => '/users/$userToken/sets/';

  @override
  String get contentType => 'application/x-www-form-urlencoded';

  @override
  get payload => {
        'set_num': setNum,
        'quantity': quantity,
        'include_spares': includeSpares,
      };

  @override
  bool isSuccess(int statusCode) => statusCode == 201 || statusCode == 200;

  final String userToken;
  final String setNum;
  final int quantity;
  final bool includeSpares;

  AddUserSet(
    this.userToken,
    this.setNum, {
    this.quantity = 1,
    this.includeSpares = true,
  });

  @override
  bool handleResponse(Response response) => true;
}
