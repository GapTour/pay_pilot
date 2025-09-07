// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $IncomesTable extends Incomes with TableInfo<$IncomesTable, Income> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  static const VerificationMeta _createAtMeta = const VerificationMeta(
    'createAt',
  );
  @override
  late final GeneratedColumn<DateTime> createAt = GeneratedColumn<DateTime>(
    'create_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    amount,
    date,
    createAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'incomes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Income> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('create_at')) {
      context.handle(
        _createAtMeta,
        createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Income map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Income(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      createAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_at'],
      )!,
    );
  }

  @override
  $IncomesTable createAlias(String alias) {
    return $IncomesTable(attachedDatabase, alias);
  }
}

class Income extends DataClass implements Insertable<Income> {
  final int id;
  final String title;
  final String? description;
  final double amount;
  final DateTime date;
  final DateTime createAt;
  const Income({
    required this.id,
    required this.title,
    this.description,
    required this.amount,
    required this.date,
    required this.createAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    map['create_at'] = Variable<DateTime>(createAt);
    return map;
  }

  IncomesCompanion toCompanion(bool nullToAbsent) {
    return IncomesCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      amount: Value(amount),
      date: Value(date),
      createAt: Value(createAt),
    );
  }

  factory Income.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Income(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'createAt': serializer.toJson<DateTime>(createAt),
    };
  }

  Income copyWith({
    int? id,
    String? title,
    Value<String?> description = const Value.absent(),
    double? amount,
    DateTime? date,
    DateTime? createAt,
  }) => Income(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    createAt: createAt ?? this.createAt,
  );
  Income copyWithCompanion(IncomesCompanion data) {
    return Income(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Income(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, amount, date, createAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Income &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.createAt == this.createAt);
}

class IncomesCompanion extends UpdateCompanion<Income> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<DateTime> createAt;
  const IncomesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.createAt = const Value.absent(),
  });
  IncomesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    required double amount,
    this.date = const Value.absent(),
    this.createAt = const Value.absent(),
  }) : title = Value(title),
       amount = Value(amount);
  static Insertable<Income> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<DateTime>? createAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (createAt != null) 'create_at': createAt,
    });
  }

  IncomesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<double>? amount,
    Value<DateTime>? date,
    Value<DateTime>? createAt,
  }) {
    return IncomesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      createAt: createAt ?? this.createAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncomesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }
}

class $MembersTable extends Members with TableInfo<$MembersTable, Member> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _percentageMeta = const VerificationMeta(
    'percentage',
  );
  @override
  late final GeneratedColumn<double> percentage = GeneratedColumn<double>(
    'percentage',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createAtMeta = const VerificationMeta(
    'createAt',
  );
  @override
  late final GeneratedColumn<DateTime> createAt = GeneratedColumn<DateTime>(
    'create_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    percentage,
    createAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'members';
  @override
  VerificationContext validateIntegrity(
    Insertable<Member> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('percentage')) {
      context.handle(
        _percentageMeta,
        percentage.isAcceptableOrUnknown(data['percentage']!, _percentageMeta),
      );
    } else if (isInserting) {
      context.missing(_percentageMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(
        _createAtMeta,
        createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Member map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Member(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      percentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}percentage'],
      )!,
      createAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_at'],
      )!,
    );
  }

  @override
  $MembersTable createAlias(String alias) {
    return $MembersTable(attachedDatabase, alias);
  }
}

class Member extends DataClass implements Insertable<Member> {
  final int id;
  final String name;
  final String? description;
  final double percentage;
  final DateTime createAt;
  const Member({
    required this.id,
    required this.name,
    this.description,
    required this.percentage,
    required this.createAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['percentage'] = Variable<double>(percentage);
    map['create_at'] = Variable<DateTime>(createAt);
    return map;
  }

  MembersCompanion toCompanion(bool nullToAbsent) {
    return MembersCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      percentage: Value(percentage),
      createAt: Value(createAt),
    );
  }

  factory Member.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Member(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      percentage: serializer.fromJson<double>(json['percentage']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'percentage': serializer.toJson<double>(percentage),
      'createAt': serializer.toJson<DateTime>(createAt),
    };
  }

