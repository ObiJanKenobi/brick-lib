import 'package:flutter_test/flutter_test.dart';
import 'package:brick_lib/brick_lib.dart';
import 'package:brick_lib/brick_lib_platform_interface.dart';
import 'package:brick_lib/brick_lib_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBrickLibPlatform
    with MockPlatformInterfaceMixin
    implements BrickLibPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BrickLibPlatform initialPlatform = BrickLibPlatform.instance;

  test('$MethodChannelBrickLib is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBrickLib>());
  });

  test('getPlatformVersion', () async {
    BrickLib brickLibPlugin = BrickLib();
    MockBrickLibPlatform fakePlatform = MockBrickLibPlatform();
    BrickLibPlatform.instance = fakePlatform;

    expect(await brickLibPlugin.getPlatformVersion(), '42');
  });
}
