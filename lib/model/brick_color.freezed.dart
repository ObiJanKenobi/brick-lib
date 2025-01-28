// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brick_color.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BrickColor _$BrickColorFromJson(Map<String, dynamic> json) {
  return _BrickColor.fromJson(json);
}

/// @nodoc
mixin _$BrickColor {
  String get legoColor => throw _privateConstructorUsedError;

  String get bricklinkColor => throw _privateConstructorUsedError;

  String get rebrickableColor => throw _privateConstructorUsedError;

  String get goBrickColor => throw _privateConstructorUsedError;

  String get lddName => throw _privateConstructorUsedError;

  String get name => throw _privateConstructorUsedError;

  String get rgb => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BrickColorCopyWith<BrickColor> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrickColorCopyWith<$Res> {
  factory $BrickColorCopyWith(BrickColor value, $Res Function(BrickColor) then) = _$BrickColorCopyWithImpl<$Res, BrickColor>;

  @useResult
  $Res call(
      {String legoColor, String bricklinkColor, String rebrickableColor, String goBrickColor, String lddName, String name, String rgb});
}

/// @nodoc
class _$BrickColorCopyWithImpl<$Res, $Val extends BrickColor> implements $BrickColorCopyWith<$Res> {
  _$BrickColorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? legoColor = null,
    Object? bricklinkColor = null,
    Object? rebrickableColor = null,
    Object? goBrickColor = null,
    Object? lddName = null,
    Object? name = null,
    Object? rgb = null,
  }) {
    return _then(_value.copyWith(
      legoColor: null == legoColor
          ? _value.legoColor
          : legoColor // ignore: cast_nullable_to_non_nullable
              as String,
      bricklinkColor: null == bricklinkColor
          ? _value.bricklinkColor
          : bricklinkColor // ignore: cast_nullable_to_non_nullable
              as String,
      rebrickableColor: null == rebrickableColor
          ? _value.rebrickableColor
          : rebrickableColor // ignore: cast_nullable_to_non_nullable
              as String,
      goBrickColor: null == goBrickColor
          ? _value.goBrickColor
          : goBrickColor // ignore: cast_nullable_to_non_nullable
              as String,
      lddName: null == lddName
          ? _value.lddName
          : lddName // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rgb: null == rgb
          ? _value.rgb
          : rgb // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BrickColorImplCopyWith<$Res> implements $BrickColorCopyWith<$Res> {
  factory _$$BrickColorImplCopyWith(_$BrickColorImpl value, $Res Function(_$BrickColorImpl) then) = __$$BrickColorImplCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call(
      {String legoColor, String bricklinkColor, String rebrickableColor, String goBrickColor, String lddName, String name, String rgb});
}

/// @nodoc
class __$$BrickColorImplCopyWithImpl<$Res> extends _$BrickColorCopyWithImpl<$Res, _$BrickColorImpl>
    implements _$$BrickColorImplCopyWith<$Res> {
  __$$BrickColorImplCopyWithImpl(_$BrickColorImpl _value, $Res Function(_$BrickColorImpl) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? legoColor = null,
    Object? bricklinkColor = null,
    Object? rebrickableColor = null,
    Object? goBrickColor = null,
    Object? lddName = null,
    Object? name = null,
    Object? rgb = null,
  }) {
    return _then(_$BrickColorImpl(
      legoColor: null == legoColor
          ? _value.legoColor
          : legoColor // ignore: cast_nullable_to_non_nullable
              as String,
      bricklinkColor: null == bricklinkColor
          ? _value.bricklinkColor
          : bricklinkColor // ignore: cast_nullable_to_non_nullable
              as String,
      rebrickableColor: null == rebrickableColor
          ? _value.rebrickableColor
          : rebrickableColor // ignore: cast_nullable_to_non_nullable
              as String,
      goBrickColor: null == goBrickColor
          ? _value.goBrickColor
          : goBrickColor // ignore: cast_nullable_to_non_nullable
              as String,
      lddName: null == lddName
          ? _value.lddName
          : lddName // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rgb: null == rgb
          ? _value.rgb
          : rgb // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BrickColorImpl with DiagnosticableTreeMixin implements _BrickColor {
  const _$BrickColorImpl(
      {required this.legoColor,
      required this.bricklinkColor,
      required this.rebrickableColor,
      required this.goBrickColor,
      required this.lddName,
      required this.name,
      required this.rgb});

  factory _$BrickColorImpl.fromJson(Map<String, dynamic> json) => _$$BrickColorImplFromJson(json);

  @override
  final String legoColor;
  @override
  final String bricklinkColor;
  @override
  final String rebrickableColor;
  @override
  final String goBrickColor;
  @override
  final String lddName;
  @override
  final String name;
  @override
  final String rgb;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrickColor(legoColor: $legoColor, bricklinkColor: $bricklinkColor, rebrickableColor: $rebrickableColor, goBrickColor: $goBrickColor, lddName: $lddName, name: $name, rgb: $rgb)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BrickColor'))
      ..add(DiagnosticsProperty('legoColor', legoColor))
      ..add(DiagnosticsProperty('bricklinkColor', bricklinkColor))
      ..add(DiagnosticsProperty('rebrickableColor', rebrickableColor))
      ..add(DiagnosticsProperty('goBrickColor', goBrickColor))
      ..add(DiagnosticsProperty('lddName', lddName))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('rgb', rgb));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrickColorImpl &&
            (identical(other.legoColor, legoColor) || other.legoColor == legoColor) &&
            (identical(other.bricklinkColor, bricklinkColor) || other.bricklinkColor == bricklinkColor) &&
            (identical(other.rebrickableColor, rebrickableColor) || other.rebrickableColor == rebrickableColor) &&
            (identical(other.goBrickColor, goBrickColor) || other.goBrickColor == goBrickColor) &&
            (identical(other.lddName, lddName) || other.lddName == lddName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rgb, rgb) || other.rgb == rgb));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, legoColor, bricklinkColor, rebrickableColor, goBrickColor, lddName, name, rgb);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BrickColorImplCopyWith<_$BrickColorImpl> get copyWith => __$$BrickColorImplCopyWithImpl<_$BrickColorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BrickColorImplToJson(
      this,
    );
  }
}

abstract class _BrickColor implements BrickColor {
  const factory _BrickColor(
      {required final String legoColor,
      required final String bricklinkColor,
      required final String rebrickableColor,
      required final String goBrickColor,
      required final String lddName,
      required final String name,
      required final String rgb}) = _$BrickColorImpl;

  factory _BrickColor.fromJson(Map<String, dynamic> json) = _$BrickColorImpl.fromJson;

  @override
  String get legoColor;

  @override
  String get bricklinkColor;

  @override
  String get rebrickableColor;

  @override
  String get goBrickColor;

  @override
  String get lddName;

  @override
  String get name;

  @override
  String get rgb;

  @override
  @JsonKey(ignore: true)
  _$$BrickColorImplCopyWith<_$BrickColorImpl> get copyWith => throw _privateConstructorUsedError;
}
