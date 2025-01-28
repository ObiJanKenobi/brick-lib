import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

// optional: Since our RebrickablePart class is serializable, we must add this line.
// But if RebrickablePart was not serializable, we could skip it.
part 'rebrickable_part.g.dart';

@embedded
@JsonSerializable(explicitToJson: true)
class RebrickablePart {
  RebrickablePart({
    this.partNum,
    this.name,
    this.imgUrl,
    this.url,
    this.externalIds,
  });

  @JsonKey(name: 'part_num')
  String? partNum;
  String? name;
  @JsonKey(name: 'part_img_url')
  String? imgUrl;
  @JsonKey(name: 'part_url')
  String? url;

  @Ignore()
  @JsonKey(name: 'external_ids')
  dynamic externalIds;

  factory RebrickablePart.fromJson(Map<String, Object?> json) => _$RebrickablePartFromJson(json);

  Map<String, dynamic> toJson() => _$RebrickablePartToJson(this);
}
