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
  @override
  List<GeneratedColumn> get $columns => [id, title, description, createAt];
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
  const Team({
    required this.id,
    required this.title,
    this.description,
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
    map['create_at'] = Variable<DateTime>(createAt);
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
    };
  }

  Team copyWith({
    int? id,
    String? title,
    Value<String?> description = const Value.absent(),
    DateTime? createAt,
  }) => Team(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    createAt: createAt ?? this.createAt,
  );
  Team copyWithCompanion(TeamsCompanion data) {
    return Team(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Team(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, createAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Team &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.createAt == this.createAt);
}

class TeamsCompanion extends UpdateCompanion<Team> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime> createAt;
  const TeamsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.createAt = const Value.absent(),
  });
  TeamsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.createAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Team> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? createAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (createAt != null) 'create_at': createAt,
    });
  }

  TeamsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<DateTime>? createAt,
  }) {
    return TeamsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
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
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createAt: $createAt')
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
      'REFERENCES teams (id)',
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    teamID,
    date,
    createAt,
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
  const Event({
    required this.id,
    required this.title,
    this.description,
    required this.teamID,
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
    map['team_i_d'] = Variable<int>(teamID);
    map['date'] = Variable<DateTime>(date);
    map['create_at'] = Variable<DateTime>(createAt);
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
    };
  }

  Event copyWith({
    int? id,
    String? title,
    Value<String?> description = const Value.absent(),
    int? teamID,
    DateTime? date,
    DateTime? createAt,
  }) => Event(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    teamID: teamID ?? this.teamID,
    date: date ?? this.date,
    createAt: createAt ?? this.createAt,
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
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, teamID, date, createAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.teamID == this.teamID &&
          other.date == this.date &&
          other.createAt == this.createAt);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<int> teamID;
  final Value<DateTime> date;
  final Value<DateTime> createAt;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.teamID = const Value.absent(),
    this.date = const Value.absent(),
    this.createAt = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    required int teamID,
    this.date = const Value.absent(),
    this.createAt = const Value.absent(),
  }) : title = Value(title),
       teamID = Value(teamID);
  static Insertable<Event> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? teamID,
    Expression<DateTime>? date,
    Expression<DateTime>? createAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (teamID != null) 'team_i_d': teamID,
      if (date != null) 'date': date,
      if (createAt != null) 'create_at': createAt,
    });
  }

  EventsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<int>? teamID,
    Value<DateTime>? date,
    Value<DateTime>? createAt,
  }) {
    return EventsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      teamID: teamID ?? this.teamID,
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
    if (teamID.present) {
      map['team_i_d'] = Variable<int>(teamID.value);
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
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('teamID: $teamID, ')
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
  static const VerificationMeta _joinAtMeta = const VerificationMeta('joinAt');
  @override
  late final GeneratedColumn<DateTime> joinAt = GeneratedColumn<DateTime>(
    'join_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    joinAt,
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
    if (data.containsKey('join_at')) {
      context.handle(
        _joinAtMeta,
        joinAt.isAcceptableOrUnknown(data['join_at']!, _joinAtMeta),
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
  final DateTime? joinAt;
  final DateTime createAt;
  const Member({
    required this.id,
    required this.name,
    this.description,
    this.joinAt,
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
    if (!nullToAbsent || joinAt != null) {
      map['join_at'] = Variable<DateTime>(joinAt);
    }
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
      joinAt: joinAt == null && nullToAbsent
          ? const Value.absent()
          : Value(joinAt),
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
      joinAt: serializer.fromJson<DateTime?>(json['joinAt']),
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
      'joinAt': serializer.toJson<DateTime?>(joinAt),
      'createAt': serializer.toJson<DateTime>(createAt),
    };
  }

  Member copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<DateTime?> joinAt = const Value.absent(),
    DateTime? createAt,
  }) => Member(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    joinAt: joinAt.present ? joinAt.value : this.joinAt,
    createAt: createAt ?? this.createAt,
  );
  Member copyWithCompanion(MembersCompanion data) {
    return Member(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      joinAt: data.joinAt.present ? data.joinAt.value : this.joinAt,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Member(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('joinAt: $joinAt, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, joinAt, createAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Member &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.joinAt == this.joinAt &&
          other.createAt == this.createAt);
}

class MembersCompanion extends UpdateCompanion<Member> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime?> joinAt;
  final Value<DateTime> createAt;
  const MembersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.joinAt = const Value.absent(),
    this.createAt = const Value.absent(),
  });
  MembersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.joinAt = const Value.absent(),
    this.createAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Member> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? joinAt,
    Expression<DateTime>? createAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (joinAt != null) 'join_at': joinAt,
      if (createAt != null) 'create_at': createAt,
    });
  }

  MembersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<DateTime?>? joinAt,
    Value<DateTime>? createAt,
  }) {
    return MembersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      joinAt: joinAt ?? this.joinAt,
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
    if (joinAt.present) {
      map['join_at'] = Variable<DateTime>(joinAt.value);
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
          ..write('joinAt: $joinAt, ')
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    version,
    description,
    generateFor,
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
  const Report({
    required this.id,
    required this.title,
    required this.version,
    this.description,
    required this.generateFor,
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
    map['generate_for'] = Variable<DateTime>(generateFor);
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
      generateFor: Value(generateFor),
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
      generateFor: serializer.fromJson<DateTime>(json['generateFor']),
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
      'generateFor': serializer.toJson<DateTime>(generateFor),
      'createAt': serializer.toJson<DateTime>(createAt),
    };
  }

  Report copyWith({
    int? id,
    String? title,
    int? version,
    Value<String?> description = const Value.absent(),
    DateTime? generateFor,
    DateTime? createAt,
  }) => Report(
    id: id ?? this.id,
    title: title ?? this.title,
    version: version ?? this.version,
    description: description.present ? description.value : this.description,
    generateFor: generateFor ?? this.generateFor,
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
      generateFor: data.generateFor.present
          ? data.generateFor.value
          : this.generateFor,
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
          ..write('generateFor: $generateFor, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, version, description, generateFor, createAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Report &&
          other.id == this.id &&
          other.title == this.title &&
          other.version == this.version &&
          other.description == this.description &&
          other.generateFor == this.generateFor &&
          other.createAt == this.createAt);
}

class ReportsCompanion extends UpdateCompanion<Report> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> version;
  final Value<String?> description;
  final Value<DateTime> generateFor;
  final Value<DateTime> createAt;
  const ReportsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.version = const Value.absent(),
    this.description = const Value.absent(),
    this.generateFor = const Value.absent(),
    this.createAt = const Value.absent(),
  });
  ReportsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int version,
    this.description = const Value.absent(),
    this.generateFor = const Value.absent(),
    this.createAt = const Value.absent(),
  }) : title = Value(title),
       version = Value(version);
  static Insertable<Report> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? version,
    Expression<String>? description,
    Expression<DateTime>? generateFor,
    Expression<DateTime>? createAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (version != null) 'version': version,
      if (description != null) 'description': description,
      if (generateFor != null) 'generate_for': generateFor,
      if (createAt != null) 'create_at': createAt,
    });
  }

  ReportsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<int>? version,
    Value<String?>? description,
    Value<DateTime>? generateFor,
    Value<DateTime>? createAt,
  }) {
    return ReportsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      version: version ?? this.version,
      description: description ?? this.description,
      generateFor: generateFor ?? this.generateFor,
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
    if (generateFor.present) {
      map['generate_for'] = Variable<DateTime>(generateFor.value);
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
          ..write('generateFor: $generateFor, ')
          ..write('createAt: $createAt')
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
      'REFERENCES members (id)',
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
      'REFERENCES teams (id)',
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
  @override
  List<GeneratedColumn> get $columns => [id, memberID, teamID, ratio, createAt];
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
  const Ratio({
    required this.id,
    required this.memberID,
    required this.teamID,
    required this.ratio,
    required this.createAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['member_i_d'] = Variable<int>(memberID);
    map['team_i_d'] = Variable<int>(teamID);
    map['ratio'] = Variable<double>(ratio);
    map['create_at'] = Variable<DateTime>(createAt);
    return map;
  }

  RatiosCompanion toCompanion(bool nullToAbsent) {
    return RatiosCompanion(
      id: Value(id),
      memberID: Value(memberID),
      teamID: Value(teamID),
      ratio: Value(ratio),
      createAt: Value(createAt),
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
    };
  }

  Ratio copyWith({
    int? id,
    int? memberID,
    int? teamID,
    double? ratio,
    DateTime? createAt,
  }) => Ratio(
    id: id ?? this.id,
    memberID: memberID ?? this.memberID,
    teamID: teamID ?? this.teamID,
    ratio: ratio ?? this.ratio,
    createAt: createAt ?? this.createAt,
  );
  Ratio copyWithCompanion(RatiosCompanion data) {
    return Ratio(
      id: data.id.present ? data.id.value : this.id,
      memberID: data.memberID.present ? data.memberID.value : this.memberID,
      teamID: data.teamID.present ? data.teamID.value : this.teamID,
      ratio: data.ratio.present ? data.ratio.value : this.ratio,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ratio(')
          ..write('id: $id, ')
          ..write('memberID: $memberID, ')
          ..write('teamID: $teamID, ')
          ..write('ratio: $ratio, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, memberID, teamID, ratio, createAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ratio &&
          other.id == this.id &&
          other.memberID == this.memberID &&
          other.teamID == this.teamID &&
          other.ratio == this.ratio &&
          other.createAt == this.createAt);
}

class RatiosCompanion extends UpdateCompanion<Ratio> {
  final Value<int> id;
  final Value<int> memberID;
  final Value<int> teamID;
  final Value<double> ratio;
  final Value<DateTime> createAt;
  const RatiosCompanion({
    this.id = const Value.absent(),
    this.memberID = const Value.absent(),
    this.teamID = const Value.absent(),
    this.ratio = const Value.absent(),
    this.createAt = const Value.absent(),
  });
  RatiosCompanion.insert({
    this.id = const Value.absent(),
    required int memberID,
    required int teamID,
    required double ratio,
    this.createAt = const Value.absent(),
  }) : memberID = Value(memberID),
       teamID = Value(teamID),
       ratio = Value(ratio);
  static Insertable<Ratio> custom({
    Expression<int>? id,
    Expression<int>? memberID,
    Expression<int>? teamID,
    Expression<double>? ratio,
    Expression<DateTime>? createAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (memberID != null) 'member_i_d': memberID,
      if (teamID != null) 'team_i_d': teamID,
      if (ratio != null) 'ratio': ratio,
      if (createAt != null) 'create_at': createAt,
    });
  }

  RatiosCompanion copyWith({
    Value<int>? id,
    Value<int>? memberID,
    Value<int>? teamID,
    Value<double>? ratio,
    Value<DateTime>? createAt,
  }) {
    return RatiosCompanion(
      id: id ?? this.id,
      memberID: memberID ?? this.memberID,
      teamID: teamID ?? this.teamID,
      ratio: ratio ?? this.ratio,
      createAt: createAt ?? this.createAt,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RatiosCompanion(')
          ..write('id: $id, ')
          ..write('memberID: $memberID, ')
          ..write('teamID: $teamID, ')
          ..write('ratio: $ratio, ')
          ..write('createAt: $createAt')
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
      'REFERENCES events (id)',
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
      'REFERENCES reports (id)',
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
  @override
  List<GeneratedColumn> get $columns => [id, eventID, reportID, createAt];
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
  const CollectReportEvent({
    required this.id,
    required this.eventID,
    required this.reportID,
    required this.createAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_i_d'] = Variable<int>(eventID);
    map['report_i_d'] = Variable<int>(reportID);
    map['create_at'] = Variable<DateTime>(createAt);
    return map;
  }

  CollectReportEventsCompanion toCompanion(bool nullToAbsent) {
    return CollectReportEventsCompanion(
      id: Value(id),
      eventID: Value(eventID),
      reportID: Value(reportID),
      createAt: Value(createAt),
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
    };
  }

  CollectReportEvent copyWith({
    int? id,
    int? eventID,
    int? reportID,
    DateTime? createAt,
  }) => CollectReportEvent(
    id: id ?? this.id,
    eventID: eventID ?? this.eventID,
    reportID: reportID ?? this.reportID,
    createAt: createAt ?? this.createAt,
  );
  CollectReportEvent copyWithCompanion(CollectReportEventsCompanion data) {
    return CollectReportEvent(
      id: data.id.present ? data.id.value : this.id,
      eventID: data.eventID.present ? data.eventID.value : this.eventID,
      reportID: data.reportID.present ? data.reportID.value : this.reportID,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectReportEvent(')
          ..write('id: $id, ')
          ..write('eventID: $eventID, ')
          ..write('reportID: $reportID, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eventID, reportID, createAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectReportEvent &&
          other.id == this.id &&
          other.eventID == this.eventID &&
          other.reportID == this.reportID &&
          other.createAt == this.createAt);
}

class CollectReportEventsCompanion extends UpdateCompanion<CollectReportEvent> {
  final Value<int> id;
  final Value<int> eventID;
  final Value<int> reportID;
  final Value<DateTime> createAt;
  const CollectReportEventsCompanion({
    this.id = const Value.absent(),
    this.eventID = const Value.absent(),
    this.reportID = const Value.absent(),
    this.createAt = const Value.absent(),
  });
  CollectReportEventsCompanion.insert({
    this.id = const Value.absent(),
    required int eventID,
    required int reportID,
    this.createAt = const Value.absent(),
  }) : eventID = Value(eventID),
       reportID = Value(reportID);
  static Insertable<CollectReportEvent> custom({
    Expression<int>? id,
    Expression<int>? eventID,
    Expression<int>? reportID,
    Expression<DateTime>? createAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventID != null) 'event_i_d': eventID,
      if (reportID != null) 'report_i_d': reportID,
      if (createAt != null) 'create_at': createAt,
    });
  }

  CollectReportEventsCompanion copyWith({
    Value<int>? id,
    Value<int>? eventID,
    Value<int>? reportID,
    Value<DateTime>? createAt,
  }) {
    return CollectReportEventsCompanion(
      id: id ?? this.id,
      eventID: eventID ?? this.eventID,
      reportID: reportID ?? this.reportID,
      createAt: createAt ?? this.createAt,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectReportEventsCompanion(')
          ..write('id: $id, ')
          ..write('eventID: $eventID, ')
          ..write('reportID: $reportID, ')
          ..write('createAt: $createAt')
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
      'REFERENCES events (id)',
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    description,
    amount,
    transactionType,
    eventID,
    date,
    createAt,
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
  const EventTransaction({
    required this.id,
    this.description,
    required this.amount,
    required this.transactionType,
    required this.eventID,
    required this.date,
    required this.createAt,
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
  }) => EventTransaction(
    id: id ?? this.id,
    description: description.present ? description.value : this.description,
    amount: amount ?? this.amount,
    transactionType: transactionType ?? this.transactionType,
    eventID: eventID ?? this.eventID,
    date: date ?? this.date,
    createAt: createAt ?? this.createAt,
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
          ..write('createAt: $createAt')
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
          other.createAt == this.createAt);
}

class EventTransactionsCompanion extends UpdateCompanion<EventTransaction> {
  final Value<int> id;
  final Value<String?> description;
  final Value<double> amount;
  final Value<TransactionType> transactionType;
  final Value<int> eventID;
  final Value<DateTime> date;
  final Value<DateTime> createAt;
  const EventTransactionsCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.amount = const Value.absent(),
    this.transactionType = const Value.absent(),
    this.eventID = const Value.absent(),
    this.date = const Value.absent(),
    this.createAt = const Value.absent(),
  });
  EventTransactionsCompanion.insert({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    required double amount,
    required TransactionType transactionType,
    required int eventID,
    this.date = const Value.absent(),
    this.createAt = const Value.absent(),
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
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (description != null) 'description': description,
      if (amount != null) 'amount': amount,
      if (transactionType != null) 'transaction_type': transactionType,
      if (eventID != null) 'event_i_d': eventID,
      if (date != null) 'date': date,
      if (createAt != null) 'create_at': createAt,
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
  }) {
    return EventTransactionsCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      transactionType: transactionType ?? this.transactionType,
      eventID: eventID ?? this.eventID,
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
          ..write('createAt: $createAt')
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
  late final $EventTransactionsTable eventTransactions =
      $EventTransactionsTable(this);
  late final ReportDao reportDao = ReportDao(this as AppDatabase);
  late final RatioDao ratioDao = RatioDao(this as AppDatabase);
  late final EventDao eventDao = EventDao(this as AppDatabase);
  late final TeamDao teamDao = TeamDao(this as AppDatabase);
  late final MemberDao memberDao = MemberDao(this as AppDatabase);
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
    eventTransactions,
  ];
}

typedef $$TeamsTableCreateCompanionBuilder =
    TeamsCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> description,
      Value<DateTime> createAt,
    });
typedef $$TeamsTableUpdateCompanionBuilder =
    TeamsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> description,
      Value<DateTime> createAt,
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
              }) => TeamsCompanion(
                id: id,
                title: title,
                description: description,
                createAt: createAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
              }) => TeamsCompanion.insert(
                id: id,
                title: title,
                description: description,
                createAt: createAt,
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
    });
typedef $$EventsTableUpdateCompanionBuilder =
    EventsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> description,
      Value<int> teamID,
      Value<DateTime> date,
      Value<DateTime> createAt,
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
              }) => EventsCompanion(
                id: id,
                title: title,
                description: description,
                teamID: teamID,
                date: date,
                createAt: createAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                required int teamID,
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
              }) => EventsCompanion.insert(
                id: id,
                title: title,
                description: description,
                teamID: teamID,
                date: date,
                createAt: createAt,
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
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (collectReportEventsRefs) db.collectReportEvents,
                    if (eventTransactionsRefs) db.eventTransactions,
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
      })
    >;