  Member copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    double? percentage,
    DateTime? createAt,
  }) => Member(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    percentage: percentage ?? this.percentage,
    createAt: createAt ?? this.createAt,
  );
  Member copyWithCompanion(MembersCompanion data) {
    return Member(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      percentage: data.percentage.present
          ? data.percentage.value
          : this.percentage,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Member(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('percentage: $percentage, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, percentage, createAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Member &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.percentage == this.percentage &&
          other.createAt == this.createAt);
}

class MembersCompanion extends UpdateCompanion<Member> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<double> percentage;
  final Value<DateTime> createAt;
  const MembersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.percentage = const Value.absent(),
    this.createAt = const Value.absent(),
  });
  MembersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required double percentage,
    this.createAt = const Value.absent(),
  }) : name = Value(name),
       percentage = Value(percentage);
  static Insertable<Member> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? percentage,
    Expression<DateTime>? createAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (percentage != null) 'percentage': percentage,
      if (createAt != null) 'create_at': createAt,
    });
  }

  MembersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<double>? percentage,
    Value<DateTime>? createAt,
  }) {
    return MembersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      percentage: percentage ?? this.percentage,
      createAt: createAt ?? this.createAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<double>(percentage.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('percentage: $percentage, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }
}

class $ReportsTable extends Reports with TableInfo<$ReportsTable, Report> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _membersReportMeta = const VerificationMeta(
    'membersReport',
  );
  @override
  late final GeneratedColumn<String> membersReport = GeneratedColumn<String>(
    'members_report',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalBalanceMeta = const VerificationMeta(
    'totalBalance',
  );
  @override
  late final GeneratedColumn<double> totalBalance = GeneratedColumn<double>(
    'total_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  static const VerificationMeta _createAtMeta = const VerificationMeta(
    'createAt',
  );
  @override
  late final GeneratedColumn<DateTime> createAt = GeneratedColumn<DateTime>(
    'create_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    version,
    description,
    membersReport,
    totalBalance,
    date,
    createAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<Report> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('members_report')) {
      context.handle(
        _membersReportMeta,
        membersReport.isAcceptableOrUnknown(
          data['members_report']!,
          _membersReportMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_membersReportMeta);
    }
    if (data.containsKey('total_balance')) {
      context.handle(
        _totalBalanceMeta,
        totalBalance.isAcceptableOrUnknown(
          data['total_balance']!,
          _totalBalanceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalBalanceMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('create_at')) {
      context.handle(
        _createAtMeta,
        createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Report map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Report(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      membersReport: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}members_report'],
      )!,
      totalBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_balance'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      createAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_at'],
      )!,
    );
  }

  @override
  $ReportsTable createAlias(String alias) {
    return $ReportsTable(attachedDatabase, alias);
  }
}

class Report extends DataClass implements Insertable<Report> {
  final int id;
  final String title;
  final int version;
  final String? description;
  final String membersReport;
  final double totalBalance;
  final DateTime date;
  final DateTime createAt;
  const Report({
    required this.id,
    required this.title,
    required this.version,
    this.description,
    required this.membersReport,
    required this.totalBalance,
    required this.date,
    required this.createAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['version'] = Variable<int>(version);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['members_report'] = Variable<String>(membersReport);
    map['total_balance'] = Variable<double>(totalBalance);
    map['date'] = Variable<DateTime>(date);
    map['create_at'] = Variable<DateTime>(createAt);
    return map;
  }

  ReportsCompanion toCompanion(bool nullToAbsent) {
    return ReportsCompanion(
      id: Value(id),
      title: Value(title),
      version: Value(version),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      membersReport: Value(membersReport),
      totalBalance: Value(totalBalance),
      date: Value(date),
      createAt: Value(createAt),
    );
  }

  factory Report.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Report(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      version: serializer.fromJson<int>(json['version']),
      description: serializer.fromJson<String?>(json['description']),
      membersReport: serializer.fromJson<String>(json['membersReport']),
      totalBalance: serializer.fromJson<double>(json['totalBalance']),
      date: serializer.fromJson<DateTime>(json['date']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'version': serializer.toJson<int>(version),
      'description': serializer.toJson<String?>(description),
      'membersReport': serializer.toJson<String>(membersReport),
      'totalBalance': serializer.toJson<double>(totalBalance),
      'date': serializer.toJson<DateTime>(date),
      'createAt': serializer.toJson<DateTime>(createAt),
    };
  }

  Report copyWith({
    int? id,
    String? title,
    int? version,
    Value<String?> description = const Value.absent(),
    String? membersReport,
    double? totalBalance,
    DateTime? date,
    DateTime? createAt,
  }) => Report(
    id: id ?? this.id,
    title: title ?? this.title,
    version: version ?? this.version,
    description: description.present ? description.value : this.description,
    membersReport: membersReport ?? this.membersReport,
    totalBalance: totalBalance ?? this.totalBalance,
    date: date ?? this.date,
    createAt: createAt ?? this.createAt,
  );
  Report copyWithCompanion(ReportsCompanion data) {
    return Report(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      version: data.version.present ? data.version.value : this.version,
      description: data.description.present
          ? data.description.value
          : this.description,
      membersReport: data.membersReport.present
          ? data.membersReport.value
          : this.membersReport,
      totalBalance: data.totalBalance.present
          ? data.totalBalance.value
          : this.totalBalance,
      date: data.date.present ? data.date.value : this.date,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Report(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('version: $version, ')
          ..write('description: $description, ')
          ..write('membersReport: $membersReport, ')
          ..write('totalBalance: $totalBalance, ')
          ..write('date: $date, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    version,
    description,
    membersReport,
    totalBalance,
    date,
    createAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Report &&
          other.id == this.id &&
          other.title == this.title &&
          other.version == this.version &&
          other.description == this.description &&
          other.membersReport == this.membersReport &&
          other.totalBalance == this.totalBalance &&
          other.date == this.date &&
          other.createAt == this.createAt);
}

class ReportsCompanion extends UpdateCompanion<Report> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> version;
  final Value<String?> description;
  final Value<String> membersReport;
  final Value<double> totalBalance;
  final Value<DateTime> date;
  final Value<DateTime> createAt;
  const ReportsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.version = const Value.absent(),
    this.description = const Value.absent(),
    this.membersReport = const Value.absent(),
    this.totalBalance = const Value.absent(),
    this.date = const Value.absent(),
    this.createAt = const Value.absent(),
  });
  ReportsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int version,
    this.description = const Value.absent(),
    required String membersReport,
    required double totalBalance,
    this.date = const Value.absent(),
    this.createAt = const Value.absent(),
  }) : title = Value(title),
       version = Value(version),
       membersReport = Value(membersReport),
       totalBalance = Value(totalBalance);
  static Insertable<Report> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? version,
    Expression<String>? description,
    Expression<String>? membersReport,
    Expression<double>? totalBalance,
    Expression<DateTime>? date,
    Expression<DateTime>? createAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (version != null) 'version': version,
      if (description != null) 'description': description,
      if (membersReport != null) 'members_report': membersReport,
      if (totalBalance != null) 'total_balance': totalBalance,
      if (date != null) 'date': date,
      if (createAt != null) 'create_at': createAt,
    });
  }

  ReportsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<int>? version,
    Value<String?>? description,
    Value<String>? membersReport,
    Value<double>? totalBalance,
    Value<DateTime>? date,
    Value<DateTime>? createAt,
  }) {
    return ReportsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      version: version ?? this.version,
      description: description ?? this.description,
      membersReport: membersReport ?? this.membersReport,
      totalBalance: totalBalance ?? this.totalBalance,
      date: date ?? this.date,
      createAt: createAt ?? this.createAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (membersReport.present) {
      map['members_report'] = Variable<String>(membersReport.value);
    }
    if (totalBalance.present) {
      map['total_balance'] = Variable<double>(totalBalance.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReportsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('version: $version, ')
          ..write('description: $description, ')
          ..write('membersReport: $membersReport, ')
          ..write('totalBalance: $totalBalance, ')
          ..write('date: $date, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $IncomesTable incomes = $IncomesTable(this);
  late final $MembersTable members = $MembersTable(this);
  late final $ReportsTable reports = $ReportsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    incomes,
    members,
    reports,
  ];
}

typedef $$IncomesTableCreateCompanionBuilder =
    IncomesCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> description,
      required double amount,
      Value<DateTime> date,
      Value<DateTime> createAt,
    });
