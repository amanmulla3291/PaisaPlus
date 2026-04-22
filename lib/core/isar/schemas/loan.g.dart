// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLoanCollection on Isar {
  IsarCollection<Loan> get loans => this.collection();
}

const LoanSchema = CollectionSchema(
  name: r'Loan',
  id: 3165146227223573679,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dueDate': PropertySchema(
      id: 1,
      name: r'dueDate',
      type: IsarType.dateTime,
    ),
    r'interestRatePercent100': PropertySchema(
      id: 2,
      name: r'interestRatePercent100',
      type: IsarType.long,
    ),
    r'isSettled': PropertySchema(
      id: 3,
      name: r'isSettled',
      type: IsarType.bool,
    ),
    r'linkedAccountId': PropertySchema(
      id: 4,
      name: r'linkedAccountId',
      type: IsarType.long,
    ),
    r'loanType': PropertySchema(
      id: 5,
      name: r'loanType',
      type: IsarType.byte,
      enumMap: _LoanloanTypeEnumValueMap,
    ),
    r'name': PropertySchema(
      id: 6,
      name: r'name',
      type: IsarType.string,
    ),
    r'outstandingAmountInPaise': PropertySchema(
      id: 7,
      name: r'outstandingAmountInPaise',
      type: IsarType.long,
    ),
    r'personContact': PropertySchema(
      id: 8,
      name: r'personContact',
      type: IsarType.string,
    ),
    r'personName': PropertySchema(
      id: 9,
      name: r'personName',
      type: IsarType.string,
    ),
    r'principalAmountInPaise': PropertySchema(
      id: 10,
      name: r'principalAmountInPaise',
      type: IsarType.long,
    ),
    r'startDate': PropertySchema(
      id: 11,
      name: r'startDate',
      type: IsarType.dateTime,
    ),
    r'updatedAt': PropertySchema(
      id: 12,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'uuid': PropertySchema(
      id: 13,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _loanEstimateSize,
  serialize: _loanSerialize,
  deserialize: _loanDeserialize,
  deserializeProp: _loanDeserializeProp,
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
    ),
    r'personName': IndexSchema(
      id: 1248926044822021493,
      name: r'personName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'personName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _loanGetId,
  getLinks: _loanGetLinks,
  attach: _loanAttach,
  version: '3.1.0+1',
);

int _loanEstimateSize(
  Loan object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.personContact;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.personName.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _loanSerialize(
  Loan object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeDateTime(offsets[1], object.dueDate);
  writer.writeLong(offsets[2], object.interestRatePercent100);
  writer.writeBool(offsets[3], object.isSettled);
  writer.writeLong(offsets[4], object.linkedAccountId);
  writer.writeByte(offsets[5], object.loanType.index);
  writer.writeString(offsets[6], object.name);
  writer.writeLong(offsets[7], object.outstandingAmountInPaise);
  writer.writeString(offsets[8], object.personContact);
  writer.writeString(offsets[9], object.personName);
  writer.writeLong(offsets[10], object.principalAmountInPaise);
  writer.writeDateTime(offsets[11], object.startDate);
  writer.writeDateTime(offsets[12], object.updatedAt);
  writer.writeString(offsets[13], object.uuid);
}

Loan _loanDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Loan();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.dueDate = reader.readDateTimeOrNull(offsets[1]);
  object.id = id;
  object.interestRatePercent100 = reader.readLongOrNull(offsets[2]);
  object.isSettled = reader.readBool(offsets[3]);
  object.linkedAccountId = reader.readLongOrNull(offsets[4]);
  object.loanType =
      _LoanloanTypeValueEnumMap[reader.readByteOrNull(offsets[5])] ??
          LoanType.borrowed;
  object.name = reader.readString(offsets[6]);
  object.outstandingAmountInPaise = reader.readLong(offsets[7]);
  object.personContact = reader.readStringOrNull(offsets[8]);
  object.personName = reader.readString(offsets[9]);
  object.principalAmountInPaise = reader.readLong(offsets[10]);
  object.startDate = reader.readDateTime(offsets[11]);
  object.updatedAt = reader.readDateTime(offsets[12]);
  object.uuid = reader.readString(offsets[13]);
  return object;
}

P _loanDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (_LoanloanTypeValueEnumMap[reader.readByteOrNull(offset)] ??
          LoanType.borrowed) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readDateTime(offset)) as P;
    case 12:
      return (reader.readDateTime(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _LoanloanTypeEnumValueMap = {
  'borrowed': 0,
  'lent': 1,
};
const _LoanloanTypeValueEnumMap = {
  0: LoanType.borrowed,
  1: LoanType.lent,
};

Id _loanGetId(Loan object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _loanGetLinks(Loan object) {
  return [];
}

void _loanAttach(IsarCollection<dynamic> col, Id id, Loan object) {
  object.id = id;
}

extension LoanByIndex on IsarCollection<Loan> {
  Future<Loan?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  Loan? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<Loan?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<Loan?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(Loan object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(Loan object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<Loan> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<Loan> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension LoanQueryWhereSort on QueryBuilder<Loan, Loan, QWhere> {
  QueryBuilder<Loan, Loan, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LoanQueryWhere on QueryBuilder<Loan, Loan, QWhereClause> {
  QueryBuilder<Loan, Loan, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Loan, Loan, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Loan, Loan, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Loan, Loan, QAfterWhereClause> idBetween(
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

  QueryBuilder<Loan, Loan, QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterWhereClause> uuidNotEqualTo(String uuid) {
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

  QueryBuilder<Loan, Loan, QAfterWhereClause> nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterWhereClause> nameNotEqualTo(String name) {
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

  QueryBuilder<Loan, Loan, QAfterWhereClause> personNameEqualTo(
      String personName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'personName',
        value: [personName],
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterWhereClause> personNameNotEqualTo(
      String personName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'personName',
              lower: [],
              upper: [personName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'personName',
              lower: [personName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'personName',
              lower: [personName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'personName',
              lower: [],
              upper: [personName],
              includeUpper: false,
            ));
      }
    });
  }
}

extension LoanQueryFilter on QueryBuilder<Loan, Loan, QFilterCondition> {
  QueryBuilder<Loan, Loan, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> dueDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dueDate',
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> dueDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dueDate',
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> dueDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> dueDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> dueDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> dueDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dueDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition>
      interestRatePercent100IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'interestRatePercent100',
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition>
      interestRatePercent100IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'interestRatePercent100',
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> interestRatePercent100EqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interestRatePercent100',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition>
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition>
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> interestRatePercent100Between(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> isSettledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSettled',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> linkedAccountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'linkedAccountId',
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> linkedAccountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'linkedAccountId',
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> linkedAccountIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkedAccountId',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> linkedAccountIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'linkedAccountId',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> linkedAccountIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'linkedAccountId',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> linkedAccountIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'linkedAccountId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> loanTypeEqualTo(
      LoanType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loanType',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> loanTypeGreaterThan(
    LoanType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loanType',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> loanTypeLessThan(
    LoanType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loanType',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> loanTypeBetween(
    LoanType lower,
    LoanType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loanType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition>
      outstandingAmountInPaiseEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'outstandingAmountInPaise',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition>
      outstandingAmountInPaiseGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'outstandingAmountInPaise',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition>
      outstandingAmountInPaiseLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'outstandingAmountInPaise',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition>
      outstandingAmountInPaiseBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'outstandingAmountInPaise',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personContactIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'personContact',
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personContactIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'personContact',
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personContactEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personContact',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personContactGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'personContact',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personContactLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'personContact',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personContactBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'personContact',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personContactStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'personContact',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personContactEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'personContact',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personContactContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'personContact',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personContactMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'personContact',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personContactIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personContact',
        value: '',
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personContactIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'personContact',
        value: '',
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'personName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'personName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'personName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'personName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'personName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'personName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'personName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personName',
        value: '',
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> personNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'personName',
        value: '',
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> principalAmountInPaiseEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'principalAmountInPaise',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition>
      principalAmountInPaiseGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'principalAmountInPaise',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition>
      principalAmountInPaiseLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'principalAmountInPaise',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> principalAmountInPaiseBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'principalAmountInPaise',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> startDateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> startDateGreaterThan(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> startDateLessThan(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> startDateBetween(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> updatedAtGreaterThan(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> updatedAtLessThan(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> updatedAtBetween(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> uuidEqualTo(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> uuidGreaterThan(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> uuidLessThan(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> uuidBetween(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> uuidStartsWith(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> uuidEndsWith(
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

  QueryBuilder<Loan, Loan, QAfterFilterCondition> uuidContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> uuidMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<Loan, Loan, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension LoanQueryObject on QueryBuilder<Loan, Loan, QFilterCondition> {}

extension LoanQueryLinks on QueryBuilder<Loan, Loan, QFilterCondition> {}

extension LoanQuerySortBy on QueryBuilder<Loan, Loan, QSortBy> {
  QueryBuilder<Loan, Loan, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByInterestRatePercent100() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestRatePercent100', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByInterestRatePercent100Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestRatePercent100', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByIsSettled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSettled', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByIsSettledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSettled', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByLinkedAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAccountId', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByLinkedAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAccountId', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByLoanType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanType', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByLoanTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanType', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByOutstandingAmountInPaise() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outstandingAmountInPaise', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByOutstandingAmountInPaiseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outstandingAmountInPaise', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByPersonContact() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personContact', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByPersonContactDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personContact', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByPersonName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personName', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByPersonNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personName', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByPrincipalAmountInPaise() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'principalAmountInPaise', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByPrincipalAmountInPaiseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'principalAmountInPaise', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension LoanQuerySortThenBy on QueryBuilder<Loan, Loan, QSortThenBy> {
  QueryBuilder<Loan, Loan, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByInterestRatePercent100() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestRatePercent100', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByInterestRatePercent100Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interestRatePercent100', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByIsSettled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSettled', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByIsSettledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSettled', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByLinkedAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAccountId', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByLinkedAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAccountId', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByLoanType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanType', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByLoanTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanType', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByOutstandingAmountInPaise() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outstandingAmountInPaise', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByOutstandingAmountInPaiseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outstandingAmountInPaise', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByPersonContact() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personContact', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByPersonContactDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personContact', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByPersonName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personName', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByPersonNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personName', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByPrincipalAmountInPaise() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'principalAmountInPaise', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByPrincipalAmountInPaiseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'principalAmountInPaise', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Loan, Loan, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension LoanQueryWhereDistinct on QueryBuilder<Loan, Loan, QDistinct> {
  QueryBuilder<Loan, Loan, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Loan, Loan, QDistinct> distinctByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dueDate');
    });
  }

  QueryBuilder<Loan, Loan, QDistinct> distinctByInterestRatePercent100() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'interestRatePercent100');
    });
  }

  QueryBuilder<Loan, Loan, QDistinct> distinctByIsSettled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSettled');
    });
  }

  QueryBuilder<Loan, Loan, QDistinct> distinctByLinkedAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'linkedAccountId');
    });
  }

  QueryBuilder<Loan, Loan, QDistinct> distinctByLoanType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loanType');
    });
  }

  QueryBuilder<Loan, Loan, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Loan, Loan, QDistinct> distinctByOutstandingAmountInPaise() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'outstandingAmountInPaise');
    });
  }

  QueryBuilder<Loan, Loan, QDistinct> distinctByPersonContact(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personContact',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Loan, Loan, QDistinct> distinctByPersonName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Loan, Loan, QDistinct> distinctByPrincipalAmountInPaise() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'principalAmountInPaise');
    });
  }

  QueryBuilder<Loan, Loan, QDistinct> distinctByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startDate');
    });
  }

  QueryBuilder<Loan, Loan, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<Loan, Loan, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension LoanQueryProperty on QueryBuilder<Loan, Loan, QQueryProperty> {
  QueryBuilder<Loan, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Loan, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Loan, DateTime?, QQueryOperations> dueDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dueDate');
    });
  }

  QueryBuilder<Loan, int?, QQueryOperations> interestRatePercent100Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interestRatePercent100');
    });
  }

  QueryBuilder<Loan, bool, QQueryOperations> isSettledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSettled');
    });
  }

  QueryBuilder<Loan, int?, QQueryOperations> linkedAccountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'linkedAccountId');
    });
  }

  QueryBuilder<Loan, LoanType, QQueryOperations> loanTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loanType');
    });
  }

  QueryBuilder<Loan, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Loan, int, QQueryOperations> outstandingAmountInPaiseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'outstandingAmountInPaise');
    });
  }

  QueryBuilder<Loan, String?, QQueryOperations> personContactProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personContact');
    });
  }

  QueryBuilder<Loan, String, QQueryOperations> personNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personName');
    });
  }

  QueryBuilder<Loan, int, QQueryOperations> principalAmountInPaiseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'principalAmountInPaise');
    });
  }

  QueryBuilder<Loan, DateTime, QQueryOperations> startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startDate');
    });
  }

  QueryBuilder<Loan, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<Loan, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