typedef $$MembersTableCreateCompanionBuilder =
    MembersCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<DateTime?> joinAt,
      Value<DateTime> createAt,
    });
typedef $$MembersTableUpdateCompanionBuilder =
    MembersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<DateTime?> joinAt,
      Value<DateTime> createAt,
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

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
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

  GeneratedColumn<DateTime> get joinAt =>
      $composableBuilder(column: $table.joinAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);

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
          PrefetchHooks Function({bool ratiosRefs})
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
                Value<DateTime> createAt = const Value.absent(),
              }) => MembersCompanion(
                id: id,
                name: name,
                description: description,
                joinAt: joinAt,
                createAt: createAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<DateTime?> joinAt = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
              }) => MembersCompanion.insert(
                id: id,
                name: name,
                description: description,
                joinAt: joinAt,
                createAt: createAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MembersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ratiosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ratiosRefs) db.ratios],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ratiosRefs)
                    await $_getPrefetchedData<Member, $MembersTable, Ratio>(
                      currentTable: table,
                      referencedTable: $$MembersTableReferences
                          ._ratiosRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MembersTableReferences(db, table, p0).ratiosRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.memberID == item.id),
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
      PrefetchHooks Function({bool ratiosRefs})
    >;
typedef $$ReportsTableCreateCompanionBuilder =
    ReportsCompanion Function({
      Value<int> id,
      required String title,
      required int version,
      Value<String?> description,
      Value<DateTime> generateFor,
      Value<DateTime> createAt,
    });