typedef $$IncomesTableUpdateCompanionBuilder =
    IncomesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> description,
      Value<double> amount,
      Value<DateTime> date,
      Value<DateTime> createAt,
    });

class $$IncomesTableFilterComposer
    extends Composer<_$AppDatabase, $IncomesTable> {
  $$IncomesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$IncomesTableOrderingComposer
    extends Composer<_$AppDatabase, $IncomesTable> {
  $$IncomesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IncomesTableAnnotationComposer
    extends Composer<_$AppDatabase, $IncomesTable> {
  $$IncomesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);
}

class $$IncomesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IncomesTable,
          Income,
          $$IncomesTableFilterComposer,
          $$IncomesTableOrderingComposer,
          $$IncomesTableAnnotationComposer,
          $$IncomesTableCreateCompanionBuilder,
          $$IncomesTableUpdateCompanionBuilder,
          (Income, BaseReferences<_$AppDatabase, $IncomesTable, Income>),
          Income,
          PrefetchHooks Function()
        > {
  $$IncomesTableTableManager(_$AppDatabase db, $IncomesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IncomesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IncomesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IncomesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
              }) => IncomesCompanion(
                id: id,
                title: title,
                description: description,
                amount: amount,
                date: date,
                createAt: createAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                required double amount,
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
              }) => IncomesCompanion.insert(
                id: id,
                title: title,
                description: description,
                amount: amount,
                date: date,
                createAt: createAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IncomesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IncomesTable,
      Income,
      $$IncomesTableFilterComposer,
      $$IncomesTableOrderingComposer,
      $$IncomesTableAnnotationComposer,
      $$IncomesTableCreateCompanionBuilder,
      $$IncomesTableUpdateCompanionBuilder,
      (Income, BaseReferences<_$AppDatabase, $IncomesTable, Income>),
      Income,
      PrefetchHooks Function()
    >;
typedef $$MembersTableCreateCompanionBuilder =
    MembersCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      required double percentage,
      Value<DateTime> createAt,
    });
