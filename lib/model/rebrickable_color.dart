import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

// optional: Since our RebrickableColor class is serializable, we must add this line.
// But if RebrickableColor was not serializable, we could skip it.
part 'rebrickable_color.g.dart';

@embedded
@JsonSerializable(explicitToJson: true)
class RebrickableColor {
  RebrickableColor({
    this.rgb = "",
    this.name = "",
    this.id = 0,
    this.externalIds,
  });

  String rgb;
  String name;
  int id;
  @JsonKey(name: 'is_trans')
  bool? isTrans;

  @Ignore()
  @JsonKey(name: 'external_ids')
  dynamic externalIds;

  factory RebrickableColor.fromJson(Map<String, Object?> json) => _$RebrickableColorFromJson(json);

  Map<String, dynamic> toJson() => _$RebrickableColorToJson(this);
}
