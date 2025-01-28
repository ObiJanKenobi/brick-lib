// This file is "main.dart"
import 'package:brick_lib/brick_lib.dart';
import 'package:brick_lib/model/rebrickable_color.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// optional: Since our RebrickablePartListItem class is serializable, we must add this line.
// But if RebrickablePartListItem was not serializable, we could skip it.
part 'rebrickable_part_list_item.g.dart';

@JsonSerializable(explicitToJson: true)
class RebrickablePartListItem {
  RebrickablePartListItem(this.part, this.quantity, this.color);

  @JsonKey(name: 'list_id')
  int? listId;
  RebrickablePart part;
  RebrickableColor color;
  int quantity;

  factory RebrickablePartListItem.fromJson(Map<String, Object?> json) => _$RebrickablePartListItemFromJson(json);
}
