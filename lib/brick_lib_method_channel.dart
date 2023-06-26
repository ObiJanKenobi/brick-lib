import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'brick_lib_platform_interface.dart';

/// An implementation of [BrickLibPlatform] that uses method channels.
class MethodChannelBrickLib extends BrickLibPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('brick_lib');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
