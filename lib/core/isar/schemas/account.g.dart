// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAccountCollection on Isar {
  IsarCollection<Account> get accounts => this.collection();
}

const AccountSchema = CollectionSchema(
  name: r'Account',
  id: -6646797162501847804,
  properties: {
    r'accountNumberLast4': PropertySchema(
      id: 0,
      name: r'accountNumberLast4',
      type: IsarType.string,
    ),
    r'bankName': PropertySchema(
      id: 1,
      name: r'bankName',
      type: IsarType.string,
    ),
    r'billingCycleDay': PropertySchema(
      id: 2,
      name: r'billingCycleDay',
      type: IsarType.long,
    ),
    r'colorValue': PropertySchema(
      id: 3,
      name: r'colorValue',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 4,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'creditLimitInPaise': PropertySchema(
      id: 5,
      name: r'creditLimitInPaise',
      type: IsarType.long,
    ),
    r'creditLimitInRupees': PropertySchema(
      id: 6,
      name: r'creditLimitInRupees',
      type: IsarType.double,
    ),
    r'iconCodePoint': PropertySchema(
      id: 7,
      name: r'iconCodePoint',
      type: IsarType.long,
    ),
    r'ifscCode': PropertySchema(
      id: 8,
      name: r'ifscCode',
      type: IsarType.string,
    ),
    r'interestRatePercent100': PropertySchema(
      id: 9,
      name: r'interestRatePercent100',
      type: IsarType.long,
    ),
    r'isArchived': PropertySchema(
      id: 10,
      name: r'isArchived',
      type: IsarType.bool,
    ),
    r'isCreditType': PropertySchema(
      id: 11,
      name: r'isCreditType',
      type: IsarType.bool,
    ),
    r'isExcludedFromTotal': PropertySchema(
      id: 12,
      name: r'isExcludedFromTotal',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 13,
      name: r'name',
      type: IsarType.string,
    ),
    r'openingBalanceDate': PropertySchema(
      id: 14,
      name: r'openingBalanceDate',
      type: IsarType.dateTime,
    ),
    r'openingBalanceInPaise': PropertySchema(
      id: 15,
      name: r'openingBalanceInPaise',
      type: IsarType.long,
    ),
    r'openingBalanceInRupees': PropertySchema(
      id: 16,
      name: r'openingBalanceInRupees',
      type: IsarType.double,
    ),
    r'paymentDueDays': PropertySchema(
      id: 17,
      name: r'paymentDueDays',
      type: IsarType.long,
    ),
    r'sortOrder': PropertySchema(
      id: 18,
      name: r'sortOrder',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 19,
      name: r'type',
      type: IsarType.byte,
      enumMap: _AccounttypeEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 20,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'uuid': PropertySchema(
      id: 21,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _accountEstimateSize,
  serialize: _accountSerialize,
  deserialize: _accountDeserialize,
  deserializeProp: _accountDeserializeProp,
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
  getId: _accountGetId,
  getLinks: _accountGetLinks,
  attach: _accountAttach,
  version: '3.1.0+1',
);

int _accountEstimateSize(
  Account object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.accountNumberLast4;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.bankName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.ifscCode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _accountSerialize(
  Account object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accountNumberLast4);
  writer.writeString(offsets[1], object.bankName);
  writer.writeLong(offsets[2], object.billingCycleDay);
  writer.writeLong(offsets[3], object.colorValue);
  writer.writeDateTime(offsets[4], object.createdAt);
  writer.writeLong(offsets[5], object.creditLimitInPaise);
  writer.writeDouble(offsets[6], object.creditLimitInRupees);
  writer.writeLong(offsets[7], object.iconCodePoint);
  writer.writeString(offsets[8], object.ifscCode);
  writer.writeLong(offsets[9], object.interestRatePercent100);
  writer.writeBool(offsets[10], object.isArchived);
  writer.writeBool(offsets[11], object.isCreditType);
  writer.writeBool(offsets[12], object.isExcludedFromTotal);
  writer.writeString(offsets[13], object.name);
  writer.writeDateTime(offsets[14], object.openingBalanceDate);
  writer.writeLong(offsets[15], object.openingBalanceInPaise);
  writer.writeDouble(offsets[16], object.openingBalanceInRupees);
  writer.writeLong(offsets[17], object.paymentDueDays);
  writer.writeLong(offsets[18], object.sortOrder);
  writer.writeByte(offsets[19], object.type.index);
  writer.writeDateTime(offsets[20], object.updatedAt);
  writer.writeString(offsets[21], object.uuid);
}

Account _accountDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Account();
  object.accountNumberLast4 = reader.readStringOrNull(offsets[0]);
  object.bankName = reader.readStringOrNull(offsets[1]);
  object.billingCycleDay = reader.readLongOrNull(offsets[2]);
  object.colorValue = reader.readLong(offsets[3]);
  object.createdAt = reader.readDateTime(offsets[4]);
  object.creditLimitInPaise = reader.readLongOrNull(offsets[5]);
  object.iconCodePoint = reader.readLong(offsets[7]);
  object.id = id;
  object.ifscCode = reader.readStringOrNull(offsets[8]);
  object.interestRatePercent100 = reader.readLongOrNull(offsets[9]);
  object.isArchived = reader.readBool(offsets[10]);
  object.isExcludedFromTotal = reader.readBool(offsets[12]);
  object.name = reader.readString(offsets[13]);
  object.openingBalanceDate = reader.readDateTime(offsets[14]);
  object.openingBalanceInPaise = reader.readLong(offsets[15]);
  object.paymentDueDays = reader.readLongOrNull(offsets[17]);
  object.sortOrder = reader.readLong(offsets[18]);
  object.type = _AccounttypeValueEnumMap[reader.readByteOrNull(offsets[19])] ??
      AccountType.cash;
  object.updatedAt = reader.readDateTime(offsets[20]);
  object.uuid = reader.readString(offsets[21]);
  return object;
}

P _accountDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readDateTime(offset)) as P;
    case 15:
      return (reader.readLong(offset)) as P;
    case 16:
      return (reader.readDouble(offset)) as P;
    case 17:
      return (reader.readLongOrNull(offset)) as P;
    case 18:
      return (reader.readLong(offset)) as P;
    case 19:
      return (_AccounttypeValueEnumMap[reader.readByteOrNull(offset)] ??
          AccountType.cash) as P;
    case 20:
      return (reader.readDateTime(offset)) as P;
    case 21:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AccounttypeEnumValueMap = {
  'cash': 0,
  'bankAccount': 1,
  'creditCard': 2,
  'digitalWallet': 3,
  'investment': 4,
  'loan': 5,
  'other': 6,
};
const _AccounttypeValueEnumMap = {
  0: AccountType.cash,
  1: AccountType.bankAccount,
  2: AccountType.creditCard,
  3: AccountType.digitalWallet,
  4: AccountType.investment,
  5: AccountType.loan,
  6: AccountType.other,
};

Id _accountGetId(Account object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _accountGetLinks(Account object) {
  return [];
}

void _accountAttach(IsarCollection<dynamic> col, Id id, Account object) {
  object.id = id;
}

extension AccountByIndex on IsarCollection<Account> {
  Future<Account?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  Account? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<Account?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<Account?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(Account object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(Account object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<Account> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<Account> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension AccountQueryWhereSort on QueryBuilder<Account, Account, QWhere> {
  QueryBuilder<Account, Account, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AccountQueryWhere on QueryBuilder<Account, Account, QWhereClause> {
  QueryBuilder<Account, Account, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Account, Account, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Account, Account, QAfterWhereClause> idBetween(
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

  QueryBuilder<Account, Account, QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterWhereClause> uuidNotEqualTo(
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

  QueryBuilder<Account, Account, QAfterWhereClause> nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterWhereClause> nameNotEqualTo(
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

extension AccountQueryFilter
    on QueryBuilder<Account, Account, QFilterCondition> {
  QueryBuilder<Account, Account, QAfterFilterCondition>
      accountNumberLast4IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accountNumberLast4',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      accountNumberLast4IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accountNumberLast4',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      accountNumberLast4EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountNumberLast4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      accountNumberLast4GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accountNumberLast4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      accountNumberLast4LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accountNumberLast4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      accountNumberLast4Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accountNumberLast4',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      accountNumberLast4StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'accountNumberLast4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      accountNumberLast4EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'accountNumberLast4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      accountNumberLast4Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'accountNumberLast4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      accountNumberLast4Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'accountNumberLast4',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      accountNumberLast4IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountNumberLast4',
        value: '',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      accountNumberLast4IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accountNumberLast4',
        value: '',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> bankNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bankName',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> bankNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bankName',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> bankNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> bankNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bankName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> bankNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bankName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> bankNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bankName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> bankNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bankName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> bankNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bankName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> bankNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bankName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> bankNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bankName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> bankNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankName',
        value: '',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> bankNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bankName',
        value: '',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      billingCycleDayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'billingCycleDay',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      billingCycleDayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'billingCycleDay',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> billingCycleDayEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'billingCycleDay',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      billingCycleDayGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'billingCycleDay',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> billingCycleDayLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'billingCycleDay',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> billingCycleDayBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'billingCycleDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> colorValueEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> colorValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> colorValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> colorValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'colorValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<Account, Account, QAfterFilterCondition>
      creditLimitInPaiseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'creditLimitInPaise',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      creditLimitInPaiseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'creditLimitInPaise',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      creditLimitInPaiseEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditLimitInPaise',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      creditLimitInPaiseGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creditLimitInPaise',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      creditLimitInPaiseLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creditLimitInPaise',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      creditLimitInPaiseBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creditLimitInPaise',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      creditLimitInRupeesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'creditLimitInRupees',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      creditLimitInRupeesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'creditLimitInRupees',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      creditLimitInRupeesEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditLimitInRupees',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      creditLimitInRupeesGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creditLimitInRupees',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      creditLimitInRupeesLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creditLimitInRupees',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      creditLimitInRupeesBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creditLimitInRupees',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> iconCodePointEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconCodePoint',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      iconCodePointGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iconCodePoint',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> iconCodePointLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iconCodePoint',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> iconCodePointBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iconCodePoint',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> ifscCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ifscCode',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> ifscCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ifscCode',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> ifscCodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ifscCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> ifscCodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ifscCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> ifscCodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ifscCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> ifscCodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ifscCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> ifscCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ifscCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> ifscCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ifscCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> ifscCodeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ifscCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> ifscCodeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ifscCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> ifscCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ifscCode',
        value: '',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> ifscCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ifscCode',
        value: '',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      interestRatePercent100IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'interestRatePercent100',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      interestRatePercent100IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'interestRatePercent100',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      interestRatePercent100EqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interestRatePercent100',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      interestRatePercent100GreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interestRatePercent100',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      interestRatePercent100LessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interestRatePercent100',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      interestRatePercent100Between(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interestRatePercent100',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> isArchivedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isArchived',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> isCreditTypeEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCreditType',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      isExcludedFromTotalEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isExcludedFromTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      openingBalanceDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openingBalanceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      openingBalanceDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'openingBalanceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      openingBalanceDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'openingBalanceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      openingBalanceDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'openingBalanceDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      openingBalanceInPaiseEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openingBalanceInPaise',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      openingBalanceInPaiseGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'openingBalanceInPaise',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      openingBalanceInPaiseLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'openingBalanceInPaise',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      openingBalanceInPaiseBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'openingBalanceInPaise',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      openingBalanceInRupeesEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openingBalanceInRupees',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      openingBalanceInRupeesGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'openingBalanceInRupees',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      openingBalanceInRupeesLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'openingBalanceInRupees',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      openingBalanceInRupeesBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'openingBalanceInRupees',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> paymentDueDaysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'paymentDueDays',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      paymentDueDaysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'paymentDueDays',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> paymentDueDaysEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentDueDays',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition>
      paymentDueDaysGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentDueDays',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> paymentDueDaysLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentDueDays',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> paymentDueDaysBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentDueDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> sortOrderEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sortOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> sortOrderGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sortOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> sortOrderLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sortOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> sortOrderBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sortOrder',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> typeEqualTo(
      AccountType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> typeGreaterThan(
    AccountType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> typeLessThan(
    AccountType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> typeBetween(
    AccountType lower,
    AccountType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> updatedAtGreaterThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> updatedAtLessThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> updatedAtBetween(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> uuidEqualTo(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> uuidGreaterThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> uuidLessThan(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> uuidBetween(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> uuidStartsWith(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> uuidEndsWith(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> uuidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> uuidMatches(
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

  QueryBuilder<Account, Account, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<Account, Account, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension AccountQueryObject
    on QueryBuilder<Account, Account, QFilterCondition> {}

extension AccountQueryLinks
    on QueryBuilder<Account, Account, QFilterCondition> {}

extension AccountQuerySortBy on QueryBuilder<Account, Account, QSortBy> {
  QueryBuilder<Account, Account, QAfterSortBy> sortByAccountNumberLast4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNumberLast4', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByAccountNumberLast4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNumberLast4', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByBankName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankName', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByBankNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankName', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByBillingCycleDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billingCycleDay', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByBillingCycleDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billingCycleDay', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByCreditLimitInPaise() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditLimitInPaise', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByCreditLimitInPaiseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditLimitInPaise', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByCreditLimitInRupees() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditLimitInRupees', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByCreditLimitInRupeesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditLimitInRupees', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByIconCodePoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconCodePoint', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByIconCodePointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconCodePoint', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByIfscCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ifscCode', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByIfscCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ifscCode', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByInterestRatePercent100() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestRatePercent100', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy>
      sortByInterestRatePercent100Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestRatePercent100', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByIsArchivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByIsCreditType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCreditType', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByIsCreditTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCreditType', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByIsExcludedFromTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExcludedFromTotal', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByIsExcludedFromTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExcludedFromTotal', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByOpeningBalanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingBalanceDate', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByOpeningBalanceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingBalanceDate', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByOpeningBalanceInPaise() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingBalanceInPaise', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy>
      sortByOpeningBalanceInPaiseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingBalanceInPaise', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByOpeningBalanceInRupees() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingBalanceInRupees', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy>
      sortByOpeningBalanceInRupeesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingBalanceInRupees', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByPaymentDueDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentDueDays', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByPaymentDueDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentDueDays', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortBySortOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension AccountQuerySortThenBy
    on QueryBuilder<Account, Account, QSortThenBy> {
  QueryBuilder<Account, Account, QAfterSortBy> thenByAccountNumberLast4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNumberLast4', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByAccountNumberLast4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNumberLast4', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByBankName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankName', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByBankNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankName', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByBillingCycleDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billingCycleDay', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByBillingCycleDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billingCycleDay', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByCreditLimitInPaise() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditLimitInPaise', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByCreditLimitInPaiseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditLimitInPaise', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByCreditLimitInRupees() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditLimitInRupees', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByCreditLimitInRupeesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditLimitInRupees', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIconCodePoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconCodePoint', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIconCodePointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconCodePoint', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIfscCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ifscCode', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIfscCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ifscCode', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByInterestRatePercent100() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestRatePercent100', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy>
      thenByInterestRatePercent100Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestRatePercent100', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIsArchivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIsCreditType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCreditType', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIsCreditTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCreditType', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIsExcludedFromTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExcludedFromTotal', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByIsExcludedFromTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExcludedFromTotal', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByOpeningBalanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingBalanceDate', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByOpeningBalanceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingBalanceDate', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByOpeningBalanceInPaise() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingBalanceInPaise', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy>
      thenByOpeningBalanceInPaiseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingBalanceInPaise', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByOpeningBalanceInRupees() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingBalanceInRupees', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy>
      thenByOpeningBalanceInRupeesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingBalanceInRupees', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByPaymentDueDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentDueDays', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByPaymentDueDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentDueDays', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenBySortOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Account, Account, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension AccountQueryWhereDistinct
    on QueryBuilder<Account, Account, QDistinct> {
  QueryBuilder<Account, Account, QDistinct> distinctByAccountNumberLast4(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountNumberLast4',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByBankName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bankName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByBillingCycleDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'billingCycleDay');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'colorValue');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByCreditLimitInPaise() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creditLimitInPaise');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByCreditLimitInRupees() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creditLimitInRupees');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByIconCodePoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconCodePoint');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByIfscCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ifscCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByInterestRatePercent100() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'interestRatePercent100');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isArchived');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByIsCreditType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCreditType');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByIsExcludedFromTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isExcludedFromTotal');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByOpeningBalanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'openingBalanceDate');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByOpeningBalanceInPaise() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'openingBalanceInPaise');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByOpeningBalanceInRupees() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'openingBalanceInRupees');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByPaymentDueDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paymentDueDays');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sortOrder');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<Account, Account, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension AccountQueryProperty
    on QueryBuilder<Account, Account, QQueryProperty> {
  QueryBuilder<Account, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Account, String?, QQueryOperations>
      accountNumberLast4Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountNumberLast4');
    });
  }

  QueryBuilder<Account, String?, QQueryOperations> bankNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bankName');
    });
  }

  QueryBuilder<Account, int?, QQueryOperations> billingCycleDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'billingCycleDay');
    });
  }

  QueryBuilder<Account, int, QQueryOperations> colorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'colorValue');
    });
  }

  QueryBuilder<Account, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Account, int?, QQueryOperations> creditLimitInPaiseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creditLimitInPaise');
    });
  }

  QueryBuilder<Account, double?, QQueryOperations>
      creditLimitInRupeesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creditLimitInRupees');
    });
  }

  QueryBuilder<Account, int, QQueryOperations> iconCodePointProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconCodePoint');
    });
  }

  QueryBuilder<Account, String?, QQueryOperations> ifscCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ifscCode');
    });
  }

  QueryBuilder<Account, int?, QQueryOperations>
      interestRatePercent100Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interestRatePercent100');
    });
  }

  QueryBuilder<Account, bool, QQueryOperations> isArchivedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isArchived');
    });
  }

  QueryBuilder<Account, bool, QQueryOperations> isCreditTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCreditType');
    });
  }

  QueryBuilder<Account, bool, QQueryOperations> isExcludedFromTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isExcludedFromTotal');
    });
  }

  QueryBuilder<Account, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Account, DateTime, QQueryOperations>
      openingBalanceDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'openingBalanceDate');
    });
  }

  QueryBuilder<Account, int, QQueryOperations> openingBalanceInPaiseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'openingBalanceInPaise');
    });
  }

  QueryBuilder<Account, double, QQueryOperations>
      openingBalanceInRupeesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'openingBalanceInRupees');
    });
  }

  QueryBuilder<Account, int?, QQueryOperations> paymentDueDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentDueDays');
    });
  }

  QueryBuilder<Account, int, QQueryOperations> sortOrderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sortOrder');
    });
  }

  QueryBuilder<Account, AccountType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<Account, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<Account, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