typedef $$MembersTableUpdateCompanionBuilder =
    MembersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<double> percentage,
      Value<DateTime> createAt,
    });

class $$MembersTableFilterComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MembersTableOrderingComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);
}

class $$MembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MembersTable,
          Member,
          $$MembersTableFilterComposer,
          $$MembersTableOrderingComposer,
          $$MembersTableAnnotationComposer,
          $$MembersTableCreateCompanionBuilder,
          $$MembersTableUpdateCompanionBuilder,
          (Member, BaseReferences<_$AppDatabase, $MembersTable, Member>),
          Member,
          PrefetchHooks Function()
        > {
  $$MembersTableTableManager(_$AppDatabase db, $MembersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double> percentage = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
              }) => MembersCompanion(
                id: id,
                name: name,
                description: description,
                percentage: percentage,
                createAt: createAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                required double percentage,
                Value<DateTime> createAt = const Value.absent(),
              }) => MembersCompanion.insert(
                id: id,
                name: name,
                description: description,
                percentage: percentage,
                createAt: createAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MembersTable,
      Member,
      $$MembersTableFilterComposer,
      $$MembersTableOrderingComposer,
      $$MembersTableAnnotationComposer,
      $$MembersTableCreateCompanionBuilder,
      $$MembersTableUpdateCompanionBuilder,
      (Member, BaseReferences<_$AppDatabase, $MembersTable, Member>),
      Member,
      PrefetchHooks Function()
    >;
typedef $$ReportsTableCreateCompanionBuilder =
    ReportsCompanion Function({
      Value<int> id,
      required String title,
      required int version,
      Value<String?> description,
      required String membersReport,
      required double totalBalance,
      Value<DateTime> date,
      Value<DateTime> createAt,
    });
typedef $$ReportsTableUpdateCompanionBuilder =
    ReportsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<int> version,
      Value<String?> description,
      Value<String> membersReport,
      Value<double> totalBalance,
      Value<DateTime> date,
      Value<DateTime> createAt,
    });

class $$ReportsTableFilterComposer
    extends Composer<_$AppDatabase, $ReportsTable> {
  $$ReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get membersReport => $composableBuilder(
    column: $table.membersReport,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalBalance => $composableBuilder(
    column: $table.totalBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReportsTable> {
  $$ReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get membersReport => $composableBuilder(
    column: $table.membersReport,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalBalance => $composableBuilder(
    column: $table.totalBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReportsTable> {
  $$ReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get membersReport => $composableBuilder(
    column: $table.membersReport,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalBalance => $composableBuilder(
    column: $table.totalBalance,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);
}

class $$ReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReportsTable,
          Report,
          $$ReportsTableFilterComposer,
          $$ReportsTableOrderingComposer,
          $$ReportsTableAnnotationComposer,
          $$ReportsTableCreateCompanionBuilder,
          $$ReportsTableUpdateCompanionBuilder,
          (Report, BaseReferences<_$AppDatabase, $ReportsTable, Report>),
          Report,
          PrefetchHooks Function()
        > {
  $$ReportsTableTableManager(_$AppDatabase db, $ReportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> membersReport = const Value.absent(),
                Value<double> totalBalance = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
              }) => ReportsCompanion(
                id: id,
                title: title,
                version: version,
                description: description,
                membersReport: membersReport,
                totalBalance: totalBalance,
                date: date,
                createAt: createAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required int version,
                Value<String?> description = const Value.absent(),
                required String membersReport,
                required double totalBalance,
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
              }) => ReportsCompanion.insert(
                id: id,
                title: title,
                version: version,
                description: description,
                membersReport: membersReport,
                totalBalance: totalBalance,
                date: date,
                createAt: createAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReportsTable,
      Report,
      $$ReportsTableFilterComposer,
      $$ReportsTableOrderingComposer,
      $$ReportsTableAnnotationComposer,
      $$ReportsTableCreateCompanionBuilder,
      $$ReportsTableUpdateCompanionBuilder,
      (Report, BaseReferences<_$AppDatabase, $ReportsTable, Report>),
      Report,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$IncomesTableTableManager get incomes =>
      $$IncomesTableTableManager(_db, _db.incomes);
  $$MembersTableTableManager get members =>
      $$MembersTableTableManager(_db, _db.members);
  $$ReportsTableTableManager get reports =>
      $$ReportsTableTableManager(_db, _db.reports);
}
