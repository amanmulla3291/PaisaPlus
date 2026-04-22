// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTransactionCollection on Isar {
  IsarCollection<Transaction> get transactions => this.collection();
}

const TransactionSchema = CollectionSchema(
  name: r'Transaction',
  id: 5320225499417954855,
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
    r'amountInRupees': PropertySchema(
      id: 2,
      name: r'amountInRupees',
      type: IsarType.double,
    ),
    r'attachmentPath': PropertySchema(
      id: 3,
      name: r'attachmentPath',
      type: IsarType.string,
    ),
    r'categoryId': PropertySchema(
      id: 4,
      name: r'categoryId',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 5,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'deletedAt': PropertySchema(
      id: 6,
      name: r'deletedAt',
      type: IsarType.dateTime,
    ),
    r'entryMode': PropertySchema(
      id: 7,
      name: r'entryMode',
      type: IsarType.byte,
      enumMap: _TransactionentryModeEnumValueMap,
    ),
    r'isDeleted': PropertySchema(
      id: 8,
      name: r'isDeleted',
      type: IsarType.bool,
    ),
    r'isTransferCredit': PropertySchema(
      id: 9,
      name: r'isTransferCredit',
      type: IsarType.bool,
    ),
    r'isTransferDebit': PropertySchema(
      id: 10,
      name: r'isTransferDebit',
      type: IsarType.bool,
    ),
    r'loanId': PropertySchema(
      id: 11,
      name: r'loanId',
      type: IsarType.long,
    ),
    r'locationLatMicro': PropertySchema(
      id: 12,
      name: r'locationLatMicro',
      type: IsarType.long,
    ),
    r'locationLngMicro': PropertySchema(
      id: 13,
      name: r'locationLngMicro',
      type: IsarType.long,
    ),
    r'locationName': PropertySchema(
      id: 14,
      name: r'locationName',
      type: IsarType.string,
    ),
    r'note': PropertySchema(
      id: 15,
      name: r'note',
      type: IsarType.string,
    ),
    r'payee': PropertySchema(
      id: 16,
      name: r'payee',
      type: IsarType.string,
    ),
    r'recurringRuleId': PropertySchema(
      id: 17,
      name: r'recurringRuleId',
      type: IsarType.long,
    ),
    r'tags': PropertySchema(
      id: 18,
      name: r'tags',
      type: IsarType.stringList,
    ),
    r'toAccountId': PropertySchema(
      id: 19,
      name: r'toAccountId',
      type: IsarType.long,
    ),
    r'transactionDate': PropertySchema(
      id: 20,
      name: r'transactionDate',
      type: IsarType.dateTime,
    ),
    r'transferPairId': PropertySchema(
      id: 21,
      name: r'transferPairId',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 22,
      name: r'type',
      type: IsarType.byte,
      enumMap: _TransactiontypeEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 23,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'uuid': PropertySchema(
      id: 24,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _transactionEstimateSize,
  serialize: _transactionSerialize,
  deserialize: _transactionDeserialize,
  deserializeProp: _transactionDeserializeProp,
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
    r'toAccountId': IndexSchema(
      id: 1956423193434608400,
      name: r'toAccountId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'toAccountId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'transferPairId': IndexSchema(
      id: 3358128702183047017,
      name: r'transferPairId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'transferPairId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'transactionDate': IndexSchema(
      id: 3386085016894654755,
      name: r'transactionDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'transactionDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'recurringRuleId': IndexSchema(
      id: 7860537796394788863,
      name: r'recurringRuleId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'recurringRuleId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'loanId': IndexSchema(
      id: -2433238998242736672,
      name: r'loanId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'loanId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isDeleted': IndexSchema(
      id: -786475870904832312,
      name: r'isDeleted',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isDeleted',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _transactionGetId,
  getLinks: _transactionGetLinks,
  attach: _transactionAttach,
  version: '3.1.0+1',
);

int _transactionEstimateSize(
  Transaction object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.attachmentPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.locationName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.note;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.payee;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.tags.length * 3;
  {
    for (var i = 0; i < object.tags.length; i++) {
      final value = object.tags[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.transferPairId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _transactionSerialize(
  Transaction object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.accountId);
  writer.writeLong(offsets[1], object.amountInPaise);
  writer.writeDouble(offsets[2], object.amountInRupees);
  writer.writeString(offsets[3], object.attachmentPath);
  writer.writeLong(offsets[4], object.categoryId);
  writer.writeDateTime(offsets[5], object.createdAt);
  writer.writeDateTime(offsets[6], object.deletedAt);
  writer.writeByte(offsets[7], object.entryMode.index);
  writer.writeBool(offsets[8], object.isDeleted);
  writer.writeBool(offsets[9], object.isTransferCredit);
  writer.writeBool(offsets[10], object.isTransferDebit);
  writer.writeLong(offsets[11], object.loanId);
  writer.writeLong(offsets[12], object.locationLatMicro);
  writer.writeLong(offsets[13], object.locationLngMicro);
  writer.writeString(offsets[14], object.locationName);
  writer.writeString(offsets[15], object.note);
  writer.writeString(offsets[16], object.payee);
  writer.writeLong(offsets[17], object.recurringRuleId);
  writer.writeStringList(offsets[18], object.tags);
  writer.writeLong(offsets[19], object.toAccountId);
  writer.writeDateTime(offsets[20], object.transactionDate);
  writer.writeString(offsets[21], object.transferPairId);
  writer.writeByte(offsets[22], object.type.index);
  writer.writeDateTime(offsets[23], object.updatedAt);
  writer.writeString(offsets[24], object.uuid);
}

Transaction _transactionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Transaction();
  object.accountId = reader.readLong(offsets[0]);
  object.amountInPaise = reader.readLong(offsets[1]);
  object.attachmentPath = reader.readStringOrNull(offsets[3]);
  object.categoryId = reader.readLong(offsets[4]);
  object.createdAt = reader.readDateTime(offsets[5]);
  object.deletedAt = reader.readDateTimeOrNull(offsets[6]);
  object.entryMode =
      _TransactionentryModeValueEnumMap[reader.readByteOrNull(offsets[7])] ??
          TransactionEntryMode.manual;
  object.id = id;
  object.isDeleted = reader.readBool(offsets[8]);
  object.loanId = reader.readLongOrNull(offsets[11]);
  object.locationLatMicro = reader.readLongOrNull(offsets[12]);
  object.locationLngMicro = reader.readLongOrNull(offsets[13]);
  object.locationName = reader.readStringOrNull(offsets[14]);
  object.note = reader.readStringOrNull(offsets[15]);
  object.payee = reader.readStringOrNull(offsets[16]);
  object.recurringRuleId = reader.readLongOrNull(offsets[17]);
  object.tags = reader.readStringList(offsets[18]) ?? [];
  object.toAccountId = reader.readLongOrNull(offsets[19]);
  object.transactionDate = reader.readDateTime(offsets[20]);
  object.transferPairId = reader.readStringOrNull(offsets[21]);
  object.type =
      _TransactiontypeValueEnumMap[reader.readByteOrNull(offsets[22])] ??
          TransactionType.expense;
  object.updatedAt = reader.readDateTime(offsets[23]);
  object.uuid = reader.readString(offsets[24]);
  return object;
}

P _transactionDeserializeProp<P>(
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
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (_TransactionentryModeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          TransactionEntryMode.manual) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readLongOrNull(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    case 13:
      return (reader.readLongOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readLongOrNull(offset)) as P;
    case 18:
      return (reader.readStringList(offset) ?? []) as P;
    case 19:
      return (reader.readLongOrNull(offset)) as P;
    case 20:
      return (reader.readDateTime(offset)) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    case 22:
      return (_TransactiontypeValueEnumMap[reader.readByteOrNull(offset)] ??
          TransactionType.expense) as P;
    case 23:
      return (reader.readDateTime(offset)) as P;
    case 24:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TransactionentryModeEnumValueMap = {
  'manual': 0,
  'recurring': 1,
  'imported': 2,
};
const _TransactionentryModeValueEnumMap = {
  0: TransactionEntryMode.manual,
  1: TransactionEntryMode.recurring,
  2: TransactionEntryMode.imported,
};
const _TransactiontypeEnumValueMap = {
  'expense': 0,
  'income': 1,
  'transfer': 2,
};
const _TransactiontypeValueEnumMap = {
  0: TransactionType.expense,
  1: TransactionType.income,
  2: TransactionType.transfer,
};

Id _transactionGetId(Transaction object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _transactionGetLinks(Transaction object) {
  return [];
}

void _transactionAttach(
    IsarCollection<dynamic> col, Id id, Transaction object) {
  object.id = id;
}

extension TransactionByIndex on IsarCollection<Transaction> {
  Future<Transaction?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  Transaction? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<Transaction?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<Transaction?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(Transaction object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(Transaction object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<Transaction> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<Transaction> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension TransactionQueryWhereSort
    on QueryBuilder<Transaction, Transaction, QWhere> {
  QueryBuilder<Transaction, Transaction, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhere> anyToAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'toAccountId'),
      );
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhere> anyTransactionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'transactionDate'),
      );
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhere> anyRecurringRuleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'recurringRuleId'),
      );
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhere> anyLoanId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'loanId'),
      );
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhere> anyIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isDeleted'),
      );
    });
  }
}

extension TransactionQueryWhere
    on QueryBuilder<Transaction, Transaction, QWhereClause> {
  QueryBuilder<Transaction, Transaction, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<Transaction, Transaction, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause> idBetween(
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

  QueryBuilder<Transaction, Transaction, QAfterWhereClause> uuidEqualTo(
      String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause> uuidNotEqualTo(
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

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      toAccountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'toAccountId',
        value: [null],
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      toAccountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'toAccountId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause> toAccountIdEqualTo(
      int? toAccountId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'toAccountId',
        value: [toAccountId],
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      toAccountIdNotEqualTo(int? toAccountId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'toAccountId',
              lower: [],
              upper: [toAccountId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'toAccountId',
              lower: [toAccountId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'toAccountId',
              lower: [toAccountId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'toAccountId',
              lower: [],
              upper: [toAccountId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      toAccountIdGreaterThan(
    int? toAccountId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'toAccountId',
        lower: [toAccountId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause> toAccountIdLessThan(
    int? toAccountId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'toAccountId',
        lower: [],
        upper: [toAccountId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause> toAccountIdBetween(
    int? lowerToAccountId,
    int? upperToAccountId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'toAccountId',
        lower: [lowerToAccountId],
        includeLower: includeLower,
        upper: [upperToAccountId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      transferPairIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'transferPairId',
        value: [null],
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      transferPairIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'transferPairId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      transferPairIdEqualTo(String? transferPairId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'transferPairId',
        value: [transferPairId],
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      transferPairIdNotEqualTo(String? transferPairId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transferPairId',
              lower: [],
              upper: [transferPairId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transferPairId',
              lower: [transferPairId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transferPairId',
              lower: [transferPairId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transferPairId',
              lower: [],
              upper: [transferPairId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      transactionDateEqualTo(DateTime transactionDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'transactionDate',
        value: [transactionDate],
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      transactionDateNotEqualTo(DateTime transactionDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transactionDate',
              lower: [],
              upper: [transactionDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transactionDate',
              lower: [transactionDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transactionDate',
              lower: [transactionDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transactionDate',
              lower: [],
              upper: [transactionDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      transactionDateGreaterThan(
    DateTime transactionDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'transactionDate',
        lower: [transactionDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      transactionDateLessThan(
    DateTime transactionDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'transactionDate',
        lower: [],
        upper: [transactionDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      transactionDateBetween(
    DateTime lowerTransactionDate,
    DateTime upperTransactionDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'transactionDate',
        lower: [lowerTransactionDate],
        includeLower: includeLower,
        upper: [upperTransactionDate],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      recurringRuleIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'recurringRuleId',
        value: [null],
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      recurringRuleIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'recurringRuleId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      recurringRuleIdEqualTo(int? recurringRuleId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'recurringRuleId',
        value: [recurringRuleId],
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      recurringRuleIdNotEqualTo(int? recurringRuleId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recurringRuleId',
              lower: [],
              upper: [recurringRuleId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recurringRuleId',
              lower: [recurringRuleId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recurringRuleId',
              lower: [recurringRuleId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recurringRuleId',
              lower: [],
              upper: [recurringRuleId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      recurringRuleIdGreaterThan(
    int? recurringRuleId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'recurringRuleId',
        lower: [recurringRuleId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      recurringRuleIdLessThan(
    int? recurringRuleId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'recurringRuleId',
        lower: [],
        upper: [recurringRuleId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause>
      recurringRuleIdBetween(
    int? lowerRecurringRuleId,
    int? upperRecurringRuleId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'recurringRuleId',
        lower: [lowerRecurringRuleId],
        includeLower: includeLower,
        upper: [upperRecurringRuleId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause> loanIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'loanId',
        value: [null],
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause> loanIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'loanId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause> loanIdEqualTo(
      int? loanId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'loanId',
        value: [loanId],
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause> loanIdNotEqualTo(
      int? loanId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'loanId',
              lower: [],
              upper: [loanId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'loanId',
              lower: [loanId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'loanId',
              lower: [loanId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'loanId',
              lower: [],
              upper: [loanId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause> loanIdGreaterThan(
    int? loanId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'loanId',
        lower: [loanId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause> loanIdLessThan(
    int? loanId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'loanId',
        lower: [],
        upper: [loanId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause> loanIdBetween(
    int? lowerLoanId,
    int? upperLoanId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'loanId',
        lower: [lowerLoanId],
        includeLower: includeLower,
        upper: [upperLoanId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause> isDeletedEqualTo(
      bool isDeleted) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isDeleted',
        value: [isDeleted],
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterWhereClause> isDeletedNotEqualTo(
      bool isDeleted) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDeleted',
              lower: [],
              upper: [isDeleted],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDeleted',
              lower: [isDeleted],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDeleted',
              lower: [isDeleted],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDeleted',
              lower: [],
              upper: [isDeleted],
              includeUpper: false,
            ));
      }
    });
  }
}

extension TransactionQueryFilter
    on QueryBuilder<Transaction, Transaction, QFilterCondition> {
  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      accountIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      amountInPaiseEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountInPaise',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      amountInRupeesEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountInRupees',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      amountInRupeesGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountInRupees',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      amountInRupeesLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountInRupees',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      amountInRupeesBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountInRupees',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      attachmentPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'attachmentPath',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      attachmentPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'attachmentPath',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      attachmentPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'attachmentPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      attachmentPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'attachmentPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      attachmentPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'attachmentPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      attachmentPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'attachmentPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      attachmentPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'attachmentPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      attachmentPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'attachmentPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      attachmentPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'attachmentPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      attachmentPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'attachmentPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      attachmentPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'attachmentPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      attachmentPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'attachmentPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      categoryIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      deletedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deletedAt',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      deletedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deletedAt',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      deletedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deletedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      deletedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deletedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      deletedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deletedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      deletedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deletedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      entryModeEqualTo(TransactionEntryMode value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryMode',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      entryModeGreaterThan(
    TransactionEntryMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'entryMode',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      entryModeLessThan(
    TransactionEntryMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'entryMode',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      entryModeBetween(
    TransactionEntryMode lower,
    TransactionEntryMode upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'entryMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      isDeletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      isTransferCreditEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isTransferCredit',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      isTransferDebitEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isTransferDebit',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> loanIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'loanId',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      loanIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'loanId',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> loanIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loanId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      loanIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loanId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> loanIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loanId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> loanIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loanId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationLatMicroIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'locationLatMicro',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationLatMicroIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'locationLatMicro',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationLatMicroEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationLatMicro',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationLatMicroGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locationLatMicro',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationLatMicroLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locationLatMicro',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationLatMicroBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locationLatMicro',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationLngMicroIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'locationLngMicro',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationLngMicroIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'locationLngMicro',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationLngMicroEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationLngMicro',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationLngMicroGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locationLngMicro',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationLngMicroLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locationLngMicro',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationLngMicroBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locationLngMicro',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'locationName',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'locationName',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locationName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'locationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'locationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'locationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'locationName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationName',
        value: '',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      locationNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'locationName',
        value: '',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> noteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      noteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> noteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> noteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> noteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> noteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'note',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> noteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> noteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> noteContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> noteMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'note',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> payeeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'payee',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      payeeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'payee',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> payeeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payee',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      payeeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'payee',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> payeeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'payee',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> payeeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'payee',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> payeeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'payee',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> payeeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'payee',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> payeeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'payee',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> payeeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'payee',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> payeeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payee',
        value: '',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      payeeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'payee',
        value: '',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      recurringRuleIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recurringRuleId',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      recurringRuleIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recurringRuleId',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      recurringRuleIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurringRuleId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      recurringRuleIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recurringRuleId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      recurringRuleIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recurringRuleId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      recurringRuleIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recurringRuleId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      tagsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      tagsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      tagsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      tagsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tags',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      tagsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      tagsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      tagsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      tagsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      tagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      tagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      tagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      tagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      tagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      toAccountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'toAccountId',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      toAccountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'toAccountId',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      toAccountIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toAccountId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      toAccountIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toAccountId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      toAccountIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toAccountId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      toAccountIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toAccountId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      transactionDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transactionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      transactionDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transactionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      transactionDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transactionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      transactionDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transactionDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      transferPairIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'transferPairId',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      transferPairIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'transferPairId',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      transferPairIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transferPairId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      transferPairIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transferPairId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      transferPairIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transferPairId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      transferPairIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transferPairId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      transferPairIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'transferPairId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      transferPairIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'transferPairId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      transferPairIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'transferPairId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      transferPairIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'transferPairId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      transferPairIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transferPairId',
        value: '',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      transferPairIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'transferPairId',
        value: '',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> typeEqualTo(
      TransactionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> typeGreaterThan(
    TransactionType value, {
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> typeLessThan(
    TransactionType value, {
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> typeBetween(
    TransactionType lower,
    TransactionType upper, {
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> uuidEqualTo(
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> uuidGreaterThan(
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> uuidLessThan(
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> uuidBetween(
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> uuidStartsWith(
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> uuidEndsWith(
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> uuidContains(
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> uuidMatches(
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

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterFilterCondition>
      uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension TransactionQueryObject
    on QueryBuilder<Transaction, Transaction, QFilterCondition> {}

extension TransactionQueryLinks
    on QueryBuilder<Transaction, Transaction, QFilterCondition> {}

extension TransactionQuerySortBy
    on QueryBuilder<Transaction, Transaction, QSortBy> {
  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByAmountInPaise() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountInPaise', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      sortByAmountInPaiseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountInPaise', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByAmountInRupees() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountInRupees', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      sortByAmountInRupeesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountInRupees', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByAttachmentPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attachmentPath', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      sortByAttachmentPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attachmentPath', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByDeletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByDeletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByEntryMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryMode', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByEntryModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryMode', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      sortByIsTransferCredit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTransferCredit', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      sortByIsTransferCreditDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTransferCredit', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByIsTransferDebit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTransferDebit', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      sortByIsTransferDebitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTransferDebit', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByLoanId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanId', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByLoanIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanId', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      sortByLocationLatMicro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationLatMicro', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      sortByLocationLatMicroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationLatMicro', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      sortByLocationLngMicro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationLngMicro', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      sortByLocationLngMicroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationLngMicro', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByLocationName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationName', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      sortByLocationNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationName', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByPayee() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payee', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByPayeeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payee', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByRecurringRuleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRuleId', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      sortByRecurringRuleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRuleId', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByToAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAccountId', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByToAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAccountId', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByTransactionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionDate', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      sortByTransactionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionDate', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByTransferPairId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferPairId', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      sortByTransferPairIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferPairId', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension TransactionQuerySortThenBy
    on QueryBuilder<Transaction, Transaction, QSortThenBy> {
  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByAmountInPaise() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountInPaise', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      thenByAmountInPaiseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountInPaise', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByAmountInRupees() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountInRupees', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      thenByAmountInRupeesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountInRupees', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByAttachmentPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attachmentPath', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      thenByAttachmentPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attachmentPath', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByDeletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByDeletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByEntryMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryMode', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByEntryModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryMode', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      thenByIsTransferCredit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTransferCredit', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      thenByIsTransferCreditDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTransferCredit', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByIsTransferDebit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTransferDebit', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      thenByIsTransferDebitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTransferDebit', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByLoanId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanId', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByLoanIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanId', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      thenByLocationLatMicro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationLatMicro', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      thenByLocationLatMicroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationLatMicro', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      thenByLocationLngMicro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationLngMicro', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      thenByLocationLngMicroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationLngMicro', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByLocationName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationName', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      thenByLocationNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationName', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByPayee() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payee', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByPayeeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payee', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByRecurringRuleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRuleId', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      thenByRecurringRuleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRuleId', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByToAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAccountId', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByToAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAccountId', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByTransactionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionDate', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      thenByTransactionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionDate', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByTransferPairId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferPairId', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy>
      thenByTransferPairIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferPairId', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Transaction, Transaction, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension TransactionQueryWhereDistinct
    on QueryBuilder<Transaction, Transaction, QDistinct> {
  QueryBuilder<Transaction, Transaction, QDistinct> distinctByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountId');
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct> distinctByAmountInPaise() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amountInPaise');
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct> distinctByAmountInRupees() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amountInRupees');
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct> distinctByAttachmentPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'attachmentPath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct> distinctByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryId');
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct> distinctByDeletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deletedAt');
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct> distinctByEntryMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entryMode');
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct> distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeleted');
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct>
      distinctByIsTransferCredit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isTransferCredit');
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct>
      distinctByIsTransferDebit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isTransferDebit');
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct> distinctByLoanId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loanId');
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct>
      distinctByLocationLatMicro() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'locationLatMicro');
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct>
      distinctByLocationLngMicro() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'locationLngMicro');
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct> distinctByLocationName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'locationName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct> distinctByNote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct> distinctByPayee(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'payee', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct>
      distinctByRecurringRuleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurringRuleId');
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct> distinctByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tags');
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct> distinctByToAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toAccountId');
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct>
      distinctByTransactionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transactionDate');
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct> distinctByTransferPairId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transferPairId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<Transaction, Transaction, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension TransactionQueryProperty
    on QueryBuilder<Transaction, Transaction, QQueryProperty> {
  QueryBuilder<Transaction, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Transaction, int, QQueryOperations> accountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountId');
    });
  }

  QueryBuilder<Transaction, int, QQueryOperations> amountInPaiseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amountInPaise');
    });
  }

  QueryBuilder<Transaction, double, QQueryOperations> amountInRupeesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amountInRupees');
    });
  }

  QueryBuilder<Transaction, String?, QQueryOperations>
      attachmentPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'attachmentPath');
    });
  }

  QueryBuilder<Transaction, int, QQueryOperations> categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryId');
    });
  }

  QueryBuilder<Transaction, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Transaction, DateTime?, QQueryOperations> deletedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deletedAt');
    });
  }

  QueryBuilder<Transaction, TransactionEntryMode, QQueryOperations>
      entryModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entryMode');
    });
  }

  QueryBuilder<Transaction, bool, QQueryOperations> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeleted');
    });
  }

  QueryBuilder<Transaction, bool, QQueryOperations> isTransferCreditProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isTransferCredit');
    });
  }

  QueryBuilder<Transaction, bool, QQueryOperations> isTransferDebitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isTransferDebit');
    });
  }

  QueryBuilder<Transaction, int?, QQueryOperations> loanIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loanId');
    });
  }

  QueryBuilder<Transaction, int?, QQueryOperations> locationLatMicroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'locationLatMicro');
    });
  }

  QueryBuilder<Transaction, int?, QQueryOperations> locationLngMicroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'locationLngMicro');
    });
  }

  QueryBuilder<Transaction, String?, QQueryOperations> locationNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'locationName');
    });
  }

  QueryBuilder<Transaction, String?, QQueryOperations> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<Transaction, String?, QQueryOperations> payeeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'payee');
    });
  }

  QueryBuilder<Transaction, int?, QQueryOperations> recurringRuleIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurringRuleId');
    });
  }

  QueryBuilder<Transaction, List<String>, QQueryOperations> tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tags');
    });
  }

  QueryBuilder<Transaction, int?, QQueryOperations> toAccountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toAccountId');
    });
  }

  QueryBuilder<Transaction, DateTime, QQueryOperations>
      transactionDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transactionDate');
    });
  }

  QueryBuilder<Transaction, String?, QQueryOperations>
      transferPairIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transferPairId');
    });
  }

  QueryBuilder<Transaction, TransactionType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<Transaction, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<Transaction, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
