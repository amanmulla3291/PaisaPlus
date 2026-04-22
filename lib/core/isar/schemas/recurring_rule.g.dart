// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_rule.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecurringRuleCollection on Isar {
  IsarCollection<RecurringRule> get recurringRules => this.collection();
}

const RecurringRuleSchema = CollectionSchema(
  name: r'RecurringRule',
  id: -4060329745646828675,
  properties: {
    r'accountId': PropertySchema(
      id: 0,
      name: r'accountId',
      type: IsarType.long,
    ),
    r'amountInPaise': PropertySchema(
      id: 1,
      name: r'amountInPaise',
      type: IsarType.long,
    ),
    r'categoryId': PropertySchema(
      id: 2,
      name: r'categoryId',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dayOfMonth': PropertySchema(
      id: 4,
      name: r'dayOfMonth',
      type: IsarType.long,
    ),
    r'dayOfWeek': PropertySchema(
      id: 5,
      name: r'dayOfWeek',
      type: IsarType.long,
    ),
    r'endDate': PropertySchema(
      id: 6,
      name: r'endDate',
      type: IsarType.dateTime,
    ),
    r'frequency': PropertySchema(
      id: 7,
      name: r'frequency',
      type: IsarType.byte,
      enumMap: _RecurringRulefrequencyEnumValueMap,
    ),
    r'isActive': PropertySchema(
      id: 8,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'lastGeneratedDate': PropertySchema(
      id: 9,
      name: r'lastGeneratedDate',
      type: IsarType.dateTime,
    ),
    r'name': PropertySchema(
      id: 10,
      name: r'name',
      type: IsarType.string,
    ),
    r'startDate': PropertySchema(
      id: 11,
      name: r'startDate',
      type: IsarType.dateTime,
    ),
    r'transactionType': PropertySchema(
      id: 12,
      name: r'transactionType',
      type: IsarType.byte,
      enumMap: _RecurringRuletransactionTypeEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 13,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'uuid': PropertySchema(
      id: 14,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _recurringRuleEstimateSize,
  serialize: _recurringRuleSerialize,
  deserialize: _recurringRuleDeserialize,
  deserializeProp: _recurringRuleDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: 2134397340427724972,
      name: r'uuid',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'uuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _recurringRuleGetId,
  getLinks: _recurringRuleGetLinks,
  attach: _recurringRuleAttach,
  version: '3.1.0+1',
);

int _recurringRuleEstimateSize(
  RecurringRule object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _recurringRuleSerialize(
  RecurringRule object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.accountId);
  writer.writeLong(offsets[1], object.amountInPaise);
  writer.writeLong(offsets[2], object.categoryId);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeLong(offsets[4], object.dayOfMonth);
  writer.writeLong(offsets[5], object.dayOfWeek);
  writer.writeDateTime(offsets[6], object.endDate);
  writer.writeByte(offsets[7], object.frequency.index);
  writer.writeBool(offsets[8], object.isActive);
  writer.writeDateTime(offsets[9], object.lastGeneratedDate);
  writer.writeString(offsets[10], object.name);
  writer.writeDateTime(offsets[11], object.startDate);
  writer.writeByte(offsets[12], object.transactionType.index);
  writer.writeDateTime(offsets[13], object.updatedAt);
  writer.writeString(offsets[14], object.uuid);
}

RecurringRule _recurringRuleDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecurringRule();
  object.accountId = reader.readLong(offsets[0]);
  object.amountInPaise = reader.readLong(offsets[1]);
  object.categoryId = reader.readLong(offsets[2]);
  object.createdAt = reader.readDateTime(offsets[3]);
  object.dayOfMonth = reader.readLongOrNull(offsets[4]);
  object.dayOfWeek = reader.readLongOrNull(offsets[5]);
  object.endDate = reader.readDateTimeOrNull(offsets[6]);
  object.frequency =
      _RecurringRulefrequencyValueEnumMap[reader.readByteOrNull(offsets[7])] ??
          RecurringFrequency.daily;
  object.id = id;
  object.isActive = reader.readBool(offsets[8]);
  object.lastGeneratedDate = reader.readDateTimeOrNull(offsets[9]);
  object.name = reader.readString(offsets[10]);
  object.startDate = reader.readDateTime(offsets[11]);
  object.transactionType = _RecurringRuletransactionTypeValueEnumMap[
          reader.readByteOrNull(offsets[12])] ??
      TransactionType.expense;
  object.updatedAt = reader.readDateTime(offsets[13]);
  object.uuid = reader.readString(offsets[14]);
  return object;
}

P _recurringRuleDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (_RecurringRulefrequencyValueEnumMap[
              reader.readByteOrNull(offset)] ??
          RecurringFrequency.daily) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readDateTime(offset)) as P;
    case 12:
      return (_RecurringRuletransactionTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          TransactionType.expense) as P;
    case 13:
      return (reader.readDateTime(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _RecurringRulefrequencyEnumValueMap = {
  'daily': 0,
  'weekly': 1,
  'biweekly': 2,
  'monthly': 3,
  'quarterly': 4,
  'yearly': 5,
};
const _RecurringRulefrequencyValueEnumMap = {
  0: RecurringFrequency.daily,
  1: RecurringFrequency.weekly,
  2: RecurringFrequency.biweekly,
  3: RecurringFrequency.monthly,
  4: RecurringFrequency.quarterly,
  5: RecurringFrequency.yearly,
};
const _RecurringRuletransactionTypeEnumValueMap = {
  'expense': 0,
  'income': 1,
  'transfer': 2,
};
const _RecurringRuletransactionTypeValueEnumMap = {
  0: TransactionType.expense,
  1: TransactionType.income,
  2: TransactionType.transfer,
};

Id _recurringRuleGetId(RecurringRule object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recurringRuleGetLinks(RecurringRule object) {
  return [];
}

void _recurringRuleAttach(
    IsarCollection<dynamic> col, Id id, RecurringRule object) {
  object.id = id;
}

extension RecurringRuleByIndex on IsarCollection<RecurringRule> {
  Future<RecurringRule?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  RecurringRule? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<RecurringRule?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<RecurringRule?> getAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uuid', values);
  }

  Future<int> deleteAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uuid', values);
  }

  int deleteAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uuid', values);
  }

  Future<Id> putByUuid(RecurringRule object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(RecurringRule object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<RecurringRule> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<RecurringRule> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension RecurringRuleQueryWhereSort
    on QueryBuilder<RecurringRule, RecurringRule, QWhere> {
  QueryBuilder<RecurringRule, RecurringRule, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecurringRuleQueryWhere
    on QueryBuilder<RecurringRule, RecurringRule, QWhereClause> {
  QueryBuilder<RecurringRule, RecurringRule, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterWhereClause> uuidEqualTo(
      String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterWhereClause> uuidNotEqualTo(
      String uuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterWhereClause> nameEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterWhereClause> nameNotEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }
}

extension RecurringRuleQueryFilter
    on QueryBuilder<RecurringRule, RecurringRule, QFilterCondition> {
  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      accountIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountId',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      accountIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accountId',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      accountIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accountId',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      accountIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accountId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      amountInPaiseEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountInPaise',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      amountInPaiseGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountInPaise',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      amountInPaiseLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountInPaise',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      amountInPaiseBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountInPaise',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      categoryIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      categoryIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      categoryIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      categoryIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      dayOfMonthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dayOfMonth',
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      dayOfMonthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dayOfMonth',
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      dayOfMonthEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dayOfMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      dayOfMonthGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dayOfMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      dayOfMonthLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dayOfMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      dayOfMonthBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dayOfMonth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      dayOfWeekIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dayOfWeek',
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      dayOfWeekIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dayOfWeek',
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      dayOfWeekEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dayOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      dayOfWeekGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dayOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      dayOfWeekLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dayOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      dayOfWeekBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dayOfWeek',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      endDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endDate',
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      endDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endDate',
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      endDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      endDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      endDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      endDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      frequencyEqualTo(RecurringFrequency value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frequency',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      frequencyGreaterThan(
    RecurringFrequency value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frequency',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      frequencyLessThan(
    RecurringFrequency value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frequency',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      frequencyBetween(
    RecurringFrequency lower,
    RecurringFrequency upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frequency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
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

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition> idLessThan(
    Id value, {
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

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
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

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      lastGeneratedDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastGeneratedDate',
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      lastGeneratedDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastGeneratedDate',
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      lastGeneratedDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastGeneratedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      lastGeneratedDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastGeneratedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      lastGeneratedDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastGeneratedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      lastGeneratedDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastGeneratedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      nameGreaterThan(
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

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      nameLessThan(
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

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      nameStartsWith(
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

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      nameEndsWith(
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

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      startDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      startDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      startDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      startDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      transactionTypeEqualTo(TransactionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transactionType',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      transactionTypeGreaterThan(
    TransactionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transactionType',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      transactionTypeLessThan(
    TransactionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transactionType',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      transactionTypeBetween(
    TransactionType lower,
    TransactionType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transactionType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition> uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition> uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition> uuidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterFilterCondition>
      uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension RecurringRuleQueryObject
    on QueryBuilder<RecurringRule, RecurringRule, QFilterCondition> {}

extension RecurringRuleQueryLinks
    on QueryBuilder<RecurringRule, RecurringRule, QFilterCondition> {}

extension RecurringRuleQuerySortBy
    on QueryBuilder<RecurringRule, RecurringRule, QSortBy> {
  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> sortByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      sortByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      sortByAmountInPaise() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountInPaise', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      sortByAmountInPaiseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountInPaise', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> sortByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      sortByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> sortByDayOfMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfMonth', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      sortByDayOfMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfMonth', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> sortByDayOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfWeek', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      sortByDayOfWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfWeek', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> sortByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> sortByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> sortByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      sortByFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      sortByLastGeneratedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastGeneratedDate', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      sortByLastGeneratedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastGeneratedDate', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> sortByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      sortByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      sortByTransactionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionType', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      sortByTransactionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionType', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension RecurringRuleQuerySortThenBy
    on QueryBuilder<RecurringRule, RecurringRule, QSortThenBy> {
  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> thenByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      thenByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      thenByAmountInPaise() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountInPaise', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      thenByAmountInPaiseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountInPaise', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> thenByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      thenByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> thenByDayOfMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfMonth', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      thenByDayOfMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfMonth', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> thenByDayOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfWeek', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      thenByDayOfWeekDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOfWeek', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> thenByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> thenByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> thenByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      thenByFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      thenByLastGeneratedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastGeneratedDate', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      thenByLastGeneratedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastGeneratedDate', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> thenByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      thenByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      thenByTransactionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionType', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      thenByTransactionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionType', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension RecurringRuleQueryWhereDistinct
    on QueryBuilder<RecurringRule, RecurringRule, QDistinct> {
  QueryBuilder<RecurringRule, RecurringRule, QDistinct> distinctByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountId');
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QDistinct>
      distinctByAmountInPaise() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amountInPaise');
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QDistinct> distinctByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryId');
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QDistinct> distinctByDayOfMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayOfMonth');
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QDistinct> distinctByDayOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayOfWeek');
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QDistinct> distinctByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endDate');
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QDistinct> distinctByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frequency');
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QDistinct>
      distinctByLastGeneratedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastGeneratedDate');
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QDistinct> distinctByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startDate');
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QDistinct>
      distinctByTransactionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transactionType');
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<RecurringRule, RecurringRule, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension RecurringRuleQueryProperty
    on QueryBuilder<RecurringRule, RecurringRule, QQueryProperty> {
  QueryBuilder<RecurringRule, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecurringRule, int, QQueryOperations> accountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountId');
    });
  }

  QueryBuilder<RecurringRule, int, QQueryOperations> amountInPaiseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amountInPaise');
    });
  }

  QueryBuilder<RecurringRule, int, QQueryOperations> categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryId');
    });
  }

  QueryBuilder<RecurringRule, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<RecurringRule, int?, QQueryOperations> dayOfMonthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayOfMonth');
    });
  }

  QueryBuilder<RecurringRule, int?, QQueryOperations> dayOfWeekProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayOfWeek');
    });
  }

  QueryBuilder<RecurringRule, DateTime?, QQueryOperations> endDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endDate');
    });
  }

  QueryBuilder<RecurringRule, RecurringFrequency, QQueryOperations>
      frequencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frequency');
    });
  }

  QueryBuilder<RecurringRule, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<RecurringRule, DateTime?, QQueryOperations>
      lastGeneratedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastGeneratedDate');
    });
  }

  QueryBuilder<RecurringRule, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<RecurringRule, DateTime, QQueryOperations> startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startDate');
    });
  }

  QueryBuilder<RecurringRule, TransactionType, QQueryOperations>
      transactionTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transactionType');
    });
  }

  QueryBuilder<RecurringRule, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<RecurringRule, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
