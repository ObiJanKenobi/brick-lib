import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:brick_lib/brick_lib_method_channel.dart';

void main() {
  MethodChannelBrickLib platform = MethodChannelBrickLib();
  const MethodChannel channel = MethodChannel('brick_lib');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
