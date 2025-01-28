import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

// optional: Since our RebrickablePartGroup class is serializable, we must add this line.
// But if RebrickablePartGroup was not serializable, we could skip it.
part 'rebrickable_part_category.g.dart';

@embedded
@JsonSerializable(explicitToJson: true)
class RebrickablePartCategory {
  RebrickablePartCategory({
    this.id = 1,
    this.name = "",
    this.partCount = 0,
  });

  @JsonKey(name: 'part_count')
  int partCount;
  String name;
  int id;

  factory RebrickablePartCategory.fromJson(Map<String, Object?> json) => _$RebrickablePartCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$RebrickablePartCategoryToJson(this);
}
