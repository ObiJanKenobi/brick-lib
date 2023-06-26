

library brick_lib;

export 'package:brick_lib/model/brick_color.dart';
export 'package:brick_lib/model/brick_part.dart';
export 'package:brick_lib/model/part_group.dart';
export 'package:brick_lib/model/rebrickable_part.dart';
export 'package:brick_lib/ui/group_colors.dart';

import 'dart:ui';

import 'brick_lib_platform_interface.dart';
class BrickLib {
  Future<String?> getPlatformVersion() {
    return BrickLibPlatform.instance.getPlatformVersion();
  }
}


extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
