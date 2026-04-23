// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brick_color.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BrickColor _$BrickColorFromJson(Map<String, dynamic> json) => _BrickColor(
      legoColor: json['legoColor'] as String,
      bricklinkColor: json['bricklinkColor'] as String,
      rebrickableColor: json['rebrickableColor'] as String,
      goBrickColor: json['goBrickColor'] as String,
      lddName: json['lddName'] as String,
      name: json['name'] as String,
      rgb: json['rgb'] as String,
    );

Map<String, dynamic> _$BrickColorToJson(_BrickColor instance) =>
    <String, dynamic>{
      'legoColor': instance.legoColor,
      'bricklinkColor': instance.bricklinkColor,
      'rebrickableColor': instance.rebrickableColor,
      'goBrickColor': instance.goBrickColor,
      'lddName': instance.lddName,
      'name': instance.name,
      'rgb': instance.rgb,
    };
