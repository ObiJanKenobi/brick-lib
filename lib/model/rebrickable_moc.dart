import 'package:json_annotation/json_annotation.dart';

part 'rebrickable_moc.g.dart';

/// A MOC as returned by `/lego/sets/{set_num}/alternates/`.
///
/// Rebrickable reuses the `set_num` key for the MOC identifier ("MOC-152271"),
/// so this deliberately mirrors [RebrickableSet]'s field naming rather than
/// inventing a `mocNum`.
@JsonSerializable(explicitToJson: true)
class RebrickableMoc {
  RebrickableMoc({
    required this.setNum,
    required this.name,
    this.year = 0,
    this.numParts = 0,
    this.themeId,
    this.mocImgUrl,
    this.mocUrl,
    this.designerName,
    this.designerUrl,
  });

  @JsonKey(name: 'set_num')
  String setNum;
  String name;
  int year;
  @JsonKey(name: 'num_parts')
  int numParts;
  @JsonKey(name: 'theme_id')
  int? themeId;
  @JsonKey(name: 'moc_img_url')
  String? mocImgUrl;

  /// Public page for the MOC. The API exposes no MOC inventory endpoint, so
  /// this is how the user reaches the part list (to export a CSV and import it
  /// into the app).
  @JsonKey(name: 'moc_url')
  String? mocUrl;

  @JsonKey(name: 'designer_name')
  String? designerName;
  @JsonKey(name: 'designer_url')
  String? designerUrl;

  factory RebrickableMoc.fromJson(Map<String, Object?> json) => _$RebrickableMocFromJson(json);

  Map<String, dynamic> toJson() => _$RebrickableMocToJson(this);
}
