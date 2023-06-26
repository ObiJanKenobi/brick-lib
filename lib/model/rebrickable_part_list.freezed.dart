// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rebrickable_part_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RebrickablePartList _$RebrickablePartListFromJson(Map<String, dynamic> json) {
  return _RebrickablePartList.fromJson(json);
}

/// @nodoc
mixin _$RebrickablePartList {
  int get id => throw _privateConstructorUsedError;

  String get name => throw _privateConstructorUsedError;

  @JsonKey(name: 'is_buildable')
  bool get isBuildable => throw _privateConstructorUsedError;

  @JsonKey(name: 'num_parts')
  int get partCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RebrickablePartListCopyWith<RebrickablePartList> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RebrickablePartListCopyWith<$Res> {
  factory $RebrickablePartListCopyWith(RebrickablePartList value, $Res Function(RebrickablePartList) then) =
      _$RebrickablePartListCopyWithImpl<$Res, RebrickablePartList>;

  @useResult
  $Res call({int id, String name, @JsonKey(name: 'is_buildable') bool isBuildable, @JsonKey(name: 'num_parts') int partCount});
}

/// @nodoc
class _$RebrickablePartListCopyWithImpl<$Res, $Val extends RebrickablePartList> implements $RebrickablePartListCopyWith<$Res> {
  _$RebrickablePartListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isBuildable = null,
    Object? partCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isBuildable: null == isBuildable
          ? _value.isBuildable
          : isBuildable // ignore: cast_nullable_to_non_nullable
              as bool,
      partCount: null == partCount
          ? _value.partCount
          : partCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RebrickablePartListCopyWith<$Res> implements $RebrickablePartListCopyWith<$Res> {
  factory _$$_RebrickablePartListCopyWith(_$_RebrickablePartList value, $Res Function(_$_RebrickablePartList) then) =
      __$$_RebrickablePartListCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({int id, String name, @JsonKey(name: 'is_buildable') bool isBuildable, @JsonKey(name: 'num_parts') int partCount});
}

/// @nodoc
class __$$_RebrickablePartListCopyWithImpl<$Res> extends _$RebrickablePartListCopyWithImpl<$Res, _$_RebrickablePartList>
    implements _$$_RebrickablePartListCopyWith<$Res> {
  __$$_RebrickablePartListCopyWithImpl(_$_RebrickablePartList _value, $Res Function(_$_RebrickablePartList) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isBuildable = null,
    Object? partCount = null,
  }) {
    return _then(_$_RebrickablePartList(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == isBuildable
          ? _value.isBuildable
          : isBuildable // ignore: cast_nullable_to_non_nullable
              as bool,
      null == partCount
          ? _value.partCount
          : partCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RebrickablePartList with DiagnosticableTreeMixin implements _RebrickablePartList {
  const _$_RebrickablePartList(
      this.id, this.name, @JsonKey(name: 'is_buildable') this.isBuildable, @JsonKey(name: 'num_parts') this.partCount);

  factory _$_RebrickablePartList.fromJson(Map<String, dynamic> json) => _$$_RebrickablePartListFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'is_buildable')
  final bool isBuildable;
  @override
  @JsonKey(name: 'num_parts')
  final int partCount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RebrickablePartList(id: $id, name: $name, isBuildable: $isBuildable, partCount: $partCount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RebrickablePartList'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('isBuildable', isBuildable))
      ..add(DiagnosticsProperty('partCount', partCount));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RebrickablePartList &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isBuildable, isBuildable) || other.isBuildable == isBuildable) &&
            (identical(other.partCount, partCount) || other.partCount == partCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, isBuildable, partCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RebrickablePartListCopyWith<_$_RebrickablePartList> get copyWith =>
      __$$_RebrickablePartListCopyWithImpl<_$_RebrickablePartList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RebrickablePartListToJson(
      this,
    );
  }
}

abstract class _RebrickablePartList implements RebrickablePartList {
  const factory _RebrickablePartList(final int id, final String name, @JsonKey(name: 'is_buildable') final bool isBuildable,
      @JsonKey(name: 'num_parts') final int partCount) = _$_RebrickablePartList;

  factory _RebrickablePartList.fromJson(Map<String, dynamic> json) = _$_RebrickablePartList.fromJson;

  @override
  int get id;

  @override
  String get name;

  @override
  @JsonKey(name: 'is_buildable')
  bool get isBuildable;

  @override
  @JsonKey(name: 'num_parts')
  int get partCount;

  @override
  @JsonKey(ignore: true)
  _$$_RebrickablePartListCopyWith<_$_RebrickablePartList> get copyWith => throw _privateConstructorUsedError;
}
