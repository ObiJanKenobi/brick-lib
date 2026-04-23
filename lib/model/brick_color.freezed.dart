// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brick_color.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BrickColor implements DiagnosticableTreeMixin {
  String get legoColor;
  String get bricklinkColor;
  String get rebrickableColor;
  String get goBrickColor;
  String get lddName;
  String get name;
  String get rgb;

  /// Create a copy of BrickColor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BrickColorCopyWith<BrickColor> get copyWith =>
      _$BrickColorCopyWithImpl<BrickColor>(this as BrickColor, _$identity);

  /// Serializes this BrickColor to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
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
            other is BrickColor &&
            (identical(other.legoColor, legoColor) ||
                other.legoColor == legoColor) &&
            (identical(other.bricklinkColor, bricklinkColor) ||
                other.bricklinkColor == bricklinkColor) &&
            (identical(other.rebrickableColor, rebrickableColor) ||
                other.rebrickableColor == rebrickableColor) &&
            (identical(other.goBrickColor, goBrickColor) ||
                other.goBrickColor == goBrickColor) &&
            (identical(other.lddName, lddName) || other.lddName == lddName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rgb, rgb) || other.rgb == rgb));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, legoColor, bricklinkColor,
      rebrickableColor, goBrickColor, lddName, name, rgb);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrickColor(legoColor: $legoColor, bricklinkColor: $bricklinkColor, rebrickableColor: $rebrickableColor, goBrickColor: $goBrickColor, lddName: $lddName, name: $name, rgb: $rgb)';
  }
}

/// @nodoc
abstract mixin class $BrickColorCopyWith<$Res> {
  factory $BrickColorCopyWith(
          BrickColor value, $Res Function(BrickColor) _then) =
      _$BrickColorCopyWithImpl;
  @useResult
  $Res call(
      {String legoColor,
      String bricklinkColor,
      String rebrickableColor,
      String goBrickColor,
      String lddName,
      String name,
      String rgb});
}

/// @nodoc
class _$BrickColorCopyWithImpl<$Res> implements $BrickColorCopyWith<$Res> {
  _$BrickColorCopyWithImpl(this._self, this._then);

  final BrickColor _self;
  final $Res Function(BrickColor) _then;

  /// Create a copy of BrickColor
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      legoColor: null == legoColor
          ? _self.legoColor
          : legoColor // ignore: cast_nullable_to_non_nullable
              as String,
      bricklinkColor: null == bricklinkColor
          ? _self.bricklinkColor
          : bricklinkColor // ignore: cast_nullable_to_non_nullable
              as String,
      rebrickableColor: null == rebrickableColor
          ? _self.rebrickableColor
          : rebrickableColor // ignore: cast_nullable_to_non_nullable
              as String,
      goBrickColor: null == goBrickColor
          ? _self.goBrickColor
          : goBrickColor // ignore: cast_nullable_to_non_nullable
              as String,
      lddName: null == lddName
          ? _self.lddName
          : lddName // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rgb: null == rgb
          ? _self.rgb
          : rgb // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [BrickColor].
extension BrickColorPatterns on BrickColor {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_BrickColor value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BrickColor() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_BrickColor value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrickColor():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_BrickColor value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrickColor() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String legoColor,
            String bricklinkColor,
            String rebrickableColor,
            String goBrickColor,
            String lddName,
            String name,
            String rgb)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BrickColor() when $default != null:
        return $default(
            _that.legoColor,
            _that.bricklinkColor,
            _that.rebrickableColor,
            _that.goBrickColor,
            _that.lddName,
            _that.name,
            _that.rgb);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String legoColor,
            String bricklinkColor,
            String rebrickableColor,
            String goBrickColor,
            String lddName,
            String name,
            String rgb)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrickColor():
        return $default(
            _that.legoColor,
            _that.bricklinkColor,
            _that.rebrickableColor,
            _that.goBrickColor,
            _that.lddName,
            _that.name,
            _that.rgb);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String legoColor,
            String bricklinkColor,
            String rebrickableColor,
            String goBrickColor,
            String lddName,
            String name,
            String rgb)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrickColor() when $default != null:
        return $default(
            _that.legoColor,
            _that.bricklinkColor,
            _that.rebrickableColor,
            _that.goBrickColor,
            _that.lddName,
            _that.name,
            _that.rgb);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BrickColor with DiagnosticableTreeMixin implements BrickColor {
  const _BrickColor(
      {required this.legoColor,
      required this.bricklinkColor,
      required this.rebrickableColor,
      required this.goBrickColor,
      required this.lddName,
      required this.name,
      required this.rgb});
  factory _BrickColor.fromJson(Map<String, dynamic> json) =>
      _$BrickColorFromJson(json);

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

  /// Create a copy of BrickColor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BrickColorCopyWith<_BrickColor> get copyWith =>
      __$BrickColorCopyWithImpl<_BrickColor>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BrickColorToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
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
            other is _BrickColor &&
            (identical(other.legoColor, legoColor) ||
                other.legoColor == legoColor) &&
            (identical(other.bricklinkColor, bricklinkColor) ||
                other.bricklinkColor == bricklinkColor) &&
            (identical(other.rebrickableColor, rebrickableColor) ||
                other.rebrickableColor == rebrickableColor) &&
            (identical(other.goBrickColor, goBrickColor) ||
                other.goBrickColor == goBrickColor) &&
            (identical(other.lddName, lddName) || other.lddName == lddName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rgb, rgb) || other.rgb == rgb));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, legoColor, bricklinkColor,
      rebrickableColor, goBrickColor, lddName, name, rgb);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrickColor(legoColor: $legoColor, bricklinkColor: $bricklinkColor, rebrickableColor: $rebrickableColor, goBrickColor: $goBrickColor, lddName: $lddName, name: $name, rgb: $rgb)';
  }
}

/// @nodoc
abstract mixin class _$BrickColorCopyWith<$Res>
    implements $BrickColorCopyWith<$Res> {
  factory _$BrickColorCopyWith(
          _BrickColor value, $Res Function(_BrickColor) _then) =
      __$BrickColorCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String legoColor,
      String bricklinkColor,
      String rebrickableColor,
      String goBrickColor,
      String lddName,
      String name,
      String rgb});
}

/// @nodoc
class __$BrickColorCopyWithImpl<$Res> implements _$BrickColorCopyWith<$Res> {
  __$BrickColorCopyWithImpl(this._self, this._then);

  final _BrickColor _self;
  final $Res Function(_BrickColor) _then;

  /// Create a copy of BrickColor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? legoColor = null,
    Object? bricklinkColor = null,
    Object? rebrickableColor = null,
    Object? goBrickColor = null,
    Object? lddName = null,
    Object? name = null,
    Object? rgb = null,
  }) {
    return _then(_BrickColor(
      legoColor: null == legoColor
          ? _self.legoColor
          : legoColor // ignore: cast_nullable_to_non_nullable
              as String,
      bricklinkColor: null == bricklinkColor
          ? _self.bricklinkColor
          : bricklinkColor // ignore: cast_nullable_to_non_nullable
              as String,
      rebrickableColor: null == rebrickableColor
          ? _self.rebrickableColor
          : rebrickableColor // ignore: cast_nullable_to_non_nullable
              as String,
      goBrickColor: null == goBrickColor
          ? _self.goBrickColor
          : goBrickColor // ignore: cast_nullable_to_non_nullable
              as String,
      lddName: null == lddName
          ? _self.lddName
          : lddName // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rgb: null == rgb
          ? _self.rgb
          : rgb // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
