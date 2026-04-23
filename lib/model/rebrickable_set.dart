import 'package:json_annotation/json_annotation.dart';

part 'rebrickable_set.g.dart';

@JsonSerializable(explicitToJson: true)
class RebrickableSet {
  RebrickableSet({
    required this.setNum,
    required this.name,
    this.year = 0,
    this.numParts = 0,
    this.setImgUrl,
    this.themeId,
  });

  @JsonKey(name: 'set_num')
  String setNum;
  String name;
  int year;
  @JsonKey(name: 'num_parts')
  int numParts;
  @JsonKey(name: 'set_img_url')
  String? setImgUrl;
  @JsonKey(name: 'theme_id')
  int? themeId;

  factory RebrickableSet.fromJson(Map<String, Object?> json) => _$RebrickableSetFromJson(json);

  Map<String, dynamic> toJson() => _$RebrickableSetToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RebrickableUserSet {
  RebrickableUserSet({
    required this.listId,
    required this.set,
    this.quantity = 1,
    this.includeSpares = true,
  });

  @JsonKey(name: 'list_id')
  int listId;
  RebrickableSet set;
  int quantity;
  @JsonKey(name: 'include_spares')
  bool includeSpares;

  factory RebrickableUserSet.fromJson(Map<String, Object?> json) => _$RebrickableUserSetFromJson(json);

  Map<String, dynamic> toJson() => _$RebrickableUserSetToJson(this);
}
