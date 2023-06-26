// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rebrickable_part_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RebrickablePartList _$$_RebrickablePartListFromJson(Map<String, dynamic> json) => _$_RebrickablePartList(
      json['id'] as int,
      json['name'] as String,
      json['is_buildable'] as bool,
      json['num_parts'] as int,
    );

Map<String, dynamic> _$$_RebrickablePartListToJson(_$_RebrickablePartList instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_buildable': instance.isBuildable,
      'num_parts': instance.partCount,
    };
