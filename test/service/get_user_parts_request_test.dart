import 'package:brick_lib/request/GetUserPartsByPartNum.dart';
import 'package:brick_lib/request/login_request.dart';
import 'package:brick_lib/util/debug.dart';
import 'package:flutter_test/flutter_test.dart';

const USER_TOKEN = "744667e2a7272f0765fcc6031c0850dfa8ec2e91700eb48f8f7c9ad226572e89";
const COLOR_LBG = 71;
const COLOR_DARK_TAN = 28;

void main() {
  test('Should get user parts', () async {
    Debug.setLoggingEnabledByType(DebugType.Request, true);

    final results =
    await GetUserPartsByPartNum(USER_TOKEN, partCategoryId: 21, colorId: [COLOR_LBG.toString(), COLOR_DARK_TAN.toString()]).send();

    expect(results, isNotNull);
  });
}
