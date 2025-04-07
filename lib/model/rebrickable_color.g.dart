// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rebrickable_color.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RebrickableColorSchema = Schema(
  name: r'RebrickableColor',
  id: -776224360140002351,
  properties: {
    r'id': PropertySchema(
      id: 0,
      name: r'id',
      type: IsarType.long,
    ),
    r'isTrans': PropertySchema(
      id: 1,
      name: r'isTrans',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    ),
    r'rgb': PropertySchema(
      id: 3,
      name: r'rgb',
      type: IsarType.string,
    )
  },
  estimateSize: _rebrickableColorEstimateSize,
  serialize: _rebrickableColorSerialize,
  deserialize: _rebrickableColorDeserialize,
  deserializeProp: _rebrickableColorDeserializeProp,
);

int _rebrickableColorEstimateSize(
  RebrickableColor object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.rgb.length * 3;
  return bytesCount;
}

void _rebrickableColorSerialize(
  RebrickableColor object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.id);
  writer.writeBool(offsets[1], object.isTrans);
  writer.writeString(offsets[2], object.name);
  writer.writeString(offsets[3], object.rgb);
}

RebrickableColor _rebrickableColorDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RebrickableColor(
    id: reader.readLongOrNull(offsets[0]) ?? 0,
    name: reader.readStringOrNull(offsets[2]) ?? "",
    rgb: reader.readStringOrNull(offsets[3]) ?? "",
  );
  object.isTrans = reader.readBoolOrNull(offsets[1]);
  return object;
}

P _rebrickableColorDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? "") as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RebrickableColorQueryFilter on QueryBuilder<RebrickableColor, RebrickableColor, QFilterCondition> {
  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> idEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> isTransIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isTrans',
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> isTransIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isTrans',
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> isTransEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isTrans',
        value: value,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> rgbEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rgb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> rgbGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rgb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> rgbLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rgb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> rgbBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rgb',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> rgbStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rgb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> rgbEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rgb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> rgbContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rgb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> rgbMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rgb',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> rgbIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rgb',
        value: '',
      ));
    });
  }

  QueryBuilder<RebrickableColor, RebrickableColor, QAfterFilterCondition> rgbIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rgb',
        value: '',
      ));
    });
  }
}

extension RebrickableColorQueryObject on QueryBuilder<RebrickableColor, RebrickableColor, QFilterCondition> {}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RebrickableColor _$RebrickableColorFromJson(Map<String, dynamic> json) => RebrickableColor(
      rgb: json['rgb'] as String? ?? "",
      name: json['name'] as String? ?? "",
      id: (json['id'] as num?)?.toInt() ?? 0,
      externalIds: json['external_ids'],
    )..isTrans = json['is_trans'] as bool?;

Map<String, dynamic> _$RebrickableColorToJson(RebrickableColor instance) => <String, dynamic>{
      'rgb': instance.rgb,
      'name': instance.name,
      'id': instance.id,
      'is_trans': instance.isTrans,
      'external_ids': instance.externalIds,
    };
