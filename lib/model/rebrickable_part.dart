// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'rebrickable_part.freezed.dart';

// optional: Since our RebrickablePart class is serializable, we must add this line.
// But if RebrickablePart was not serializable, we could skip it.
part 'rebrickable_part.g.dart';

@freezed
class RebrickablePart with _$RebrickablePart {
  const factory RebrickablePart(
    @JsonKey(name: 'part_num') String partNum,
    String name,
    @JsonKey(name: 'part_img_url') String imgUrl,
    @JsonKey(name: 'part_url') String url,
    @JsonKey(name: 'external_ids') dynamic externalIds,
  ) = _RebrickablePart;

  factory RebrickablePart.fromJson(Map<String, Object?> json) => _$RebrickablePartFromJson(json);
}
