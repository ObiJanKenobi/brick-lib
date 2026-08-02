// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rebrickable_moc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RebrickableMoc _$RebrickableMocFromJson(Map<String, dynamic> json) =>
    RebrickableMoc(
      setNum: json['set_num'] as String,
      name: json['name'] as String,
      year: (json['year'] as num?)?.toInt() ?? 0,
      numParts: (json['num_parts'] as num?)?.toInt() ?? 0,
      themeId: (json['theme_id'] as num?)?.toInt(),
      mocImgUrl: json['moc_img_url'] as String?,
      mocUrl: json['moc_url'] as String?,
      designerName: json['designer_name'] as String?,
      designerUrl: json['designer_url'] as String?,
    );

Map<String, dynamic> _$RebrickableMocToJson(RebrickableMoc instance) =>
    <String, dynamic>{
      'set_num': instance.setNum,
      'name': instance.name,
      'year': instance.year,
      'num_parts': instance.numParts,
      'theme_id': instance.themeId,
      'moc_img_url': instance.mocImgUrl,
      'moc_url': instance.mocUrl,
      'designer_name': instance.designerName,
      'designer_url': instance.designerUrl,
    };