typedef $$ReportsTableUpdateCompanionBuilder =
    ReportsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<int> version,
      Value<String?> description,
      Value<DateTime> generateFor,
      Value<DateTime> createAt,
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
              }) => ReportsCompanion(
                id: id,
                title: title,
                version: version,
                description: description,
                generateFor: generateFor,
                createAt: createAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required int version,
                Value<String?> description = const Value.absent(),
                Value<DateTime> generateFor = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
              }) => ReportsCompanion.insert(
                id: id,
                title: title,
                version: version,
                description: description,
                generateFor: generateFor,
                createAt: createAt,
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
    });
typedef $$RatiosTableUpdateCompanionBuilder =
    RatiosCompanion Function({
      Value<int> id,
      Value<int> memberID,
      Value<int> teamID,
      Value<double> ratio,
      Value<DateTime> createAt,
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
              }) => RatiosCompanion(
                id: id,
                memberID: memberID,
                teamID: teamID,
                ratio: ratio,
                createAt: createAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int memberID,
                required int teamID,
                required double ratio,
                Value<DateTime> createAt = const Value.absent(),
              }) => RatiosCompanion.insert(
                id: id,
                memberID: memberID,
                teamID: teamID,
                ratio: ratio,
                createAt: createAt,
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
    });
typedef $$CollectReportEventsTableUpdateCompanionBuilder =
    CollectReportEventsCompanion Function({
      Value<int> id,
      Value<int> eventID,
      Value<int> reportID,
      Value<DateTime> createAt,
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
              }) => CollectReportEventsCompanion(
                id: id,
                eventID: eventID,
                reportID: reportID,
                createAt: createAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int eventID,
                required int reportID,
                Value<DateTime> createAt = const Value.absent(),
              }) => CollectReportEventsCompanion.insert(
                id: id,
                eventID: eventID,
                reportID: reportID,
                createAt: createAt,
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
typedef $$EventTransactionsTableCreateCompanionBuilder =
    EventTransactionsCompanion Function({
      Value<int> id,
      Value<String?> description,
      required double amount,
      required TransactionType transactionType,
      required int eventID,
      Value<DateTime> date,
      Value<DateTime> createAt,
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
          PrefetchHooks Function({bool eventID})
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
              }) => EventTransactionsCompanion(
                id: id,
                description: description,
                amount: amount,
                transactionType: transactionType,
                eventID: eventID,
                date: date,
                createAt: createAt,
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
              }) => EventTransactionsCompanion.insert(
                id: id,
                description: description,
                amount: amount,
                transactionType: transactionType,
                eventID: eventID,
                date: date,
                createAt: createAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventTransactionsTableReferences(db, table, e),
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
  $$EventTransactionsTableTableManager get eventTransactions =>
      $$EventTransactionsTableTableManager(_db, _db.eventTransactions);
}
