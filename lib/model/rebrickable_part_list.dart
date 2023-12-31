// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'rebrickable_part_list.freezed.dart';

// optional: Since our RebrickablePart class is serializable, we must add this line.
// But if RebrickablePart was not serializable, we could skip it.
part 'rebrickable_part_list.g.dart';

@freezed
class RebrickablePartList with _$RebrickablePartList {
  const factory RebrickablePartList(
    int id,
    String name,
    @JsonKey(name: 'is_buildable') bool isBuildable,
    @JsonKey(name: 'num_parts') int partCount,
  ) = _RebrickablePartList;

  factory RebrickablePartList.fromJson(Map<String, Object?> json) => _$RebrickablePartListFromJson(json);
}
