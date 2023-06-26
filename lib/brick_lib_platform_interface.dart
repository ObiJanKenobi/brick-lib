import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'brick_lib_method_channel.dart';

abstract class BrickLibPlatform extends PlatformInterface {
  /// Constructs a BrickLibPlatform.
  BrickLibPlatform() : super(token: _token);

  static final Object _token = Object();

  static BrickLibPlatform _instance = MethodChannelBrickLib();

  /// The default instance of [BrickLibPlatform] to use.
  ///
  /// Defaults to [MethodChannelBrickLib].
  static BrickLibPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BrickLibPlatform] when
  /// they register themselves.
  static set instance(BrickLibPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
