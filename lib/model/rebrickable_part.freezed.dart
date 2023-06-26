// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rebrickable_part.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RebrickablePart _$RebrickablePartFromJson(Map<String, dynamic> json) {
  return _RebrickablePart.fromJson(json);
}

/// @nodoc
mixin _$RebrickablePart {
  @JsonKey(name: 'part_num')
  String get partNum => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'part_img_url')
  String get imgUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'part_url')
  String get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'external_ids')
  dynamic get externalIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RebrickablePartCopyWith<RebrickablePart> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RebrickablePartCopyWith<$Res> {
  factory $RebrickablePartCopyWith(
          RebrickablePart value, $Res Function(RebrickablePart) then) =
      _$RebrickablePartCopyWithImpl<$Res, RebrickablePart>;
  @useResult
  $Res call(
      {@JsonKey(name: 'part_num') String partNum,
      String name,
      @JsonKey(name: 'part_img_url') String imgUrl,
      @JsonKey(name: 'part_url') String url,
      @JsonKey(name: 'external_ids') dynamic externalIds});
}

/// @nodoc
class _$RebrickablePartCopyWithImpl<$Res, $Val extends RebrickablePart>
    implements $RebrickablePartCopyWith<$Res> {
  _$RebrickablePartCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? partNum = null,
    Object? name = null,
    Object? imgUrl = null,
    Object? url = null,
    Object? externalIds = freezed,
  }) {
    return _then(_value.copyWith(
      partNum: null == partNum
          ? _value.partNum
          : partNum // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imgUrl: null == imgUrl
          ? _value.imgUrl
          : imgUrl // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      externalIds: freezed == externalIds
          ? _value.externalIds
          : externalIds // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RebrickablePartCopyWith<$Res>
    implements $RebrickablePartCopyWith<$Res> {
  factory _$$_RebrickablePartCopyWith(
          _$_RebrickablePart value, $Res Function(_$_RebrickablePart) then) =
      __$$_RebrickablePartCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'part_num') String partNum,
      String name,
      @JsonKey(name: 'part_img_url') String imgUrl,
      @JsonKey(name: 'part_url') String url,
      @JsonKey(name: 'external_ids') dynamic externalIds});
}

/// @nodoc
class __$$_RebrickablePartCopyWithImpl<$Res>
    extends _$RebrickablePartCopyWithImpl<$Res, _$_RebrickablePart>
    implements _$$_RebrickablePartCopyWith<$Res> {
  __$$_RebrickablePartCopyWithImpl(
      _$_RebrickablePart _value, $Res Function(_$_RebrickablePart) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? partNum = null,
    Object? name = null,
    Object? imgUrl = null,
    Object? url = null,
    Object? externalIds = freezed,
  }) {
    return _then(_$_RebrickablePart(
      null == partNum
          ? _value.partNum
          : partNum // ignore: cast_nullable_to_non_nullable
              as String,
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == imgUrl
          ? _value.imgUrl
          : imgUrl // ignore: cast_nullable_to_non_nullable
              as String,
      null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == externalIds
          ? _value.externalIds
          : externalIds // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RebrickablePart
    with DiagnosticableTreeMixin
    implements _RebrickablePart {
  const _$_RebrickablePart(
      @JsonKey(name: 'part_num') this.partNum,
      this.name,
      @JsonKey(name: 'part_img_url') this.imgUrl,
      @JsonKey(name: 'part_url') this.url,
      @JsonKey(name: 'external_ids') this.externalIds);

  factory _$_RebrickablePart.fromJson(Map<String, dynamic> json) =>
      _$$_RebrickablePartFromJson(json);

  @override
  @JsonKey(name: 'part_num')
  final String partNum;
  @override
  final String name;
  @override
  @JsonKey(name: 'part_img_url')
  final String imgUrl;
  @override
  @JsonKey(name: 'part_url')
  final String url;
  @override
  @JsonKey(name: 'external_ids')
  final dynamic externalIds;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RebrickablePart(partNum: $partNum, name: $name, imgUrl: $imgUrl, url: $url, externalIds: $externalIds)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RebrickablePart'))
      ..add(DiagnosticsProperty('partNum', partNum))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('imgUrl', imgUrl))
      ..add(DiagnosticsProperty('url', url))
      ..add(DiagnosticsProperty('externalIds', externalIds));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RebrickablePart &&
            (identical(other.partNum, partNum) || other.partNum == partNum) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imgUrl, imgUrl) || other.imgUrl == imgUrl) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality()
                .equals(other.externalIds, externalIds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, partNum, name, imgUrl, url,
      const DeepCollectionEquality().hash(externalIds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RebrickablePartCopyWith<_$_RebrickablePart> get copyWith =>
      __$$_RebrickablePartCopyWithImpl<_$_RebrickablePart>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RebrickablePartToJson(
      this,
    );
  }
}

abstract class _RebrickablePart implements RebrickablePart {
  const factory _RebrickablePart(
          @JsonKey(name: 'part_num') final String partNum,
          final String name,
          @JsonKey(name: 'part_img_url') final String imgUrl,
          @JsonKey(name: 'part_url') final String url,
          @JsonKey(name: 'external_ids') final dynamic externalIds) =
      _$_RebrickablePart;

  factory _RebrickablePart.fromJson(Map<String, dynamic> json) =
      _$_RebrickablePart.fromJson;

  @override
  @JsonKey(name: 'part_num')
  String get partNum;
  @override
  String get name;
  @override
  @JsonKey(name: 'part_img_url')
  String get imgUrl;
  @override
  @JsonKey(name: 'part_url')
  String get url;
  @override
  @JsonKey(name: 'external_ids')
  dynamic get externalIds;
  @override
  @JsonKey(ignore: true)
  _$$_RebrickablePartCopyWith<_$_RebrickablePart> get copyWith =>
      throw _privateConstructorUsedError;
}
