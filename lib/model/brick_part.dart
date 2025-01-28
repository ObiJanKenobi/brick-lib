// This file is "main.dart"
import 'package:brick_lib/model/rebrickable_part.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

// optional: Since our BrickPart class is serializable, we must add this line.
// But if BrickPart was not serializable, we could skip it.
part 'brick_part.g.dart';

@JsonSerializable(explicitToJson: true)
class BrickPart {
  BrickPart({
    this.part,
    this.color,
    this.quantity = 0,
    this.colorName,
    this.gobricksColor,
    this.bricklinkColor,
    this.bricklinkId,
    this.rgb,
    this.goBrickPart,
    this.name,
    this.details,
  });

  String? part;
  String? color;
  int quantity;
  String? colorName;
  String? gobricksColor;
  String? bricklinkColor;
  String? bricklinkId;
  String? rgb;
  String? goBrickPart;
  String? name;
  RebrickablePart? details;

  bool get noMapping => goBrickPart == null || goBrickPart?.isEmpty == true;

  factory BrickPart.fromJson(Map<String, Object?> json) => _$BrickPartFromJson(json);

  Map<String, dynamic> toJson() => _$BrickPartToJson(this);
}
