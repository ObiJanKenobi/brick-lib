// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rebrickable_part_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RebrickablePartList _$RebrickablePartListFromJson(Map<String, dynamic> json) => RebrickablePartList(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['is_buildable'] as bool,
      (json['num_parts'] as num).toInt(),
    );

Map<String, dynamic> _$RebrickablePartListToJson(RebrickablePartList instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_buildable': instance.isBuildable,
      'num_parts': instance.partCount,
    };
