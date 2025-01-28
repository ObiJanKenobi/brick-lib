// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// optional: Since our RebrickablePart class is serializable, we must add this line.
// But if RebrickablePart was not serializable, we could skip it.
part 'rebrickable_part_list.g.dart';

@JsonSerializable(explicitToJson: true)
class RebrickablePartList {
  RebrickablePartList(
    this.id,
    this.name,
    this.isBuildable,
    this.partCount,
  );

  int id;
  String name;
  @JsonKey(name: 'is_buildable')
  bool isBuildable;
  @JsonKey(name: 'num_parts')
  int partCount;

  factory RebrickablePartList.fromJson(Map<String, Object?> json) => _$RebrickablePartListFromJson(json);
}
