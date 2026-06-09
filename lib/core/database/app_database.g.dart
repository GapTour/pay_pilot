// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TeamsTable extends Teams with TableInfo<$TeamsTable, Team> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _modifiedAtMeta = const VerificationMeta(
    'modifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
    'modified_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    createAt,
    modifiedAt,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teams';
  @override
  VerificationContext validateIntegrity(
    Insertable<Team> instance, {
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
    if (data.containsKey('create_at')) {
      context.handle(
        _createAtMeta,
        createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta),
      );
    }
    if (data.containsKey('modified_at')) {
      context.handle(
        _modifiedAtMeta,
        modifiedAt.isAcceptableOrUnknown(data['modified_at']!, _modifiedAtMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Team map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Team(
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
      createAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_at'],
      )!,
      modifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}modified_at'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $TeamsTable createAlias(String alias) {
    return $TeamsTable(attachedDatabase, alias);
  }
}

class Team extends DataClass implements Insertable<Team> {
  final int id;
  final String title;
  final String? description;
  final DateTime createAt;
  final DateTime modifiedAt;
  final bool isActive;
  const Team({
    required this.id,
    required this.title,
    this.description,
    required this.createAt,
    required this.modifiedAt,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['create_at'] = Variable<DateTime>(createAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  TeamsCompanion toCompanion(bool nullToAbsent) {
    return TeamsCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createAt: Value(createAt),
      modifiedAt: Value(modifiedAt),
      isActive: Value(isActive),
    );
  }

  factory Team.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Team(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'createAt': serializer.toJson<DateTime>(createAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Team copyWith({
    int? id,
    String? title,
    Value<String?> description = const Value.absent(),
    DateTime? createAt,
    DateTime? modifiedAt,
    bool? isActive,
  }) => Team(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    createAt: createAt ?? this.createAt,
    modifiedAt: modifiedAt ?? this.modifiedAt,
    isActive: isActive ?? this.isActive,
  );
  Team copyWithCompanion(TeamsCompanion data) {
    return Team(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
      modifiedAt: data.modifiedAt.present
          ? data.modifiedAt.value
          : this.modifiedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Team(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, createAt, modifiedAt, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Team &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.createAt == this.createAt &&
          other.modifiedAt == this.modifiedAt &&
          other.isActive == this.isActive);
}

class TeamsCompanion extends UpdateCompanion<Team> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime> createAt;
  final Value<DateTime> modifiedAt;
  final Value<bool> isActive;
  const TeamsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  TeamsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.isActive = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Team> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? createAt,
    Expression<DateTime>? modifiedAt,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (createAt != null) 'create_at': createAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (isActive != null) 'is_active': isActive,
    });
  }

  TeamsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<DateTime>? createAt,
    Value<DateTime>? modifiedAt,
    Value<bool>? isActive,
  }) {
    return TeamsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createAt: createAt ?? this.createAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      isActive: isActive ?? this.isActive,
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
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _teamIDMeta = const VerificationMeta('teamID');
  @override
  late final GeneratedColumn<int> teamID = GeneratedColumn<int>(
    'team_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES teams (id) ON DELETE CASCADE',
    ),
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
  static const VerificationMeta _modifiedAtMeta = const VerificationMeta(
    'modifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
    'modified_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    teamID,
    date,
    createAt,
    modifiedAt,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(
    Insertable<Event> instance, {
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
    if (data.containsKey('team_i_d')) {
      context.handle(
        _teamIDMeta,
        teamID.isAcceptableOrUnknown(data['team_i_d']!, _teamIDMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIDMeta);
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
    if (data.containsKey('modified_at')) {
      context.handle(
        _modifiedAtMeta,
        modifiedAt.isAcceptableOrUnknown(data['modified_at']!, _modifiedAtMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
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
      teamID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_i_d'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      createAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_at'],
      )!,
      modifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}modified_at'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class Event extends DataClass implements Insertable<Event> {
  final int id;
  final String title;
  final String? description;
  final int teamID;
  final DateTime date;
  final DateTime createAt;
  final DateTime modifiedAt;
  final bool isActive;
  const Event({
    required this.id,
    required this.title,
    this.description,
    required this.teamID,
    required this.date,
    required this.createAt,
    required this.modifiedAt,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['team_i_d'] = Variable<int>(teamID);
    map['date'] = Variable<DateTime>(date);
    map['create_at'] = Variable<DateTime>(createAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      teamID: Value(teamID),
      date: Value(date),
      createAt: Value(createAt),
      modifiedAt: Value(modifiedAt),
      isActive: Value(isActive),
    );
  }

  factory Event.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      teamID: serializer.fromJson<int>(json['teamID']),
      date: serializer.fromJson<DateTime>(json['date']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'teamID': serializer.toJson<int>(teamID),
      'date': serializer.toJson<DateTime>(date),
      'createAt': serializer.toJson<DateTime>(createAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Event copyWith({
    int? id,
    String? title,
    Value<String?> description = const Value.absent(),
    int? teamID,
    DateTime? date,
    DateTime? createAt,
    DateTime? modifiedAt,
    bool? isActive,
  }) => Event(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    teamID: teamID ?? this.teamID,
    date: date ?? this.date,
    createAt: createAt ?? this.createAt,
    modifiedAt: modifiedAt ?? this.modifiedAt,
    isActive: isActive ?? this.isActive,
  );
  Event copyWithCompanion(EventsCompanion data) {
    return Event(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      teamID: data.teamID.present ? data.teamID.value : this.teamID,
      date: data.date.present ? data.date.value : this.date,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
      modifiedAt: data.modifiedAt.present
          ? data.modifiedAt.value
          : this.modifiedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('teamID: $teamID, ')
          ..write('date: $date, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    teamID,
    date,
    createAt,
    modifiedAt,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.teamID == this.teamID &&
          other.date == this.date &&
          other.createAt == this.createAt &&
          other.modifiedAt == this.modifiedAt &&
          other.isActive == this.isActive);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<int> teamID;
  final Value<DateTime> date;
  final Value<DateTime> createAt;
  final Value<DateTime> modifiedAt;
  final Value<bool> isActive;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.teamID = const Value.absent(),
    this.date = const Value.absent(),
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    required int teamID,
    this.date = const Value.absent(),
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.isActive = const Value.absent(),
  }) : title = Value(title),
       teamID = Value(teamID);
  static Insertable<Event> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? teamID,
    Expression<DateTime>? date,
    Expression<DateTime>? createAt,
    Expression<DateTime>? modifiedAt,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (teamID != null) 'team_i_d': teamID,
      if (date != null) 'date': date,
      if (createAt != null) 'create_at': createAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (isActive != null) 'is_active': isActive,
    });
  }

  EventsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<int>? teamID,
    Value<DateTime>? date,
    Value<DateTime>? createAt,
    Value<DateTime>? modifiedAt,
    Value<bool>? isActive,
  }) {
    return EventsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      teamID: teamID ?? this.teamID,
      date: date ?? this.date,
      createAt: createAt ?? this.createAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      isActive: isActive ?? this.isActive,
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
    if (teamID.present) {
      map['team_i_d'] = Variable<int>(teamID.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('teamID: $teamID, ')
          ..write('date: $date, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('isActive: $isActive')
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
  static const VerificationMeta _joinAtMeta = const VerificationMeta('joinAt');
  @override
  late final GeneratedColumn<DateTime> joinAt = GeneratedColumn<DateTime>(
    'join_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _birthdayMeta = const VerificationMeta(
    'birthday',
  );
  @override
  late final GeneratedColumn<DateTime> birthday = GeneratedColumn<DateTime>(
    'birthday',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _profileImageMeta = const VerificationMeta(
    'profileImage',
  );
  @override
  late final GeneratedColumn<String> profileImage = GeneratedColumn<String>(
    'profile_image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _modifiedAtMeta = const VerificationMeta(
    'modifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
    'modified_at',
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
    joinAt,
    isActive,
    birthday,
    profileImage,
    createAt,
    modifiedAt,
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
    if (data.containsKey('join_at')) {
      context.handle(
        _joinAtMeta,
        joinAt.isAcceptableOrUnknown(data['join_at']!, _joinAtMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('birthday')) {
      context.handle(
        _birthdayMeta,
        birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta),
      );
    }
    if (data.containsKey('profile_image')) {
      context.handle(
        _profileImageMeta,
        profileImage.isAcceptableOrUnknown(
          data['profile_image']!,
          _profileImageMeta,
        ),
      );
    }
    if (data.containsKey('create_at')) {
      context.handle(
        _createAtMeta,
        createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta),
      );
    }
    if (data.containsKey('modified_at')) {
      context.handle(
        _modifiedAtMeta,
        modifiedAt.isAcceptableOrUnknown(data['modified_at']!, _modifiedAtMeta),
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
      joinAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}join_at'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      birthday: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birthday'],
      ),
      profileImage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_image'],
      ),
      createAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_at'],
      )!,
      modifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}modified_at'],
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
  final DateTime? joinAt;
  final bool isActive;
  final DateTime? birthday;
  final String? profileImage;
  final DateTime createAt;
  final DateTime modifiedAt;
  const Member({
    required this.id,
    required this.name,
    this.description,
    this.joinAt,
    required this.isActive,
    this.birthday,
    this.profileImage,
    required this.createAt,
    required this.modifiedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || joinAt != null) {
      map['join_at'] = Variable<DateTime>(joinAt);
    }
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || birthday != null) {
      map['birthday'] = Variable<DateTime>(birthday);
    }
    if (!nullToAbsent || profileImage != null) {
      map['profile_image'] = Variable<String>(profileImage);
    }
    map['create_at'] = Variable<DateTime>(createAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    return map;
  }

  MembersCompanion toCompanion(bool nullToAbsent) {
    return MembersCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      joinAt: joinAt == null && nullToAbsent
          ? const Value.absent()
          : Value(joinAt),
      isActive: Value(isActive),
      birthday: birthday == null && nullToAbsent
          ? const Value.absent()
          : Value(birthday),
      profileImage: profileImage == null && nullToAbsent
          ? const Value.absent()
          : Value(profileImage),
      createAt: Value(createAt),
      modifiedAt: Value(modifiedAt),
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
      joinAt: serializer.fromJson<DateTime?>(json['joinAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      birthday: serializer.fromJson<DateTime?>(json['birthday']),
      profileImage: serializer.fromJson<String?>(json['profileImage']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'joinAt': serializer.toJson<DateTime?>(joinAt),
      'isActive': serializer.toJson<bool>(isActive),
      'birthday': serializer.toJson<DateTime?>(birthday),
      'profileImage': serializer.toJson<String?>(profileImage),
      'createAt': serializer.toJson<DateTime>(createAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
    };
  }

  Member copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<DateTime?> joinAt = const Value.absent(),
    bool? isActive,
    Value<DateTime?> birthday = const Value.absent(),
    Value<String?> profileImage = const Value.absent(),
    DateTime? createAt,
    DateTime? modifiedAt,
  }) => Member(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    joinAt: joinAt.present ? joinAt.value : this.joinAt,
    isActive: isActive ?? this.isActive,
    birthday: birthday.present ? birthday.value : this.birthday,
    profileImage: profileImage.present ? profileImage.value : this.profileImage,
    createAt: createAt ?? this.createAt,
    modifiedAt: modifiedAt ?? this.modifiedAt,
  );
  Member copyWithCompanion(MembersCompanion data) {
    return Member(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      joinAt: data.joinAt.present ? data.joinAt.value : this.joinAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      birthday: data.birthday.present ? data.birthday.value : this.birthday,
      profileImage: data.profileImage.present
          ? data.profileImage.value
          : this.profileImage,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
      modifiedAt: data.modifiedAt.present
          ? data.modifiedAt.value
          : this.modifiedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Member(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('joinAt: $joinAt, ')
          ..write('isActive: $isActive, ')
          ..write('birthday: $birthday, ')
          ..write('profileImage: $profileImage, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    joinAt,
    isActive,
    birthday,
    profileImage,
    createAt,
    modifiedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Member &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.joinAt == this.joinAt &&
          other.isActive == this.isActive &&
          other.birthday == this.birthday &&
          other.profileImage == this.profileImage &&
          other.createAt == this.createAt &&
          other.modifiedAt == this.modifiedAt);
}

class MembersCompanion extends UpdateCompanion<Member> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime?> joinAt;
  final Value<bool> isActive;
  final Value<DateTime?> birthday;
  final Value<String?> profileImage;
  final Value<DateTime> createAt;
  final Value<DateTime> modifiedAt;
  const MembersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.joinAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.birthday = const Value.absent(),
    this.profileImage = const Value.absent(),
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
  });
  MembersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.joinAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.birthday = const Value.absent(),
    this.profileImage = const Value.absent(),
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Member> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? joinAt,
    Expression<bool>? isActive,
    Expression<DateTime>? birthday,
    Expression<String>? profileImage,
    Expression<DateTime>? createAt,
    Expression<DateTime>? modifiedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (joinAt != null) 'join_at': joinAt,
      if (isActive != null) 'is_active': isActive,
      if (birthday != null) 'birthday': birthday,
      if (profileImage != null) 'profile_image': profileImage,
      if (createAt != null) 'create_at': createAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
    });
  }

  MembersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<DateTime?>? joinAt,
    Value<bool>? isActive,
    Value<DateTime?>? birthday,
    Value<String?>? profileImage,
    Value<DateTime>? createAt,
    Value<DateTime>? modifiedAt,
  }) {
    return MembersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      joinAt: joinAt ?? this.joinAt,
      isActive: isActive ?? this.isActive,
      birthday: birthday ?? this.birthday,
      profileImage: profileImage ?? this.profileImage,
      createAt: createAt ?? this.createAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
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
    if (joinAt.present) {
      map['join_at'] = Variable<DateTime>(joinAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<DateTime>(birthday.value);
    }
    if (profileImage.present) {
      map['profile_image'] = Variable<String>(profileImage.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('joinAt: $joinAt, ')
          ..write('isActive: $isActive, ')
          ..write('birthday: $birthday, ')
          ..write('profileImage: $profileImage, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt')
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
  static const VerificationMeta _generateForMeta = const VerificationMeta(
    'generateFor',
  );
  @override
  late final GeneratedColumn<DateTime> generateFor = GeneratedColumn<DateTime>(
    'generate_for',
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
  static const VerificationMeta _modifiedAtMeta = const VerificationMeta(
    'modifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
    'modified_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    version,
    description,
    generateFor,
    createAt,
    modifiedAt,
    isActive,
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
    if (data.containsKey('generate_for')) {
      context.handle(
        _generateForMeta,
        generateFor.isAcceptableOrUnknown(
          data['generate_for']!,
          _generateForMeta,
        ),
      );
    }
    if (data.containsKey('create_at')) {
      context.handle(
        _createAtMeta,
        createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta),
      );
    }
    if (data.containsKey('modified_at')) {
      context.handle(
        _modifiedAtMeta,
        modifiedAt.isAcceptableOrUnknown(data['modified_at']!, _modifiedAtMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
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
      generateFor: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}generate_for'],
      )!,
      createAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_at'],
      )!,
      modifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}modified_at'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
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
  final DateTime generateFor;
  final DateTime createAt;
  final DateTime modifiedAt;
  final bool isActive;
  const Report({
    required this.id,
    required this.title,
    required this.version,
    this.description,
    required this.generateFor,
    required this.createAt,
    required this.modifiedAt,
    required this.isActive,
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
    map['generate_for'] = Variable<DateTime>(generateFor);
    map['create_at'] = Variable<DateTime>(createAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    map['is_active'] = Variable<bool>(isActive);
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
      generateFor: Value(generateFor),
      createAt: Value(createAt),
      modifiedAt: Value(modifiedAt),
      isActive: Value(isActive),
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
      generateFor: serializer.fromJson<DateTime>(json['generateFor']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
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
      'generateFor': serializer.toJson<DateTime>(generateFor),
      'createAt': serializer.toJson<DateTime>(createAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Report copyWith({
    int? id,
    String? title,
    int? version,
    Value<String?> description = const Value.absent(),
    DateTime? generateFor,
    DateTime? createAt,
    DateTime? modifiedAt,
    bool? isActive,
  }) => Report(
    id: id ?? this.id,
    title: title ?? this.title,
    version: version ?? this.version,
    description: description.present ? description.value : this.description,
    generateFor: generateFor ?? this.generateFor,
    createAt: createAt ?? this.createAt,
    modifiedAt: modifiedAt ?? this.modifiedAt,
    isActive: isActive ?? this.isActive,
  );
  Report copyWithCompanion(ReportsCompanion data) {
    return Report(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      version: data.version.present ? data.version.value : this.version,
      description: data.description.present
          ? data.description.value
          : this.description,
      generateFor: data.generateFor.present
          ? data.generateFor.value
          : this.generateFor,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
      modifiedAt: data.modifiedAt.present
          ? data.modifiedAt.value
          : this.modifiedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Report(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('version: $version, ')
          ..write('description: $description, ')
          ..write('generateFor: $generateFor, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    version,
    description,
    generateFor,
    createAt,
    modifiedAt,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Report &&
          other.id == this.id &&
          other.title == this.title &&
          other.version == this.version &&
          other.description == this.description &&
          other.generateFor == this.generateFor &&
          other.createAt == this.createAt &&
          other.modifiedAt == this.modifiedAt &&
          other.isActive == this.isActive);
}

class ReportsCompanion extends UpdateCompanion<Report> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> version;
  final Value<String?> description;
  final Value<DateTime> generateFor;
  final Value<DateTime> createAt;
  final Value<DateTime> modifiedAt;
  final Value<bool> isActive;
  const ReportsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.version = const Value.absent(),
    this.description = const Value.absent(),
    this.generateFor = const Value.absent(),
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  ReportsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int version,
    this.description = const Value.absent(),
    this.generateFor = const Value.absent(),
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.isActive = const Value.absent(),
  }) : title = Value(title),
       version = Value(version);
  static Insertable<Report> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? version,
    Expression<String>? description,
    Expression<DateTime>? generateFor,
    Expression<DateTime>? createAt,
    Expression<DateTime>? modifiedAt,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (version != null) 'version': version,
      if (description != null) 'description': description,
      if (generateFor != null) 'generate_for': generateFor,
      if (createAt != null) 'create_at': createAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (isActive != null) 'is_active': isActive,
    });
  }

  ReportsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<int>? version,
    Value<String?>? description,
    Value<DateTime>? generateFor,
    Value<DateTime>? createAt,
    Value<DateTime>? modifiedAt,
    Value<bool>? isActive,
  }) {
    return ReportsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      version: version ?? this.version,
      description: description ?? this.description,
      generateFor: generateFor ?? this.generateFor,
      createAt: createAt ?? this.createAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      isActive: isActive ?? this.isActive,
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
    if (generateFor.present) {
      map['generate_for'] = Variable<DateTime>(generateFor.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
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
          ..write('generateFor: $generateFor, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $RatiosTable extends Ratios with TableInfo<$RatiosTable, Ratio> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RatiosTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _memberIDMeta = const VerificationMeta(
    'memberID',
  );
  @override
  late final GeneratedColumn<int> memberID = GeneratedColumn<int>(
    'member_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _teamIDMeta = const VerificationMeta('teamID');
  @override
  late final GeneratedColumn<int> teamID = GeneratedColumn<int>(
    'team_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES teams (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ratioMeta = const VerificationMeta('ratio');
  @override
  late final GeneratedColumn<double> ratio = GeneratedColumn<double>(
    'ratio',
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
  static const VerificationMeta _modifiedAtMeta = const VerificationMeta(
    'modifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
    'modified_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    memberID,
    teamID,
    ratio,
    createAt,
    modifiedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ratios';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ratio> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('member_i_d')) {
      context.handle(
        _memberIDMeta,
        memberID.isAcceptableOrUnknown(data['member_i_d']!, _memberIDMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIDMeta);
    }
    if (data.containsKey('team_i_d')) {
      context.handle(
        _teamIDMeta,
        teamID.isAcceptableOrUnknown(data['team_i_d']!, _teamIDMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIDMeta);
    }
    if (data.containsKey('ratio')) {
      context.handle(
        _ratioMeta,
        ratio.isAcceptableOrUnknown(data['ratio']!, _ratioMeta),
      );
    } else if (isInserting) {
      context.missing(_ratioMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(
        _createAtMeta,
        createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta),
      );
    }
    if (data.containsKey('modified_at')) {
      context.handle(
        _modifiedAtMeta,
        modifiedAt.isAcceptableOrUnknown(data['modified_at']!, _modifiedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ratio map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ratio(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      memberID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}member_i_d'],
      )!,
      teamID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_i_d'],
      )!,
      ratio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ratio'],
      )!,
      createAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_at'],
      )!,
      modifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}modified_at'],
      )!,
    );
  }

  @override
  $RatiosTable createAlias(String alias) {
    return $RatiosTable(attachedDatabase, alias);
  }
}

class Ratio extends DataClass implements Insertable<Ratio> {
  final int id;
  final int memberID;
  final int teamID;
  final double ratio;
  final DateTime createAt;
  final DateTime modifiedAt;
  const Ratio({
    required this.id,
    required this.memberID,
    required this.teamID,
    required this.ratio,
    required this.createAt,
    required this.modifiedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['member_i_d'] = Variable<int>(memberID);
    map['team_i_d'] = Variable<int>(teamID);
    map['ratio'] = Variable<double>(ratio);
    map['create_at'] = Variable<DateTime>(createAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    return map;
  }

  RatiosCompanion toCompanion(bool nullToAbsent) {
    return RatiosCompanion(
      id: Value(id),
      memberID: Value(memberID),
      teamID: Value(teamID),
      ratio: Value(ratio),
      createAt: Value(createAt),
      modifiedAt: Value(modifiedAt),
    );
  }

  factory Ratio.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ratio(
      id: serializer.fromJson<int>(json['id']),
      memberID: serializer.fromJson<int>(json['memberID']),
      teamID: serializer.fromJson<int>(json['teamID']),
      ratio: serializer.fromJson<double>(json['ratio']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'memberID': serializer.toJson<int>(memberID),
      'teamID': serializer.toJson<int>(teamID),
      'ratio': serializer.toJson<double>(ratio),
      'createAt': serializer.toJson<DateTime>(createAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
    };
  }

  Ratio copyWith({
    int? id,
    int? memberID,
    int? teamID,
    double? ratio,
    DateTime? createAt,
    DateTime? modifiedAt,
  }) => Ratio(
    id: id ?? this.id,
    memberID: memberID ?? this.memberID,
    teamID: teamID ?? this.teamID,
    ratio: ratio ?? this.ratio,
    createAt: createAt ?? this.createAt,
    modifiedAt: modifiedAt ?? this.modifiedAt,
  );
  Ratio copyWithCompanion(RatiosCompanion data) {
    return Ratio(
      id: data.id.present ? data.id.value : this.id,
      memberID: data.memberID.present ? data.memberID.value : this.memberID,
      teamID: data.teamID.present ? data.teamID.value : this.teamID,
      ratio: data.ratio.present ? data.ratio.value : this.ratio,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
      modifiedAt: data.modifiedAt.present
          ? data.modifiedAt.value
          : this.modifiedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ratio(')
          ..write('id: $id, ')
          ..write('memberID: $memberID, ')
          ..write('teamID: $teamID, ')
          ..write('ratio: $ratio, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, memberID, teamID, ratio, createAt, modifiedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ratio &&
          other.id == this.id &&
          other.memberID == this.memberID &&
          other.teamID == this.teamID &&
          other.ratio == this.ratio &&
          other.createAt == this.createAt &&
          other.modifiedAt == this.modifiedAt);
}

class RatiosCompanion extends UpdateCompanion<Ratio> {
  final Value<int> id;
  final Value<int> memberID;
  final Value<int> teamID;
  final Value<double> ratio;
  final Value<DateTime> createAt;
  final Value<DateTime> modifiedAt;
  const RatiosCompanion({
    this.id = const Value.absent(),
    this.memberID = const Value.absent(),
    this.teamID = const Value.absent(),
    this.ratio = const Value.absent(),
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
  });
  RatiosCompanion.insert({
    this.id = const Value.absent(),
    required int memberID,
    required int teamID,
    required double ratio,
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
  }) : memberID = Value(memberID),
       teamID = Value(teamID),
       ratio = Value(ratio);
  static Insertable<Ratio> custom({
    Expression<int>? id,
    Expression<int>? memberID,
    Expression<int>? teamID,
    Expression<double>? ratio,
    Expression<DateTime>? createAt,
    Expression<DateTime>? modifiedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (memberID != null) 'member_i_d': memberID,
      if (teamID != null) 'team_i_d': teamID,
      if (ratio != null) 'ratio': ratio,
      if (createAt != null) 'create_at': createAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
    });
  }

  RatiosCompanion copyWith({
    Value<int>? id,
    Value<int>? memberID,
    Value<int>? teamID,
    Value<double>? ratio,
    Value<DateTime>? createAt,
    Value<DateTime>? modifiedAt,
  }) {
    return RatiosCompanion(
      id: id ?? this.id,
      memberID: memberID ?? this.memberID,
      teamID: teamID ?? this.teamID,
      ratio: ratio ?? this.ratio,
      createAt: createAt ?? this.createAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (memberID.present) {
      map['member_i_d'] = Variable<int>(memberID.value);
    }
    if (teamID.present) {
      map['team_i_d'] = Variable<int>(teamID.value);
    }
    if (ratio.present) {
      map['ratio'] = Variable<double>(ratio.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RatiosCompanion(')
          ..write('id: $id, ')
          ..write('memberID: $memberID, ')
          ..write('teamID: $teamID, ')
          ..write('ratio: $ratio, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt')
          ..write(')'))
        .toString();
  }
}

class $CollectReportEventsTable extends CollectReportEvents
    with TableInfo<$CollectReportEventsTable, CollectReportEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectReportEventsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _eventIDMeta = const VerificationMeta(
    'eventID',
  );
  @override
  late final GeneratedColumn<int> eventID = GeneratedColumn<int>(
    'event_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _reportIDMeta = const VerificationMeta(
    'reportID',
  );
  @override
  late final GeneratedColumn<int> reportID = GeneratedColumn<int>(
    'report_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES reports (id) ON DELETE CASCADE',
    ),
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
  static const VerificationMeta _modifiedAtMeta = const VerificationMeta(
    'modifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
    'modified_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventID,
    reportID,
    createAt,
    modifiedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collect_report_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<CollectReportEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_i_d')) {
      context.handle(
        _eventIDMeta,
        eventID.isAcceptableOrUnknown(data['event_i_d']!, _eventIDMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIDMeta);
    }
    if (data.containsKey('report_i_d')) {
      context.handle(
        _reportIDMeta,
        reportID.isAcceptableOrUnknown(data['report_i_d']!, _reportIDMeta),
      );
    } else if (isInserting) {
      context.missing(_reportIDMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(
        _createAtMeta,
        createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta),
      );
    }
    if (data.containsKey('modified_at')) {
      context.handle(
        _modifiedAtMeta,
        modifiedAt.isAcceptableOrUnknown(data['modified_at']!, _modifiedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CollectReportEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectReportEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      eventID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_i_d'],
      )!,
      reportID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}report_i_d'],
      )!,
      createAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_at'],
      )!,
      modifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}modified_at'],
      )!,
    );
  }

  @override
  $CollectReportEventsTable createAlias(String alias) {
    return $CollectReportEventsTable(attachedDatabase, alias);
  }
}

class CollectReportEvent extends DataClass
    implements Insertable<CollectReportEvent> {
  final int id;
  final int eventID;
  final int reportID;
  final DateTime createAt;
  final DateTime modifiedAt;
  const CollectReportEvent({
    required this.id,
    required this.eventID,
    required this.reportID,
    required this.createAt,
    required this.modifiedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_i_d'] = Variable<int>(eventID);
    map['report_i_d'] = Variable<int>(reportID);
    map['create_at'] = Variable<DateTime>(createAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    return map;
  }

  CollectReportEventsCompanion toCompanion(bool nullToAbsent) {
    return CollectReportEventsCompanion(
      id: Value(id),
      eventID: Value(eventID),
      reportID: Value(reportID),
      createAt: Value(createAt),
      modifiedAt: Value(modifiedAt),
    );
  }

  factory CollectReportEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectReportEvent(
      id: serializer.fromJson<int>(json['id']),
      eventID: serializer.fromJson<int>(json['eventID']),
      reportID: serializer.fromJson<int>(json['reportID']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventID': serializer.toJson<int>(eventID),
      'reportID': serializer.toJson<int>(reportID),
      'createAt': serializer.toJson<DateTime>(createAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
    };
  }

  CollectReportEvent copyWith({
    int? id,
    int? eventID,
    int? reportID,
    DateTime? createAt,
    DateTime? modifiedAt,
  }) => CollectReportEvent(
    id: id ?? this.id,
    eventID: eventID ?? this.eventID,
    reportID: reportID ?? this.reportID,
    createAt: createAt ?? this.createAt,
    modifiedAt: modifiedAt ?? this.modifiedAt,
  );
  CollectReportEvent copyWithCompanion(CollectReportEventsCompanion data) {
    return CollectReportEvent(
      id: data.id.present ? data.id.value : this.id,
      eventID: data.eventID.present ? data.eventID.value : this.eventID,
      reportID: data.reportID.present ? data.reportID.value : this.reportID,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
      modifiedAt: data.modifiedAt.present
          ? data.modifiedAt.value
          : this.modifiedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectReportEvent(')
          ..write('id: $id, ')
          ..write('eventID: $eventID, ')
          ..write('reportID: $reportID, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eventID, reportID, createAt, modifiedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectReportEvent &&
          other.id == this.id &&
          other.eventID == this.eventID &&
          other.reportID == this.reportID &&
          other.createAt == this.createAt &&
          other.modifiedAt == this.modifiedAt);
}

class CollectReportEventsCompanion extends UpdateCompanion<CollectReportEvent> {
  final Value<int> id;
  final Value<int> eventID;
  final Value<int> reportID;
  final Value<DateTime> createAt;
  final Value<DateTime> modifiedAt;
  const CollectReportEventsCompanion({
    this.id = const Value.absent(),
    this.eventID = const Value.absent(),
    this.reportID = const Value.absent(),
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
  });
  CollectReportEventsCompanion.insert({
    this.id = const Value.absent(),
    required int eventID,
    required int reportID,
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
  }) : eventID = Value(eventID),
       reportID = Value(reportID);
  static Insertable<CollectReportEvent> custom({
    Expression<int>? id,
    Expression<int>? eventID,
    Expression<int>? reportID,
    Expression<DateTime>? createAt,
    Expression<DateTime>? modifiedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventID != null) 'event_i_d': eventID,
      if (reportID != null) 'report_i_d': reportID,
      if (createAt != null) 'create_at': createAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
    });
  }

  CollectReportEventsCompanion copyWith({
    Value<int>? id,
    Value<int>? eventID,
    Value<int>? reportID,
    Value<DateTime>? createAt,
    Value<DateTime>? modifiedAt,
  }) {
    return CollectReportEventsCompanion(
      id: id ?? this.id,
      eventID: eventID ?? this.eventID,
      reportID: reportID ?? this.reportID,
      createAt: createAt ?? this.createAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventID.present) {
      map['event_i_d'] = Variable<int>(eventID.value);
    }
    if (reportID.present) {
      map['report_i_d'] = Variable<int>(reportID.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectReportEventsCompanion(')
          ..write('id: $id, ')
          ..write('eventID: $eventID, ')
          ..write('reportID: $reportID, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt')
          ..write(')'))
        .toString();
  }
}

class $GuestsTable extends Guests with TableInfo<$GuestsTable, Guest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GuestsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _profileImageMeta = const VerificationMeta(
    'profileImage',
  );
  @override
  late final GeneratedColumn<String> profileImage = GeneratedColumn<String>(
    'profile_image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _modifiedAtMeta = const VerificationMeta(
    'modifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
    'modified_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _telegramIdMeta = const VerificationMeta(
    'telegramId',
  );
  @override
  late final GeneratedColumn<String> telegramId = GeneratedColumn<String>(
    'telegram_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _instagramIdMeta = const VerificationMeta(
    'instagramId',
  );
  @override
  late final GeneratedColumn<String> instagramId = GeneratedColumn<String>(
    'instagram_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _birthdayMeta = const VerificationMeta(
    'birthday',
  );
  @override
  late final GeneratedColumn<DateTime> birthday = GeneratedColumn<DateTime>(
    'birthday',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    profileImage,
    createAt,
    modifiedAt,
    isActive,
    telegramId,
    instagramId,
    phoneNumber,
    birthday,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'guests';
  @override
  VerificationContext validateIntegrity(
    Insertable<Guest> instance, {
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
    if (data.containsKey('profile_image')) {
      context.handle(
        _profileImageMeta,
        profileImage.isAcceptableOrUnknown(
          data['profile_image']!,
          _profileImageMeta,
        ),
      );
    }
    if (data.containsKey('create_at')) {
      context.handle(
        _createAtMeta,
        createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta),
      );
    }
    if (data.containsKey('modified_at')) {
      context.handle(
        _modifiedAtMeta,
        modifiedAt.isAcceptableOrUnknown(data['modified_at']!, _modifiedAtMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('telegram_id')) {
      context.handle(
        _telegramIdMeta,
        telegramId.isAcceptableOrUnknown(data['telegram_id']!, _telegramIdMeta),
      );
    }
    if (data.containsKey('instagram_id')) {
      context.handle(
        _instagramIdMeta,
        instagramId.isAcceptableOrUnknown(
          data['instagram_id']!,
          _instagramIdMeta,
        ),
      );
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    if (data.containsKey('birthday')) {
      context.handle(
        _birthdayMeta,
        birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Guest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Guest(
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
      profileImage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_image'],
      ),
      createAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_at'],
      )!,
      modifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}modified_at'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      telegramId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telegram_id'],
      ),
      instagramId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instagram_id'],
      ),
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      ),
      birthday: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birthday'],
      ),
    );
  }

  @override
  $GuestsTable createAlias(String alias) {
    return $GuestsTable(attachedDatabase, alias);
  }
}

class Guest extends DataClass implements Insertable<Guest> {
  final int id;
  final String name;
  final String? description;
  final String? profileImage;
  final DateTime createAt;
  final DateTime modifiedAt;
  final bool isActive;
  final String? telegramId;
  final String? instagramId;
  final String? phoneNumber;
  final DateTime? birthday;
  const Guest({
    required this.id,
    required this.name,
    this.description,
    this.profileImage,
    required this.createAt,
    required this.modifiedAt,
    required this.isActive,
    this.telegramId,
    this.instagramId,
    this.phoneNumber,
    this.birthday,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || profileImage != null) {
      map['profile_image'] = Variable<String>(profileImage);
    }
    map['create_at'] = Variable<DateTime>(createAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || telegramId != null) {
      map['telegram_id'] = Variable<String>(telegramId);
    }
    if (!nullToAbsent || instagramId != null) {
      map['instagram_id'] = Variable<String>(instagramId);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || birthday != null) {
      map['birthday'] = Variable<DateTime>(birthday);
    }
    return map;
  }

  GuestsCompanion toCompanion(bool nullToAbsent) {
    return GuestsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      profileImage: profileImage == null && nullToAbsent
          ? const Value.absent()
          : Value(profileImage),
      createAt: Value(createAt),
      modifiedAt: Value(modifiedAt),
      isActive: Value(isActive),
      telegramId: telegramId == null && nullToAbsent
          ? const Value.absent()
          : Value(telegramId),
      instagramId: instagramId == null && nullToAbsent
          ? const Value.absent()
          : Value(instagramId),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      birthday: birthday == null && nullToAbsent
          ? const Value.absent()
          : Value(birthday),
    );
  }

  factory Guest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Guest(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      profileImage: serializer.fromJson<String?>(json['profileImage']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      telegramId: serializer.fromJson<String?>(json['telegramId']),
      instagramId: serializer.fromJson<String?>(json['instagramId']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      birthday: serializer.fromJson<DateTime?>(json['birthday']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'profileImage': serializer.toJson<String?>(profileImage),
      'createAt': serializer.toJson<DateTime>(createAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
      'isActive': serializer.toJson<bool>(isActive),
      'telegramId': serializer.toJson<String?>(telegramId),
      'instagramId': serializer.toJson<String?>(instagramId),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'birthday': serializer.toJson<DateTime?>(birthday),
    };
  }

  Guest copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> profileImage = const Value.absent(),
    DateTime? createAt,
    DateTime? modifiedAt,
    bool? isActive,
    Value<String?> telegramId = const Value.absent(),
    Value<String?> instagramId = const Value.absent(),
    Value<String?> phoneNumber = const Value.absent(),
    Value<DateTime?> birthday = const Value.absent(),
  }) => Guest(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    profileImage: profileImage.present ? profileImage.value : this.profileImage,
    createAt: createAt ?? this.createAt,
    modifiedAt: modifiedAt ?? this.modifiedAt,
    isActive: isActive ?? this.isActive,
    telegramId: telegramId.present ? telegramId.value : this.telegramId,
    instagramId: instagramId.present ? instagramId.value : this.instagramId,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    birthday: birthday.present ? birthday.value : this.birthday,
  );
  Guest copyWithCompanion(GuestsCompanion data) {
    return Guest(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      profileImage: data.profileImage.present
          ? data.profileImage.value
          : this.profileImage,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
      modifiedAt: data.modifiedAt.present
          ? data.modifiedAt.value
          : this.modifiedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      telegramId: data.telegramId.present
          ? data.telegramId.value
          : this.telegramId,
      instagramId: data.instagramId.present
          ? data.instagramId.value
          : this.instagramId,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      birthday: data.birthday.present ? data.birthday.value : this.birthday,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Guest(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('profileImage: $profileImage, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('isActive: $isActive, ')
          ..write('telegramId: $telegramId, ')
          ..write('instagramId: $instagramId, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('birthday: $birthday')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    profileImage,
    createAt,
    modifiedAt,
    isActive,
    telegramId,
    instagramId,
    phoneNumber,
    birthday,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Guest &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.profileImage == this.profileImage &&
          other.createAt == this.createAt &&
          other.modifiedAt == this.modifiedAt &&
          other.isActive == this.isActive &&
          other.telegramId == this.telegramId &&
          other.instagramId == this.instagramId &&
          other.phoneNumber == this.phoneNumber &&
          other.birthday == this.birthday);
}

class GuestsCompanion extends UpdateCompanion<Guest> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> profileImage;
  final Value<DateTime> createAt;
  final Value<DateTime> modifiedAt;
  final Value<bool> isActive;
  final Value<String?> telegramId;
  final Value<String?> instagramId;
  final Value<String?> phoneNumber;
  final Value<DateTime?> birthday;
  const GuestsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.profileImage = const Value.absent(),
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.telegramId = const Value.absent(),
    this.instagramId = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.birthday = const Value.absent(),
  });
  GuestsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.profileImage = const Value.absent(),
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.telegramId = const Value.absent(),
    this.instagramId = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.birthday = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Guest> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? profileImage,
    Expression<DateTime>? createAt,
    Expression<DateTime>? modifiedAt,
    Expression<bool>? isActive,
    Expression<String>? telegramId,
    Expression<String>? instagramId,
    Expression<String>? phoneNumber,
    Expression<DateTime>? birthday,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (profileImage != null) 'profile_image': profileImage,
      if (createAt != null) 'create_at': createAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (isActive != null) 'is_active': isActive,
      if (telegramId != null) 'telegram_id': telegramId,
      if (instagramId != null) 'instagram_id': instagramId,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (birthday != null) 'birthday': birthday,
    });
  }

  GuestsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? profileImage,
    Value<DateTime>? createAt,
    Value<DateTime>? modifiedAt,
    Value<bool>? isActive,
    Value<String?>? telegramId,
    Value<String?>? instagramId,
    Value<String?>? phoneNumber,
    Value<DateTime?>? birthday,
  }) {
    return GuestsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      profileImage: profileImage ?? this.profileImage,
      createAt: createAt ?? this.createAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      isActive: isActive ?? this.isActive,
      telegramId: telegramId ?? this.telegramId,
      instagramId: instagramId ?? this.instagramId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthday: birthday ?? this.birthday,
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
    if (profileImage.present) {
      map['profile_image'] = Variable<String>(profileImage.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (telegramId.present) {
      map['telegram_id'] = Variable<String>(telegramId.value);
    }
    if (instagramId.present) {
      map['instagram_id'] = Variable<String>(instagramId.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<DateTime>(birthday.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GuestsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('profileImage: $profileImage, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('isActive: $isActive, ')
          ..write('telegramId: $telegramId, ')
          ..write('instagramId: $instagramId, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('birthday: $birthday')
          ..write(')'))
        .toString();
  }
}

class $EventTransactionsTable extends EventTransactions
    with TableInfo<$EventTransactionsTable, EventTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventTransactionsTable(this.attachedDatabase, [this._alias]);
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
  @override
  late final GeneratedColumnWithTypeConverter<TransactionType, String>
  transactionType =
      GeneratedColumn<String>(
        'transaction_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TransactionType>(
        $EventTransactionsTable.$convertertransactionType,
      );
  static const VerificationMeta _eventIDMeta = const VerificationMeta(
    'eventID',
  );
  @override
  late final GeneratedColumn<int> eventID = GeneratedColumn<int>(
    'event_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
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
  static const VerificationMeta _modifiedAtMeta = const VerificationMeta(
    'modifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
    'modified_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  static const VerificationMeta _memberIDMeta = const VerificationMeta(
    'memberID',
  );
  @override
  late final GeneratedColumn<int> memberID = GeneratedColumn<int>(
    'member_i_d',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _guestIDMeta = const VerificationMeta(
    'guestID',
  );
  @override
  late final GeneratedColumn<int> guestID = GeneratedColumn<int>(
    'guest_i_d',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES guests (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _attachmentMeta = const VerificationMeta(
    'attachment',
  );
  @override
  late final GeneratedColumn<String> attachment = GeneratedColumn<String>(
    'attachment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    description,
    amount,
    transactionType,
    eventID,
    date,
    createAt,
    modifiedAt,
    memberID,
    guestID,
    attachment,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
    if (data.containsKey('event_i_d')) {
      context.handle(
        _eventIDMeta,
        eventID.isAcceptableOrUnknown(data['event_i_d']!, _eventIDMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIDMeta);
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
    if (data.containsKey('modified_at')) {
      context.handle(
        _modifiedAtMeta,
        modifiedAt.isAcceptableOrUnknown(data['modified_at']!, _modifiedAtMeta),
      );
    }
    if (data.containsKey('member_i_d')) {
      context.handle(
        _memberIDMeta,
        memberID.isAcceptableOrUnknown(data['member_i_d']!, _memberIDMeta),
      );
    }
    if (data.containsKey('guest_i_d')) {
      context.handle(
        _guestIDMeta,
        guestID.isAcceptableOrUnknown(data['guest_i_d']!, _guestIDMeta),
      );
    }
    if (data.containsKey('attachment')) {
      context.handle(
        _attachmentMeta,
        attachment.isAcceptableOrUnknown(data['attachment']!, _attachmentMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      transactionType: $EventTransactionsTable.$convertertransactionType
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}transaction_type'],
            )!,
          ),
      eventID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_i_d'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      createAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_at'],
      )!,
      modifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}modified_at'],
      )!,
      memberID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}member_i_d'],
      ),
      guestID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}guest_i_d'],
      ),
      attachment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attachment'],
      ),
    );
  }

  @override
  $EventTransactionsTable createAlias(String alias) {
    return $EventTransactionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TransactionType, String, String>
  $convertertransactionType = const EnumNameConverter<TransactionType>(
    TransactionType.values,
  );
}

class EventTransaction extends DataClass
    implements Insertable<EventTransaction> {
  final int id;
  final String? description;
  final double amount;
  final TransactionType transactionType;
  final int eventID;
  final DateTime date;
  final DateTime createAt;
  final DateTime modifiedAt;
  final int? memberID;
  final int? guestID;
  final String? attachment;
  const EventTransaction({
    required this.id,
    this.description,
    required this.amount,
    required this.transactionType,
    required this.eventID,
    required this.date,
    required this.createAt,
    required this.modifiedAt,
    this.memberID,
    this.guestID,
    this.attachment,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['amount'] = Variable<double>(amount);
    {
      map['transaction_type'] = Variable<String>(
        $EventTransactionsTable.$convertertransactionType.toSql(
          transactionType,
        ),
      );
    }
    map['event_i_d'] = Variable<int>(eventID);
    map['date'] = Variable<DateTime>(date);
    map['create_at'] = Variable<DateTime>(createAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    if (!nullToAbsent || memberID != null) {
      map['member_i_d'] = Variable<int>(memberID);
    }
    if (!nullToAbsent || guestID != null) {
      map['guest_i_d'] = Variable<int>(guestID);
    }
    if (!nullToAbsent || attachment != null) {
      map['attachment'] = Variable<String>(attachment);
    }
    return map;
  }

  EventTransactionsCompanion toCompanion(bool nullToAbsent) {
    return EventTransactionsCompanion(
      id: Value(id),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      amount: Value(amount),
      transactionType: Value(transactionType),
      eventID: Value(eventID),
      date: Value(date),
      createAt: Value(createAt),
      modifiedAt: Value(modifiedAt),
      memberID: memberID == null && nullToAbsent
          ? const Value.absent()
          : Value(memberID),
      guestID: guestID == null && nullToAbsent
          ? const Value.absent()
          : Value(guestID),
      attachment: attachment == null && nullToAbsent
          ? const Value.absent()
          : Value(attachment),
    );
  }

  factory EventTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventTransaction(
      id: serializer.fromJson<int>(json['id']),
      description: serializer.fromJson<String?>(json['description']),
      amount: serializer.fromJson<double>(json['amount']),
      transactionType: $EventTransactionsTable.$convertertransactionType
          .fromJson(serializer.fromJson<String>(json['transactionType'])),
      eventID: serializer.fromJson<int>(json['eventID']),
      date: serializer.fromJson<DateTime>(json['date']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
      memberID: serializer.fromJson<int?>(json['memberID']),
      guestID: serializer.fromJson<int?>(json['guestID']),
      attachment: serializer.fromJson<String?>(json['attachment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'description': serializer.toJson<String?>(description),
      'amount': serializer.toJson<double>(amount),
      'transactionType': serializer.toJson<String>(
        $EventTransactionsTable.$convertertransactionType.toJson(
          transactionType,
        ),
      ),
      'eventID': serializer.toJson<int>(eventID),
      'date': serializer.toJson<DateTime>(date),
      'createAt': serializer.toJson<DateTime>(createAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
      'memberID': serializer.toJson<int?>(memberID),
      'guestID': serializer.toJson<int?>(guestID),
      'attachment': serializer.toJson<String?>(attachment),
    };
  }

  EventTransaction copyWith({
    int? id,
    Value<String?> description = const Value.absent(),
    double? amount,
    TransactionType? transactionType,
    int? eventID,
    DateTime? date,
    DateTime? createAt,
    DateTime? modifiedAt,
    Value<int?> memberID = const Value.absent(),
    Value<int?> guestID = const Value.absent(),
    Value<String?> attachment = const Value.absent(),
  }) => EventTransaction(
    id: id ?? this.id,
    description: description.present ? description.value : this.description,
    amount: amount ?? this.amount,
    transactionType: transactionType ?? this.transactionType,
    eventID: eventID ?? this.eventID,
    date: date ?? this.date,
    createAt: createAt ?? this.createAt,
    modifiedAt: modifiedAt ?? this.modifiedAt,
    memberID: memberID.present ? memberID.value : this.memberID,
    guestID: guestID.present ? guestID.value : this.guestID,
    attachment: attachment.present ? attachment.value : this.attachment,
  );
  EventTransaction copyWithCompanion(EventTransactionsCompanion data) {
    return EventTransaction(
      id: data.id.present ? data.id.value : this.id,
      description: data.description.present
          ? data.description.value
          : this.description,
      amount: data.amount.present ? data.amount.value : this.amount,
      transactionType: data.transactionType.present
          ? data.transactionType.value
          : this.transactionType,
      eventID: data.eventID.present ? data.eventID.value : this.eventID,
      date: data.date.present ? data.date.value : this.date,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
      modifiedAt: data.modifiedAt.present
          ? data.modifiedAt.value
          : this.modifiedAt,
      memberID: data.memberID.present ? data.memberID.value : this.memberID,
      guestID: data.guestID.present ? data.guestID.value : this.guestID,
      attachment: data.attachment.present
          ? data.attachment.value
          : this.attachment,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventTransaction(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('transactionType: $transactionType, ')
          ..write('eventID: $eventID, ')
          ..write('date: $date, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('memberID: $memberID, ')
          ..write('guestID: $guestID, ')
          ..write('attachment: $attachment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    description,
    amount,
    transactionType,
    eventID,
    date,
    createAt,
    modifiedAt,
    memberID,
    guestID,
    attachment,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventTransaction &&
          other.id == this.id &&
          other.description == this.description &&
          other.amount == this.amount &&
          other.transactionType == this.transactionType &&
          other.eventID == this.eventID &&
          other.date == this.date &&
          other.createAt == this.createAt &&
          other.modifiedAt == this.modifiedAt &&
          other.memberID == this.memberID &&
          other.guestID == this.guestID &&
          other.attachment == this.attachment);
}

class EventTransactionsCompanion extends UpdateCompanion<EventTransaction> {
  final Value<int> id;
  final Value<String?> description;
  final Value<double> amount;
  final Value<TransactionType> transactionType;
  final Value<int> eventID;
  final Value<DateTime> date;
  final Value<DateTime> createAt;
  final Value<DateTime> modifiedAt;
  final Value<int?> memberID;
  final Value<int?> guestID;
  final Value<String?> attachment;
  const EventTransactionsCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.amount = const Value.absent(),
    this.transactionType = const Value.absent(),
    this.eventID = const Value.absent(),
    this.date = const Value.absent(),
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.memberID = const Value.absent(),
    this.guestID = const Value.absent(),
    this.attachment = const Value.absent(),
  });
  EventTransactionsCompanion.insert({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    required double amount,
    required TransactionType transactionType,
    required int eventID,
    this.date = const Value.absent(),
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.memberID = const Value.absent(),
    this.guestID = const Value.absent(),
    this.attachment = const Value.absent(),
  }) : amount = Value(amount),
       transactionType = Value(transactionType),
       eventID = Value(eventID);
  static Insertable<EventTransaction> custom({
    Expression<int>? id,
    Expression<String>? description,
    Expression<double>? amount,
    Expression<String>? transactionType,
    Expression<int>? eventID,
    Expression<DateTime>? date,
    Expression<DateTime>? createAt,
    Expression<DateTime>? modifiedAt,
    Expression<int>? memberID,
    Expression<int>? guestID,
    Expression<String>? attachment,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (description != null) 'description': description,
      if (amount != null) 'amount': amount,
      if (transactionType != null) 'transaction_type': transactionType,
      if (eventID != null) 'event_i_d': eventID,
      if (date != null) 'date': date,
      if (createAt != null) 'create_at': createAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (memberID != null) 'member_i_d': memberID,
      if (guestID != null) 'guest_i_d': guestID,
      if (attachment != null) 'attachment': attachment,
    });
  }

  EventTransactionsCompanion copyWith({
    Value<int>? id,
    Value<String?>? description,
    Value<double>? amount,
    Value<TransactionType>? transactionType,
    Value<int>? eventID,
    Value<DateTime>? date,
    Value<DateTime>? createAt,
    Value<DateTime>? modifiedAt,
    Value<int?>? memberID,
    Value<int?>? guestID,
    Value<String?>? attachment,
  }) {
    return EventTransactionsCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      transactionType: transactionType ?? this.transactionType,
      eventID: eventID ?? this.eventID,
      date: date ?? this.date,
      createAt: createAt ?? this.createAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      memberID: memberID ?? this.memberID,
      guestID: guestID ?? this.guestID,
      attachment: attachment ?? this.attachment,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (transactionType.present) {
      map['transaction_type'] = Variable<String>(
        $EventTransactionsTable.$convertertransactionType.toSql(
          transactionType.value,
        ),
      );
    }
    if (eventID.present) {
      map['event_i_d'] = Variable<int>(eventID.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    if (memberID.present) {
      map['member_i_d'] = Variable<int>(memberID.value);
    }
    if (guestID.present) {
      map['guest_i_d'] = Variable<int>(guestID.value);
    }
    if (attachment.present) {
      map['attachment'] = Variable<String>(attachment.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('transactionType: $transactionType, ')
          ..write('eventID: $eventID, ')
          ..write('date: $date, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('memberID: $memberID, ')
          ..write('guestID: $guestID, ')
          ..write('attachment: $attachment')
          ..write(')'))
        .toString();
  }
}

class $EventRatiosTable extends EventRatios
    with TableInfo<$EventRatiosTable, EventRatio> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventRatiosTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _memberIDMeta = const VerificationMeta(
    'memberID',
  );
  @override
  late final GeneratedColumn<int> memberID = GeneratedColumn<int>(
    'member_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _eventIDMeta = const VerificationMeta(
    'eventID',
  );
  @override
  late final GeneratedColumn<int> eventID = GeneratedColumn<int>(
    'event_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ratioMeta = const VerificationMeta('ratio');
  @override
  late final GeneratedColumn<double> ratio = GeneratedColumn<double>(
    'ratio',
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
  static const VerificationMeta _modifiedAtMeta = const VerificationMeta(
    'modifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
    'modified_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    memberID,
    eventID,
    ratio,
    createAt,
    modifiedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_ratios';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventRatio> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('member_i_d')) {
      context.handle(
        _memberIDMeta,
        memberID.isAcceptableOrUnknown(data['member_i_d']!, _memberIDMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIDMeta);
    }
    if (data.containsKey('event_i_d')) {
      context.handle(
        _eventIDMeta,
        eventID.isAcceptableOrUnknown(data['event_i_d']!, _eventIDMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIDMeta);
    }
    if (data.containsKey('ratio')) {
      context.handle(
        _ratioMeta,
        ratio.isAcceptableOrUnknown(data['ratio']!, _ratioMeta),
      );
    } else if (isInserting) {
      context.missing(_ratioMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(
        _createAtMeta,
        createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta),
      );
    }
    if (data.containsKey('modified_at')) {
      context.handle(
        _modifiedAtMeta,
        modifiedAt.isAcceptableOrUnknown(data['modified_at']!, _modifiedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventRatio map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventRatio(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      memberID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}member_i_d'],
      )!,
      eventID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_i_d'],
      )!,
      ratio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ratio'],
      )!,
      createAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_at'],
      )!,
      modifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}modified_at'],
      )!,
    );
  }

  @override
  $EventRatiosTable createAlias(String alias) {
    return $EventRatiosTable(attachedDatabase, alias);
  }
}

class EventRatio extends DataClass implements Insertable<EventRatio> {
  final int id;
  final int memberID;
  final int eventID;
  final double ratio;
  final DateTime createAt;
  final DateTime modifiedAt;
  const EventRatio({
    required this.id,
    required this.memberID,
    required this.eventID,
    required this.ratio,
    required this.createAt,
    required this.modifiedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['member_i_d'] = Variable<int>(memberID);
    map['event_i_d'] = Variable<int>(eventID);
    map['ratio'] = Variable<double>(ratio);
    map['create_at'] = Variable<DateTime>(createAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    return map;
  }

  EventRatiosCompanion toCompanion(bool nullToAbsent) {
    return EventRatiosCompanion(
      id: Value(id),
      memberID: Value(memberID),
      eventID: Value(eventID),
      ratio: Value(ratio),
      createAt: Value(createAt),
      modifiedAt: Value(modifiedAt),
    );
  }

  factory EventRatio.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventRatio(
      id: serializer.fromJson<int>(json['id']),
      memberID: serializer.fromJson<int>(json['memberID']),
      eventID: serializer.fromJson<int>(json['eventID']),
      ratio: serializer.fromJson<double>(json['ratio']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'memberID': serializer.toJson<int>(memberID),
      'eventID': serializer.toJson<int>(eventID),
      'ratio': serializer.toJson<double>(ratio),
      'createAt': serializer.toJson<DateTime>(createAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
    };
  }

  EventRatio copyWith({
    int? id,
    int? memberID,
    int? eventID,
    double? ratio,
    DateTime? createAt,
    DateTime? modifiedAt,
  }) => EventRatio(
    id: id ?? this.id,
    memberID: memberID ?? this.memberID,
    eventID: eventID ?? this.eventID,
    ratio: ratio ?? this.ratio,
    createAt: createAt ?? this.createAt,
    modifiedAt: modifiedAt ?? this.modifiedAt,
  );
  EventRatio copyWithCompanion(EventRatiosCompanion data) {
    return EventRatio(
      id: data.id.present ? data.id.value : this.id,
      memberID: data.memberID.present ? data.memberID.value : this.memberID,
      eventID: data.eventID.present ? data.eventID.value : this.eventID,
      ratio: data.ratio.present ? data.ratio.value : this.ratio,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
      modifiedAt: data.modifiedAt.present
          ? data.modifiedAt.value
          : this.modifiedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventRatio(')
          ..write('id: $id, ')
          ..write('memberID: $memberID, ')
          ..write('eventID: $eventID, ')
          ..write('ratio: $ratio, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, memberID, eventID, ratio, createAt, modifiedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventRatio &&
          other.id == this.id &&
          other.memberID == this.memberID &&
          other.eventID == this.eventID &&
          other.ratio == this.ratio &&
          other.createAt == this.createAt &&
          other.modifiedAt == this.modifiedAt);
}

class EventRatiosCompanion extends UpdateCompanion<EventRatio> {
  final Value<int> id;
  final Value<int> memberID;
  final Value<int> eventID;
  final Value<double> ratio;
  final Value<DateTime> createAt;
  final Value<DateTime> modifiedAt;
  const EventRatiosCompanion({
    this.id = const Value.absent(),
    this.memberID = const Value.absent(),
    this.eventID = const Value.absent(),
    this.ratio = const Value.absent(),
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
  });
  EventRatiosCompanion.insert({
    this.id = const Value.absent(),
    required int memberID,
    required int eventID,
    required double ratio,
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
  }) : memberID = Value(memberID),
       eventID = Value(eventID),
       ratio = Value(ratio);
  static Insertable<EventRatio> custom({
    Expression<int>? id,
    Expression<int>? memberID,
    Expression<int>? eventID,
    Expression<double>? ratio,
    Expression<DateTime>? createAt,
    Expression<DateTime>? modifiedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (memberID != null) 'member_i_d': memberID,
      if (eventID != null) 'event_i_d': eventID,
      if (ratio != null) 'ratio': ratio,
      if (createAt != null) 'create_at': createAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
    });
  }

  EventRatiosCompanion copyWith({
    Value<int>? id,
    Value<int>? memberID,
    Value<int>? eventID,
    Value<double>? ratio,
    Value<DateTime>? createAt,
    Value<DateTime>? modifiedAt,
  }) {
    return EventRatiosCompanion(
      id: id ?? this.id,
      memberID: memberID ?? this.memberID,
      eventID: eventID ?? this.eventID,
      ratio: ratio ?? this.ratio,
      createAt: createAt ?? this.createAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (memberID.present) {
      map['member_i_d'] = Variable<int>(memberID.value);
    }
    if (eventID.present) {
      map['event_i_d'] = Variable<int>(eventID.value);
    }
    if (ratio.present) {
      map['ratio'] = Variable<double>(ratio.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventRatiosCompanion(')
          ..write('id: $id, ')
          ..write('memberID: $memberID, ')
          ..write('eventID: $eventID, ')
          ..write('ratio: $ratio, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt')
          ..write(')'))
        .toString();
  }
}

class $MenusTable extends Menus with TableInfo<$MenusTable, MenusData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenusTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _modifiedAtMeta = const VerificationMeta(
    'modifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
    'modified_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    createAt,
    modifiedAt,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'menus';
  @override
  VerificationContext validateIntegrity(
    Insertable<MenusData> instance, {
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
    if (data.containsKey('create_at')) {
      context.handle(
        _createAtMeta,
        createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta),
      );
    }
    if (data.containsKey('modified_at')) {
      context.handle(
        _modifiedAtMeta,
        modifiedAt.isAcceptableOrUnknown(data['modified_at']!, _modifiedAtMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MenusData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MenusData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      createAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_at'],
      )!,
      modifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}modified_at'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $MenusTable createAlias(String alias) {
    return $MenusTable(attachedDatabase, alias);
  }
}

class MenusData extends DataClass implements Insertable<MenusData> {
  final int id;
  final String title;
  final DateTime createAt;
  final DateTime modifiedAt;
  final bool isActive;
  const MenusData({
    required this.id,
    required this.title,
    required this.createAt,
    required this.modifiedAt,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['create_at'] = Variable<DateTime>(createAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  MenusCompanion toCompanion(bool nullToAbsent) {
    return MenusCompanion(
      id: Value(id),
      title: Value(title),
      createAt: Value(createAt),
      modifiedAt: Value(modifiedAt),
      isActive: Value(isActive),
    );
  }

  factory MenusData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MenusData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'createAt': serializer.toJson<DateTime>(createAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  MenusData copyWith({
    int? id,
    String? title,
    DateTime? createAt,
    DateTime? modifiedAt,
    bool? isActive,
  }) => MenusData(
    id: id ?? this.id,
    title: title ?? this.title,
    createAt: createAt ?? this.createAt,
    modifiedAt: modifiedAt ?? this.modifiedAt,
    isActive: isActive ?? this.isActive,
  );
  MenusData copyWithCompanion(MenusCompanion data) {
    return MenusData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
      modifiedAt: data.modifiedAt.present
          ? data.modifiedAt.value
          : this.modifiedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MenusData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, createAt, modifiedAt, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MenusData &&
          other.id == this.id &&
          other.title == this.title &&
          other.createAt == this.createAt &&
          other.modifiedAt == this.modifiedAt &&
          other.isActive == this.isActive);
}

class MenusCompanion extends UpdateCompanion<MenusData> {
  final Value<int> id;
  final Value<String> title;
  final Value<DateTime> createAt;
  final Value<DateTime> modifiedAt;
  final Value<bool> isActive;
  const MenusCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  MenusCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.isActive = const Value.absent(),
  }) : title = Value(title);
  static Insertable<MenusData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<DateTime>? createAt,
    Expression<DateTime>? modifiedAt,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (createAt != null) 'create_at': createAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (isActive != null) 'is_active': isActive,
    });
  }

  MenusCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<DateTime>? createAt,
    Value<DateTime>? modifiedAt,
    Value<bool>? isActive,
  }) {
    return MenusCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      createAt: createAt ?? this.createAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      isActive: isActive ?? this.isActive,
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
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MenusCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $EventOrdersTable extends EventOrders
    with TableInfo<$EventOrdersTable, EventOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventOrdersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _memberIDMeta = const VerificationMeta(
    'memberID',
  );
  @override
  late final GeneratedColumn<int> memberID = GeneratedColumn<int>(
    'member_i_d',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _guessIDMeta = const VerificationMeta(
    'guessID',
  );
  @override
  late final GeneratedColumn<int> guessID = GeneratedColumn<int>(
    'guess_i_d',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES guests (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _eventIDMeta = const VerificationMeta(
    'eventID',
  );
  @override
  late final GeneratedColumn<int> eventID = GeneratedColumn<int>(
    'event_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _isDeliveredMeta = const VerificationMeta(
    'isDelivered',
  );
  @override
  late final GeneratedColumn<bool> isDelivered = GeneratedColumn<bool>(
    'is_delivered',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_delivered" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _menuItemsMeta = const VerificationMeta(
    'menuItems',
  );
  @override
  late final GeneratedColumn<String> menuItems = GeneratedColumn<String>(
    'menu_items',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _modifiedAtMeta = const VerificationMeta(
    'modifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
    'modified_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    memberID,
    guessID,
    eventID,
    isDelivered,
    menuItems,
    createAt,
    modifiedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventOrder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('member_i_d')) {
      context.handle(
        _memberIDMeta,
        memberID.isAcceptableOrUnknown(data['member_i_d']!, _memberIDMeta),
      );
    }
    if (data.containsKey('guess_i_d')) {
      context.handle(
        _guessIDMeta,
        guessID.isAcceptableOrUnknown(data['guess_i_d']!, _guessIDMeta),
      );
    }
    if (data.containsKey('event_i_d')) {
      context.handle(
        _eventIDMeta,
        eventID.isAcceptableOrUnknown(data['event_i_d']!, _eventIDMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIDMeta);
    }
    if (data.containsKey('is_delivered')) {
      context.handle(
        _isDeliveredMeta,
        isDelivered.isAcceptableOrUnknown(
          data['is_delivered']!,
          _isDeliveredMeta,
        ),
      );
    }
    if (data.containsKey('menu_items')) {
      context.handle(
        _menuItemsMeta,
        menuItems.isAcceptableOrUnknown(data['menu_items']!, _menuItemsMeta),
      );
    }
    if (data.containsKey('create_at')) {
      context.handle(
        _createAtMeta,
        createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta),
      );
    }
    if (data.containsKey('modified_at')) {
      context.handle(
        _modifiedAtMeta,
        modifiedAt.isAcceptableOrUnknown(data['modified_at']!, _modifiedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventOrder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      memberID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}member_i_d'],
      ),
      guessID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}guess_i_d'],
      ),
      eventID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_i_d'],
      )!,
      isDelivered: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_delivered'],
      )!,
      menuItems: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}menu_items'],
      ),
      createAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_at'],
      )!,
      modifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}modified_at'],
      )!,
    );
  }

  @override
  $EventOrdersTable createAlias(String alias) {
    return $EventOrdersTable(attachedDatabase, alias);
  }
}

class EventOrder extends DataClass implements Insertable<EventOrder> {
  final int id;
  final int? memberID;
  final int? guessID;
  final int eventID;
  final bool isDelivered;
  final String? menuItems;
  final DateTime createAt;
  final DateTime modifiedAt;
  const EventOrder({
    required this.id,
    this.memberID,
    this.guessID,
    required this.eventID,
    required this.isDelivered,
    this.menuItems,
    required this.createAt,
    required this.modifiedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || memberID != null) {
      map['member_i_d'] = Variable<int>(memberID);
    }
    if (!nullToAbsent || guessID != null) {
      map['guess_i_d'] = Variable<int>(guessID);
    }
    map['event_i_d'] = Variable<int>(eventID);
    map['is_delivered'] = Variable<bool>(isDelivered);
    if (!nullToAbsent || menuItems != null) {
      map['menu_items'] = Variable<String>(menuItems);
    }
    map['create_at'] = Variable<DateTime>(createAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    return map;
  }

  EventOrdersCompanion toCompanion(bool nullToAbsent) {
    return EventOrdersCompanion(
      id: Value(id),
      memberID: memberID == null && nullToAbsent
          ? const Value.absent()
          : Value(memberID),
      guessID: guessID == null && nullToAbsent
          ? const Value.absent()
          : Value(guessID),
      eventID: Value(eventID),
      isDelivered: Value(isDelivered),
      menuItems: menuItems == null && nullToAbsent
          ? const Value.absent()
          : Value(menuItems),
      createAt: Value(createAt),
      modifiedAt: Value(modifiedAt),
    );
  }

  factory EventOrder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventOrder(
      id: serializer.fromJson<int>(json['id']),
      memberID: serializer.fromJson<int?>(json['memberID']),
      guessID: serializer.fromJson<int?>(json['guessID']),
      eventID: serializer.fromJson<int>(json['eventID']),
      isDelivered: serializer.fromJson<bool>(json['isDelivered']),
      menuItems: serializer.fromJson<String?>(json['menuItems']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'memberID': serializer.toJson<int?>(memberID),
      'guessID': serializer.toJson<int?>(guessID),
      'eventID': serializer.toJson<int>(eventID),
      'isDelivered': serializer.toJson<bool>(isDelivered),
      'menuItems': serializer.toJson<String?>(menuItems),
      'createAt': serializer.toJson<DateTime>(createAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
    };
  }

  EventOrder copyWith({
    int? id,
    Value<int?> memberID = const Value.absent(),
    Value<int?> guessID = const Value.absent(),
    int? eventID,
    bool? isDelivered,
    Value<String?> menuItems = const Value.absent(),
    DateTime? createAt,
    DateTime? modifiedAt,
  }) => EventOrder(
    id: id ?? this.id,
    memberID: memberID.present ? memberID.value : this.memberID,
    guessID: guessID.present ? guessID.value : this.guessID,
    eventID: eventID ?? this.eventID,
    isDelivered: isDelivered ?? this.isDelivered,
    menuItems: menuItems.present ? menuItems.value : this.menuItems,
    createAt: createAt ?? this.createAt,
    modifiedAt: modifiedAt ?? this.modifiedAt,
  );
  EventOrder copyWithCompanion(EventOrdersCompanion data) {
    return EventOrder(
      id: data.id.present ? data.id.value : this.id,
      memberID: data.memberID.present ? data.memberID.value : this.memberID,
      guessID: data.guessID.present ? data.guessID.value : this.guessID,
      eventID: data.eventID.present ? data.eventID.value : this.eventID,
      isDelivered: data.isDelivered.present
          ? data.isDelivered.value
          : this.isDelivered,
      menuItems: data.menuItems.present ? data.menuItems.value : this.menuItems,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
      modifiedAt: data.modifiedAt.present
          ? data.modifiedAt.value
          : this.modifiedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventOrder(')
          ..write('id: $id, ')
          ..write('memberID: $memberID, ')
          ..write('guessID: $guessID, ')
          ..write('eventID: $eventID, ')
          ..write('isDelivered: $isDelivered, ')
          ..write('menuItems: $menuItems, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    memberID,
    guessID,
    eventID,
    isDelivered,
    menuItems,
    createAt,
    modifiedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventOrder &&
          other.id == this.id &&
          other.memberID == this.memberID &&
          other.guessID == this.guessID &&
          other.eventID == this.eventID &&
          other.isDelivered == this.isDelivered &&
          other.menuItems == this.menuItems &&
          other.createAt == this.createAt &&
          other.modifiedAt == this.modifiedAt);
}

class EventOrdersCompanion extends UpdateCompanion<EventOrder> {
  final Value<int> id;
  final Value<int?> memberID;
  final Value<int?> guessID;
  final Value<int> eventID;
  final Value<bool> isDelivered;
  final Value<String?> menuItems;
  final Value<DateTime> createAt;
  final Value<DateTime> modifiedAt;
  const EventOrdersCompanion({
    this.id = const Value.absent(),
    this.memberID = const Value.absent(),
    this.guessID = const Value.absent(),
    this.eventID = const Value.absent(),
    this.isDelivered = const Value.absent(),
    this.menuItems = const Value.absent(),
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
  });
  EventOrdersCompanion.insert({
    this.id = const Value.absent(),
    this.memberID = const Value.absent(),
    this.guessID = const Value.absent(),
    required int eventID,
    this.isDelivered = const Value.absent(),
    this.menuItems = const Value.absent(),
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
  }) : eventID = Value(eventID);
  static Insertable<EventOrder> custom({
    Expression<int>? id,
    Expression<int>? memberID,
    Expression<int>? guessID,
    Expression<int>? eventID,
    Expression<bool>? isDelivered,
    Expression<String>? menuItems,
    Expression<DateTime>? createAt,
    Expression<DateTime>? modifiedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (memberID != null) 'member_i_d': memberID,
      if (guessID != null) 'guess_i_d': guessID,
      if (eventID != null) 'event_i_d': eventID,
      if (isDelivered != null) 'is_delivered': isDelivered,
      if (menuItems != null) 'menu_items': menuItems,
      if (createAt != null) 'create_at': createAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
    });
  }

  EventOrdersCompanion copyWith({
    Value<int>? id,
    Value<int?>? memberID,
    Value<int?>? guessID,
    Value<int>? eventID,
    Value<bool>? isDelivered,
    Value<String?>? menuItems,
    Value<DateTime>? createAt,
    Value<DateTime>? modifiedAt,
  }) {
    return EventOrdersCompanion(
      id: id ?? this.id,
      memberID: memberID ?? this.memberID,
      guessID: guessID ?? this.guessID,
      eventID: eventID ?? this.eventID,
      isDelivered: isDelivered ?? this.isDelivered,
      menuItems: menuItems ?? this.menuItems,
      createAt: createAt ?? this.createAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (memberID.present) {
      map['member_i_d'] = Variable<int>(memberID.value);
    }
    if (guessID.present) {
      map['guess_i_d'] = Variable<int>(guessID.value);
    }
    if (eventID.present) {
      map['event_i_d'] = Variable<int>(eventID.value);
    }
    if (isDelivered.present) {
      map['is_delivered'] = Variable<bool>(isDelivered.value);
    }
    if (menuItems.present) {
      map['menu_items'] = Variable<String>(menuItems.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventOrdersCompanion(')
          ..write('id: $id, ')
          ..write('memberID: $memberID, ')
          ..write('guessID: $guessID, ')
          ..write('eventID: $eventID, ')
          ..write('isDelivered: $isDelivered, ')
          ..write('menuItems: $menuItems, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt')
          ..write(')'))
        .toString();
  }
}

class $EventStoriesTable extends EventStories
    with TableInfo<$EventStoriesTable, EventStory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventStoriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _eventIDMeta = const VerificationMeta(
    'eventID',
  );
  @override
  late final GeneratedColumn<int> eventID = GeneratedColumn<int>(
    'event_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _encodedTextMeta = const VerificationMeta(
    'encodedText',
  );
  @override
  late final GeneratedColumn<String> encodedText = GeneratedColumn<String>(
    'encoded_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _modifiedAtMeta = const VerificationMeta(
    'modifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
    'modified_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventID,
    encodedText,
    title,
    createAt,
    modifiedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_stories';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventStory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_i_d')) {
      context.handle(
        _eventIDMeta,
        eventID.isAcceptableOrUnknown(data['event_i_d']!, _eventIDMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIDMeta);
    }
    if (data.containsKey('encoded_text')) {
      context.handle(
        _encodedTextMeta,
        encodedText.isAcceptableOrUnknown(
          data['encoded_text']!,
          _encodedTextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_encodedTextMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(
        _createAtMeta,
        createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta),
      );
    }
    if (data.containsKey('modified_at')) {
      context.handle(
        _modifiedAtMeta,
        modifiedAt.isAcceptableOrUnknown(data['modified_at']!, _modifiedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventStory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventStory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      eventID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_i_d'],
      )!,
      encodedText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}encoded_text'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      createAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_at'],
      )!,
      modifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}modified_at'],
      )!,
    );
  }

  @override
  $EventStoriesTable createAlias(String alias) {
    return $EventStoriesTable(attachedDatabase, alias);
  }
}

class EventStory extends DataClass implements Insertable<EventStory> {
  final int id;
  final int eventID;
  final String encodedText;
  final String title;
  final DateTime createAt;
  final DateTime modifiedAt;
  const EventStory({
    required this.id,
    required this.eventID,
    required this.encodedText,
    required this.title,
    required this.createAt,
    required this.modifiedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_i_d'] = Variable<int>(eventID);
    map['encoded_text'] = Variable<String>(encodedText);
    map['title'] = Variable<String>(title);
    map['create_at'] = Variable<DateTime>(createAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    return map;
  }

  EventStoriesCompanion toCompanion(bool nullToAbsent) {
    return EventStoriesCompanion(
      id: Value(id),
      eventID: Value(eventID),
      encodedText: Value(encodedText),
      title: Value(title),
      createAt: Value(createAt),
      modifiedAt: Value(modifiedAt),
    );
  }

  factory EventStory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventStory(
      id: serializer.fromJson<int>(json['id']),
      eventID: serializer.fromJson<int>(json['eventID']),
      encodedText: serializer.fromJson<String>(json['encodedText']),
      title: serializer.fromJson<String>(json['title']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventID': serializer.toJson<int>(eventID),
      'encodedText': serializer.toJson<String>(encodedText),
      'title': serializer.toJson<String>(title),
      'createAt': serializer.toJson<DateTime>(createAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
    };
  }

  EventStory copyWith({
    int? id,
    int? eventID,
    String? encodedText,
    String? title,
    DateTime? createAt,
    DateTime? modifiedAt,
  }) => EventStory(
    id: id ?? this.id,
    eventID: eventID ?? this.eventID,
    encodedText: encodedText ?? this.encodedText,
    title: title ?? this.title,
    createAt: createAt ?? this.createAt,
    modifiedAt: modifiedAt ?? this.modifiedAt,
  );
  EventStory copyWithCompanion(EventStoriesCompanion data) {
    return EventStory(
      id: data.id.present ? data.id.value : this.id,
      eventID: data.eventID.present ? data.eventID.value : this.eventID,
      encodedText: data.encodedText.present
          ? data.encodedText.value
          : this.encodedText,
      title: data.title.present ? data.title.value : this.title,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
      modifiedAt: data.modifiedAt.present
          ? data.modifiedAt.value
          : this.modifiedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventStory(')
          ..write('id: $id, ')
          ..write('eventID: $eventID, ')
          ..write('encodedText: $encodedText, ')
          ..write('title: $title, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, eventID, encodedText, title, createAt, modifiedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventStory &&
          other.id == this.id &&
          other.eventID == this.eventID &&
          other.encodedText == this.encodedText &&
          other.title == this.title &&
          other.createAt == this.createAt &&
          other.modifiedAt == this.modifiedAt);
}

class EventStoriesCompanion extends UpdateCompanion<EventStory> {
  final Value<int> id;
  final Value<int> eventID;
  final Value<String> encodedText;
  final Value<String> title;
  final Value<DateTime> createAt;
  final Value<DateTime> modifiedAt;
  const EventStoriesCompanion({
    this.id = const Value.absent(),
    this.eventID = const Value.absent(),
    this.encodedText = const Value.absent(),
    this.title = const Value.absent(),
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
  });
  EventStoriesCompanion.insert({
    this.id = const Value.absent(),
    required int eventID,
    required String encodedText,
    required String title,
    this.createAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
  }) : eventID = Value(eventID),
       encodedText = Value(encodedText),
       title = Value(title);
  static Insertable<EventStory> custom({
    Expression<int>? id,
    Expression<int>? eventID,
    Expression<String>? encodedText,
    Expression<String>? title,
    Expression<DateTime>? createAt,
    Expression<DateTime>? modifiedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventID != null) 'event_i_d': eventID,
      if (encodedText != null) 'encoded_text': encodedText,
      if (title != null) 'title': title,
      if (createAt != null) 'create_at': createAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
    });
  }

  EventStoriesCompanion copyWith({
    Value<int>? id,
    Value<int>? eventID,
    Value<String>? encodedText,
    Value<String>? title,
    Value<DateTime>? createAt,
    Value<DateTime>? modifiedAt,
  }) {
    return EventStoriesCompanion(
      id: id ?? this.id,
      eventID: eventID ?? this.eventID,
      encodedText: encodedText ?? this.encodedText,
      title: title ?? this.title,
      createAt: createAt ?? this.createAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventID.present) {
      map['event_i_d'] = Variable<int>(eventID.value);
    }
    if (encodedText.present) {
      map['encoded_text'] = Variable<String>(encodedText.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventStoriesCompanion(')
          ..write('id: $id, ')
          ..write('eventID: $eventID, ')
          ..write('encodedText: $encodedText, ')
          ..write('title: $title, ')
          ..write('createAt: $createAt, ')
          ..write('modifiedAt: $modifiedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TeamsTable teams = $TeamsTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $MembersTable members = $MembersTable(this);
  late final $ReportsTable reports = $ReportsTable(this);
  late final $RatiosTable ratios = $RatiosTable(this);
  late final $CollectReportEventsTable collectReportEvents =
      $CollectReportEventsTable(this);
  late final $GuestsTable guests = $GuestsTable(this);
  late final $EventTransactionsTable eventTransactions =
      $EventTransactionsTable(this);
  late final $EventRatiosTable eventRatios = $EventRatiosTable(this);
  late final $MenusTable menus = $MenusTable(this);
  late final $EventOrdersTable eventOrders = $EventOrdersTable(this);
  late final $EventStoriesTable eventStories = $EventStoriesTable(this);
  late final ReportDao reportDao = ReportDao(this as AppDatabase);
  late final RatioDao ratioDao = RatioDao(this as AppDatabase);
  late final EventDao eventDao = EventDao(this as AppDatabase);
  late final TeamDao teamDao = TeamDao(this as AppDatabase);
  late final MemberDao memberDao = MemberDao(this as AppDatabase);
  late final GuestDao guestDao = GuestDao(this as AppDatabase);
  late final MenuDao menuDao = MenuDao(this as AppDatabase);
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    teams,
    events,
    members,
    reports,
    ratios,
    collectReportEvents,
    guests,
    eventTransactions,
    eventRatios,
    menus,
    eventOrders,
    eventStories,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'teams',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('events', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'members',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('ratios', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'teams',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('ratios', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('collect_report_events', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'reports',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('collect_report_events', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_transactions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'members',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_transactions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'guests',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_transactions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'members',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_ratios', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_ratios', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'members',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_orders', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'guests',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_orders', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_orders', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_stories', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$TeamsTableCreateCompanionBuilder =
    TeamsCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> description,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
      Value<bool> isActive,
    });
typedef $$TeamsTableUpdateCompanionBuilder =
    TeamsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> description,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
      Value<bool> isActive,
    });

final class $$TeamsTableReferences
    extends BaseReferences<_$AppDatabase, $TeamsTable, Team> {
  $$TeamsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EventsTable, List<Event>> _eventsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.events,
    aliasName: $_aliasNameGenerator(db.teams.id, db.events.teamID),
  );

  $$EventsTableProcessedTableManager get eventsRefs {
    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.teamID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RatiosTable, List<Ratio>> _ratiosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.ratios,
    aliasName: $_aliasNameGenerator(db.teams.id, db.ratios.teamID),
  );

  $$RatiosTableProcessedTableManager get ratiosRefs {
    final manager = $$RatiosTableTableManager(
      $_db,
      $_db.ratios,
    ).filter((f) => f.teamID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ratiosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TeamsTableFilterComposer extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableFilterComposer({
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

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> eventsRefs(
    Expression<bool> Function($$EventsTableFilterComposer f) f,
  ) {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.teamID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ratiosRefs(
    Expression<bool> Function($$RatiosTableFilterComposer f) f,
  ) {
    final $$RatiosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ratios,
      getReferencedColumn: (t) => t.teamID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RatiosTableFilterComposer(
            $db: $db,
            $table: $db.ratios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TeamsTableOrderingComposer
    extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TeamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableAnnotationComposer({
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

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> eventsRefs<T extends Object>(
    Expression<T> Function($$EventsTableAnnotationComposer a) f,
  ) {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.teamID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> ratiosRefs<T extends Object>(
    Expression<T> Function($$RatiosTableAnnotationComposer a) f,
  ) {
    final $$RatiosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ratios,
      getReferencedColumn: (t) => t.teamID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RatiosTableAnnotationComposer(
            $db: $db,
            $table: $db.ratios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TeamsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeamsTable,
          Team,
          $$TeamsTableFilterComposer,
          $$TeamsTableOrderingComposer,
          $$TeamsTableAnnotationComposer,
          $$TeamsTableCreateCompanionBuilder,
          $$TeamsTableUpdateCompanionBuilder,
          (Team, $$TeamsTableReferences),
          Team,
          PrefetchHooks Function({bool eventsRefs, bool ratiosRefs})
        > {
  $$TeamsTableTableManager(_$AppDatabase db, $TeamsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => TeamsCompanion(
                id: id,
                title: title,
                description: description,
                createAt: createAt,
                modifiedAt: modifiedAt,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => TeamsCompanion.insert(
                id: id,
                title: title,
                description: description,
                createAt: createAt,
                modifiedAt: modifiedAt,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TeamsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({eventsRefs = false, ratiosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (eventsRefs) db.events,
                if (ratiosRefs) db.ratios,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (eventsRefs)
                    await $_getPrefetchedData<Team, $TeamsTable, Event>(
                      currentTable: table,
                      referencedTable: $$TeamsTableReferences._eventsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$TeamsTableReferences(db, table, p0).eventsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.teamID == item.id),
                      typedResults: items,
                    ),
                  if (ratiosRefs)
                    await $_getPrefetchedData<Team, $TeamsTable, Ratio>(
                      currentTable: table,
                      referencedTable: $$TeamsTableReferences._ratiosRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$TeamsTableReferences(db, table, p0).ratiosRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.teamID == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TeamsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeamsTable,
      Team,
      $$TeamsTableFilterComposer,
      $$TeamsTableOrderingComposer,
      $$TeamsTableAnnotationComposer,
      $$TeamsTableCreateCompanionBuilder,
      $$TeamsTableUpdateCompanionBuilder,
      (Team, $$TeamsTableReferences),
      Team,
      PrefetchHooks Function({bool eventsRefs, bool ratiosRefs})
    >;
typedef $$EventsTableCreateCompanionBuilder =
    EventsCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> description,
      required int teamID,
      Value<DateTime> date,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
      Value<bool> isActive,
    });
typedef $$EventsTableUpdateCompanionBuilder =
    EventsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> description,
      Value<int> teamID,
      Value<DateTime> date,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
      Value<bool> isActive,
    });

final class $$EventsTableReferences
    extends BaseReferences<_$AppDatabase, $EventsTable, Event> {
  $$EventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TeamsTable _teamIDTable(_$AppDatabase db) =>
      db.teams.createAlias($_aliasNameGenerator(db.events.teamID, db.teams.id));

  $$TeamsTableProcessedTableManager get teamID {
    final $_column = $_itemColumn<int>('team_i_d')!;

    final manager = $$TeamsTableTableManager(
      $_db,
      $_db.teams,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teamIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $CollectReportEventsTable,
    List<CollectReportEvent>
  >
  _collectReportEventsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.collectReportEvents,
        aliasName: $_aliasNameGenerator(
          db.events.id,
          db.collectReportEvents.eventID,
        ),
      );

  $$CollectReportEventsTableProcessedTableManager get collectReportEventsRefs {
    final manager = $$CollectReportEventsTableTableManager(
      $_db,
      $_db.collectReportEvents,
    ).filter((f) => f.eventID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _collectReportEventsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventTransactionsTable, List<EventTransaction>>
  _eventTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.eventTransactions,
        aliasName: $_aliasNameGenerator(
          db.events.id,
          db.eventTransactions.eventID,
        ),
      );

  $$EventTransactionsTableProcessedTableManager get eventTransactionsRefs {
    final manager = $$EventTransactionsTableTableManager(
      $_db,
      $_db.eventTransactions,
    ).filter((f) => f.eventID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _eventTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventRatiosTable, List<EventRatio>>
  _eventRatiosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventRatios,
    aliasName: $_aliasNameGenerator(db.events.id, db.eventRatios.eventID),
  );

  $$EventRatiosTableProcessedTableManager get eventRatiosRefs {
    final manager = $$EventRatiosTableTableManager(
      $_db,
      $_db.eventRatios,
    ).filter((f) => f.eventID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventRatiosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventOrdersTable, List<EventOrder>>
  _eventOrdersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventOrders,
    aliasName: $_aliasNameGenerator(db.events.id, db.eventOrders.eventID),
  );

  $$EventOrdersTableProcessedTableManager get eventOrdersRefs {
    final manager = $$EventOrdersTableTableManager(
      $_db,
      $_db.eventOrders,
    ).filter((f) => f.eventID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventOrdersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventStoriesTable, List<EventStory>>
  _eventStoriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventStories,
    aliasName: $_aliasNameGenerator(db.events.id, db.eventStories.eventID),
  );

  $$EventStoriesTableProcessedTableManager get eventStoriesRefs {
    final manager = $$EventStoriesTableTableManager(
      $_db,
      $_db.eventStories,
    ).filter((f) => f.eventID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventStoriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EventsTableFilterComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableFilterComposer({
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

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  $$TeamsTableFilterComposer get teamID {
    final $$TeamsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamID,
      referencedTable: $db.teams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamsTableFilterComposer(
            $db: $db,
            $table: $db.teams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> collectReportEventsRefs(
    Expression<bool> Function($$CollectReportEventsTableFilterComposer f) f,
  ) {
    final $$CollectReportEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.collectReportEvents,
      getReferencedColumn: (t) => t.eventID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectReportEventsTableFilterComposer(
            $db: $db,
            $table: $db.collectReportEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventTransactionsRefs(
    Expression<bool> Function($$EventTransactionsTableFilterComposer f) f,
  ) {
    final $$EventTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventTransactions,
      getReferencedColumn: (t) => t.eventID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.eventTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventRatiosRefs(
    Expression<bool> Function($$EventRatiosTableFilterComposer f) f,
  ) {
    final $$EventRatiosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventRatios,
      getReferencedColumn: (t) => t.eventID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventRatiosTableFilterComposer(
            $db: $db,
            $table: $db.eventRatios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventOrdersRefs(
    Expression<bool> Function($$EventOrdersTableFilterComposer f) f,
  ) {
    final $$EventOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventOrders,
      getReferencedColumn: (t) => t.eventID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventOrdersTableFilterComposer(
            $db: $db,
            $table: $db.eventOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventStoriesRefs(
    Expression<bool> Function($$EventStoriesTableFilterComposer f) f,
  ) {
    final $$EventStoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventStories,
      getReferencedColumn: (t) => t.eventID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventStoriesTableFilterComposer(
            $db: $db,
            $table: $db.eventStories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EventsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  $$TeamsTableOrderingComposer get teamID {
    final $$TeamsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamID,
      referencedTable: $db.teams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamsTableOrderingComposer(
            $db: $db,
            $table: $db.teams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableAnnotationComposer({
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

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$TeamsTableAnnotationComposer get teamID {
    final $$TeamsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamID,
      referencedTable: $db.teams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamsTableAnnotationComposer(
            $db: $db,
            $table: $db.teams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> collectReportEventsRefs<T extends Object>(
    Expression<T> Function($$CollectReportEventsTableAnnotationComposer a) f,
  ) {
    final $$CollectReportEventsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.collectReportEvents,
          getReferencedColumn: (t) => t.eventID,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CollectReportEventsTableAnnotationComposer(
                $db: $db,
                $table: $db.collectReportEvents,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> eventTransactionsRefs<T extends Object>(
    Expression<T> Function($$EventTransactionsTableAnnotationComposer a) f,
  ) {
    final $$EventTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.eventTransactions,
          getReferencedColumn: (t) => t.eventID,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EventTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.eventTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> eventRatiosRefs<T extends Object>(
    Expression<T> Function($$EventRatiosTableAnnotationComposer a) f,
  ) {
    final $$EventRatiosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventRatios,
      getReferencedColumn: (t) => t.eventID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventRatiosTableAnnotationComposer(
            $db: $db,
            $table: $db.eventRatios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> eventOrdersRefs<T extends Object>(
    Expression<T> Function($$EventOrdersTableAnnotationComposer a) f,
  ) {
    final $$EventOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventOrders,
      getReferencedColumn: (t) => t.eventID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.eventOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> eventStoriesRefs<T extends Object>(
    Expression<T> Function($$EventStoriesTableAnnotationComposer a) f,
  ) {
    final $$EventStoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventStories,
      getReferencedColumn: (t) => t.eventID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventStoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.eventStories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventsTable,
          Event,
          $$EventsTableFilterComposer,
          $$EventsTableOrderingComposer,
          $$EventsTableAnnotationComposer,
          $$EventsTableCreateCompanionBuilder,
          $$EventsTableUpdateCompanionBuilder,
          (Event, $$EventsTableReferences),
          Event,
          PrefetchHooks Function({
            bool teamID,
            bool collectReportEventsRefs,
            bool eventTransactionsRefs,
            bool eventRatiosRefs,
            bool eventOrdersRefs,
            bool eventStoriesRefs,
          })
        > {
  $$EventsTableTableManager(_$AppDatabase db, $EventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> teamID = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => EventsCompanion(
                id: id,
                title: title,
                description: description,
                teamID: teamID,
                date: date,
                createAt: createAt,
                modifiedAt: modifiedAt,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                required int teamID,
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => EventsCompanion.insert(
                id: id,
                title: title,
                description: description,
                teamID: teamID,
                date: date,
                createAt: createAt,
                modifiedAt: modifiedAt,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$EventsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                teamID = false,
                collectReportEventsRefs = false,
                eventTransactionsRefs = false,
                eventRatiosRefs = false,
                eventOrdersRefs = false,
                eventStoriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (collectReportEventsRefs) db.collectReportEvents,
                    if (eventTransactionsRefs) db.eventTransactions,
                    if (eventRatiosRefs) db.eventRatios,
                    if (eventOrdersRefs) db.eventOrders,
                    if (eventStoriesRefs) db.eventStories,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (teamID) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.teamID,
                                    referencedTable: $$EventsTableReferences
                                        ._teamIDTable(db),
                                    referencedColumn: $$EventsTableReferences
                                        ._teamIDTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (collectReportEventsRefs)
                        await $_getPrefetchedData<
                          Event,
                          $EventsTable,
                          CollectReportEvent
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._collectReportEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).collectReportEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventTransactionsRefs)
                        await $_getPrefetchedData<
                          Event,
                          $EventsTable,
                          EventTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._eventTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventRatiosRefs)
                        await $_getPrefetchedData<
                          Event,
                          $EventsTable,
                          EventRatio
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._eventRatiosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventRatiosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventOrdersRefs)
                        await $_getPrefetchedData<
                          Event,
                          $EventsTable,
                          EventOrder
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._eventOrdersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventOrdersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventStoriesRefs)
                        await $_getPrefetchedData<
                          Event,
                          $EventsTable,
                          EventStory
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._eventStoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventStoriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventID == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventsTable,
      Event,
      $$EventsTableFilterComposer,
      $$EventsTableOrderingComposer,
      $$EventsTableAnnotationComposer,
      $$EventsTableCreateCompanionBuilder,
      $$EventsTableUpdateCompanionBuilder,
      (Event, $$EventsTableReferences),
      Event,
      PrefetchHooks Function({
        bool teamID,
        bool collectReportEventsRefs,
        bool eventTransactionsRefs,
        bool eventRatiosRefs,
        bool eventOrdersRefs,
        bool eventStoriesRefs,
      })
    >;
typedef $$MembersTableCreateCompanionBuilder =
    MembersCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<DateTime?> joinAt,
      Value<bool> isActive,
      Value<DateTime?> birthday,
      Value<String?> profileImage,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
    });
typedef $$MembersTableUpdateCompanionBuilder =
    MembersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<DateTime?> joinAt,
      Value<bool> isActive,
      Value<DateTime?> birthday,
      Value<String?> profileImage,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
    });

final class $$MembersTableReferences
    extends BaseReferences<_$AppDatabase, $MembersTable, Member> {
  $$MembersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RatiosTable, List<Ratio>> _ratiosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.ratios,
    aliasName: $_aliasNameGenerator(db.members.id, db.ratios.memberID),
  );

  $$RatiosTableProcessedTableManager get ratiosRefs {
    final manager = $$RatiosTableTableManager(
      $_db,
      $_db.ratios,
    ).filter((f) => f.memberID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ratiosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventTransactionsTable, List<EventTransaction>>
  _eventTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.eventTransactions,
        aliasName: $_aliasNameGenerator(
          db.members.id,
          db.eventTransactions.memberID,
        ),
      );

  $$EventTransactionsTableProcessedTableManager get eventTransactionsRefs {
    final manager = $$EventTransactionsTableTableManager(
      $_db,
      $_db.eventTransactions,
    ).filter((f) => f.memberID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _eventTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventRatiosTable, List<EventRatio>>
  _eventRatiosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventRatios,
    aliasName: $_aliasNameGenerator(db.members.id, db.eventRatios.memberID),
  );

  $$EventRatiosTableProcessedTableManager get eventRatiosRefs {
    final manager = $$EventRatiosTableTableManager(
      $_db,
      $_db.eventRatios,
    ).filter((f) => f.memberID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventRatiosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventOrdersTable, List<EventOrder>>
  _eventOrdersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventOrders,
    aliasName: $_aliasNameGenerator(db.members.id, db.eventOrders.memberID),
  );

  $$EventOrdersTableProcessedTableManager get eventOrdersRefs {
    final manager = $$EventOrdersTableTableManager(
      $_db,
      $_db.eventOrders,
    ).filter((f) => f.memberID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventOrdersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  ColumnFilters<DateTime> get joinAt => $composableBuilder(
    column: $table.joinAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get birthday => $composableBuilder(
    column: $table.birthday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profileImage => $composableBuilder(
    column: $table.profileImage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ratiosRefs(
    Expression<bool> Function($$RatiosTableFilterComposer f) f,
  ) {
    final $$RatiosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ratios,
      getReferencedColumn: (t) => t.memberID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RatiosTableFilterComposer(
            $db: $db,
            $table: $db.ratios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventTransactionsRefs(
    Expression<bool> Function($$EventTransactionsTableFilterComposer f) f,
  ) {
    final $$EventTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventTransactions,
      getReferencedColumn: (t) => t.memberID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.eventTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventRatiosRefs(
    Expression<bool> Function($$EventRatiosTableFilterComposer f) f,
  ) {
    final $$EventRatiosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventRatios,
      getReferencedColumn: (t) => t.memberID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventRatiosTableFilterComposer(
            $db: $db,
            $table: $db.eventRatios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventOrdersRefs(
    Expression<bool> Function($$EventOrdersTableFilterComposer f) f,
  ) {
    final $$EventOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventOrders,
      getReferencedColumn: (t) => t.memberID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventOrdersTableFilterComposer(
            $db: $db,
            $table: $db.eventOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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

  ColumnOrderings<DateTime> get joinAt => $composableBuilder(
    column: $table.joinAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthday => $composableBuilder(
    column: $table.birthday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profileImage => $composableBuilder(
    column: $table.profileImage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
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

  GeneratedColumn<DateTime> get joinAt =>
      $composableBuilder(column: $table.joinAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get birthday =>
      $composableBuilder(column: $table.birthday, builder: (column) => column);

  GeneratedColumn<String> get profileImage => $composableBuilder(
    column: $table.profileImage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => column,
  );

  Expression<T> ratiosRefs<T extends Object>(
    Expression<T> Function($$RatiosTableAnnotationComposer a) f,
  ) {
    final $$RatiosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ratios,
      getReferencedColumn: (t) => t.memberID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RatiosTableAnnotationComposer(
            $db: $db,
            $table: $db.ratios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> eventTransactionsRefs<T extends Object>(
    Expression<T> Function($$EventTransactionsTableAnnotationComposer a) f,
  ) {
    final $$EventTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.eventTransactions,
          getReferencedColumn: (t) => t.memberID,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EventTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.eventTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> eventRatiosRefs<T extends Object>(
    Expression<T> Function($$EventRatiosTableAnnotationComposer a) f,
  ) {
    final $$EventRatiosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventRatios,
      getReferencedColumn: (t) => t.memberID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventRatiosTableAnnotationComposer(
            $db: $db,
            $table: $db.eventRatios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> eventOrdersRefs<T extends Object>(
    Expression<T> Function($$EventOrdersTableAnnotationComposer a) f,
  ) {
    final $$EventOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventOrders,
      getReferencedColumn: (t) => t.memberID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.eventOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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
          (Member, $$MembersTableReferences),
          Member,
          PrefetchHooks Function({
            bool ratiosRefs,
            bool eventTransactionsRefs,
            bool eventRatiosRefs,
            bool eventOrdersRefs,
          })
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
                Value<DateTime?> joinAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> birthday = const Value.absent(),
                Value<String?> profileImage = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
              }) => MembersCompanion(
                id: id,
                name: name,
                description: description,
                joinAt: joinAt,
                isActive: isActive,
                birthday: birthday,
                profileImage: profileImage,
                createAt: createAt,
                modifiedAt: modifiedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<DateTime?> joinAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> birthday = const Value.absent(),
                Value<String?> profileImage = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
              }) => MembersCompanion.insert(
                id: id,
                name: name,
                description: description,
                joinAt: joinAt,
                isActive: isActive,
                birthday: birthday,
                profileImage: profileImage,
                createAt: createAt,
                modifiedAt: modifiedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MembersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                ratiosRefs = false,
                eventTransactionsRefs = false,
                eventRatiosRefs = false,
                eventOrdersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (ratiosRefs) db.ratios,
                    if (eventTransactionsRefs) db.eventTransactions,
                    if (eventRatiosRefs) db.eventRatios,
                    if (eventOrdersRefs) db.eventOrders,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (ratiosRefs)
                        await $_getPrefetchedData<Member, $MembersTable, Ratio>(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._ratiosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).ratiosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.memberID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventTransactionsRefs)
                        await $_getPrefetchedData<
                          Member,
                          $MembersTable,
                          EventTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._eventTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).eventTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.memberID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventRatiosRefs)
                        await $_getPrefetchedData<
                          Member,
                          $MembersTable,
                          EventRatio
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._eventRatiosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).eventRatiosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.memberID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventOrdersRefs)
                        await $_getPrefetchedData<
                          Member,
                          $MembersTable,
                          EventOrder
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._eventOrdersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).eventOrdersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.memberID == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
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
      (Member, $$MembersTableReferences),
      Member,
      PrefetchHooks Function({
        bool ratiosRefs,
        bool eventTransactionsRefs,
        bool eventRatiosRefs,
        bool eventOrdersRefs,
      })
    >;
typedef $$ReportsTableCreateCompanionBuilder =
    ReportsCompanion Function({
      Value<int> id,
      required String title,
      required int version,
      Value<String?> description,
      Value<DateTime> generateFor,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
      Value<bool> isActive,
    });
typedef $$ReportsTableUpdateCompanionBuilder =
    ReportsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<int> version,
      Value<String?> description,
      Value<DateTime> generateFor,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
      Value<bool> isActive,
    });

final class $$ReportsTableReferences
    extends BaseReferences<_$AppDatabase, $ReportsTable, Report> {
  $$ReportsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $CollectReportEventsTable,
    List<CollectReportEvent>
  >
  _collectReportEventsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.collectReportEvents,
        aliasName: $_aliasNameGenerator(
          db.reports.id,
          db.collectReportEvents.reportID,
        ),
      );

  $$CollectReportEventsTableProcessedTableManager get collectReportEventsRefs {
    final manager = $$CollectReportEventsTableTableManager(
      $_db,
      $_db.collectReportEvents,
    ).filter((f) => f.reportID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _collectReportEventsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  ColumnFilters<DateTime> get generateFor => $composableBuilder(
    column: $table.generateFor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> collectReportEventsRefs(
    Expression<bool> Function($$CollectReportEventsTableFilterComposer f) f,
  ) {
    final $$CollectReportEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.collectReportEvents,
      getReferencedColumn: (t) => t.reportID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectReportEventsTableFilterComposer(
            $db: $db,
            $table: $db.collectReportEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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

  ColumnOrderings<DateTime> get generateFor => $composableBuilder(
    column: $table.generateFor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
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

  GeneratedColumn<DateTime> get generateFor => $composableBuilder(
    column: $table.generateFor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> collectReportEventsRefs<T extends Object>(
    Expression<T> Function($$CollectReportEventsTableAnnotationComposer a) f,
  ) {
    final $$CollectReportEventsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.collectReportEvents,
          getReferencedColumn: (t) => t.reportID,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CollectReportEventsTableAnnotationComposer(
                $db: $db,
                $table: $db.collectReportEvents,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
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
          (Report, $$ReportsTableReferences),
          Report,
          PrefetchHooks Function({bool collectReportEventsRefs})
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
                Value<DateTime> generateFor = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => ReportsCompanion(
                id: id,
                title: title,
                version: version,
                description: description,
                generateFor: generateFor,
                createAt: createAt,
                modifiedAt: modifiedAt,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required int version,
                Value<String?> description = const Value.absent(),
                Value<DateTime> generateFor = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => ReportsCompanion.insert(
                id: id,
                title: title,
                version: version,
                description: description,
                generateFor: generateFor,
                createAt: createAt,
                modifiedAt: modifiedAt,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReportsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({collectReportEventsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (collectReportEventsRefs) db.collectReportEvents,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (collectReportEventsRefs)
                    await $_getPrefetchedData<
                      Report,
                      $ReportsTable,
                      CollectReportEvent
                    >(
                      currentTable: table,
                      referencedTable: $$ReportsTableReferences
                          ._collectReportEventsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ReportsTableReferences(
                        db,
                        table,
                        p0,
                      ).collectReportEventsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.reportID == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
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
      (Report, $$ReportsTableReferences),
      Report,
      PrefetchHooks Function({bool collectReportEventsRefs})
    >;
typedef $$RatiosTableCreateCompanionBuilder =
    RatiosCompanion Function({
      Value<int> id,
      required int memberID,
      required int teamID,
      required double ratio,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
    });
typedef $$RatiosTableUpdateCompanionBuilder =
    RatiosCompanion Function({
      Value<int> id,
      Value<int> memberID,
      Value<int> teamID,
      Value<double> ratio,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
    });

final class $$RatiosTableReferences
    extends BaseReferences<_$AppDatabase, $RatiosTable, Ratio> {
  $$RatiosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MembersTable _memberIDTable(_$AppDatabase db) => db.members
      .createAlias($_aliasNameGenerator(db.ratios.memberID, db.members.id));

  $$MembersTableProcessedTableManager get memberID {
    final $_column = $_itemColumn<int>('member_i_d')!;

    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TeamsTable _teamIDTable(_$AppDatabase db) =>
      db.teams.createAlias($_aliasNameGenerator(db.ratios.teamID, db.teams.id));

  $$TeamsTableProcessedTableManager get teamID {
    final $_column = $_itemColumn<int>('team_i_d')!;

    final manager = $$TeamsTableTableManager(
      $_db,
      $_db.teams,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teamIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RatiosTableFilterComposer
    extends Composer<_$AppDatabase, $RatiosTable> {
  $$RatiosTableFilterComposer({
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

  ColumnFilters<double> get ratio => $composableBuilder(
    column: $table.ratio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MembersTableFilterComposer get memberID {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberID,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamsTableFilterComposer get teamID {
    final $$TeamsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamID,
      referencedTable: $db.teams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamsTableFilterComposer(
            $db: $db,
            $table: $db.teams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RatiosTableOrderingComposer
    extends Composer<_$AppDatabase, $RatiosTable> {
  $$RatiosTableOrderingComposer({
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

  ColumnOrderings<double> get ratio => $composableBuilder(
    column: $table.ratio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MembersTableOrderingComposer get memberID {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberID,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableOrderingComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamsTableOrderingComposer get teamID {
    final $$TeamsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamID,
      referencedTable: $db.teams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamsTableOrderingComposer(
            $db: $db,
            $table: $db.teams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RatiosTableAnnotationComposer
    extends Composer<_$AppDatabase, $RatiosTable> {
  $$RatiosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get ratio =>
      $composableBuilder(column: $table.ratio, builder: (column) => column);

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => column,
  );

  $$MembersTableAnnotationComposer get memberID {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberID,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamsTableAnnotationComposer get teamID {
    final $$TeamsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamID,
      referencedTable: $db.teams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamsTableAnnotationComposer(
            $db: $db,
            $table: $db.teams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RatiosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RatiosTable,
          Ratio,
          $$RatiosTableFilterComposer,
          $$RatiosTableOrderingComposer,
          $$RatiosTableAnnotationComposer,
          $$RatiosTableCreateCompanionBuilder,
          $$RatiosTableUpdateCompanionBuilder,
          (Ratio, $$RatiosTableReferences),
          Ratio,
          PrefetchHooks Function({bool memberID, bool teamID})
        > {
  $$RatiosTableTableManager(_$AppDatabase db, $RatiosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RatiosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RatiosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RatiosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> memberID = const Value.absent(),
                Value<int> teamID = const Value.absent(),
                Value<double> ratio = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
              }) => RatiosCompanion(
                id: id,
                memberID: memberID,
                teamID: teamID,
                ratio: ratio,
                createAt: createAt,
                modifiedAt: modifiedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int memberID,
                required int teamID,
                required double ratio,
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
              }) => RatiosCompanion.insert(
                id: id,
                memberID: memberID,
                teamID: teamID,
                ratio: ratio,
                createAt: createAt,
                modifiedAt: modifiedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$RatiosTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({memberID = false, teamID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (memberID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.memberID,
                                referencedTable: $$RatiosTableReferences
                                    ._memberIDTable(db),
                                referencedColumn: $$RatiosTableReferences
                                    ._memberIDTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (teamID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.teamID,
                                referencedTable: $$RatiosTableReferences
                                    ._teamIDTable(db),
                                referencedColumn: $$RatiosTableReferences
                                    ._teamIDTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RatiosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RatiosTable,
      Ratio,
      $$RatiosTableFilterComposer,
      $$RatiosTableOrderingComposer,
      $$RatiosTableAnnotationComposer,
      $$RatiosTableCreateCompanionBuilder,
      $$RatiosTableUpdateCompanionBuilder,
      (Ratio, $$RatiosTableReferences),
      Ratio,
      PrefetchHooks Function({bool memberID, bool teamID})
    >;
typedef $$CollectReportEventsTableCreateCompanionBuilder =
    CollectReportEventsCompanion Function({
      Value<int> id,
      required int eventID,
      required int reportID,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
    });
typedef $$CollectReportEventsTableUpdateCompanionBuilder =
    CollectReportEventsCompanion Function({
      Value<int> id,
      Value<int> eventID,
      Value<int> reportID,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
    });

final class $$CollectReportEventsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CollectReportEventsTable,
          CollectReportEvent
        > {
  $$CollectReportEventsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EventsTable _eventIDTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.collectReportEvents.eventID, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventID {
    final $_column = $_itemColumn<int>('event_i_d')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ReportsTable _reportIDTable(_$AppDatabase db) =>
      db.reports.createAlias(
        $_aliasNameGenerator(db.collectReportEvents.reportID, db.reports.id),
      );

  $$ReportsTableProcessedTableManager get reportID {
    final $_column = $_itemColumn<int>('report_i_d')!;

    final manager = $$ReportsTableTableManager(
      $_db,
      $_db.reports,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reportIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CollectReportEventsTableFilterComposer
    extends Composer<_$AppDatabase, $CollectReportEventsTable> {
  $$CollectReportEventsTableFilterComposer({
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

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventID {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReportsTableFilterComposer get reportID {
    final $$ReportsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportID,
      referencedTable: $db.reports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportsTableFilterComposer(
            $db: $db,
            $table: $db.reports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectReportEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectReportEventsTable> {
  $$CollectReportEventsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventID {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReportsTableOrderingComposer get reportID {
    final $$ReportsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportID,
      referencedTable: $db.reports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportsTableOrderingComposer(
            $db: $db,
            $table: $db.reports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectReportEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectReportEventsTable> {
  $$CollectReportEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => column,
  );

  $$EventsTableAnnotationComposer get eventID {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReportsTableAnnotationComposer get reportID {
    final $$ReportsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportID,
      referencedTable: $db.reports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportsTableAnnotationComposer(
            $db: $db,
            $table: $db.reports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectReportEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CollectReportEventsTable,
          CollectReportEvent,
          $$CollectReportEventsTableFilterComposer,
          $$CollectReportEventsTableOrderingComposer,
          $$CollectReportEventsTableAnnotationComposer,
          $$CollectReportEventsTableCreateCompanionBuilder,
          $$CollectReportEventsTableUpdateCompanionBuilder,
          (CollectReportEvent, $$CollectReportEventsTableReferences),
          CollectReportEvent,
          PrefetchHooks Function({bool eventID, bool reportID})
        > {
  $$CollectReportEventsTableTableManager(
    _$AppDatabase db,
    $CollectReportEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CollectReportEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CollectReportEventsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CollectReportEventsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> eventID = const Value.absent(),
                Value<int> reportID = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
              }) => CollectReportEventsCompanion(
                id: id,
                eventID: eventID,
                reportID: reportID,
                createAt: createAt,
                modifiedAt: modifiedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int eventID,
                required int reportID,
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
              }) => CollectReportEventsCompanion.insert(
                id: id,
                eventID: eventID,
                reportID: reportID,
                createAt: createAt,
                modifiedAt: modifiedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CollectReportEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventID = false, reportID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventID,
                                referencedTable:
                                    $$CollectReportEventsTableReferences
                                        ._eventIDTable(db),
                                referencedColumn:
                                    $$CollectReportEventsTableReferences
                                        ._eventIDTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (reportID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.reportID,
                                referencedTable:
                                    $$CollectReportEventsTableReferences
                                        ._reportIDTable(db),
                                referencedColumn:
                                    $$CollectReportEventsTableReferences
                                        ._reportIDTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CollectReportEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CollectReportEventsTable,
      CollectReportEvent,
      $$CollectReportEventsTableFilterComposer,
      $$CollectReportEventsTableOrderingComposer,
      $$CollectReportEventsTableAnnotationComposer,
      $$CollectReportEventsTableCreateCompanionBuilder,
      $$CollectReportEventsTableUpdateCompanionBuilder,
      (CollectReportEvent, $$CollectReportEventsTableReferences),
      CollectReportEvent,
      PrefetchHooks Function({bool eventID, bool reportID})
    >;
typedef $$GuestsTableCreateCompanionBuilder =
    GuestsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<String?> profileImage,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
      Value<bool> isActive,
      Value<String?> telegramId,
      Value<String?> instagramId,
      Value<String?> phoneNumber,
      Value<DateTime?> birthday,
    });
typedef $$GuestsTableUpdateCompanionBuilder =
    GuestsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<String?> profileImage,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
      Value<bool> isActive,
      Value<String?> telegramId,
      Value<String?> instagramId,
      Value<String?> phoneNumber,
      Value<DateTime?> birthday,
    });

final class $$GuestsTableReferences
    extends BaseReferences<_$AppDatabase, $GuestsTable, Guest> {
  $$GuestsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EventTransactionsTable, List<EventTransaction>>
  _eventTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.eventTransactions,
        aliasName: $_aliasNameGenerator(
          db.guests.id,
          db.eventTransactions.guestID,
        ),
      );

  $$EventTransactionsTableProcessedTableManager get eventTransactionsRefs {
    final manager = $$EventTransactionsTableTableManager(
      $_db,
      $_db.eventTransactions,
    ).filter((f) => f.guestID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _eventTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventOrdersTable, List<EventOrder>>
  _eventOrdersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventOrders,
    aliasName: $_aliasNameGenerator(db.guests.id, db.eventOrders.guessID),
  );

  $$EventOrdersTableProcessedTableManager get eventOrdersRefs {
    final manager = $$EventOrdersTableTableManager(
      $_db,
      $_db.eventOrders,
    ).filter((f) => f.guessID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventOrdersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GuestsTableFilterComposer
    extends Composer<_$AppDatabase, $GuestsTable> {
  $$GuestsTableFilterComposer({
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

  ColumnFilters<String> get profileImage => $composableBuilder(
    column: $table.profileImage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telegramId => $composableBuilder(
    column: $table.telegramId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instagramId => $composableBuilder(
    column: $table.instagramId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get birthday => $composableBuilder(
    column: $table.birthday,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> eventTransactionsRefs(
    Expression<bool> Function($$EventTransactionsTableFilterComposer f) f,
  ) {
    final $$EventTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventTransactions,
      getReferencedColumn: (t) => t.guestID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.eventTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventOrdersRefs(
    Expression<bool> Function($$EventOrdersTableFilterComposer f) f,
  ) {
    final $$EventOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventOrders,
      getReferencedColumn: (t) => t.guessID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventOrdersTableFilterComposer(
            $db: $db,
            $table: $db.eventOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GuestsTableOrderingComposer
    extends Composer<_$AppDatabase, $GuestsTable> {
  $$GuestsTableOrderingComposer({
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

  ColumnOrderings<String> get profileImage => $composableBuilder(
    column: $table.profileImage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telegramId => $composableBuilder(
    column: $table.telegramId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instagramId => $composableBuilder(
    column: $table.instagramId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthday => $composableBuilder(
    column: $table.birthday,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GuestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GuestsTable> {
  $$GuestsTableAnnotationComposer({
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

  GeneratedColumn<String> get profileImage => $composableBuilder(
    column: $table.profileImage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get telegramId => $composableBuilder(
    column: $table.telegramId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get instagramId => $composableBuilder(
    column: $table.instagramId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get birthday =>
      $composableBuilder(column: $table.birthday, builder: (column) => column);

  Expression<T> eventTransactionsRefs<T extends Object>(
    Expression<T> Function($$EventTransactionsTableAnnotationComposer a) f,
  ) {
    final $$EventTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.eventTransactions,
          getReferencedColumn: (t) => t.guestID,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EventTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.eventTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> eventOrdersRefs<T extends Object>(
    Expression<T> Function($$EventOrdersTableAnnotationComposer a) f,
  ) {
    final $$EventOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventOrders,
      getReferencedColumn: (t) => t.guessID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.eventOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GuestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GuestsTable,
          Guest,
          $$GuestsTableFilterComposer,
          $$GuestsTableOrderingComposer,
          $$GuestsTableAnnotationComposer,
          $$GuestsTableCreateCompanionBuilder,
          $$GuestsTableUpdateCompanionBuilder,
          (Guest, $$GuestsTableReferences),
          Guest,
          PrefetchHooks Function({
            bool eventTransactionsRefs,
            bool eventOrdersRefs,
          })
        > {
  $$GuestsTableTableManager(_$AppDatabase db, $GuestsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GuestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GuestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GuestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> profileImage = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String?> telegramId = const Value.absent(),
                Value<String?> instagramId = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<DateTime?> birthday = const Value.absent(),
              }) => GuestsCompanion(
                id: id,
                name: name,
                description: description,
                profileImage: profileImage,
                createAt: createAt,
                modifiedAt: modifiedAt,
                isActive: isActive,
                telegramId: telegramId,
                instagramId: instagramId,
                phoneNumber: phoneNumber,
                birthday: birthday,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> profileImage = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String?> telegramId = const Value.absent(),
                Value<String?> instagramId = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<DateTime?> birthday = const Value.absent(),
              }) => GuestsCompanion.insert(
                id: id,
                name: name,
                description: description,
                profileImage: profileImage,
                createAt: createAt,
                modifiedAt: modifiedAt,
                isActive: isActive,
                telegramId: telegramId,
                instagramId: instagramId,
                phoneNumber: phoneNumber,
                birthday: birthday,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$GuestsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({eventTransactionsRefs = false, eventOrdersRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (eventTransactionsRefs) db.eventTransactions,
                    if (eventOrdersRefs) db.eventOrders,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (eventTransactionsRefs)
                        await $_getPrefetchedData<
                          Guest,
                          $GuestsTable,
                          EventTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$GuestsTableReferences
                              ._eventTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GuestsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.guestID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventOrdersRefs)
                        await $_getPrefetchedData<
                          Guest,
                          $GuestsTable,
                          EventOrder
                        >(
                          currentTable: table,
                          referencedTable: $$GuestsTableReferences
                              ._eventOrdersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GuestsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventOrdersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.guessID == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GuestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GuestsTable,
      Guest,
      $$GuestsTableFilterComposer,
      $$GuestsTableOrderingComposer,
      $$GuestsTableAnnotationComposer,
      $$GuestsTableCreateCompanionBuilder,
      $$GuestsTableUpdateCompanionBuilder,
      (Guest, $$GuestsTableReferences),
      Guest,
      PrefetchHooks Function({bool eventTransactionsRefs, bool eventOrdersRefs})
    >;
typedef $$EventTransactionsTableCreateCompanionBuilder =
    EventTransactionsCompanion Function({
      Value<int> id,
      Value<String?> description,
      required double amount,
      required TransactionType transactionType,
      required int eventID,
      Value<DateTime> date,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
      Value<int?> memberID,
      Value<int?> guestID,
      Value<String?> attachment,
    });
typedef $$EventTransactionsTableUpdateCompanionBuilder =
    EventTransactionsCompanion Function({
      Value<int> id,
      Value<String?> description,
      Value<double> amount,
      Value<TransactionType> transactionType,
      Value<int> eventID,
      Value<DateTime> date,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
      Value<int?> memberID,
      Value<int?> guestID,
      Value<String?> attachment,
    });

final class $$EventTransactionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $EventTransactionsTable,
          EventTransaction
        > {
  $$EventTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EventsTable _eventIDTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.eventTransactions.eventID, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventID {
    final $_column = $_itemColumn<int>('event_i_d')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MembersTable _memberIDTable(_$AppDatabase db) =>
      db.members.createAlias(
        $_aliasNameGenerator(db.eventTransactions.memberID, db.members.id),
      );

  $$MembersTableProcessedTableManager? get memberID {
    final $_column = $_itemColumn<int>('member_i_d');
    if ($_column == null) return null;
    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GuestsTable _guestIDTable(_$AppDatabase db) => db.guests.createAlias(
    $_aliasNameGenerator(db.eventTransactions.guestID, db.guests.id),
  );

  $$GuestsTableProcessedTableManager? get guestID {
    final $_column = $_itemColumn<int>('guest_i_d');
    if ($_column == null) return null;
    final manager = $$GuestsTableTableManager(
      $_db,
      $_db.guests,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_guestIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $EventTransactionsTable> {
  $$EventTransactionsTableFilterComposer({
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

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TransactionType, TransactionType, String>
  get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attachment => $composableBuilder(
    column: $table.attachment,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventID {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableFilterComposer get memberID {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberID,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GuestsTableFilterComposer get guestID {
    final $$GuestsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.guestID,
      referencedTable: $db.guests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GuestsTableFilterComposer(
            $db: $db,
            $table: $db.guests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventTransactionsTable> {
  $$EventTransactionsTableOrderingComposer({
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

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
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

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attachment => $composableBuilder(
    column: $table.attachment,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventID {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableOrderingComposer get memberID {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberID,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableOrderingComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GuestsTableOrderingComposer get guestID {
    final $$GuestsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.guestID,
      referencedTable: $db.guests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GuestsTableOrderingComposer(
            $db: $db,
            $table: $db.guests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventTransactionsTable> {
  $$EventTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TransactionType, String>
  get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get attachment => $composableBuilder(
    column: $table.attachment,
    builder: (column) => column,
  );

  $$EventsTableAnnotationComposer get eventID {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableAnnotationComposer get memberID {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberID,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GuestsTableAnnotationComposer get guestID {
    final $$GuestsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.guestID,
      referencedTable: $db.guests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GuestsTableAnnotationComposer(
            $db: $db,
            $table: $db.guests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventTransactionsTable,
          EventTransaction,
          $$EventTransactionsTableFilterComposer,
          $$EventTransactionsTableOrderingComposer,
          $$EventTransactionsTableAnnotationComposer,
          $$EventTransactionsTableCreateCompanionBuilder,
          $$EventTransactionsTableUpdateCompanionBuilder,
          (EventTransaction, $$EventTransactionsTableReferences),
          EventTransaction,
          PrefetchHooks Function({bool eventID, bool memberID, bool guestID})
        > {
  $$EventTransactionsTableTableManager(
    _$AppDatabase db,
    $EventTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<TransactionType> transactionType = const Value.absent(),
                Value<int> eventID = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
                Value<int?> memberID = const Value.absent(),
                Value<int?> guestID = const Value.absent(),
                Value<String?> attachment = const Value.absent(),
              }) => EventTransactionsCompanion(
                id: id,
                description: description,
                amount: amount,
                transactionType: transactionType,
                eventID: eventID,
                date: date,
                createAt: createAt,
                modifiedAt: modifiedAt,
                memberID: memberID,
                guestID: guestID,
                attachment: attachment,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required double amount,
                required TransactionType transactionType,
                required int eventID,
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
                Value<int?> memberID = const Value.absent(),
                Value<int?> guestID = const Value.absent(),
                Value<String?> attachment = const Value.absent(),
              }) => EventTransactionsCompanion.insert(
                id: id,
                description: description,
                amount: amount,
                transactionType: transactionType,
                eventID: eventID,
                date: date,
                createAt: createAt,
                modifiedAt: modifiedAt,
                memberID: memberID,
                guestID: guestID,
                attachment: attachment,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({eventID = false, memberID = false, guestID = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (eventID) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.eventID,
                                    referencedTable:
                                        $$EventTransactionsTableReferences
                                            ._eventIDTable(db),
                                    referencedColumn:
                                        $$EventTransactionsTableReferences
                                            ._eventIDTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (memberID) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.memberID,
                                    referencedTable:
                                        $$EventTransactionsTableReferences
                                            ._memberIDTable(db),
                                    referencedColumn:
                                        $$EventTransactionsTableReferences
                                            ._memberIDTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (guestID) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.guestID,
                                    referencedTable:
                                        $$EventTransactionsTableReferences
                                            ._guestIDTable(db),
                                    referencedColumn:
                                        $$EventTransactionsTableReferences
                                            ._guestIDTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$EventTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventTransactionsTable,
      EventTransaction,
      $$EventTransactionsTableFilterComposer,
      $$EventTransactionsTableOrderingComposer,
      $$EventTransactionsTableAnnotationComposer,
      $$EventTransactionsTableCreateCompanionBuilder,
      $$EventTransactionsTableUpdateCompanionBuilder,
      (EventTransaction, $$EventTransactionsTableReferences),
      EventTransaction,
      PrefetchHooks Function({bool eventID, bool memberID, bool guestID})
    >;
typedef $$EventRatiosTableCreateCompanionBuilder =
    EventRatiosCompanion Function({
      Value<int> id,
      required int memberID,
      required int eventID,
      required double ratio,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
    });
typedef $$EventRatiosTableUpdateCompanionBuilder =
    EventRatiosCompanion Function({
      Value<int> id,
      Value<int> memberID,
      Value<int> eventID,
      Value<double> ratio,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
    });

final class $$EventRatiosTableReferences
    extends BaseReferences<_$AppDatabase, $EventRatiosTable, EventRatio> {
  $$EventRatiosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MembersTable _memberIDTable(_$AppDatabase db) =>
      db.members.createAlias(
        $_aliasNameGenerator(db.eventRatios.memberID, db.members.id),
      );

  $$MembersTableProcessedTableManager get memberID {
    final $_column = $_itemColumn<int>('member_i_d')!;

    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EventsTable _eventIDTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.eventRatios.eventID, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventID {
    final $_column = $_itemColumn<int>('event_i_d')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventRatiosTableFilterComposer
    extends Composer<_$AppDatabase, $EventRatiosTable> {
  $$EventRatiosTableFilterComposer({
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

  ColumnFilters<double> get ratio => $composableBuilder(
    column: $table.ratio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MembersTableFilterComposer get memberID {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberID,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventsTableFilterComposer get eventID {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventRatiosTableOrderingComposer
    extends Composer<_$AppDatabase, $EventRatiosTable> {
  $$EventRatiosTableOrderingComposer({
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

  ColumnOrderings<double> get ratio => $composableBuilder(
    column: $table.ratio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MembersTableOrderingComposer get memberID {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberID,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableOrderingComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventsTableOrderingComposer get eventID {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventRatiosTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventRatiosTable> {
  $$EventRatiosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get ratio =>
      $composableBuilder(column: $table.ratio, builder: (column) => column);

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => column,
  );

  $$MembersTableAnnotationComposer get memberID {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberID,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventsTableAnnotationComposer get eventID {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventRatiosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventRatiosTable,
          EventRatio,
          $$EventRatiosTableFilterComposer,
          $$EventRatiosTableOrderingComposer,
          $$EventRatiosTableAnnotationComposer,
          $$EventRatiosTableCreateCompanionBuilder,
          $$EventRatiosTableUpdateCompanionBuilder,
          (EventRatio, $$EventRatiosTableReferences),
          EventRatio,
          PrefetchHooks Function({bool memberID, bool eventID})
        > {
  $$EventRatiosTableTableManager(_$AppDatabase db, $EventRatiosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventRatiosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventRatiosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventRatiosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> memberID = const Value.absent(),
                Value<int> eventID = const Value.absent(),
                Value<double> ratio = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
              }) => EventRatiosCompanion(
                id: id,
                memberID: memberID,
                eventID: eventID,
                ratio: ratio,
                createAt: createAt,
                modifiedAt: modifiedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int memberID,
                required int eventID,
                required double ratio,
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
              }) => EventRatiosCompanion.insert(
                id: id,
                memberID: memberID,
                eventID: eventID,
                ratio: ratio,
                createAt: createAt,
                modifiedAt: modifiedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventRatiosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({memberID = false, eventID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (memberID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.memberID,
                                referencedTable: $$EventRatiosTableReferences
                                    ._memberIDTable(db),
                                referencedColumn: $$EventRatiosTableReferences
                                    ._memberIDTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (eventID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventID,
                                referencedTable: $$EventRatiosTableReferences
                                    ._eventIDTable(db),
                                referencedColumn: $$EventRatiosTableReferences
                                    ._eventIDTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EventRatiosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventRatiosTable,
      EventRatio,
      $$EventRatiosTableFilterComposer,
      $$EventRatiosTableOrderingComposer,
      $$EventRatiosTableAnnotationComposer,
      $$EventRatiosTableCreateCompanionBuilder,
      $$EventRatiosTableUpdateCompanionBuilder,
      (EventRatio, $$EventRatiosTableReferences),
      EventRatio,
      PrefetchHooks Function({bool memberID, bool eventID})
    >;
typedef $$MenusTableCreateCompanionBuilder =
    MenusCompanion Function({
      Value<int> id,
      required String title,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
      Value<bool> isActive,
    });
typedef $$MenusTableUpdateCompanionBuilder =
    MenusCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
      Value<bool> isActive,
    });

class $$MenusTableFilterComposer extends Composer<_$AppDatabase, $MenusTable> {
  $$MenusTableFilterComposer({
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

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MenusTableOrderingComposer
    extends Composer<_$AppDatabase, $MenusTable> {
  $$MenusTableOrderingComposer({
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

  ColumnOrderings<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MenusTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenusTable> {
  $$MenusTableAnnotationComposer({
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

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$MenusTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MenusTable,
          MenusData,
          $$MenusTableFilterComposer,
          $$MenusTableOrderingComposer,
          $$MenusTableAnnotationComposer,
          $$MenusTableCreateCompanionBuilder,
          $$MenusTableUpdateCompanionBuilder,
          (MenusData, BaseReferences<_$AppDatabase, $MenusTable, MenusData>),
          MenusData,
          PrefetchHooks Function()
        > {
  $$MenusTableTableManager(_$AppDatabase db, $MenusTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenusTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenusTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MenusTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => MenusCompanion(
                id: id,
                title: title,
                createAt: createAt,
                modifiedAt: modifiedAt,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => MenusCompanion.insert(
                id: id,
                title: title,
                createAt: createAt,
                modifiedAt: modifiedAt,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MenusTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MenusTable,
      MenusData,
      $$MenusTableFilterComposer,
      $$MenusTableOrderingComposer,
      $$MenusTableAnnotationComposer,
      $$MenusTableCreateCompanionBuilder,
      $$MenusTableUpdateCompanionBuilder,
      (MenusData, BaseReferences<_$AppDatabase, $MenusTable, MenusData>),
      MenusData,
      PrefetchHooks Function()
    >;
typedef $$EventOrdersTableCreateCompanionBuilder =
    EventOrdersCompanion Function({
      Value<int> id,
      Value<int?> memberID,
      Value<int?> guessID,
      required int eventID,
      Value<bool> isDelivered,
      Value<String?> menuItems,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
    });
typedef $$EventOrdersTableUpdateCompanionBuilder =
    EventOrdersCompanion Function({
      Value<int> id,
      Value<int?> memberID,
      Value<int?> guessID,
      Value<int> eventID,
      Value<bool> isDelivered,
      Value<String?> menuItems,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
    });

final class $$EventOrdersTableReferences
    extends BaseReferences<_$AppDatabase, $EventOrdersTable, EventOrder> {
  $$EventOrdersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MembersTable _memberIDTable(_$AppDatabase db) =>
      db.members.createAlias(
        $_aliasNameGenerator(db.eventOrders.memberID, db.members.id),
      );

  $$MembersTableProcessedTableManager? get memberID {
    final $_column = $_itemColumn<int>('member_i_d');
    if ($_column == null) return null;
    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GuestsTable _guessIDTable(_$AppDatabase db) => db.guests.createAlias(
    $_aliasNameGenerator(db.eventOrders.guessID, db.guests.id),
  );

  $$GuestsTableProcessedTableManager? get guessID {
    final $_column = $_itemColumn<int>('guess_i_d');
    if ($_column == null) return null;
    final manager = $$GuestsTableTableManager(
      $_db,
      $_db.guests,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_guessIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EventsTable _eventIDTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.eventOrders.eventID, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventID {
    final $_column = $_itemColumn<int>('event_i_d')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $EventOrdersTable> {
  $$EventOrdersTableFilterComposer({
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

  ColumnFilters<bool> get isDelivered => $composableBuilder(
    column: $table.isDelivered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get menuItems => $composableBuilder(
    column: $table.menuItems,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MembersTableFilterComposer get memberID {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberID,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GuestsTableFilterComposer get guessID {
    final $$GuestsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.guessID,
      referencedTable: $db.guests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GuestsTableFilterComposer(
            $db: $db,
            $table: $db.guests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventsTableFilterComposer get eventID {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $EventOrdersTable> {
  $$EventOrdersTableOrderingComposer({
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

  ColumnOrderings<bool> get isDelivered => $composableBuilder(
    column: $table.isDelivered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get menuItems => $composableBuilder(
    column: $table.menuItems,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MembersTableOrderingComposer get memberID {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberID,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableOrderingComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GuestsTableOrderingComposer get guessID {
    final $$GuestsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.guessID,
      referencedTable: $db.guests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GuestsTableOrderingComposer(
            $db: $db,
            $table: $db.guests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventsTableOrderingComposer get eventID {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventOrdersTable> {
  $$EventOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isDelivered => $composableBuilder(
    column: $table.isDelivered,
    builder: (column) => column,
  );

  GeneratedColumn<String> get menuItems =>
      $composableBuilder(column: $table.menuItems, builder: (column) => column);

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => column,
  );

  $$MembersTableAnnotationComposer get memberID {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberID,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GuestsTableAnnotationComposer get guessID {
    final $$GuestsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.guessID,
      referencedTable: $db.guests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GuestsTableAnnotationComposer(
            $db: $db,
            $table: $db.guests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventsTableAnnotationComposer get eventID {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventOrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventOrdersTable,
          EventOrder,
          $$EventOrdersTableFilterComposer,
          $$EventOrdersTableOrderingComposer,
          $$EventOrdersTableAnnotationComposer,
          $$EventOrdersTableCreateCompanionBuilder,
          $$EventOrdersTableUpdateCompanionBuilder,
          (EventOrder, $$EventOrdersTableReferences),
          EventOrder,
          PrefetchHooks Function({bool memberID, bool guessID, bool eventID})
        > {
  $$EventOrdersTableTableManager(_$AppDatabase db, $EventOrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> memberID = const Value.absent(),
                Value<int?> guessID = const Value.absent(),
                Value<int> eventID = const Value.absent(),
                Value<bool> isDelivered = const Value.absent(),
                Value<String?> menuItems = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
              }) => EventOrdersCompanion(
                id: id,
                memberID: memberID,
                guessID: guessID,
                eventID: eventID,
                isDelivered: isDelivered,
                menuItems: menuItems,
                createAt: createAt,
                modifiedAt: modifiedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> memberID = const Value.absent(),
                Value<int?> guessID = const Value.absent(),
                required int eventID,
                Value<bool> isDelivered = const Value.absent(),
                Value<String?> menuItems = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
              }) => EventOrdersCompanion.insert(
                id: id,
                memberID: memberID,
                guessID: guessID,
                eventID: eventID,
                isDelivered: isDelivered,
                menuItems: menuItems,
                createAt: createAt,
                modifiedAt: modifiedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventOrdersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({memberID = false, guessID = false, eventID = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (memberID) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.memberID,
                                    referencedTable:
                                        $$EventOrdersTableReferences
                                            ._memberIDTable(db),
                                    referencedColumn:
                                        $$EventOrdersTableReferences
                                            ._memberIDTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (guessID) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.guessID,
                                    referencedTable:
                                        $$EventOrdersTableReferences
                                            ._guessIDTable(db),
                                    referencedColumn:
                                        $$EventOrdersTableReferences
                                            ._guessIDTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (eventID) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.eventID,
                                    referencedTable:
                                        $$EventOrdersTableReferences
                                            ._eventIDTable(db),
                                    referencedColumn:
                                        $$EventOrdersTableReferences
                                            ._eventIDTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$EventOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventOrdersTable,
      EventOrder,
      $$EventOrdersTableFilterComposer,
      $$EventOrdersTableOrderingComposer,
      $$EventOrdersTableAnnotationComposer,
      $$EventOrdersTableCreateCompanionBuilder,
      $$EventOrdersTableUpdateCompanionBuilder,
      (EventOrder, $$EventOrdersTableReferences),
      EventOrder,
      PrefetchHooks Function({bool memberID, bool guessID, bool eventID})
    >;
typedef $$EventStoriesTableCreateCompanionBuilder =
    EventStoriesCompanion Function({
      Value<int> id,
      required int eventID,
      required String encodedText,
      required String title,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
    });
typedef $$EventStoriesTableUpdateCompanionBuilder =
    EventStoriesCompanion Function({
      Value<int> id,
      Value<int> eventID,
      Value<String> encodedText,
      Value<String> title,
      Value<DateTime> createAt,
      Value<DateTime> modifiedAt,
    });

final class $$EventStoriesTableReferences
    extends BaseReferences<_$AppDatabase, $EventStoriesTable, EventStory> {
  $$EventStoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EventsTable _eventIDTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.eventStories.eventID, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventID {
    final $_column = $_itemColumn<int>('event_i_d')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventStoriesTableFilterComposer
    extends Composer<_$AppDatabase, $EventStoriesTable> {
  $$EventStoriesTableFilterComposer({
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

  ColumnFilters<String> get encodedText => $composableBuilder(
    column: $table.encodedText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventID {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventStoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $EventStoriesTable> {
  $$EventStoriesTableOrderingComposer({
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

  ColumnOrderings<String> get encodedText => $composableBuilder(
    column: $table.encodedText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventID {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventStoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventStoriesTable> {
  $$EventStoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get encodedText => $composableBuilder(
    column: $table.encodedText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => column,
  );

  $$EventsTableAnnotationComposer get eventID {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventStoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventStoriesTable,
          EventStory,
          $$EventStoriesTableFilterComposer,
          $$EventStoriesTableOrderingComposer,
          $$EventStoriesTableAnnotationComposer,
          $$EventStoriesTableCreateCompanionBuilder,
          $$EventStoriesTableUpdateCompanionBuilder,
          (EventStory, $$EventStoriesTableReferences),
          EventStory,
          PrefetchHooks Function({bool eventID})
        > {
  $$EventStoriesTableTableManager(_$AppDatabase db, $EventStoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventStoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventStoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventStoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> eventID = const Value.absent(),
                Value<String> encodedText = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
              }) => EventStoriesCompanion(
                id: id,
                eventID: eventID,
                encodedText: encodedText,
                title: title,
                createAt: createAt,
                modifiedAt: modifiedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int eventID,
                required String encodedText,
                required String title,
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
              }) => EventStoriesCompanion.insert(
                id: id,
                eventID: eventID,
                encodedText: encodedText,
                title: title,
                createAt: createAt,
                modifiedAt: modifiedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventStoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventID) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventID,
                                referencedTable: $$EventStoriesTableReferences
                                    ._eventIDTable(db),
                                referencedColumn: $$EventStoriesTableReferences
                                    ._eventIDTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EventStoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventStoriesTable,
      EventStory,
      $$EventStoriesTableFilterComposer,
      $$EventStoriesTableOrderingComposer,
      $$EventStoriesTableAnnotationComposer,
      $$EventStoriesTableCreateCompanionBuilder,
      $$EventStoriesTableUpdateCompanionBuilder,
      (EventStory, $$EventStoriesTableReferences),
      EventStory,
      PrefetchHooks Function({bool eventID})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db, _db.teams);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$MembersTableTableManager get members =>
      $$MembersTableTableManager(_db, _db.members);
  $$ReportsTableTableManager get reports =>
      $$ReportsTableTableManager(_db, _db.reports);
  $$RatiosTableTableManager get ratios =>
      $$RatiosTableTableManager(_db, _db.ratios);
  $$CollectReportEventsTableTableManager get collectReportEvents =>
      $$CollectReportEventsTableTableManager(_db, _db.collectReportEvents);
  $$GuestsTableTableManager get guests =>
      $$GuestsTableTableManager(_db, _db.guests);
  $$EventTransactionsTableTableManager get eventTransactions =>
      $$EventTransactionsTableTableManager(_db, _db.eventTransactions);
  $$EventRatiosTableTableManager get eventRatios =>
      $$EventRatiosTableTableManager(_db, _db.eventRatios);
  $$MenusTableTableManager get menus =>
      $$MenusTableTableManager(_db, _db.menus);
  $$EventOrdersTableTableManager get eventOrders =>
      $$EventOrdersTableTableManager(_db, _db.eventOrders);
  $$EventStoriesTableTableManager get eventStories =>
      $$EventStoriesTableTableManager(_db, _db.eventStories);
}
