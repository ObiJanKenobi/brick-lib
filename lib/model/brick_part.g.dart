// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brick_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BrickPart _$$_BrickPartFromJson(Map<String, dynamic> json) => _$_BrickPart(
      part: json['part'] as String,
      color: json['color'] as String,
      quantity: json['quantity'] as int,
      colorName: json['colorName'] as String,
      gobricksColor: json['gobricksColor'] as String,
      bricklinkColor: json['bricklinkColor'] as String,
      bricklinkId: json['bricklinkId'] as String?,
      rgb: json['rgb'] as String,
      goBrickPart: json['goBrickPart'] as String?,
      name: json['name'] as String?,
      details: json['details'] == null
          ? null
          : RebrickablePart.fromJson(json['details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_BrickPartToJson(_$_BrickPart instance) =>
    <String, dynamic>{
      'part': instance.part,
      'color': instance.color,
      'quantity': instance.quantity,
      'colorName': instance.colorName,
      'gobricksColor': instance.gobricksColor,
      'bricklinkColor': instance.bricklinkColor,
      'bricklinkId': instance.bricklinkId,
      'rgb': instance.rgb,
      'goBrickPart': instance.goBrickPart,
      'name': instance.name,
      'details': instance.details,
    };
