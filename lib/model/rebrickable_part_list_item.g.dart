// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rebrickable_part_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RebrickablePartListItem _$RebrickablePartListItemFromJson(Map<String, dynamic> json) => RebrickablePartListItem(
      RebrickablePart.fromJson(json['part'] as Map<String, dynamic>),
      (json['quantity'] as num).toInt(),
      RebrickableColor.fromJson(json['color'] as Map<String, dynamic>),
    )..listId = (json['list_id'] as num?)?.toInt();

Map<String, dynamic> _$RebrickablePartListItemToJson(RebrickablePartListItem instance) => <String, dynamic>{
      'list_id': instance.listId,
      'part': instance.part.toJson(),
      'color': instance.color.toJson(),
      'quantity': instance.quantity,
    };
