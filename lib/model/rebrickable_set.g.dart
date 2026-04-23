// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rebrickable_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RebrickableSet _$RebrickableSetFromJson(Map<String, dynamic> json) =>
    RebrickableSet(
      setNum: json['set_num'] as String,
      name: json['name'] as String,
      year: (json['year'] as num?)?.toInt() ?? 0,
      numParts: (json['num_parts'] as num?)?.toInt() ?? 0,
      setImgUrl: json['set_img_url'] as String?,
      themeId: (json['theme_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RebrickableSetToJson(RebrickableSet instance) =>
    <String, dynamic>{
      'set_num': instance.setNum,
      'name': instance.name,
      'year': instance.year,
      'num_parts': instance.numParts,
      'set_img_url': instance.setImgUrl,
      'theme_id': instance.themeId,
    };

RebrickableUserSet _$RebrickableUserSetFromJson(Map<String, dynamic> json) =>
    RebrickableUserSet(
      listId: (json['list_id'] as num).toInt(),
      set: RebrickableSet.fromJson(json['set'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      includeSpares: json['include_spares'] as bool? ?? true,
    );

Map<String, dynamic> _$RebrickableUserSetToJson(RebrickableUserSet instance) =>
    <String, dynamic>{
      'list_id': instance.listId,
      'set': instance.set.toJson(),
      'quantity': instance.quantity,
      'include_spares': instance.includeSpares,
    };
