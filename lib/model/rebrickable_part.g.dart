// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rebrickable_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RebrickablePart _$$_RebrickablePartFromJson(Map<String, dynamic> json) =>
    _$_RebrickablePart(
      json['part_num'] as String,
      json['name'] as String,
      json['part_img_url'] as String,
      json['part_url'] as String,
      json['external_ids'],
    );

Map<String, dynamic> _$$_RebrickablePartToJson(_$_RebrickablePart instance) =>
    <String, dynamic>{
      'part_num': instance.partNum,
      'name': instance.name,
      'part_img_url': instance.imgUrl,
      'part_url': instance.url,
      'external_ids': instance.externalIds,
    };
