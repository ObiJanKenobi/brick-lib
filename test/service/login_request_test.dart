import 'package:brick_lib/request/login_request.dart';
import 'package:brick_lib/util/debug.dart';
import 'package:flutter_test/flutter_test.dart';

const USER = "obijankenobi";
const PASSWORD = "Rebrickable@121";

void main() {
  test('Should get token', () async {
    Debug.setLoggingEnabledByType(DebugType.Request, true);

    final token = await LoginRequest(USER, PASSWORD).send();

    expect(token, isNotNull);
  });
}
