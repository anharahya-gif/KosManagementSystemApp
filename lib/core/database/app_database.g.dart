// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $OrganizationsTable extends Organizations
    with TableInfo<$OrganizationsTable, Organization> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrganizationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'organizations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Organization> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Organization map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Organization(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $OrganizationsTable createAlias(String alias) {
    return $OrganizationsTable(attachedDatabase, alias);
  }
}

class Organization extends DataClass implements Insertable<Organization> {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Organization({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  OrganizationsCompanion toCompanion(bool nullToAbsent) {
    return OrganizationsCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Organization.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Organization(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Organization copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Organization(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Organization copyWithCompanion(OrganizationsCompanion data) {
    return Organization(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Organization(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Organization &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class OrganizationsCompanion extends UpdateCompanion<Organization> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const OrganizationsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrganizationsCompanion.insert({
    required String id,
    required String name,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Organization> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrganizationsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return OrganizationsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrganizationsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES organizations (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    fullName,
    phoneNumber,
    email,
    role,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final String id;
  final String organizationId;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String role;
  final DateTime createdAt;
  const UserProfile({
    required this.id,
    required this.organizationId,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.role,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    map['full_name'] = Variable<String>(fullName);
    map['phone_number'] = Variable<String>(phoneNumber);
    map['email'] = Variable<String>(email);
    map['role'] = Variable<String>(role);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      fullName: Value(fullName),
      phoneNumber: Value(phoneNumber),
      email: Value(email),
      role: Value(role),
      createdAt: Value(createdAt),
    );
  }

  factory UserProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      fullName: serializer.fromJson<String>(json['fullName']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      email: serializer.fromJson<String>(json['email']),
      role: serializer.fromJson<String>(json['role']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'fullName': serializer.toJson<String>(fullName),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'email': serializer.toJson<String>(email),
      'role': serializer.toJson<String>(role),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserProfile copyWith({
    String? id,
    String? organizationId,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? role,
    DateTime? createdAt,
  }) => UserProfile(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    fullName: fullName ?? this.fullName,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    email: email ?? this.email,
    role: role ?? this.role,
    createdAt: createdAt ?? this.createdAt,
  );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      email: data.email.present ? data.email.value : this.email,
      role: data.role.present ? data.role.value : this.role,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('fullName: $fullName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    fullName,
    phoneNumber,
    email,
    role,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.fullName == this.fullName &&
          other.phoneNumber == this.phoneNumber &&
          other.email == this.email &&
          other.role == this.role &&
          other.createdAt == this.createdAt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<String> fullName;
  final Value<String> phoneNumber;
  final Value<String> email;
  final Value<String> role;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.email = const Value.absent(),
    this.role = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    required String id,
    required String organizationId,
    required String fullName,
    required String phoneNumber,
    required String email,
    required String role,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       fullName = Value(fullName),
       phoneNumber = Value(phoneNumber),
       email = Value(email),
       role = Value(role);
  static Insertable<UserProfile> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? fullName,
    Expression<String>? phoneNumber,
    Expression<String>? email,
    Expression<String>? role,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (fullName != null) 'full_name': fullName,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (email != null) 'email': email,
      if (role != null) 'role': role,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<String>? fullName,
    Value<String>? phoneNumber,
    Value<String>? email,
    Value<String>? role,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('fullName: $fullName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PropertiesTable extends Properties
    with TableInfo<$PropertiesTable, Property> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PropertiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES organizations (id) ON DELETE CASCADE',
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
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    name,
    address,
    type,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'properties';
  @override
  VerificationContext validateIntegrity(
    Insertable<Property> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Property map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Property(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PropertiesTable createAlias(String alias) {
    return $PropertiesTable(attachedDatabase, alias);
  }
}

class Property extends DataClass implements Insertable<Property> {
  final String id;
  final String organizationId;
  final String name;
  final String address;
  final String type;
  final DateTime createdAt;
  const Property({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.address,
    required this.type,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    map['type'] = Variable<String>(type);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PropertiesCompanion toCompanion(bool nullToAbsent) {
    return PropertiesCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      name: Value(name),
      address: Value(address),
      type: Value(type),
      createdAt: Value(createdAt),
    );
  }

  factory Property.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Property(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      type: serializer.fromJson<String>(json['type']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'type': serializer.toJson<String>(type),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Property copyWith({
    String? id,
    String? organizationId,
    String? name,
    String? address,
    String? type,
    DateTime? createdAt,
  }) => Property(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    name: name ?? this.name,
    address: address ?? this.address,
    type: type ?? this.type,
    createdAt: createdAt ?? this.createdAt,
  );
  Property copyWithCompanion(PropertiesCompanion data) {
    return Property(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      type: data.type.present ? data.type.value : this.type,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Property(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, organizationId, name, address, type, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Property &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.name == this.name &&
          other.address == this.address &&
          other.type == this.type &&
          other.createdAt == this.createdAt);
}

class PropertiesCompanion extends UpdateCompanion<Property> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<String> name;
  final Value<String> address;
  final Value<String> type;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PropertiesCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PropertiesCompanion.insert({
    required String id,
    required String organizationId,
    required String name,
    required String address,
    required String type,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       name = Value(name),
       address = Value(address),
       type = Value(type);
  static Insertable<Property> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? type,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (type != null) 'type': type,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PropertiesCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<String>? name,
    Value<String>? address,
    Value<String>? type,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PropertiesCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      address: address ?? this.address,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PropertiesCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PropertyManagersTable extends PropertyManagers
    with TableInfo<$PropertyManagersTable, PropertyManager> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PropertyManagersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _propertyIdMeta = const VerificationMeta(
    'propertyId',
  );
  @override
  late final GeneratedColumn<String> propertyId = GeneratedColumn<String>(
    'property_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES properties (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _assignedAtMeta = const VerificationMeta(
    'assignedAt',
  );
  @override
  late final GeneratedColumn<DateTime> assignedAt = GeneratedColumn<DateTime>(
    'assigned_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, userId, propertyId, assignedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'property_managers';
  @override
  VerificationContext validateIntegrity(
    Insertable<PropertyManager> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('property_id')) {
      context.handle(
        _propertyIdMeta,
        propertyId.isAcceptableOrUnknown(data['property_id']!, _propertyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_propertyIdMeta);
    }
    if (data.containsKey('assigned_at')) {
      context.handle(
        _assignedAtMeta,
        assignedAt.isAcceptableOrUnknown(data['assigned_at']!, _assignedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PropertyManager map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PropertyManager(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      propertyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}property_id'],
      )!,
      assignedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}assigned_at'],
      )!,
    );
  }

  @override
  $PropertyManagersTable createAlias(String alias) {
    return $PropertyManagersTable(attachedDatabase, alias);
  }
}

class PropertyManager extends DataClass implements Insertable<PropertyManager> {
  final String id;
  final String userId;
  final String propertyId;
  final DateTime assignedAt;
  const PropertyManager({
    required this.id,
    required this.userId,
    required this.propertyId,
    required this.assignedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['property_id'] = Variable<String>(propertyId);
    map['assigned_at'] = Variable<DateTime>(assignedAt);
    return map;
  }

  PropertyManagersCompanion toCompanion(bool nullToAbsent) {
    return PropertyManagersCompanion(
      id: Value(id),
      userId: Value(userId),
      propertyId: Value(propertyId),
      assignedAt: Value(assignedAt),
    );
  }

  factory PropertyManager.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PropertyManager(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      propertyId: serializer.fromJson<String>(json['propertyId']),
      assignedAt: serializer.fromJson<DateTime>(json['assignedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'propertyId': serializer.toJson<String>(propertyId),
      'assignedAt': serializer.toJson<DateTime>(assignedAt),
    };
  }

  PropertyManager copyWith({
    String? id,
    String? userId,
    String? propertyId,
    DateTime? assignedAt,
  }) => PropertyManager(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    propertyId: propertyId ?? this.propertyId,
    assignedAt: assignedAt ?? this.assignedAt,
  );
  PropertyManager copyWithCompanion(PropertyManagersCompanion data) {
    return PropertyManager(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      propertyId: data.propertyId.present
          ? data.propertyId.value
          : this.propertyId,
      assignedAt: data.assignedAt.present
          ? data.assignedAt.value
          : this.assignedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PropertyManager(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('propertyId: $propertyId, ')
          ..write('assignedAt: $assignedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, propertyId, assignedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PropertyManager &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.propertyId == this.propertyId &&
          other.assignedAt == this.assignedAt);
}

class PropertyManagersCompanion extends UpdateCompanion<PropertyManager> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> propertyId;
  final Value<DateTime> assignedAt;
  final Value<int> rowid;
  const PropertyManagersCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.propertyId = const Value.absent(),
    this.assignedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PropertyManagersCompanion.insert({
    required String id,
    required String userId,
    required String propertyId,
    this.assignedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       propertyId = Value(propertyId);
  static Insertable<PropertyManager> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? propertyId,
    Expression<DateTime>? assignedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (propertyId != null) 'property_id': propertyId,
      if (assignedAt != null) 'assigned_at': assignedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PropertyManagersCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? propertyId,
    Value<DateTime>? assignedAt,
    Value<int>? rowid,
  }) {
    return PropertyManagersCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      propertyId: propertyId ?? this.propertyId,
      assignedAt: assignedAt ?? this.assignedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (propertyId.present) {
      map['property_id'] = Variable<String>(propertyId.value);
    }
    if (assignedAt.present) {
      map['assigned_at'] = Variable<DateTime>(assignedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PropertyManagersCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('propertyId: $propertyId, ')
          ..write('assignedAt: $assignedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoomsTable extends Rooms with TableInfo<$RoomsTable, Room> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoomsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _propertyIdMeta = const VerificationMeta(
    'propertyId',
  );
  @override
  late final GeneratedColumn<String> propertyId = GeneratedColumn<String>(
    'property_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES properties (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _roomNumberMeta = const VerificationMeta(
    'roomNumber',
  );
  @override
  late final GeneratedColumn<String> roomNumber = GeneratedColumn<String>(
    'room_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _buildingNameMeta = const VerificationMeta(
    'buildingName',
  );
  @override
  late final GeneratedColumn<String> buildingName = GeneratedColumn<String>(
    'building_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _floorNameMeta = const VerificationMeta(
    'floorName',
  );
  @override
  late final GeneratedColumn<String> floorName = GeneratedColumn<String>(
    'floor_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pricePerMonthMeta = const VerificationMeta(
    'pricePerMonth',
  );
  @override
  late final GeneratedColumn<int> pricePerMonth = GeneratedColumn<int>(
    'price_per_month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('vacant'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    propertyId,
    roomNumber,
    buildingName,
    floorName,
    pricePerMonth,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rooms';
  @override
  VerificationContext validateIntegrity(
    Insertable<Room> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('property_id')) {
      context.handle(
        _propertyIdMeta,
        propertyId.isAcceptableOrUnknown(data['property_id']!, _propertyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_propertyIdMeta);
    }
    if (data.containsKey('room_number')) {
      context.handle(
        _roomNumberMeta,
        roomNumber.isAcceptableOrUnknown(data['room_number']!, _roomNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_roomNumberMeta);
    }
    if (data.containsKey('building_name')) {
      context.handle(
        _buildingNameMeta,
        buildingName.isAcceptableOrUnknown(
          data['building_name']!,
          _buildingNameMeta,
        ),
      );
    }
    if (data.containsKey('floor_name')) {
      context.handle(
        _floorNameMeta,
        floorName.isAcceptableOrUnknown(data['floor_name']!, _floorNameMeta),
      );
    }
    if (data.containsKey('price_per_month')) {
      context.handle(
        _pricePerMonthMeta,
        pricePerMonth.isAcceptableOrUnknown(
          data['price_per_month']!,
          _pricePerMonthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pricePerMonthMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Room map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Room(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      propertyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}property_id'],
      )!,
      roomNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}room_number'],
      )!,
      buildingName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}building_name'],
      ),
      floorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}floor_name'],
      ),
      pricePerMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_per_month'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RoomsTable createAlias(String alias) {
    return $RoomsTable(attachedDatabase, alias);
  }
}

class Room extends DataClass implements Insertable<Room> {
  final String id;
  final String propertyId;
  final String roomNumber;
  final String? buildingName;
  final String? floorName;
  final int pricePerMonth;
  final String status;
  final DateTime createdAt;
  const Room({
    required this.id,
    required this.propertyId,
    required this.roomNumber,
    this.buildingName,
    this.floorName,
    required this.pricePerMonth,
    required this.status,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['property_id'] = Variable<String>(propertyId);
    map['room_number'] = Variable<String>(roomNumber);
    if (!nullToAbsent || buildingName != null) {
      map['building_name'] = Variable<String>(buildingName);
    }
    if (!nullToAbsent || floorName != null) {
      map['floor_name'] = Variable<String>(floorName);
    }
    map['price_per_month'] = Variable<int>(pricePerMonth);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RoomsCompanion toCompanion(bool nullToAbsent) {
    return RoomsCompanion(
      id: Value(id),
      propertyId: Value(propertyId),
      roomNumber: Value(roomNumber),
      buildingName: buildingName == null && nullToAbsent
          ? const Value.absent()
          : Value(buildingName),
      floorName: floorName == null && nullToAbsent
          ? const Value.absent()
          : Value(floorName),
      pricePerMonth: Value(pricePerMonth),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory Room.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Room(
      id: serializer.fromJson<String>(json['id']),
      propertyId: serializer.fromJson<String>(json['propertyId']),
      roomNumber: serializer.fromJson<String>(json['roomNumber']),
      buildingName: serializer.fromJson<String?>(json['buildingName']),
      floorName: serializer.fromJson<String?>(json['floorName']),
      pricePerMonth: serializer.fromJson<int>(json['pricePerMonth']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'propertyId': serializer.toJson<String>(propertyId),
      'roomNumber': serializer.toJson<String>(roomNumber),
      'buildingName': serializer.toJson<String?>(buildingName),
      'floorName': serializer.toJson<String?>(floorName),
      'pricePerMonth': serializer.toJson<int>(pricePerMonth),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Room copyWith({
    String? id,
    String? propertyId,
    String? roomNumber,
    Value<String?> buildingName = const Value.absent(),
    Value<String?> floorName = const Value.absent(),
    int? pricePerMonth,
    String? status,
    DateTime? createdAt,
  }) => Room(
    id: id ?? this.id,
    propertyId: propertyId ?? this.propertyId,
    roomNumber: roomNumber ?? this.roomNumber,
    buildingName: buildingName.present ? buildingName.value : this.buildingName,
    floorName: floorName.present ? floorName.value : this.floorName,
    pricePerMonth: pricePerMonth ?? this.pricePerMonth,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
  Room copyWithCompanion(RoomsCompanion data) {
    return Room(
      id: data.id.present ? data.id.value : this.id,
      propertyId: data.propertyId.present
          ? data.propertyId.value
          : this.propertyId,
      roomNumber: data.roomNumber.present
          ? data.roomNumber.value
          : this.roomNumber,
      buildingName: data.buildingName.present
          ? data.buildingName.value
          : this.buildingName,
      floorName: data.floorName.present ? data.floorName.value : this.floorName,
      pricePerMonth: data.pricePerMonth.present
          ? data.pricePerMonth.value
          : this.pricePerMonth,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Room(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('roomNumber: $roomNumber, ')
          ..write('buildingName: $buildingName, ')
          ..write('floorName: $floorName, ')
          ..write('pricePerMonth: $pricePerMonth, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    propertyId,
    roomNumber,
    buildingName,
    floorName,
    pricePerMonth,
    status,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Room &&
          other.id == this.id &&
          other.propertyId == this.propertyId &&
          other.roomNumber == this.roomNumber &&
          other.buildingName == this.buildingName &&
          other.floorName == this.floorName &&
          other.pricePerMonth == this.pricePerMonth &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class RoomsCompanion extends UpdateCompanion<Room> {
  final Value<String> id;
  final Value<String> propertyId;
  final Value<String> roomNumber;
  final Value<String?> buildingName;
  final Value<String?> floorName;
  final Value<int> pricePerMonth;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RoomsCompanion({
    this.id = const Value.absent(),
    this.propertyId = const Value.absent(),
    this.roomNumber = const Value.absent(),
    this.buildingName = const Value.absent(),
    this.floorName = const Value.absent(),
    this.pricePerMonth = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoomsCompanion.insert({
    required String id,
    required String propertyId,
    required String roomNumber,
    this.buildingName = const Value.absent(),
    this.floorName = const Value.absent(),
    required int pricePerMonth,
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       propertyId = Value(propertyId),
       roomNumber = Value(roomNumber),
       pricePerMonth = Value(pricePerMonth);
  static Insertable<Room> custom({
    Expression<String>? id,
    Expression<String>? propertyId,
    Expression<String>? roomNumber,
    Expression<String>? buildingName,
    Expression<String>? floorName,
    Expression<int>? pricePerMonth,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (propertyId != null) 'property_id': propertyId,
      if (roomNumber != null) 'room_number': roomNumber,
      if (buildingName != null) 'building_name': buildingName,
      if (floorName != null) 'floor_name': floorName,
      if (pricePerMonth != null) 'price_per_month': pricePerMonth,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoomsCompanion copyWith({
    Value<String>? id,
    Value<String>? propertyId,
    Value<String>? roomNumber,
    Value<String?>? buildingName,
    Value<String?>? floorName,
    Value<int>? pricePerMonth,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return RoomsCompanion(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      roomNumber: roomNumber ?? this.roomNumber,
      buildingName: buildingName ?? this.buildingName,
      floorName: floorName ?? this.floorName,
      pricePerMonth: pricePerMonth ?? this.pricePerMonth,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (propertyId.present) {
      map['property_id'] = Variable<String>(propertyId.value);
    }
    if (roomNumber.present) {
      map['room_number'] = Variable<String>(roomNumber.value);
    }
    if (buildingName.present) {
      map['building_name'] = Variable<String>(buildingName.value);
    }
    if (floorName.present) {
      map['floor_name'] = Variable<String>(floorName.value);
    }
    if (pricePerMonth.present) {
      map['price_per_month'] = Variable<int>(pricePerMonth.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoomsCompanion(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('roomNumber: $roomNumber, ')
          ..write('buildingName: $buildingName, ')
          ..write('floorName: $floorName, ')
          ..write('pricePerMonth: $pricePerMonth, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ResidentsTable extends Residents
    with TableInfo<$ResidentsTable, Resident> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ResidentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES organizations (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_profiles (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idCardNumberMeta = const VerificationMeta(
    'idCardNumber',
  );
  @override
  late final GeneratedColumn<String> idCardNumber = GeneratedColumn<String>(
    'id_card_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('prospective'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    userId,
    fullName,
    phoneNumber,
    email,
    idCardNumber,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'residents';
  @override
  VerificationContext validateIntegrity(
    Insertable<Resident> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('id_card_number')) {
      context.handle(
        _idCardNumberMeta,
        idCardNumber.isAcceptableOrUnknown(
          data['id_card_number']!,
          _idCardNumberMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Resident map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Resident(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      idCardNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_card_number'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ResidentsTable createAlias(String alias) {
    return $ResidentsTable(attachedDatabase, alias);
  }
}

class Resident extends DataClass implements Insertable<Resident> {
  final String id;
  final String organizationId;
  final String? userId;
  final String fullName;
  final String phoneNumber;
  final String? email;
  final String? idCardNumber;
  final String status;
  final DateTime createdAt;
  const Resident({
    required this.id,
    required this.organizationId,
    this.userId,
    required this.fullName,
    required this.phoneNumber,
    this.email,
    this.idCardNumber,
    required this.status,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['full_name'] = Variable<String>(fullName);
    map['phone_number'] = Variable<String>(phoneNumber);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || idCardNumber != null) {
      map['id_card_number'] = Variable<String>(idCardNumber);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ResidentsCompanion toCompanion(bool nullToAbsent) {
    return ResidentsCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      fullName: Value(fullName),
      phoneNumber: Value(phoneNumber),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      idCardNumber: idCardNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(idCardNumber),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory Resident.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Resident(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      userId: serializer.fromJson<String?>(json['userId']),
      fullName: serializer.fromJson<String>(json['fullName']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      email: serializer.fromJson<String?>(json['email']),
      idCardNumber: serializer.fromJson<String?>(json['idCardNumber']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'userId': serializer.toJson<String?>(userId),
      'fullName': serializer.toJson<String>(fullName),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'email': serializer.toJson<String?>(email),
      'idCardNumber': serializer.toJson<String?>(idCardNumber),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Resident copyWith({
    String? id,
    String? organizationId,
    Value<String?> userId = const Value.absent(),
    String? fullName,
    String? phoneNumber,
    Value<String?> email = const Value.absent(),
    Value<String?> idCardNumber = const Value.absent(),
    String? status,
    DateTime? createdAt,
  }) => Resident(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    userId: userId.present ? userId.value : this.userId,
    fullName: fullName ?? this.fullName,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    email: email.present ? email.value : this.email,
    idCardNumber: idCardNumber.present ? idCardNumber.value : this.idCardNumber,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
  Resident copyWithCompanion(ResidentsCompanion data) {
    return Resident(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      userId: data.userId.present ? data.userId.value : this.userId,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      email: data.email.present ? data.email.value : this.email,
      idCardNumber: data.idCardNumber.present
          ? data.idCardNumber.value
          : this.idCardNumber,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Resident(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('userId: $userId, ')
          ..write('fullName: $fullName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('email: $email, ')
          ..write('idCardNumber: $idCardNumber, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    userId,
    fullName,
    phoneNumber,
    email,
    idCardNumber,
    status,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Resident &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.userId == this.userId &&
          other.fullName == this.fullName &&
          other.phoneNumber == this.phoneNumber &&
          other.email == this.email &&
          other.idCardNumber == this.idCardNumber &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class ResidentsCompanion extends UpdateCompanion<Resident> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<String?> userId;
  final Value<String> fullName;
  final Value<String> phoneNumber;
  final Value<String?> email;
  final Value<String?> idCardNumber;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ResidentsCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.userId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.email = const Value.absent(),
    this.idCardNumber = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ResidentsCompanion.insert({
    required String id,
    required String organizationId,
    this.userId = const Value.absent(),
    required String fullName,
    required String phoneNumber,
    this.email = const Value.absent(),
    this.idCardNumber = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       fullName = Value(fullName),
       phoneNumber = Value(phoneNumber);
  static Insertable<Resident> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? userId,
    Expression<String>? fullName,
    Expression<String>? phoneNumber,
    Expression<String>? email,
    Expression<String>? idCardNumber,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (userId != null) 'user_id': userId,
      if (fullName != null) 'full_name': fullName,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (email != null) 'email': email,
      if (idCardNumber != null) 'id_card_number': idCardNumber,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ResidentsCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<String?>? userId,
    Value<String>? fullName,
    Value<String>? phoneNumber,
    Value<String?>? email,
    Value<String?>? idCardNumber,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ResidentsCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      idCardNumber: idCardNumber ?? this.idCardNumber,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (idCardNumber.present) {
      map['id_card_number'] = Variable<String>(idCardNumber.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ResidentsCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('userId: $userId, ')
          ..write('fullName: $fullName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('email: $email, ')
          ..write('idCardNumber: $idCardNumber, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContractsTable extends Contracts
    with TableInfo<$ContractsTable, Contract> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContractsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES organizations (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _residentIdMeta = const VerificationMeta(
    'residentId',
  );
  @override
  late final GeneratedColumn<String> residentId = GeneratedColumn<String>(
    'resident_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES residents (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _roomIdMeta = const VerificationMeta('roomId');
  @override
  late final GeneratedColumn<String> roomId = GeneratedColumn<String>(
    'room_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rooms (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _billingCycleMeta = const VerificationMeta(
    'billingCycle',
  );
  @override
  late final GeneratedColumn<String> billingCycle = GeneratedColumn<String>(
    'billing_cycle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('monthly'),
  );
  static const VerificationMeta _pricePerCycleMeta = const VerificationMeta(
    'pricePerCycle',
  );
  @override
  late final GeneratedColumn<int> pricePerCycle = GeneratedColumn<int>(
    'price_per_cycle',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _depositAmountMeta = const VerificationMeta(
    'depositAmount',
  );
  @override
  late final GeneratedColumn<int> depositAmount = GeneratedColumn<int>(
    'deposit_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    residentId,
    roomId,
    startDate,
    endDate,
    billingCycle,
    pricePerCycle,
    depositAmount,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contracts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Contract> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('resident_id')) {
      context.handle(
        _residentIdMeta,
        residentId.isAcceptableOrUnknown(data['resident_id']!, _residentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_residentIdMeta);
    }
    if (data.containsKey('room_id')) {
      context.handle(
        _roomIdMeta,
        roomId.isAcceptableOrUnknown(data['room_id']!, _roomIdMeta),
      );
    } else if (isInserting) {
      context.missing(_roomIdMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('billing_cycle')) {
      context.handle(
        _billingCycleMeta,
        billingCycle.isAcceptableOrUnknown(
          data['billing_cycle']!,
          _billingCycleMeta,
        ),
      );
    }
    if (data.containsKey('price_per_cycle')) {
      context.handle(
        _pricePerCycleMeta,
        pricePerCycle.isAcceptableOrUnknown(
          data['price_per_cycle']!,
          _pricePerCycleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pricePerCycleMeta);
    }
    if (data.containsKey('deposit_amount')) {
      context.handle(
        _depositAmountMeta,
        depositAmount.isAcceptableOrUnknown(
          data['deposit_amount']!,
          _depositAmountMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contract map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contract(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      residentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resident_id'],
      )!,
      roomId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}room_id'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      )!,
      billingCycle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}billing_cycle'],
      )!,
      pricePerCycle: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_per_cycle'],
      )!,
      depositAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deposit_amount'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ContractsTable createAlias(String alias) {
    return $ContractsTable(attachedDatabase, alias);
  }
}

class Contract extends DataClass implements Insertable<Contract> {
  final String id;
  final String organizationId;
  final String residentId;
  final String roomId;
  final DateTime startDate;
  final DateTime endDate;
  final String billingCycle;
  final int pricePerCycle;
  final int depositAmount;
  final String status;
  final DateTime createdAt;
  const Contract({
    required this.id,
    required this.organizationId,
    required this.residentId,
    required this.roomId,
    required this.startDate,
    required this.endDate,
    required this.billingCycle,
    required this.pricePerCycle,
    required this.depositAmount,
    required this.status,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    map['resident_id'] = Variable<String>(residentId);
    map['room_id'] = Variable<String>(roomId);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['billing_cycle'] = Variable<String>(billingCycle);
    map['price_per_cycle'] = Variable<int>(pricePerCycle);
    map['deposit_amount'] = Variable<int>(depositAmount);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ContractsCompanion toCompanion(bool nullToAbsent) {
    return ContractsCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      residentId: Value(residentId),
      roomId: Value(roomId),
      startDate: Value(startDate),
      endDate: Value(endDate),
      billingCycle: Value(billingCycle),
      pricePerCycle: Value(pricePerCycle),
      depositAmount: Value(depositAmount),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory Contract.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contract(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      residentId: serializer.fromJson<String>(json['residentId']),
      roomId: serializer.fromJson<String>(json['roomId']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      billingCycle: serializer.fromJson<String>(json['billingCycle']),
      pricePerCycle: serializer.fromJson<int>(json['pricePerCycle']),
      depositAmount: serializer.fromJson<int>(json['depositAmount']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'residentId': serializer.toJson<String>(residentId),
      'roomId': serializer.toJson<String>(roomId),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'billingCycle': serializer.toJson<String>(billingCycle),
      'pricePerCycle': serializer.toJson<int>(pricePerCycle),
      'depositAmount': serializer.toJson<int>(depositAmount),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Contract copyWith({
    String? id,
    String? organizationId,
    String? residentId,
    String? roomId,
    DateTime? startDate,
    DateTime? endDate,
    String? billingCycle,
    int? pricePerCycle,
    int? depositAmount,
    String? status,
    DateTime? createdAt,
  }) => Contract(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    residentId: residentId ?? this.residentId,
    roomId: roomId ?? this.roomId,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    billingCycle: billingCycle ?? this.billingCycle,
    pricePerCycle: pricePerCycle ?? this.pricePerCycle,
    depositAmount: depositAmount ?? this.depositAmount,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
  Contract copyWithCompanion(ContractsCompanion data) {
    return Contract(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      residentId: data.residentId.present
          ? data.residentId.value
          : this.residentId,
      roomId: data.roomId.present ? data.roomId.value : this.roomId,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      billingCycle: data.billingCycle.present
          ? data.billingCycle.value
          : this.billingCycle,
      pricePerCycle: data.pricePerCycle.present
          ? data.pricePerCycle.value
          : this.pricePerCycle,
      depositAmount: data.depositAmount.present
          ? data.depositAmount.value
          : this.depositAmount,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Contract(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('residentId: $residentId, ')
          ..write('roomId: $roomId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('billingCycle: $billingCycle, ')
          ..write('pricePerCycle: $pricePerCycle, ')
          ..write('depositAmount: $depositAmount, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    residentId,
    roomId,
    startDate,
    endDate,
    billingCycle,
    pricePerCycle,
    depositAmount,
    status,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contract &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.residentId == this.residentId &&
          other.roomId == this.roomId &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.billingCycle == this.billingCycle &&
          other.pricePerCycle == this.pricePerCycle &&
          other.depositAmount == this.depositAmount &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class ContractsCompanion extends UpdateCompanion<Contract> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<String> residentId;
  final Value<String> roomId;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<String> billingCycle;
  final Value<int> pricePerCycle;
  final Value<int> depositAmount;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ContractsCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.residentId = const Value.absent(),
    this.roomId = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.billingCycle = const Value.absent(),
    this.pricePerCycle = const Value.absent(),
    this.depositAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContractsCompanion.insert({
    required String id,
    required String organizationId,
    required String residentId,
    required String roomId,
    required DateTime startDate,
    required DateTime endDate,
    this.billingCycle = const Value.absent(),
    required int pricePerCycle,
    this.depositAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       residentId = Value(residentId),
       roomId = Value(roomId),
       startDate = Value(startDate),
       endDate = Value(endDate),
       pricePerCycle = Value(pricePerCycle);
  static Insertable<Contract> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? residentId,
    Expression<String>? roomId,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? billingCycle,
    Expression<int>? pricePerCycle,
    Expression<int>? depositAmount,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (residentId != null) 'resident_id': residentId,
      if (roomId != null) 'room_id': roomId,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (billingCycle != null) 'billing_cycle': billingCycle,
      if (pricePerCycle != null) 'price_per_cycle': pricePerCycle,
      if (depositAmount != null) 'deposit_amount': depositAmount,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContractsCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<String>? residentId,
    Value<String>? roomId,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<String>? billingCycle,
    Value<int>? pricePerCycle,
    Value<int>? depositAmount,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ContractsCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      residentId: residentId ?? this.residentId,
      roomId: roomId ?? this.roomId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      billingCycle: billingCycle ?? this.billingCycle,
      pricePerCycle: pricePerCycle ?? this.pricePerCycle,
      depositAmount: depositAmount ?? this.depositAmount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (residentId.present) {
      map['resident_id'] = Variable<String>(residentId.value);
    }
    if (roomId.present) {
      map['room_id'] = Variable<String>(roomId.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (billingCycle.present) {
      map['billing_cycle'] = Variable<String>(billingCycle.value);
    }
    if (pricePerCycle.present) {
      map['price_per_cycle'] = Variable<int>(pricePerCycle.value);
    }
    if (depositAmount.present) {
      map['deposit_amount'] = Variable<int>(depositAmount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContractsCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('residentId: $residentId, ')
          ..write('roomId: $roomId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('billingCycle: $billingCycle, ')
          ..write('pricePerCycle: $pricePerCycle, ')
          ..write('depositAmount: $depositAmount, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices with TableInfo<$InvoicesTable, Invoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES organizations (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _contractIdMeta = const VerificationMeta(
    'contractId',
  );
  @override
  late final GeneratedColumn<String> contractId = GeneratedColumn<String>(
    'contract_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES contracts (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _invoiceNumberMeta = const VerificationMeta(
    'invoiceNumber',
  );
  @override
  late final GeneratedColumn<String> invoiceNumber = GeneratedColumn<String>(
    'invoice_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'UNIQUE NOT NULL',
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountDueMeta = const VerificationMeta(
    'amountDue',
  );
  @override
  late final GeneratedColumn<int> amountDue = GeneratedColumn<int>(
    'amount_due',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountPaidMeta = const VerificationMeta(
    'amountPaid',
  );
  @override
  late final GeneratedColumn<int> amountPaid = GeneratedColumn<int>(
    'amount_paid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unpaid'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    contractId,
    invoiceNumber,
    dueDate,
    amountDue,
    amountPaid,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Invoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('contract_id')) {
      context.handle(
        _contractIdMeta,
        contractId.isAcceptableOrUnknown(data['contract_id']!, _contractIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contractIdMeta);
    }
    if (data.containsKey('invoice_number')) {
      context.handle(
        _invoiceNumberMeta,
        invoiceNumber.isAcceptableOrUnknown(
          data['invoice_number']!,
          _invoiceNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceNumberMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('amount_due')) {
      context.handle(
        _amountDueMeta,
        amountDue.isAcceptableOrUnknown(data['amount_due']!, _amountDueMeta),
      );
    } else if (isInserting) {
      context.missing(_amountDueMeta);
    }
    if (data.containsKey('amount_paid')) {
      context.handle(
        _amountPaidMeta,
        amountPaid.isAcceptableOrUnknown(data['amount_paid']!, _amountPaidMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Invoice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      contractId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contract_id'],
      )!,
      invoiceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_number'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
      amountDue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_due'],
      )!,
      amountPaid: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_paid'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class Invoice extends DataClass implements Insertable<Invoice> {
  final String id;
  final String organizationId;
  final String contractId;
  final String invoiceNumber;
  final DateTime dueDate;
  final int amountDue;
  final int amountPaid;
  final String status;
  final DateTime createdAt;
  const Invoice({
    required this.id,
    required this.organizationId,
    required this.contractId,
    required this.invoiceNumber,
    required this.dueDate,
    required this.amountDue,
    required this.amountPaid,
    required this.status,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    map['contract_id'] = Variable<String>(contractId);
    map['invoice_number'] = Variable<String>(invoiceNumber);
    map['due_date'] = Variable<DateTime>(dueDate);
    map['amount_due'] = Variable<int>(amountDue);
    map['amount_paid'] = Variable<int>(amountPaid);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      contractId: Value(contractId),
      invoiceNumber: Value(invoiceNumber),
      dueDate: Value(dueDate),
      amountDue: Value(amountDue),
      amountPaid: Value(amountPaid),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory Invoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      contractId: serializer.fromJson<String>(json['contractId']),
      invoiceNumber: serializer.fromJson<String>(json['invoiceNumber']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      amountDue: serializer.fromJson<int>(json['amountDue']),
      amountPaid: serializer.fromJson<int>(json['amountPaid']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'contractId': serializer.toJson<String>(contractId),
      'invoiceNumber': serializer.toJson<String>(invoiceNumber),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'amountDue': serializer.toJson<int>(amountDue),
      'amountPaid': serializer.toJson<int>(amountPaid),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Invoice copyWith({
    String? id,
    String? organizationId,
    String? contractId,
    String? invoiceNumber,
    DateTime? dueDate,
    int? amountDue,
    int? amountPaid,
    String? status,
    DateTime? createdAt,
  }) => Invoice(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    contractId: contractId ?? this.contractId,
    invoiceNumber: invoiceNumber ?? this.invoiceNumber,
    dueDate: dueDate ?? this.dueDate,
    amountDue: amountDue ?? this.amountDue,
    amountPaid: amountPaid ?? this.amountPaid,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
  Invoice copyWithCompanion(InvoicesCompanion data) {
    return Invoice(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      contractId: data.contractId.present
          ? data.contractId.value
          : this.contractId,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      amountDue: data.amountDue.present ? data.amountDue.value : this.amountDue,
      amountPaid: data.amountPaid.present
          ? data.amountPaid.value
          : this.amountPaid,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('contractId: $contractId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('dueDate: $dueDate, ')
          ..write('amountDue: $amountDue, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    contractId,
    invoiceNumber,
    dueDate,
    amountDue,
    amountPaid,
    status,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.contractId == this.contractId &&
          other.invoiceNumber == this.invoiceNumber &&
          other.dueDate == this.dueDate &&
          other.amountDue == this.amountDue &&
          other.amountPaid == this.amountPaid &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<String> contractId;
  final Value<String> invoiceNumber;
  final Value<DateTime> dueDate;
  final Value<int> amountDue;
  final Value<int> amountPaid;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.contractId = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.amountDue = const Value.absent(),
    this.amountPaid = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvoicesCompanion.insert({
    required String id,
    required String organizationId,
    required String contractId,
    required String invoiceNumber,
    required DateTime dueDate,
    required int amountDue,
    this.amountPaid = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       contractId = Value(contractId),
       invoiceNumber = Value(invoiceNumber),
       dueDate = Value(dueDate),
       amountDue = Value(amountDue);
  static Insertable<Invoice> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? contractId,
    Expression<String>? invoiceNumber,
    Expression<DateTime>? dueDate,
    Expression<int>? amountDue,
    Expression<int>? amountPaid,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (contractId != null) 'contract_id': contractId,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (dueDate != null) 'due_date': dueDate,
      if (amountDue != null) 'amount_due': amountDue,
      if (amountPaid != null) 'amount_paid': amountPaid,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvoicesCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<String>? contractId,
    Value<String>? invoiceNumber,
    Value<DateTime>? dueDate,
    Value<int>? amountDue,
    Value<int>? amountPaid,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return InvoicesCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      contractId: contractId ?? this.contractId,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      dueDate: dueDate ?? this.dueDate,
      amountDue: amountDue ?? this.amountDue,
      amountPaid: amountPaid ?? this.amountPaid,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (contractId.present) {
      map['contract_id'] = Variable<String>(contractId.value);
    }
    if (invoiceNumber.present) {
      map['invoice_number'] = Variable<String>(invoiceNumber.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (amountDue.present) {
      map['amount_due'] = Variable<int>(amountDue.value);
    }
    if (amountPaid.present) {
      map['amount_paid'] = Variable<int>(amountPaid.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('contractId: $contractId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('dueDate: $dueDate, ')
          ..write('amountDue: $amountDue, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments with TableInfo<$PaymentsTable, Payment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES organizations (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _paymentDateMeta = const VerificationMeta(
    'paymentDate',
  );
  @override
  late final GeneratedColumn<DateTime> paymentDate = GeneratedColumn<DateTime>(
    'payment_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proofUrlMeta = const VerificationMeta(
    'proofUrl',
  );
  @override
  late final GeneratedColumn<String> proofUrl = GeneratedColumn<String>(
    'proof_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _verifiedMeta = const VerificationMeta(
    'verified',
  );
  @override
  late final GeneratedColumn<bool> verified = GeneratedColumn<bool>(
    'verified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("verified" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    paymentDate,
    amount,
    paymentMethod,
    proofUrl,
    verified,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Payment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('payment_date')) {
      context.handle(
        _paymentDateMeta,
        paymentDate.isAcceptableOrUnknown(
          data['payment_date']!,
          _paymentDateMeta,
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
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('proof_url')) {
      context.handle(
        _proofUrlMeta,
        proofUrl.isAcceptableOrUnknown(data['proof_url']!, _proofUrlMeta),
      );
    }
    if (data.containsKey('verified')) {
      context.handle(
        _verifiedMeta,
        verified.isAcceptableOrUnknown(data['verified']!, _verifiedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Payment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      paymentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}payment_date'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      proofUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proof_url'],
      ),
      verified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}verified'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class Payment extends DataClass implements Insertable<Payment> {
  final String id;
  final String organizationId;
  final DateTime paymentDate;
  final int amount;
  final String paymentMethod;
  final String? proofUrl;
  final bool verified;
  final DateTime createdAt;
  const Payment({
    required this.id,
    required this.organizationId,
    required this.paymentDate,
    required this.amount,
    required this.paymentMethod,
    this.proofUrl,
    required this.verified,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    map['payment_date'] = Variable<DateTime>(paymentDate);
    map['amount'] = Variable<int>(amount);
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || proofUrl != null) {
      map['proof_url'] = Variable<String>(proofUrl);
    }
    map['verified'] = Variable<bool>(verified);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      paymentDate: Value(paymentDate),
      amount: Value(amount),
      paymentMethod: Value(paymentMethod),
      proofUrl: proofUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(proofUrl),
      verified: Value(verified),
      createdAt: Value(createdAt),
    );
  }

  factory Payment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payment(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      paymentDate: serializer.fromJson<DateTime>(json['paymentDate']),
      amount: serializer.fromJson<int>(json['amount']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      proofUrl: serializer.fromJson<String?>(json['proofUrl']),
      verified: serializer.fromJson<bool>(json['verified']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'paymentDate': serializer.toJson<DateTime>(paymentDate),
      'amount': serializer.toJson<int>(amount),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'proofUrl': serializer.toJson<String?>(proofUrl),
      'verified': serializer.toJson<bool>(verified),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Payment copyWith({
    String? id,
    String? organizationId,
    DateTime? paymentDate,
    int? amount,
    String? paymentMethod,
    Value<String?> proofUrl = const Value.absent(),
    bool? verified,
    DateTime? createdAt,
  }) => Payment(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    paymentDate: paymentDate ?? this.paymentDate,
    amount: amount ?? this.amount,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    proofUrl: proofUrl.present ? proofUrl.value : this.proofUrl,
    verified: verified ?? this.verified,
    createdAt: createdAt ?? this.createdAt,
  );
  Payment copyWithCompanion(PaymentsCompanion data) {
    return Payment(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      paymentDate: data.paymentDate.present
          ? data.paymentDate.value
          : this.paymentDate,
      amount: data.amount.present ? data.amount.value : this.amount,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      proofUrl: data.proofUrl.present ? data.proofUrl.value : this.proofUrl,
      verified: data.verified.present ? data.verified.value : this.verified,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Payment(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('proofUrl: $proofUrl, ')
          ..write('verified: $verified, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    paymentDate,
    amount,
    paymentMethod,
    proofUrl,
    verified,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payment &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.paymentDate == this.paymentDate &&
          other.amount == this.amount &&
          other.paymentMethod == this.paymentMethod &&
          other.proofUrl == this.proofUrl &&
          other.verified == this.verified &&
          other.createdAt == this.createdAt);
}

class PaymentsCompanion extends UpdateCompanion<Payment> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<DateTime> paymentDate;
  final Value<int> amount;
  final Value<String> paymentMethod;
  final Value<String?> proofUrl;
  final Value<bool> verified;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.paymentDate = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.proofUrl = const Value.absent(),
    this.verified = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentsCompanion.insert({
    required String id,
    required String organizationId,
    this.paymentDate = const Value.absent(),
    required int amount,
    required String paymentMethod,
    this.proofUrl = const Value.absent(),
    this.verified = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       amount = Value(amount),
       paymentMethod = Value(paymentMethod);
  static Insertable<Payment> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<DateTime>? paymentDate,
    Expression<int>? amount,
    Expression<String>? paymentMethod,
    Expression<String>? proofUrl,
    Expression<bool>? verified,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (paymentDate != null) 'payment_date': paymentDate,
      if (amount != null) 'amount': amount,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (proofUrl != null) 'proof_url': proofUrl,
      if (verified != null) 'verified': verified,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentsCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<DateTime>? paymentDate,
    Value<int>? amount,
    Value<String>? paymentMethod,
    Value<String?>? proofUrl,
    Value<bool>? verified,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PaymentsCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      paymentDate: paymentDate ?? this.paymentDate,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      proofUrl: proofUrl ?? this.proofUrl,
      verified: verified ?? this.verified,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (paymentDate.present) {
      map['payment_date'] = Variable<DateTime>(paymentDate.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (proofUrl.present) {
      map['proof_url'] = Variable<String>(proofUrl.value);
    }
    if (verified.present) {
      map['verified'] = Variable<bool>(verified.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('proofUrl: $proofUrl, ')
          ..write('verified: $verified, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentItemsTable extends PaymentItems
    with TableInfo<$PaymentItemsTable, PaymentItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentIdMeta = const VerificationMeta(
    'paymentId',
  );
  @override
  late final GeneratedColumn<String> paymentId = GeneratedColumn<String>(
    'payment_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES payments (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _amountAllocatedMeta = const VerificationMeta(
    'amountAllocated',
  );
  @override
  late final GeneratedColumn<int> amountAllocated = GeneratedColumn<int>(
    'amount_allocated',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    paymentId,
    invoiceId,
    amountAllocated,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('payment_id')) {
      context.handle(
        _paymentIdMeta,
        paymentId.isAcceptableOrUnknown(data['payment_id']!, _paymentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_paymentIdMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('amount_allocated')) {
      context.handle(
        _amountAllocatedMeta,
        amountAllocated.isAcceptableOrUnknown(
          data['amount_allocated']!,
          _amountAllocatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountAllocatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      paymentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      )!,
      amountAllocated: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_allocated'],
      )!,
    );
  }

  @override
  $PaymentItemsTable createAlias(String alias) {
    return $PaymentItemsTable(attachedDatabase, alias);
  }
}

class PaymentItem extends DataClass implements Insertable<PaymentItem> {
  final String id;
  final String paymentId;
  final String invoiceId;
  final int amountAllocated;
  const PaymentItem({
    required this.id,
    required this.paymentId,
    required this.invoiceId,
    required this.amountAllocated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['payment_id'] = Variable<String>(paymentId);
    map['invoice_id'] = Variable<String>(invoiceId);
    map['amount_allocated'] = Variable<int>(amountAllocated);
    return map;
  }

  PaymentItemsCompanion toCompanion(bool nullToAbsent) {
    return PaymentItemsCompanion(
      id: Value(id),
      paymentId: Value(paymentId),
      invoiceId: Value(invoiceId),
      amountAllocated: Value(amountAllocated),
    );
  }

  factory PaymentItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentItem(
      id: serializer.fromJson<String>(json['id']),
      paymentId: serializer.fromJson<String>(json['paymentId']),
      invoiceId: serializer.fromJson<String>(json['invoiceId']),
      amountAllocated: serializer.fromJson<int>(json['amountAllocated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'paymentId': serializer.toJson<String>(paymentId),
      'invoiceId': serializer.toJson<String>(invoiceId),
      'amountAllocated': serializer.toJson<int>(amountAllocated),
    };
  }

  PaymentItem copyWith({
    String? id,
    String? paymentId,
    String? invoiceId,
    int? amountAllocated,
  }) => PaymentItem(
    id: id ?? this.id,
    paymentId: paymentId ?? this.paymentId,
    invoiceId: invoiceId ?? this.invoiceId,
    amountAllocated: amountAllocated ?? this.amountAllocated,
  );
  PaymentItem copyWithCompanion(PaymentItemsCompanion data) {
    return PaymentItem(
      id: data.id.present ? data.id.value : this.id,
      paymentId: data.paymentId.present ? data.paymentId.value : this.paymentId,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      amountAllocated: data.amountAllocated.present
          ? data.amountAllocated.value
          : this.amountAllocated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentItem(')
          ..write('id: $id, ')
          ..write('paymentId: $paymentId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('amountAllocated: $amountAllocated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, paymentId, invoiceId, amountAllocated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentItem &&
          other.id == this.id &&
          other.paymentId == this.paymentId &&
          other.invoiceId == this.invoiceId &&
          other.amountAllocated == this.amountAllocated);
}

class PaymentItemsCompanion extends UpdateCompanion<PaymentItem> {
  final Value<String> id;
  final Value<String> paymentId;
  final Value<String> invoiceId;
  final Value<int> amountAllocated;
  final Value<int> rowid;
  const PaymentItemsCompanion({
    this.id = const Value.absent(),
    this.paymentId = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.amountAllocated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentItemsCompanion.insert({
    required String id,
    required String paymentId,
    required String invoiceId,
    required int amountAllocated,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       paymentId = Value(paymentId),
       invoiceId = Value(invoiceId),
       amountAllocated = Value(amountAllocated);
  static Insertable<PaymentItem> custom({
    Expression<String>? id,
    Expression<String>? paymentId,
    Expression<String>? invoiceId,
    Expression<int>? amountAllocated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (paymentId != null) 'payment_id': paymentId,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (amountAllocated != null) 'amount_allocated': amountAllocated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? paymentId,
    Value<String>? invoiceId,
    Value<int>? amountAllocated,
    Value<int>? rowid,
  }) {
    return PaymentItemsCompanion(
      id: id ?? this.id,
      paymentId: paymentId ?? this.paymentId,
      invoiceId: invoiceId ?? this.invoiceId,
      amountAllocated: amountAllocated ?? this.amountAllocated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (paymentId.present) {
      map['payment_id'] = Variable<String>(paymentId.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (amountAllocated.present) {
      map['amount_allocated'] = Variable<int>(amountAllocated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentItemsCompanion(')
          ..write('id: $id, ')
          ..write('paymentId: $paymentId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('amountAllocated: $amountAllocated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MaintenanceTicketsTable extends MaintenanceTickets
    with TableInfo<$MaintenanceTicketsTable, MaintenanceTicket> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenanceTicketsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES organizations (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _residentIdMeta = const VerificationMeta(
    'residentId',
  );
  @override
  late final GeneratedColumn<String> residentId = GeneratedColumn<String>(
    'resident_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES residents (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _roomIdMeta = const VerificationMeta('roomId');
  @override
  late final GeneratedColumn<String> roomId = GeneratedColumn<String>(
    'room_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rooms (id) ON DELETE RESTRICT',
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urgencyMeta = const VerificationMeta(
    'urgency',
  );
  @override
  late final GeneratedColumn<String> urgency = GeneratedColumn<String>(
    'urgency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('medium'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<int> cost = GeneratedColumn<int>(
    'cost',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    residentId,
    roomId,
    title,
    description,
    urgency,
    status,
    cost,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenance_tickets';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaintenanceTicket> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('resident_id')) {
      context.handle(
        _residentIdMeta,
        residentId.isAcceptableOrUnknown(data['resident_id']!, _residentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_residentIdMeta);
    }
    if (data.containsKey('room_id')) {
      context.handle(
        _roomIdMeta,
        roomId.isAcceptableOrUnknown(data['room_id']!, _roomIdMeta),
      );
    } else if (isInserting) {
      context.missing(_roomIdMeta);
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
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('urgency')) {
      context.handle(
        _urgencyMeta,
        urgency.isAcceptableOrUnknown(data['urgency']!, _urgencyMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaintenanceTicket map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaintenanceTicket(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      residentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resident_id'],
      )!,
      roomId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}room_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      urgency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}urgency'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MaintenanceTicketsTable createAlias(String alias) {
    return $MaintenanceTicketsTable(attachedDatabase, alias);
  }
}

class MaintenanceTicket extends DataClass
    implements Insertable<MaintenanceTicket> {
  final String id;
  final String organizationId;
  final String residentId;
  final String roomId;
  final String title;
  final String description;
  final String urgency;
  final String status;
  final int? cost;
  final DateTime createdAt;
  const MaintenanceTicket({
    required this.id,
    required this.organizationId,
    required this.residentId,
    required this.roomId,
    required this.title,
    required this.description,
    required this.urgency,
    required this.status,
    this.cost,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    map['resident_id'] = Variable<String>(residentId);
    map['room_id'] = Variable<String>(roomId);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['urgency'] = Variable<String>(urgency);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || cost != null) {
      map['cost'] = Variable<int>(cost);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MaintenanceTicketsCompanion toCompanion(bool nullToAbsent) {
    return MaintenanceTicketsCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      residentId: Value(residentId),
      roomId: Value(roomId),
      title: Value(title),
      description: Value(description),
      urgency: Value(urgency),
      status: Value(status),
      cost: cost == null && nullToAbsent ? const Value.absent() : Value(cost),
      createdAt: Value(createdAt),
    );
  }

  factory MaintenanceTicket.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaintenanceTicket(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      residentId: serializer.fromJson<String>(json['residentId']),
      roomId: serializer.fromJson<String>(json['roomId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      urgency: serializer.fromJson<String>(json['urgency']),
      status: serializer.fromJson<String>(json['status']),
      cost: serializer.fromJson<int?>(json['cost']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'residentId': serializer.toJson<String>(residentId),
      'roomId': serializer.toJson<String>(roomId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'urgency': serializer.toJson<String>(urgency),
      'status': serializer.toJson<String>(status),
      'cost': serializer.toJson<int?>(cost),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MaintenanceTicket copyWith({
    String? id,
    String? organizationId,
    String? residentId,
    String? roomId,
    String? title,
    String? description,
    String? urgency,
    String? status,
    Value<int?> cost = const Value.absent(),
    DateTime? createdAt,
  }) => MaintenanceTicket(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    residentId: residentId ?? this.residentId,
    roomId: roomId ?? this.roomId,
    title: title ?? this.title,
    description: description ?? this.description,
    urgency: urgency ?? this.urgency,
    status: status ?? this.status,
    cost: cost.present ? cost.value : this.cost,
    createdAt: createdAt ?? this.createdAt,
  );
  MaintenanceTicket copyWithCompanion(MaintenanceTicketsCompanion data) {
    return MaintenanceTicket(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      residentId: data.residentId.present
          ? data.residentId.value
          : this.residentId,
      roomId: data.roomId.present ? data.roomId.value : this.roomId,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      urgency: data.urgency.present ? data.urgency.value : this.urgency,
      status: data.status.present ? data.status.value : this.status,
      cost: data.cost.present ? data.cost.value : this.cost,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceTicket(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('residentId: $residentId, ')
          ..write('roomId: $roomId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('urgency: $urgency, ')
          ..write('status: $status, ')
          ..write('cost: $cost, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    residentId,
    roomId,
    title,
    description,
    urgency,
    status,
    cost,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaintenanceTicket &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.residentId == this.residentId &&
          other.roomId == this.roomId &&
          other.title == this.title &&
          other.description == this.description &&
          other.urgency == this.urgency &&
          other.status == this.status &&
          other.cost == this.cost &&
          other.createdAt == this.createdAt);
}

class MaintenanceTicketsCompanion extends UpdateCompanion<MaintenanceTicket> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<String> residentId;
  final Value<String> roomId;
  final Value<String> title;
  final Value<String> description;
  final Value<String> urgency;
  final Value<String> status;
  final Value<int?> cost;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MaintenanceTicketsCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.residentId = const Value.absent(),
    this.roomId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.urgency = const Value.absent(),
    this.status = const Value.absent(),
    this.cost = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MaintenanceTicketsCompanion.insert({
    required String id,
    required String organizationId,
    required String residentId,
    required String roomId,
    required String title,
    required String description,
    this.urgency = const Value.absent(),
    this.status = const Value.absent(),
    this.cost = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       residentId = Value(residentId),
       roomId = Value(roomId),
       title = Value(title),
       description = Value(description);
  static Insertable<MaintenanceTicket> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? residentId,
    Expression<String>? roomId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? urgency,
    Expression<String>? status,
    Expression<int>? cost,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (residentId != null) 'resident_id': residentId,
      if (roomId != null) 'room_id': roomId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (urgency != null) 'urgency': urgency,
      if (status != null) 'status': status,
      if (cost != null) 'cost': cost,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MaintenanceTicketsCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<String>? residentId,
    Value<String>? roomId,
    Value<String>? title,
    Value<String>? description,
    Value<String>? urgency,
    Value<String>? status,
    Value<int?>? cost,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return MaintenanceTicketsCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      residentId: residentId ?? this.residentId,
      roomId: roomId ?? this.roomId,
      title: title ?? this.title,
      description: description ?? this.description,
      urgency: urgency ?? this.urgency,
      status: status ?? this.status,
      cost: cost ?? this.cost,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (residentId.present) {
      map['resident_id'] = Variable<String>(residentId.value);
    }
    if (roomId.present) {
      map['room_id'] = Variable<String>(roomId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (urgency.present) {
      map['urgency'] = Variable<String>(urgency.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (cost.present) {
      map['cost'] = Variable<int>(cost.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceTicketsCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('residentId: $residentId, ')
          ..write('roomId: $roomId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('urgency: $urgency, ')
          ..write('status: $status, ')
          ..write('cost: $cost, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuditLogsTable extends AuditLogs
    with TableInfo<$AuditLogsTable, AuditLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES organizations (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_profiles (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ipAddressMeta = const VerificationMeta(
    'ipAddress',
  );
  @override
  late final GeneratedColumn<String> ipAddress = GeneratedColumn<String>(
    'ip_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    userId,
    action,
    description,
    ipAddress,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('ip_address')) {
      context.handle(
        _ipAddressMeta,
        ipAddress.isAcceptableOrUnknown(data['ip_address']!, _ipAddressMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      ipAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ip_address'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AuditLogsTable createAlias(String alias) {
    return $AuditLogsTable(attachedDatabase, alias);
  }
}

class AuditLog extends DataClass implements Insertable<AuditLog> {
  final String id;
  final String organizationId;
  final String userId;
  final String action;
  final String description;
  final String? ipAddress;
  final DateTime createdAt;
  const AuditLog({
    required this.id,
    required this.organizationId,
    required this.userId,
    required this.action,
    required this.description,
    this.ipAddress,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    map['user_id'] = Variable<String>(userId);
    map['action'] = Variable<String>(action);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || ipAddress != null) {
      map['ip_address'] = Variable<String>(ipAddress);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AuditLogsCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      userId: Value(userId),
      action: Value(action),
      description: Value(description),
      ipAddress: ipAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(ipAddress),
      createdAt: Value(createdAt),
    );
  }

  factory AuditLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLog(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      userId: serializer.fromJson<String>(json['userId']),
      action: serializer.fromJson<String>(json['action']),
      description: serializer.fromJson<String>(json['description']),
      ipAddress: serializer.fromJson<String?>(json['ipAddress']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'userId': serializer.toJson<String>(userId),
      'action': serializer.toJson<String>(action),
      'description': serializer.toJson<String>(description),
      'ipAddress': serializer.toJson<String?>(ipAddress),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AuditLog copyWith({
    String? id,
    String? organizationId,
    String? userId,
    String? action,
    String? description,
    Value<String?> ipAddress = const Value.absent(),
    DateTime? createdAt,
  }) => AuditLog(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    userId: userId ?? this.userId,
    action: action ?? this.action,
    description: description ?? this.description,
    ipAddress: ipAddress.present ? ipAddress.value : this.ipAddress,
    createdAt: createdAt ?? this.createdAt,
  );
  AuditLog copyWithCompanion(AuditLogsCompanion data) {
    return AuditLog(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      userId: data.userId.present ? data.userId.value : this.userId,
      action: data.action.present ? data.action.value : this.action,
      description: data.description.present
          ? data.description.value
          : this.description,
      ipAddress: data.ipAddress.present ? data.ipAddress.value : this.ipAddress,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLog(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('userId: $userId, ')
          ..write('action: $action, ')
          ..write('description: $description, ')
          ..write('ipAddress: $ipAddress, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    userId,
    action,
    description,
    ipAddress,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLog &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.userId == this.userId &&
          other.action == this.action &&
          other.description == this.description &&
          other.ipAddress == this.ipAddress &&
          other.createdAt == this.createdAt);
}

class AuditLogsCompanion extends UpdateCompanion<AuditLog> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<String> userId;
  final Value<String> action;
  final Value<String> description;
  final Value<String?> ipAddress;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AuditLogsCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.userId = const Value.absent(),
    this.action = const Value.absent(),
    this.description = const Value.absent(),
    this.ipAddress = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuditLogsCompanion.insert({
    required String id,
    required String organizationId,
    required String userId,
    required String action,
    required String description,
    this.ipAddress = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       userId = Value(userId),
       action = Value(action),
       description = Value(description);
  static Insertable<AuditLog> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? userId,
    Expression<String>? action,
    Expression<String>? description,
    Expression<String>? ipAddress,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (userId != null) 'user_id': userId,
      if (action != null) 'action': action,
      if (description != null) 'description': description,
      if (ipAddress != null) 'ip_address': ipAddress,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuditLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<String>? userId,
    Value<String>? action,
    Value<String>? description,
    Value<String?>? ipAddress,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return AuditLogsCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      userId: userId ?? this.userId,
      action: action ?? this.action,
      description: description ?? this.description,
      ipAddress: ipAddress ?? this.ipAddress,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (ipAddress.present) {
      map['ip_address'] = Variable<String>(ipAddress.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('userId: $userId, ')
          ..write('action: $action, ')
          ..write('description: $description, ')
          ..write('ipAddress: $ipAddress, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $OrganizationsTable organizations = $OrganizationsTable(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $PropertiesTable properties = $PropertiesTable(this);
  late final $PropertyManagersTable propertyManagers = $PropertyManagersTable(
    this,
  );
  late final $RoomsTable rooms = $RoomsTable(this);
  late final $ResidentsTable residents = $ResidentsTable(this);
  late final $ContractsTable contracts = $ContractsTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $PaymentItemsTable paymentItems = $PaymentItemsTable(this);
  late final $MaintenanceTicketsTable maintenanceTickets =
      $MaintenanceTicketsTable(this);
  late final $AuditLogsTable auditLogs = $AuditLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    organizations,
    userProfiles,
    properties,
    propertyManagers,
    rooms,
    residents,
    contracts,
    invoices,
    payments,
    paymentItems,
    maintenanceTickets,
    auditLogs,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'organizations',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('user_profiles', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'organizations',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('properties', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'user_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('property_managers', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'properties',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('property_managers', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'properties',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('rooms', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'organizations',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('residents', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'user_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('residents', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'organizations',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('contracts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'organizations',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('invoices', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'organizations',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('payments', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'payments',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('payment_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'organizations',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('maintenance_tickets', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'organizations',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('audit_logs', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$OrganizationsTableCreateCompanionBuilder =
    OrganizationsCompanion Function({
      required String id,
      required String name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$OrganizationsTableUpdateCompanionBuilder =
    OrganizationsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$OrganizationsTableReferences
    extends BaseReferences<_$AppDatabase, $OrganizationsTable, Organization> {
  $$OrganizationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$UserProfilesTable, List<UserProfile>>
  _userProfilesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userProfiles,
    aliasName: 'organizations__id__user_profiles__organization_id',
  );

  $$UserProfilesTableProcessedTableManager get userProfilesRefs {
    final manager = $$UserProfilesTableTableManager(
      $_db,
      $_db.userProfiles,
    ).filter((f) => f.organizationId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userProfilesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PropertiesTable, List<Property>>
  _propertiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.properties,
    aliasName: 'organizations__id__properties__organization_id',
  );

  $$PropertiesTableProcessedTableManager get propertiesRefs {
    final manager = $$PropertiesTableTableManager(
      $_db,
      $_db.properties,
    ).filter((f) => f.organizationId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_propertiesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ResidentsTable, List<Resident>>
  _residentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.residents,
    aliasName: 'organizations__id__residents__organization_id',
  );

  $$ResidentsTableProcessedTableManager get residentsRefs {
    final manager = $$ResidentsTableTableManager(
      $_db,
      $_db.residents,
    ).filter((f) => f.organizationId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_residentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ContractsTable, List<Contract>>
  _contractsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.contracts,
    aliasName: 'organizations__id__contracts__organization_id',
  );

  $$ContractsTableProcessedTableManager get contractsRefs {
    final manager = $$ContractsTableTableManager(
      $_db,
      $_db.contracts,
    ).filter((f) => f.organizationId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_contractsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: 'organizations__id__invoices__organization_id',
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.organizationId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: 'organizations__id__payments__organization_id',
  );

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.organizationId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MaintenanceTicketsTable, List<MaintenanceTicket>>
  _maintenanceTicketsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.maintenanceTickets,
        aliasName: 'organizations__id__maintenance_tickets__organization_id',
      );

  $$MaintenanceTicketsTableProcessedTableManager get maintenanceTicketsRefs {
    final manager = $$MaintenanceTicketsTableTableManager(
      $_db,
      $_db.maintenanceTickets,
    ).filter((f) => f.organizationId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _maintenanceTicketsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AuditLogsTable, List<AuditLog>>
  _auditLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.auditLogs,
    aliasName: 'organizations__id__audit_logs__organization_id',
  );

  $$AuditLogsTableProcessedTableManager get auditLogsRefs {
    final manager = $$AuditLogsTableTableManager(
      $_db,
      $_db.auditLogs,
    ).filter((f) => f.organizationId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_auditLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$OrganizationsTableFilterComposer
    extends Composer<_$AppDatabase, $OrganizationsTable> {
  $$OrganizationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userProfilesRefs(
    Expression<bool> Function($$UserProfilesTableFilterComposer f) f,
  ) {
    final $$UserProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.organizationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableFilterComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> propertiesRefs(
    Expression<bool> Function($$PropertiesTableFilterComposer f) f,
  ) {
    final $$PropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.organizationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableFilterComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> residentsRefs(
    Expression<bool> Function($$ResidentsTableFilterComposer f) f,
  ) {
    final $$ResidentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.residents,
      getReferencedColumn: (t) => t.organizationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResidentsTableFilterComposer(
            $db: $db,
            $table: $db.residents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> contractsRefs(
    Expression<bool> Function($$ContractsTableFilterComposer f) f,
  ) {
    final $$ContractsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.organizationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableFilterComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.organizationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentsRefs(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.organizationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> maintenanceTicketsRefs(
    Expression<bool> Function($$MaintenanceTicketsTableFilterComposer f) f,
  ) {
    final $$MaintenanceTicketsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenanceTickets,
      getReferencedColumn: (t) => t.organizationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceTicketsTableFilterComposer(
            $db: $db,
            $table: $db.maintenanceTickets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> auditLogsRefs(
    Expression<bool> Function($$AuditLogsTableFilterComposer f) f,
  ) {
    final $$AuditLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.auditLogs,
      getReferencedColumn: (t) => t.organizationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AuditLogsTableFilterComposer(
            $db: $db,
            $table: $db.auditLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrganizationsTableOrderingComposer
    extends Composer<_$AppDatabase, $OrganizationsTable> {
  $$OrganizationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrganizationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrganizationsTable> {
  $$OrganizationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> userProfilesRefs<T extends Object>(
    Expression<T> Function($$UserProfilesTableAnnotationComposer a) f,
  ) {
    final $$UserProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.organizationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> propertiesRefs<T extends Object>(
    Expression<T> Function($$PropertiesTableAnnotationComposer a) f,
  ) {
    final $$PropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.organizationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> residentsRefs<T extends Object>(
    Expression<T> Function($$ResidentsTableAnnotationComposer a) f,
  ) {
    final $$ResidentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.residents,
      getReferencedColumn: (t) => t.organizationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResidentsTableAnnotationComposer(
            $db: $db,
            $table: $db.residents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> contractsRefs<T extends Object>(
    Expression<T> Function($$ContractsTableAnnotationComposer a) f,
  ) {
    final $$ContractsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.organizationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableAnnotationComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.organizationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentsRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.organizationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> maintenanceTicketsRefs<T extends Object>(
    Expression<T> Function($$MaintenanceTicketsTableAnnotationComposer a) f,
  ) {
    final $$MaintenanceTicketsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.maintenanceTickets,
          getReferencedColumn: (t) => t.organizationId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MaintenanceTicketsTableAnnotationComposer(
                $db: $db,
                $table: $db.maintenanceTickets,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> auditLogsRefs<T extends Object>(
    Expression<T> Function($$AuditLogsTableAnnotationComposer a) f,
  ) {
    final $$AuditLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.auditLogs,
      getReferencedColumn: (t) => t.organizationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AuditLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.auditLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrganizationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrganizationsTable,
          Organization,
          $$OrganizationsTableFilterComposer,
          $$OrganizationsTableOrderingComposer,
          $$OrganizationsTableAnnotationComposer,
          $$OrganizationsTableCreateCompanionBuilder,
          $$OrganizationsTableUpdateCompanionBuilder,
          (Organization, $$OrganizationsTableReferences),
          Organization,
          PrefetchHooks Function({
            bool userProfilesRefs,
            bool propertiesRefs,
            bool residentsRefs,
            bool contractsRefs,
            bool invoicesRefs,
            bool paymentsRefs,
            bool maintenanceTicketsRefs,
            bool auditLogsRefs,
          })
        > {
  $$OrganizationsTableTableManager(_$AppDatabase db, $OrganizationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrganizationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrganizationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrganizationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrganizationsCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrganizationsCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$OrganizationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userProfilesRefs = false,
                propertiesRefs = false,
                residentsRefs = false,
                contractsRefs = false,
                invoicesRefs = false,
                paymentsRefs = false,
                maintenanceTicketsRefs = false,
                auditLogsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userProfilesRefs) db.userProfiles,
                    if (propertiesRefs) db.properties,
                    if (residentsRefs) db.residents,
                    if (contractsRefs) db.contracts,
                    if (invoicesRefs) db.invoices,
                    if (paymentsRefs) db.payments,
                    if (maintenanceTicketsRefs) db.maintenanceTickets,
                    if (auditLogsRefs) db.auditLogs,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userProfilesRefs)
                        await $_getPrefetchedData<
                          Organization,
                          $OrganizationsTable,
                          UserProfile
                        >(
                          currentTable: table,
                          referencedTable: $$OrganizationsTableReferences
                              ._userProfilesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrganizationsTableReferences(
                                db,
                                table,
                                p0,
                              ).userProfilesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.organizationId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (propertiesRefs)
                        await $_getPrefetchedData<
                          Organization,
                          $OrganizationsTable,
                          Property
                        >(
                          currentTable: table,
                          referencedTable: $$OrganizationsTableReferences
                              ._propertiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrganizationsTableReferences(
                                db,
                                table,
                                p0,
                              ).propertiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.organizationId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (residentsRefs)
                        await $_getPrefetchedData<
                          Organization,
                          $OrganizationsTable,
                          Resident
                        >(
                          currentTable: table,
                          referencedTable: $$OrganizationsTableReferences
                              ._residentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrganizationsTableReferences(
                                db,
                                table,
                                p0,
                              ).residentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.organizationId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (contractsRefs)
                        await $_getPrefetchedData<
                          Organization,
                          $OrganizationsTable,
                          Contract
                        >(
                          currentTable: table,
                          referencedTable: $$OrganizationsTableReferences
                              ._contractsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrganizationsTableReferences(
                                db,
                                table,
                                p0,
                              ).contractsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.organizationId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoicesRefs)
                        await $_getPrefetchedData<
                          Organization,
                          $OrganizationsTable,
                          Invoice
                        >(
                          currentTable: table,
                          referencedTable: $$OrganizationsTableReferences
                              ._invoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrganizationsTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.organizationId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentsRefs)
                        await $_getPrefetchedData<
                          Organization,
                          $OrganizationsTable,
                          Payment
                        >(
                          currentTable: table,
                          referencedTable: $$OrganizationsTableReferences
                              ._paymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrganizationsTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.organizationId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (maintenanceTicketsRefs)
                        await $_getPrefetchedData<
                          Organization,
                          $OrganizationsTable,
                          MaintenanceTicket
                        >(
                          currentTable: table,
                          referencedTable: $$OrganizationsTableReferences
                              ._maintenanceTicketsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrganizationsTableReferences(
                                db,
                                table,
                                p0,
                              ).maintenanceTicketsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.organizationId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (auditLogsRefs)
                        await $_getPrefetchedData<
                          Organization,
                          $OrganizationsTable,
                          AuditLog
                        >(
                          currentTable: table,
                          referencedTable: $$OrganizationsTableReferences
                              ._auditLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrganizationsTableReferences(
                                db,
                                table,
                                p0,
                              ).auditLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.organizationId == item.id,
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

typedef $$OrganizationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrganizationsTable,
      Organization,
      $$OrganizationsTableFilterComposer,
      $$OrganizationsTableOrderingComposer,
      $$OrganizationsTableAnnotationComposer,
      $$OrganizationsTableCreateCompanionBuilder,
      $$OrganizationsTableUpdateCompanionBuilder,
      (Organization, $$OrganizationsTableReferences),
      Organization,
      PrefetchHooks Function({
        bool userProfilesRefs,
        bool propertiesRefs,
        bool residentsRefs,
        bool contractsRefs,
        bool invoicesRefs,
        bool paymentsRefs,
        bool maintenanceTicketsRefs,
        bool auditLogsRefs,
      })
    >;
typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      required String id,
      required String organizationId,
      required String fullName,
      required String phoneNumber,
      required String email,
      required String role,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<String> fullName,
      Value<String> phoneNumber,
      Value<String> email,
      Value<String> role,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$UserProfilesTableReferences
    extends BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile> {
  $$UserProfilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrganizationsTable _organizationIdTable(_$AppDatabase db) => db
      .organizations
      .createAlias('user_profiles__organization_id__organizations__id');

  $$OrganizationsTableProcessedTableManager get organizationId {
    final $_column = $_itemColumn<String>('organization_id')!;

    final manager = $$OrganizationsTableTableManager(
      $_db,
      $_db.organizations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_organizationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PropertyManagersTable, List<PropertyManager>>
  _propertyManagersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.propertyManagers,
    aliasName: 'user_profiles__id__property_managers__user_id',
  );

  $$PropertyManagersTableProcessedTableManager get propertyManagersRefs {
    final manager = $$PropertyManagersTableTableManager(
      $_db,
      $_db.propertyManagers,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _propertyManagersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ResidentsTable, List<Resident>>
  _residentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.residents,
    aliasName: 'user_profiles__id__residents__user_id',
  );

  $$ResidentsTableProcessedTableManager get residentsRefs {
    final manager = $$ResidentsTableTableManager(
      $_db,
      $_db.residents,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_residentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AuditLogsTable, List<AuditLog>>
  _auditLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.auditLogs,
    aliasName: 'user_profiles__id__audit_logs__user_id',
  );

  $$AuditLogsTableProcessedTableManager get auditLogsRefs {
    final manager = $$AuditLogsTableTableManager(
      $_db,
      $_db.auditLogs,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_auditLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$OrganizationsTableFilterComposer get organizationId {
    final $$OrganizationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableFilterComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> propertyManagersRefs(
    Expression<bool> Function($$PropertyManagersTableFilterComposer f) f,
  ) {
    final $$PropertyManagersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.propertyManagers,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertyManagersTableFilterComposer(
            $db: $db,
            $table: $db.propertyManagers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> residentsRefs(
    Expression<bool> Function($$ResidentsTableFilterComposer f) f,
  ) {
    final $$ResidentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.residents,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResidentsTableFilterComposer(
            $db: $db,
            $table: $db.residents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> auditLogsRefs(
    Expression<bool> Function($$AuditLogsTableFilterComposer f) f,
  ) {
    final $$AuditLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.auditLogs,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AuditLogsTableFilterComposer(
            $db: $db,
            $table: $db.auditLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrganizationsTableOrderingComposer get organizationId {
    final $$OrganizationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableOrderingComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$OrganizationsTableAnnotationComposer get organizationId {
    final $$OrganizationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableAnnotationComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> propertyManagersRefs<T extends Object>(
    Expression<T> Function($$PropertyManagersTableAnnotationComposer a) f,
  ) {
    final $$PropertyManagersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.propertyManagers,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertyManagersTableAnnotationComposer(
            $db: $db,
            $table: $db.propertyManagers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> residentsRefs<T extends Object>(
    Expression<T> Function($$ResidentsTableAnnotationComposer a) f,
  ) {
    final $$ResidentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.residents,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResidentsTableAnnotationComposer(
            $db: $db,
            $table: $db.residents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> auditLogsRefs<T extends Object>(
    Expression<T> Function($$AuditLogsTableAnnotationComposer a) f,
  ) {
    final $$AuditLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.auditLogs,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AuditLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.auditLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          UserProfile,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (UserProfile, $$UserProfilesTableReferences),
          UserProfile,
          PrefetchHooks Function({
            bool organizationId,
            bool propertyManagersRefs,
            bool residentsRefs,
            bool auditLogsRefs,
          })
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesCompanion(
                id: id,
                organizationId: organizationId,
                fullName: fullName,
                phoneNumber: phoneNumber,
                email: email,
                role: role,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                required String fullName,
                required String phoneNumber,
                required String email,
                required String role,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesCompanion.insert(
                id: id,
                organizationId: organizationId,
                fullName: fullName,
                phoneNumber: phoneNumber,
                email: email,
                role: role,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                organizationId = false,
                propertyManagersRefs = false,
                residentsRefs = false,
                auditLogsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (propertyManagersRefs) db.propertyManagers,
                    if (residentsRefs) db.residents,
                    if (auditLogsRefs) db.auditLogs,
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
                        if (organizationId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.organizationId,
                                    referencedTable:
                                        $$UserProfilesTableReferences
                                            ._organizationIdTable(db),
                                    referencedColumn:
                                        $$UserProfilesTableReferences
                                            ._organizationIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (propertyManagersRefs)
                        await $_getPrefetchedData<
                          UserProfile,
                          $UserProfilesTable,
                          PropertyManager
                        >(
                          currentTable: table,
                          referencedTable: $$UserProfilesTableReferences
                              ._propertyManagersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).propertyManagersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (residentsRefs)
                        await $_getPrefetchedData<
                          UserProfile,
                          $UserProfilesTable,
                          Resident
                        >(
                          currentTable: table,
                          referencedTable: $$UserProfilesTableReferences
                              ._residentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).residentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (auditLogsRefs)
                        await $_getPrefetchedData<
                          UserProfile,
                          $UserProfilesTable,
                          AuditLog
                        >(
                          currentTable: table,
                          referencedTable: $$UserProfilesTableReferences
                              ._auditLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).auditLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
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

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      UserProfile,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (UserProfile, $$UserProfilesTableReferences),
      UserProfile,
      PrefetchHooks Function({
        bool organizationId,
        bool propertyManagersRefs,
        bool residentsRefs,
        bool auditLogsRefs,
      })
    >;
typedef $$PropertiesTableCreateCompanionBuilder =
    PropertiesCompanion Function({
      required String id,
      required String organizationId,
      required String name,
      required String address,
      required String type,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$PropertiesTableUpdateCompanionBuilder =
    PropertiesCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<String> name,
      Value<String> address,
      Value<String> type,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$PropertiesTableReferences
    extends BaseReferences<_$AppDatabase, $PropertiesTable, Property> {
  $$PropertiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrganizationsTable _organizationIdTable(_$AppDatabase db) => db
      .organizations
      .createAlias('properties__organization_id__organizations__id');

  $$OrganizationsTableProcessedTableManager get organizationId {
    final $_column = $_itemColumn<String>('organization_id')!;

    final manager = $$OrganizationsTableTableManager(
      $_db,
      $_db.organizations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_organizationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PropertyManagersTable, List<PropertyManager>>
  _propertyManagersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.propertyManagers,
    aliasName: 'properties__id__property_managers__property_id',
  );

  $$PropertyManagersTableProcessedTableManager get propertyManagersRefs {
    final manager = $$PropertyManagersTableTableManager(
      $_db,
      $_db.propertyManagers,
    ).filter((f) => f.propertyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _propertyManagersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RoomsTable, List<Room>> _roomsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.rooms,
    aliasName: 'properties__id__rooms__property_id',
  );

  $$RoomsTableProcessedTableManager get roomsRefs {
    final manager = $$RoomsTableTableManager(
      $_db,
      $_db.rooms,
    ).filter((f) => f.propertyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_roomsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PropertiesTableFilterComposer
    extends Composer<_$AppDatabase, $PropertiesTable> {
  $$PropertiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$OrganizationsTableFilterComposer get organizationId {
    final $$OrganizationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableFilterComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> propertyManagersRefs(
    Expression<bool> Function($$PropertyManagersTableFilterComposer f) f,
  ) {
    final $$PropertyManagersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.propertyManagers,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertyManagersTableFilterComposer(
            $db: $db,
            $table: $db.propertyManagers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> roomsRefs(
    Expression<bool> Function($$RoomsTableFilterComposer f) f,
  ) {
    final $$RoomsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rooms,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableFilterComposer(
            $db: $db,
            $table: $db.rooms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PropertiesTableOrderingComposer
    extends Composer<_$AppDatabase, $PropertiesTable> {
  $$PropertiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrganizationsTableOrderingComposer get organizationId {
    final $$OrganizationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableOrderingComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PropertiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PropertiesTable> {
  $$PropertiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$OrganizationsTableAnnotationComposer get organizationId {
    final $$OrganizationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableAnnotationComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> propertyManagersRefs<T extends Object>(
    Expression<T> Function($$PropertyManagersTableAnnotationComposer a) f,
  ) {
    final $$PropertyManagersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.propertyManagers,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertyManagersTableAnnotationComposer(
            $db: $db,
            $table: $db.propertyManagers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> roomsRefs<T extends Object>(
    Expression<T> Function($$RoomsTableAnnotationComposer a) f,
  ) {
    final $$RoomsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rooms,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableAnnotationComposer(
            $db: $db,
            $table: $db.rooms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PropertiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PropertiesTable,
          Property,
          $$PropertiesTableFilterComposer,
          $$PropertiesTableOrderingComposer,
          $$PropertiesTableAnnotationComposer,
          $$PropertiesTableCreateCompanionBuilder,
          $$PropertiesTableUpdateCompanionBuilder,
          (Property, $$PropertiesTableReferences),
          Property,
          PrefetchHooks Function({
            bool organizationId,
            bool propertyManagersRefs,
            bool roomsRefs,
          })
        > {
  $$PropertiesTableTableManager(_$AppDatabase db, $PropertiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PropertiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PropertiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PropertiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PropertiesCompanion(
                id: id,
                organizationId: organizationId,
                name: name,
                address: address,
                type: type,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                required String name,
                required String address,
                required String type,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PropertiesCompanion.insert(
                id: id,
                organizationId: organizationId,
                name: name,
                address: address,
                type: type,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PropertiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                organizationId = false,
                propertyManagersRefs = false,
                roomsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (propertyManagersRefs) db.propertyManagers,
                    if (roomsRefs) db.rooms,
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
                        if (organizationId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.organizationId,
                                    referencedTable: $$PropertiesTableReferences
                                        ._organizationIdTable(db),
                                    referencedColumn:
                                        $$PropertiesTableReferences
                                            ._organizationIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (propertyManagersRefs)
                        await $_getPrefetchedData<
                          Property,
                          $PropertiesTable,
                          PropertyManager
                        >(
                          currentTable: table,
                          referencedTable: $$PropertiesTableReferences
                              ._propertyManagersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PropertiesTableReferences(
                                db,
                                table,
                                p0,
                              ).propertyManagersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.propertyId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (roomsRefs)
                        await $_getPrefetchedData<
                          Property,
                          $PropertiesTable,
                          Room
                        >(
                          currentTable: table,
                          referencedTable: $$PropertiesTableReferences
                              ._roomsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PropertiesTableReferences(
                                db,
                                table,
                                p0,
                              ).roomsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.propertyId == item.id,
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

typedef $$PropertiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PropertiesTable,
      Property,
      $$PropertiesTableFilterComposer,
      $$PropertiesTableOrderingComposer,
      $$PropertiesTableAnnotationComposer,
      $$PropertiesTableCreateCompanionBuilder,
      $$PropertiesTableUpdateCompanionBuilder,
      (Property, $$PropertiesTableReferences),
      Property,
      PrefetchHooks Function({
        bool organizationId,
        bool propertyManagersRefs,
        bool roomsRefs,
      })
    >;
typedef $$PropertyManagersTableCreateCompanionBuilder =
    PropertyManagersCompanion Function({
      required String id,
      required String userId,
      required String propertyId,
      Value<DateTime> assignedAt,
      Value<int> rowid,
    });
typedef $$PropertyManagersTableUpdateCompanionBuilder =
    PropertyManagersCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> propertyId,
      Value<DateTime> assignedAt,
      Value<int> rowid,
    });

final class $$PropertyManagersTableReferences
    extends
        BaseReferences<_$AppDatabase, $PropertyManagersTable, PropertyManager> {
  $$PropertyManagersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserProfilesTable _userIdTable(_$AppDatabase db) => db.userProfiles
      .createAlias('property_managers__user_id__user_profiles__id');

  $$UserProfilesTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UserProfilesTableTableManager(
      $_db,
      $_db.userProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PropertiesTable _propertyIdTable(_$AppDatabase db) => db.properties
      .createAlias('property_managers__property_id__properties__id');

  $$PropertiesTableProcessedTableManager get propertyId {
    final $_column = $_itemColumn<String>('property_id')!;

    final manager = $$PropertiesTableTableManager(
      $_db,
      $_db.properties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_propertyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PropertyManagersTableFilterComposer
    extends Composer<_$AppDatabase, $PropertyManagersTable> {
  $$PropertyManagersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get assignedAt => $composableBuilder(
    column: $table.assignedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UserProfilesTableFilterComposer get userId {
    final $$UserProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableFilterComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PropertiesTableFilterComposer get propertyId {
    final $$PropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableFilterComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PropertyManagersTableOrderingComposer
    extends Composer<_$AppDatabase, $PropertyManagersTable> {
  $$PropertyManagersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get assignedAt => $composableBuilder(
    column: $table.assignedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserProfilesTableOrderingComposer get userId {
    final $$UserProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PropertiesTableOrderingComposer get propertyId {
    final $$PropertiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableOrderingComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PropertyManagersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PropertyManagersTable> {
  $$PropertyManagersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get assignedAt => $composableBuilder(
    column: $table.assignedAt,
    builder: (column) => column,
  );

  $$UserProfilesTableAnnotationComposer get userId {
    final $$UserProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PropertiesTableAnnotationComposer get propertyId {
    final $$PropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PropertyManagersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PropertyManagersTable,
          PropertyManager,
          $$PropertyManagersTableFilterComposer,
          $$PropertyManagersTableOrderingComposer,
          $$PropertyManagersTableAnnotationComposer,
          $$PropertyManagersTableCreateCompanionBuilder,
          $$PropertyManagersTableUpdateCompanionBuilder,
          (PropertyManager, $$PropertyManagersTableReferences),
          PropertyManager,
          PrefetchHooks Function({bool userId, bool propertyId})
        > {
  $$PropertyManagersTableTableManager(
    _$AppDatabase db,
    $PropertyManagersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PropertyManagersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PropertyManagersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PropertyManagersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> propertyId = const Value.absent(),
                Value<DateTime> assignedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PropertyManagersCompanion(
                id: id,
                userId: userId,
                propertyId: propertyId,
                assignedAt: assignedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String propertyId,
                Value<DateTime> assignedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PropertyManagersCompanion.insert(
                id: id,
                userId: userId,
                propertyId: propertyId,
                assignedAt: assignedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PropertyManagersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false, propertyId = false}) {
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
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable:
                                    $$PropertyManagersTableReferences
                                        ._userIdTable(db),
                                referencedColumn:
                                    $$PropertyManagersTableReferences
                                        ._userIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (propertyId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.propertyId,
                                referencedTable:
                                    $$PropertyManagersTableReferences
                                        ._propertyIdTable(db),
                                referencedColumn:
                                    $$PropertyManagersTableReferences
                                        ._propertyIdTable(db)
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

typedef $$PropertyManagersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PropertyManagersTable,
      PropertyManager,
      $$PropertyManagersTableFilterComposer,
      $$PropertyManagersTableOrderingComposer,
      $$PropertyManagersTableAnnotationComposer,
      $$PropertyManagersTableCreateCompanionBuilder,
      $$PropertyManagersTableUpdateCompanionBuilder,
      (PropertyManager, $$PropertyManagersTableReferences),
      PropertyManager,
      PrefetchHooks Function({bool userId, bool propertyId})
    >;
typedef $$RoomsTableCreateCompanionBuilder =
    RoomsCompanion Function({
      required String id,
      required String propertyId,
      required String roomNumber,
      Value<String?> buildingName,
      Value<String?> floorName,
      required int pricePerMonth,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$RoomsTableUpdateCompanionBuilder =
    RoomsCompanion Function({
      Value<String> id,
      Value<String> propertyId,
      Value<String> roomNumber,
      Value<String?> buildingName,
      Value<String?> floorName,
      Value<int> pricePerMonth,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$RoomsTableReferences
    extends BaseReferences<_$AppDatabase, $RoomsTable, Room> {
  $$RoomsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PropertiesTable _propertyIdTable(_$AppDatabase db) =>
      db.properties.createAlias('rooms__property_id__properties__id');

  $$PropertiesTableProcessedTableManager get propertyId {
    final $_column = $_itemColumn<String>('property_id')!;

    final manager = $$PropertiesTableTableManager(
      $_db,
      $_db.properties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_propertyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ContractsTable, List<Contract>>
  _contractsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.contracts,
    aliasName: 'rooms__id__contracts__room_id',
  );

  $$ContractsTableProcessedTableManager get contractsRefs {
    final manager = $$ContractsTableTableManager(
      $_db,
      $_db.contracts,
    ).filter((f) => f.roomId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_contractsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MaintenanceTicketsTable, List<MaintenanceTicket>>
  _maintenanceTicketsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.maintenanceTickets,
        aliasName: 'rooms__id__maintenance_tickets__room_id',
      );

  $$MaintenanceTicketsTableProcessedTableManager get maintenanceTicketsRefs {
    final manager = $$MaintenanceTicketsTableTableManager(
      $_db,
      $_db.maintenanceTickets,
    ).filter((f) => f.roomId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _maintenanceTicketsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoomsTableFilterComposer extends Composer<_$AppDatabase, $RoomsTable> {
  $$RoomsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roomNumber => $composableBuilder(
    column: $table.roomNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get buildingName => $composableBuilder(
    column: $table.buildingName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get floorName => $composableBuilder(
    column: $table.floorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pricePerMonth => $composableBuilder(
    column: $table.pricePerMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PropertiesTableFilterComposer get propertyId {
    final $$PropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableFilterComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> contractsRefs(
    Expression<bool> Function($$ContractsTableFilterComposer f) f,
  ) {
    final $$ContractsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.roomId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableFilterComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> maintenanceTicketsRefs(
    Expression<bool> Function($$MaintenanceTicketsTableFilterComposer f) f,
  ) {
    final $$MaintenanceTicketsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenanceTickets,
      getReferencedColumn: (t) => t.roomId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceTicketsTableFilterComposer(
            $db: $db,
            $table: $db.maintenanceTickets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoomsTableOrderingComposer
    extends Composer<_$AppDatabase, $RoomsTable> {
  $$RoomsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roomNumber => $composableBuilder(
    column: $table.roomNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get buildingName => $composableBuilder(
    column: $table.buildingName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get floorName => $composableBuilder(
    column: $table.floorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pricePerMonth => $composableBuilder(
    column: $table.pricePerMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PropertiesTableOrderingComposer get propertyId {
    final $$PropertiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableOrderingComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoomsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoomsTable> {
  $$RoomsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get roomNumber => $composableBuilder(
    column: $table.roomNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get buildingName => $composableBuilder(
    column: $table.buildingName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get floorName =>
      $composableBuilder(column: $table.floorName, builder: (column) => column);

  GeneratedColumn<int> get pricePerMonth => $composableBuilder(
    column: $table.pricePerMonth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PropertiesTableAnnotationComposer get propertyId {
    final $$PropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> contractsRefs<T extends Object>(
    Expression<T> Function($$ContractsTableAnnotationComposer a) f,
  ) {
    final $$ContractsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.roomId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableAnnotationComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> maintenanceTicketsRefs<T extends Object>(
    Expression<T> Function($$MaintenanceTicketsTableAnnotationComposer a) f,
  ) {
    final $$MaintenanceTicketsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.maintenanceTickets,
          getReferencedColumn: (t) => t.roomId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MaintenanceTicketsTableAnnotationComposer(
                $db: $db,
                $table: $db.maintenanceTickets,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RoomsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoomsTable,
          Room,
          $$RoomsTableFilterComposer,
          $$RoomsTableOrderingComposer,
          $$RoomsTableAnnotationComposer,
          $$RoomsTableCreateCompanionBuilder,
          $$RoomsTableUpdateCompanionBuilder,
          (Room, $$RoomsTableReferences),
          Room,
          PrefetchHooks Function({
            bool propertyId,
            bool contractsRefs,
            bool maintenanceTicketsRefs,
          })
        > {
  $$RoomsTableTableManager(_$AppDatabase db, $RoomsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoomsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoomsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoomsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> propertyId = const Value.absent(),
                Value<String> roomNumber = const Value.absent(),
                Value<String?> buildingName = const Value.absent(),
                Value<String?> floorName = const Value.absent(),
                Value<int> pricePerMonth = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoomsCompanion(
                id: id,
                propertyId: propertyId,
                roomNumber: roomNumber,
                buildingName: buildingName,
                floorName: floorName,
                pricePerMonth: pricePerMonth,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String propertyId,
                required String roomNumber,
                Value<String?> buildingName = const Value.absent(),
                Value<String?> floorName = const Value.absent(),
                required int pricePerMonth,
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoomsCompanion.insert(
                id: id,
                propertyId: propertyId,
                roomNumber: roomNumber,
                buildingName: buildingName,
                floorName: floorName,
                pricePerMonth: pricePerMonth,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$RoomsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                propertyId = false,
                contractsRefs = false,
                maintenanceTicketsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (contractsRefs) db.contracts,
                    if (maintenanceTicketsRefs) db.maintenanceTickets,
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
                        if (propertyId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.propertyId,
                                    referencedTable: $$RoomsTableReferences
                                        ._propertyIdTable(db),
                                    referencedColumn: $$RoomsTableReferences
                                        ._propertyIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (contractsRefs)
                        await $_getPrefetchedData<Room, $RoomsTable, Contract>(
                          currentTable: table,
                          referencedTable: $$RoomsTableReferences
                              ._contractsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RoomsTableReferences(
                                db,
                                table,
                                p0,
                              ).contractsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.roomId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (maintenanceTicketsRefs)
                        await $_getPrefetchedData<
                          Room,
                          $RoomsTable,
                          MaintenanceTicket
                        >(
                          currentTable: table,
                          referencedTable: $$RoomsTableReferences
                              ._maintenanceTicketsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RoomsTableReferences(
                                db,
                                table,
                                p0,
                              ).maintenanceTicketsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.roomId == item.id,
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

typedef $$RoomsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoomsTable,
      Room,
      $$RoomsTableFilterComposer,
      $$RoomsTableOrderingComposer,
      $$RoomsTableAnnotationComposer,
      $$RoomsTableCreateCompanionBuilder,
      $$RoomsTableUpdateCompanionBuilder,
      (Room, $$RoomsTableReferences),
      Room,
      PrefetchHooks Function({
        bool propertyId,
        bool contractsRefs,
        bool maintenanceTicketsRefs,
      })
    >;
typedef $$ResidentsTableCreateCompanionBuilder =
    ResidentsCompanion Function({
      required String id,
      required String organizationId,
      Value<String?> userId,
      required String fullName,
      required String phoneNumber,
      Value<String?> email,
      Value<String?> idCardNumber,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$ResidentsTableUpdateCompanionBuilder =
    ResidentsCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<String?> userId,
      Value<String> fullName,
      Value<String> phoneNumber,
      Value<String?> email,
      Value<String?> idCardNumber,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$ResidentsTableReferences
    extends BaseReferences<_$AppDatabase, $ResidentsTable, Resident> {
  $$ResidentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrganizationsTable _organizationIdTable(_$AppDatabase db) => db
      .organizations
      .createAlias('residents__organization_id__organizations__id');

  $$OrganizationsTableProcessedTableManager get organizationId {
    final $_column = $_itemColumn<String>('organization_id')!;

    final manager = $$OrganizationsTableTableManager(
      $_db,
      $_db.organizations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_organizationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UserProfilesTable _userIdTable(_$AppDatabase db) =>
      db.userProfiles.createAlias('residents__user_id__user_profiles__id');

  $$UserProfilesTableProcessedTableManager? get userId {
    final $_column = $_itemColumn<String>('user_id');
    if ($_column == null) return null;
    final manager = $$UserProfilesTableTableManager(
      $_db,
      $_db.userProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ContractsTable, List<Contract>>
  _contractsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.contracts,
    aliasName: 'residents__id__contracts__resident_id',
  );

  $$ContractsTableProcessedTableManager get contractsRefs {
    final manager = $$ContractsTableTableManager(
      $_db,
      $_db.contracts,
    ).filter((f) => f.residentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_contractsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MaintenanceTicketsTable, List<MaintenanceTicket>>
  _maintenanceTicketsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.maintenanceTickets,
        aliasName: 'residents__id__maintenance_tickets__resident_id',
      );

  $$MaintenanceTicketsTableProcessedTableManager get maintenanceTicketsRefs {
    final manager = $$MaintenanceTicketsTableTableManager(
      $_db,
      $_db.maintenanceTickets,
    ).filter((f) => f.residentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _maintenanceTicketsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ResidentsTableFilterComposer
    extends Composer<_$AppDatabase, $ResidentsTable> {
  $$ResidentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idCardNumber => $composableBuilder(
    column: $table.idCardNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$OrganizationsTableFilterComposer get organizationId {
    final $$OrganizationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableFilterComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserProfilesTableFilterComposer get userId {
    final $$UserProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableFilterComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> contractsRefs(
    Expression<bool> Function($$ContractsTableFilterComposer f) f,
  ) {
    final $$ContractsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.residentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableFilterComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> maintenanceTicketsRefs(
    Expression<bool> Function($$MaintenanceTicketsTableFilterComposer f) f,
  ) {
    final $$MaintenanceTicketsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenanceTickets,
      getReferencedColumn: (t) => t.residentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceTicketsTableFilterComposer(
            $db: $db,
            $table: $db.maintenanceTickets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ResidentsTableOrderingComposer
    extends Composer<_$AppDatabase, $ResidentsTable> {
  $$ResidentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idCardNumber => $composableBuilder(
    column: $table.idCardNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrganizationsTableOrderingComposer get organizationId {
    final $$OrganizationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableOrderingComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserProfilesTableOrderingComposer get userId {
    final $$UserProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ResidentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ResidentsTable> {
  $$ResidentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get idCardNumber => $composableBuilder(
    column: $table.idCardNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$OrganizationsTableAnnotationComposer get organizationId {
    final $$OrganizationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableAnnotationComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserProfilesTableAnnotationComposer get userId {
    final $$UserProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> contractsRefs<T extends Object>(
    Expression<T> Function($$ContractsTableAnnotationComposer a) f,
  ) {
    final $$ContractsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.residentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableAnnotationComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> maintenanceTicketsRefs<T extends Object>(
    Expression<T> Function($$MaintenanceTicketsTableAnnotationComposer a) f,
  ) {
    final $$MaintenanceTicketsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.maintenanceTickets,
          getReferencedColumn: (t) => t.residentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MaintenanceTicketsTableAnnotationComposer(
                $db: $db,
                $table: $db.maintenanceTickets,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ResidentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ResidentsTable,
          Resident,
          $$ResidentsTableFilterComposer,
          $$ResidentsTableOrderingComposer,
          $$ResidentsTableAnnotationComposer,
          $$ResidentsTableCreateCompanionBuilder,
          $$ResidentsTableUpdateCompanionBuilder,
          (Resident, $$ResidentsTableReferences),
          Resident,
          PrefetchHooks Function({
            bool organizationId,
            bool userId,
            bool contractsRefs,
            bool maintenanceTicketsRefs,
          })
        > {
  $$ResidentsTableTableManager(_$AppDatabase db, $ResidentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ResidentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ResidentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ResidentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> idCardNumber = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ResidentsCompanion(
                id: id,
                organizationId: organizationId,
                userId: userId,
                fullName: fullName,
                phoneNumber: phoneNumber,
                email: email,
                idCardNumber: idCardNumber,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                Value<String?> userId = const Value.absent(),
                required String fullName,
                required String phoneNumber,
                Value<String?> email = const Value.absent(),
                Value<String?> idCardNumber = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ResidentsCompanion.insert(
                id: id,
                organizationId: organizationId,
                userId: userId,
                fullName: fullName,
                phoneNumber: phoneNumber,
                email: email,
                idCardNumber: idCardNumber,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ResidentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                organizationId = false,
                userId = false,
                contractsRefs = false,
                maintenanceTicketsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (contractsRefs) db.contracts,
                    if (maintenanceTicketsRefs) db.maintenanceTickets,
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
                        if (organizationId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.organizationId,
                                    referencedTable: $$ResidentsTableReferences
                                        ._organizationIdTable(db),
                                    referencedColumn: $$ResidentsTableReferences
                                        ._organizationIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (userId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userId,
                                    referencedTable: $$ResidentsTableReferences
                                        ._userIdTable(db),
                                    referencedColumn: $$ResidentsTableReferences
                                        ._userIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (contractsRefs)
                        await $_getPrefetchedData<
                          Resident,
                          $ResidentsTable,
                          Contract
                        >(
                          currentTable: table,
                          referencedTable: $$ResidentsTableReferences
                              ._contractsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ResidentsTableReferences(
                                db,
                                table,
                                p0,
                              ).contractsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.residentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (maintenanceTicketsRefs)
                        await $_getPrefetchedData<
                          Resident,
                          $ResidentsTable,
                          MaintenanceTicket
                        >(
                          currentTable: table,
                          referencedTable: $$ResidentsTableReferences
                              ._maintenanceTicketsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ResidentsTableReferences(
                                db,
                                table,
                                p0,
                              ).maintenanceTicketsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.residentId == item.id,
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

typedef $$ResidentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ResidentsTable,
      Resident,
      $$ResidentsTableFilterComposer,
      $$ResidentsTableOrderingComposer,
      $$ResidentsTableAnnotationComposer,
      $$ResidentsTableCreateCompanionBuilder,
      $$ResidentsTableUpdateCompanionBuilder,
      (Resident, $$ResidentsTableReferences),
      Resident,
      PrefetchHooks Function({
        bool organizationId,
        bool userId,
        bool contractsRefs,
        bool maintenanceTicketsRefs,
      })
    >;
typedef $$ContractsTableCreateCompanionBuilder =
    ContractsCompanion Function({
      required String id,
      required String organizationId,
      required String residentId,
      required String roomId,
      required DateTime startDate,
      required DateTime endDate,
      Value<String> billingCycle,
      required int pricePerCycle,
      Value<int> depositAmount,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$ContractsTableUpdateCompanionBuilder =
    ContractsCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<String> residentId,
      Value<String> roomId,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<String> billingCycle,
      Value<int> pricePerCycle,
      Value<int> depositAmount,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$ContractsTableReferences
    extends BaseReferences<_$AppDatabase, $ContractsTable, Contract> {
  $$ContractsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrganizationsTable _organizationIdTable(_$AppDatabase db) => db
      .organizations
      .createAlias('contracts__organization_id__organizations__id');

  $$OrganizationsTableProcessedTableManager get organizationId {
    final $_column = $_itemColumn<String>('organization_id')!;

    final manager = $$OrganizationsTableTableManager(
      $_db,
      $_db.organizations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_organizationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ResidentsTable _residentIdTable(_$AppDatabase db) =>
      db.residents.createAlias('contracts__resident_id__residents__id');

  $$ResidentsTableProcessedTableManager get residentId {
    final $_column = $_itemColumn<String>('resident_id')!;

    final manager = $$ResidentsTableTableManager(
      $_db,
      $_db.residents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_residentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RoomsTable _roomIdTable(_$AppDatabase db) =>
      db.rooms.createAlias('contracts__room_id__rooms__id');

  $$RoomsTableProcessedTableManager get roomId {
    final $_column = $_itemColumn<String>('room_id')!;

    final manager = $$RoomsTableTableManager(
      $_db,
      $_db.rooms,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roomIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: 'contracts__id__invoices__contract_id',
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.contractId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ContractsTableFilterComposer
    extends Composer<_$AppDatabase, $ContractsTable> {
  $$ContractsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billingCycle => $composableBuilder(
    column: $table.billingCycle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pricePerCycle => $composableBuilder(
    column: $table.pricePerCycle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get depositAmount => $composableBuilder(
    column: $table.depositAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$OrganizationsTableFilterComposer get organizationId {
    final $$OrganizationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableFilterComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ResidentsTableFilterComposer get residentId {
    final $$ResidentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.residentId,
      referencedTable: $db.residents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResidentsTableFilterComposer(
            $db: $db,
            $table: $db.residents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoomsTableFilterComposer get roomId {
    final $$RoomsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roomId,
      referencedTable: $db.rooms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableFilterComposer(
            $db: $db,
            $table: $db.rooms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.contractId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContractsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContractsTable> {
  $$ContractsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billingCycle => $composableBuilder(
    column: $table.billingCycle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pricePerCycle => $composableBuilder(
    column: $table.pricePerCycle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get depositAmount => $composableBuilder(
    column: $table.depositAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrganizationsTableOrderingComposer get organizationId {
    final $$OrganizationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableOrderingComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ResidentsTableOrderingComposer get residentId {
    final $$ResidentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.residentId,
      referencedTable: $db.residents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResidentsTableOrderingComposer(
            $db: $db,
            $table: $db.residents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoomsTableOrderingComposer get roomId {
    final $$RoomsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roomId,
      referencedTable: $db.rooms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableOrderingComposer(
            $db: $db,
            $table: $db.rooms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContractsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContractsTable> {
  $$ContractsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get billingCycle => $composableBuilder(
    column: $table.billingCycle,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pricePerCycle => $composableBuilder(
    column: $table.pricePerCycle,
    builder: (column) => column,
  );

  GeneratedColumn<int> get depositAmount => $composableBuilder(
    column: $table.depositAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$OrganizationsTableAnnotationComposer get organizationId {
    final $$OrganizationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableAnnotationComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ResidentsTableAnnotationComposer get residentId {
    final $$ResidentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.residentId,
      referencedTable: $db.residents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResidentsTableAnnotationComposer(
            $db: $db,
            $table: $db.residents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoomsTableAnnotationComposer get roomId {
    final $$RoomsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roomId,
      referencedTable: $db.rooms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableAnnotationComposer(
            $db: $db,
            $table: $db.rooms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.contractId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContractsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContractsTable,
          Contract,
          $$ContractsTableFilterComposer,
          $$ContractsTableOrderingComposer,
          $$ContractsTableAnnotationComposer,
          $$ContractsTableCreateCompanionBuilder,
          $$ContractsTableUpdateCompanionBuilder,
          (Contract, $$ContractsTableReferences),
          Contract,
          PrefetchHooks Function({
            bool organizationId,
            bool residentId,
            bool roomId,
            bool invoicesRefs,
          })
        > {
  $$ContractsTableTableManager(_$AppDatabase db, $ContractsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContractsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContractsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContractsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<String> residentId = const Value.absent(),
                Value<String> roomId = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<String> billingCycle = const Value.absent(),
                Value<int> pricePerCycle = const Value.absent(),
                Value<int> depositAmount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContractsCompanion(
                id: id,
                organizationId: organizationId,
                residentId: residentId,
                roomId: roomId,
                startDate: startDate,
                endDate: endDate,
                billingCycle: billingCycle,
                pricePerCycle: pricePerCycle,
                depositAmount: depositAmount,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                required String residentId,
                required String roomId,
                required DateTime startDate,
                required DateTime endDate,
                Value<String> billingCycle = const Value.absent(),
                required int pricePerCycle,
                Value<int> depositAmount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContractsCompanion.insert(
                id: id,
                organizationId: organizationId,
                residentId: residentId,
                roomId: roomId,
                startDate: startDate,
                endDate: endDate,
                billingCycle: billingCycle,
                pricePerCycle: pricePerCycle,
                depositAmount: depositAmount,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ContractsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                organizationId = false,
                residentId = false,
                roomId = false,
                invoicesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (invoicesRefs) db.invoices],
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
                        if (organizationId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.organizationId,
                                    referencedTable: $$ContractsTableReferences
                                        ._organizationIdTable(db),
                                    referencedColumn: $$ContractsTableReferences
                                        ._organizationIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (residentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.residentId,
                                    referencedTable: $$ContractsTableReferences
                                        ._residentIdTable(db),
                                    referencedColumn: $$ContractsTableReferences
                                        ._residentIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (roomId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.roomId,
                                    referencedTable: $$ContractsTableReferences
                                        ._roomIdTable(db),
                                    referencedColumn: $$ContractsTableReferences
                                        ._roomIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (invoicesRefs)
                        await $_getPrefetchedData<
                          Contract,
                          $ContractsTable,
                          Invoice
                        >(
                          currentTable: table,
                          referencedTable: $$ContractsTableReferences
                              ._invoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ContractsTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.contractId == item.id,
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

typedef $$ContractsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContractsTable,
      Contract,
      $$ContractsTableFilterComposer,
      $$ContractsTableOrderingComposer,
      $$ContractsTableAnnotationComposer,
      $$ContractsTableCreateCompanionBuilder,
      $$ContractsTableUpdateCompanionBuilder,
      (Contract, $$ContractsTableReferences),
      Contract,
      PrefetchHooks Function({
        bool organizationId,
        bool residentId,
        bool roomId,
        bool invoicesRefs,
      })
    >;
typedef $$InvoicesTableCreateCompanionBuilder =
    InvoicesCompanion Function({
      required String id,
      required String organizationId,
      required String contractId,
      required String invoiceNumber,
      required DateTime dueDate,
      required int amountDue,
      Value<int> amountPaid,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$InvoicesTableUpdateCompanionBuilder =
    InvoicesCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<String> contractId,
      Value<String> invoiceNumber,
      Value<DateTime> dueDate,
      Value<int> amountDue,
      Value<int> amountPaid,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$InvoicesTableReferences
    extends BaseReferences<_$AppDatabase, $InvoicesTable, Invoice> {
  $$InvoicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrganizationsTable _organizationIdTable(_$AppDatabase db) => db
      .organizations
      .createAlias('invoices__organization_id__organizations__id');

  $$OrganizationsTableProcessedTableManager get organizationId {
    final $_column = $_itemColumn<String>('organization_id')!;

    final manager = $$OrganizationsTableTableManager(
      $_db,
      $_db.organizations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_organizationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ContractsTable _contractIdTable(_$AppDatabase db) =>
      db.contracts.createAlias('invoices__contract_id__contracts__id');

  $$ContractsTableProcessedTableManager get contractId {
    final $_column = $_itemColumn<String>('contract_id')!;

    final manager = $$ContractsTableTableManager(
      $_db,
      $_db.contracts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contractIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PaymentItemsTable, List<PaymentItem>>
  _paymentItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.paymentItems,
    aliasName: 'invoices__id__payment_items__invoice_id',
  );

  $$PaymentItemsTableProcessedTableManager get paymentItemsRefs {
    final manager = $$PaymentItemsTableTableManager(
      $_db,
      $_db.paymentItems,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountDue => $composableBuilder(
    column: $table.amountDue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$OrganizationsTableFilterComposer get organizationId {
    final $$OrganizationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableFilterComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContractsTableFilterComposer get contractId {
    final $$ContractsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contractId,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableFilterComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> paymentItemsRefs(
    Expression<bool> Function($$PaymentItemsTableFilterComposer f) f,
  ) {
    final $$PaymentItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentItems,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentItemsTableFilterComposer(
            $db: $db,
            $table: $db.paymentItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountDue => $composableBuilder(
    column: $table.amountDue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrganizationsTableOrderingComposer get organizationId {
    final $$OrganizationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableOrderingComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContractsTableOrderingComposer get contractId {
    final $$ContractsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contractId,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableOrderingComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<int> get amountDue =>
      $composableBuilder(column: $table.amountDue, builder: (column) => column);

  GeneratedColumn<int> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$OrganizationsTableAnnotationComposer get organizationId {
    final $$OrganizationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableAnnotationComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContractsTableAnnotationComposer get contractId {
    final $$ContractsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contractId,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableAnnotationComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> paymentItemsRefs<T extends Object>(
    Expression<T> Function($$PaymentItemsTableAnnotationComposer a) f,
  ) {
    final $$PaymentItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentItems,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicesTable,
          Invoice,
          $$InvoicesTableFilterComposer,
          $$InvoicesTableOrderingComposer,
          $$InvoicesTableAnnotationComposer,
          $$InvoicesTableCreateCompanionBuilder,
          $$InvoicesTableUpdateCompanionBuilder,
          (Invoice, $$InvoicesTableReferences),
          Invoice,
          PrefetchHooks Function({
            bool organizationId,
            bool contractId,
            bool paymentItemsRefs,
          })
        > {
  $$InvoicesTableTableManager(_$AppDatabase db, $InvoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<String> contractId = const Value.absent(),
                Value<String> invoiceNumber = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<int> amountDue = const Value.absent(),
                Value<int> amountPaid = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoicesCompanion(
                id: id,
                organizationId: organizationId,
                contractId: contractId,
                invoiceNumber: invoiceNumber,
                dueDate: dueDate,
                amountDue: amountDue,
                amountPaid: amountPaid,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                required String contractId,
                required String invoiceNumber,
                required DateTime dueDate,
                required int amountDue,
                Value<int> amountPaid = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoicesCompanion.insert(
                id: id,
                organizationId: organizationId,
                contractId: contractId,
                invoiceNumber: invoiceNumber,
                dueDate: dueDate,
                amountDue: amountDue,
                amountPaid: amountPaid,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvoicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                organizationId = false,
                contractId = false,
                paymentItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (paymentItemsRefs) db.paymentItems,
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
                        if (organizationId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.organizationId,
                                    referencedTable: $$InvoicesTableReferences
                                        ._organizationIdTable(db),
                                    referencedColumn: $$InvoicesTableReferences
                                        ._organizationIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (contractId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.contractId,
                                    referencedTable: $$InvoicesTableReferences
                                        ._contractIdTable(db),
                                    referencedColumn: $$InvoicesTableReferences
                                        ._contractIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (paymentItemsRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          $InvoicesTable,
                          PaymentItem
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._paymentItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
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

typedef $$InvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicesTable,
      Invoice,
      $$InvoicesTableFilterComposer,
      $$InvoicesTableOrderingComposer,
      $$InvoicesTableAnnotationComposer,
      $$InvoicesTableCreateCompanionBuilder,
      $$InvoicesTableUpdateCompanionBuilder,
      (Invoice, $$InvoicesTableReferences),
      Invoice,
      PrefetchHooks Function({
        bool organizationId,
        bool contractId,
        bool paymentItemsRefs,
      })
    >;
typedef $$PaymentsTableCreateCompanionBuilder =
    PaymentsCompanion Function({
      required String id,
      required String organizationId,
      Value<DateTime> paymentDate,
      required int amount,
      required String paymentMethod,
      Value<String?> proofUrl,
      Value<bool> verified,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$PaymentsTableUpdateCompanionBuilder =
    PaymentsCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<DateTime> paymentDate,
      Value<int> amount,
      Value<String> paymentMethod,
      Value<String?> proofUrl,
      Value<bool> verified,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$PaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentsTable, Payment> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrganizationsTable _organizationIdTable(_$AppDatabase db) => db
      .organizations
      .createAlias('payments__organization_id__organizations__id');

  $$OrganizationsTableProcessedTableManager get organizationId {
    final $_column = $_itemColumn<String>('organization_id')!;

    final manager = $$OrganizationsTableTableManager(
      $_db,
      $_db.organizations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_organizationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PaymentItemsTable, List<PaymentItem>>
  _paymentItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.paymentItems,
    aliasName: 'payments__id__payment_items__payment_id',
  );

  $$PaymentItemsTableProcessedTableManager get paymentItemsRefs {
    final manager = $$PaymentItemsTableTableManager(
      $_db,
      $_db.paymentItems,
    ).filter((f) => f.paymentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proofUrl => $composableBuilder(
    column: $table.proofUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get verified => $composableBuilder(
    column: $table.verified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$OrganizationsTableFilterComposer get organizationId {
    final $$OrganizationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableFilterComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> paymentItemsRefs(
    Expression<bool> Function($$PaymentItemsTableFilterComposer f) f,
  ) {
    final $$PaymentItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentItems,
      getReferencedColumn: (t) => t.paymentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentItemsTableFilterComposer(
            $db: $db,
            $table: $db.paymentItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proofUrl => $composableBuilder(
    column: $table.proofUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get verified => $composableBuilder(
    column: $table.verified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrganizationsTableOrderingComposer get organizationId {
    final $$OrganizationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableOrderingComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get proofUrl =>
      $composableBuilder(column: $table.proofUrl, builder: (column) => column);

  GeneratedColumn<bool> get verified =>
      $composableBuilder(column: $table.verified, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$OrganizationsTableAnnotationComposer get organizationId {
    final $$OrganizationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableAnnotationComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> paymentItemsRefs<T extends Object>(
    Expression<T> Function($$PaymentItemsTableAnnotationComposer a) f,
  ) {
    final $$PaymentItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentItems,
      getReferencedColumn: (t) => t.paymentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentsTable,
          Payment,
          $$PaymentsTableFilterComposer,
          $$PaymentsTableOrderingComposer,
          $$PaymentsTableAnnotationComposer,
          $$PaymentsTableCreateCompanionBuilder,
          $$PaymentsTableUpdateCompanionBuilder,
          (Payment, $$PaymentsTableReferences),
          Payment,
          PrefetchHooks Function({bool organizationId, bool paymentItemsRefs})
        > {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<DateTime> paymentDate = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String?> proofUrl = const Value.absent(),
                Value<bool> verified = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentsCompanion(
                id: id,
                organizationId: organizationId,
                paymentDate: paymentDate,
                amount: amount,
                paymentMethod: paymentMethod,
                proofUrl: proofUrl,
                verified: verified,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                Value<DateTime> paymentDate = const Value.absent(),
                required int amount,
                required String paymentMethod,
                Value<String?> proofUrl = const Value.absent(),
                Value<bool> verified = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentsCompanion.insert(
                id: id,
                organizationId: organizationId,
                paymentDate: paymentDate,
                amount: amount,
                paymentMethod: paymentMethod,
                proofUrl: proofUrl,
                verified: verified,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({organizationId = false, paymentItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (paymentItemsRefs) db.paymentItems,
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
                        if (organizationId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.organizationId,
                                    referencedTable: $$PaymentsTableReferences
                                        ._organizationIdTable(db),
                                    referencedColumn: $$PaymentsTableReferences
                                        ._organizationIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (paymentItemsRefs)
                        await $_getPrefetchedData<
                          Payment,
                          $PaymentsTable,
                          PaymentItem
                        >(
                          currentTable: table,
                          referencedTable: $$PaymentsTableReferences
                              ._paymentItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PaymentsTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.paymentId == item.id,
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

typedef $$PaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentsTable,
      Payment,
      $$PaymentsTableFilterComposer,
      $$PaymentsTableOrderingComposer,
      $$PaymentsTableAnnotationComposer,
      $$PaymentsTableCreateCompanionBuilder,
      $$PaymentsTableUpdateCompanionBuilder,
      (Payment, $$PaymentsTableReferences),
      Payment,
      PrefetchHooks Function({bool organizationId, bool paymentItemsRefs})
    >;
typedef $$PaymentItemsTableCreateCompanionBuilder =
    PaymentItemsCompanion Function({
      required String id,
      required String paymentId,
      required String invoiceId,
      required int amountAllocated,
      Value<int> rowid,
    });
typedef $$PaymentItemsTableUpdateCompanionBuilder =
    PaymentItemsCompanion Function({
      Value<String> id,
      Value<String> paymentId,
      Value<String> invoiceId,
      Value<int> amountAllocated,
      Value<int> rowid,
    });

final class $$PaymentItemsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentItemsTable, PaymentItem> {
  $$PaymentItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PaymentsTable _paymentIdTable(_$AppDatabase db) =>
      db.payments.createAlias('payment_items__payment_id__payments__id');

  $$PaymentsTableProcessedTableManager get paymentId {
    final $_column = $_itemColumn<String>('payment_id')!;

    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_paymentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias('payment_items__invoice_id__invoices__id');

  $$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<String>('invoice_id')!;

    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PaymentItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentItemsTable> {
  $$PaymentItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountAllocated => $composableBuilder(
    column: $table.amountAllocated,
    builder: (column) => ColumnFilters(column),
  );

  $$PaymentsTableFilterComposer get paymentId {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentId,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentItemsTable> {
  $$PaymentItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountAllocated => $composableBuilder(
    column: $table.amountAllocated,
    builder: (column) => ColumnOrderings(column),
  );

  $$PaymentsTableOrderingComposer get paymentId {
    final $$PaymentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentId,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableOrderingComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentItemsTable> {
  $$PaymentItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amountAllocated => $composableBuilder(
    column: $table.amountAllocated,
    builder: (column) => column,
  );

  $$PaymentsTableAnnotationComposer get paymentId {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentId,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentItemsTable,
          PaymentItem,
          $$PaymentItemsTableFilterComposer,
          $$PaymentItemsTableOrderingComposer,
          $$PaymentItemsTableAnnotationComposer,
          $$PaymentItemsTableCreateCompanionBuilder,
          $$PaymentItemsTableUpdateCompanionBuilder,
          (PaymentItem, $$PaymentItemsTableReferences),
          PaymentItem,
          PrefetchHooks Function({bool paymentId, bool invoiceId})
        > {
  $$PaymentItemsTableTableManager(_$AppDatabase db, $PaymentItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> paymentId = const Value.absent(),
                Value<String> invoiceId = const Value.absent(),
                Value<int> amountAllocated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentItemsCompanion(
                id: id,
                paymentId: paymentId,
                invoiceId: invoiceId,
                amountAllocated: amountAllocated,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String paymentId,
                required String invoiceId,
                required int amountAllocated,
                Value<int> rowid = const Value.absent(),
              }) => PaymentItemsCompanion.insert(
                id: id,
                paymentId: paymentId,
                invoiceId: invoiceId,
                amountAllocated: amountAllocated,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PaymentItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({paymentId = false, invoiceId = false}) {
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
                    if (paymentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.paymentId,
                                referencedTable: $$PaymentItemsTableReferences
                                    ._paymentIdTable(db),
                                referencedColumn: $$PaymentItemsTableReferences
                                    ._paymentIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (invoiceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.invoiceId,
                                referencedTable: $$PaymentItemsTableReferences
                                    ._invoiceIdTable(db),
                                referencedColumn: $$PaymentItemsTableReferences
                                    ._invoiceIdTable(db)
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

typedef $$PaymentItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentItemsTable,
      PaymentItem,
      $$PaymentItemsTableFilterComposer,
      $$PaymentItemsTableOrderingComposer,
      $$PaymentItemsTableAnnotationComposer,
      $$PaymentItemsTableCreateCompanionBuilder,
      $$PaymentItemsTableUpdateCompanionBuilder,
      (PaymentItem, $$PaymentItemsTableReferences),
      PaymentItem,
      PrefetchHooks Function({bool paymentId, bool invoiceId})
    >;
typedef $$MaintenanceTicketsTableCreateCompanionBuilder =
    MaintenanceTicketsCompanion Function({
      required String id,
      required String organizationId,
      required String residentId,
      required String roomId,
      required String title,
      required String description,
      Value<String> urgency,
      Value<String> status,
      Value<int?> cost,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$MaintenanceTicketsTableUpdateCompanionBuilder =
    MaintenanceTicketsCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<String> residentId,
      Value<String> roomId,
      Value<String> title,
      Value<String> description,
      Value<String> urgency,
      Value<String> status,
      Value<int?> cost,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$MaintenanceTicketsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MaintenanceTicketsTable,
          MaintenanceTicket
        > {
  $$MaintenanceTicketsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $OrganizationsTable _organizationIdTable(_$AppDatabase db) => db
      .organizations
      .createAlias('maintenance_tickets__organization_id__organizations__id');

  $$OrganizationsTableProcessedTableManager get organizationId {
    final $_column = $_itemColumn<String>('organization_id')!;

    final manager = $$OrganizationsTableTableManager(
      $_db,
      $_db.organizations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_organizationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ResidentsTable _residentIdTable(_$AppDatabase db) => db.residents
      .createAlias('maintenance_tickets__resident_id__residents__id');

  $$ResidentsTableProcessedTableManager get residentId {
    final $_column = $_itemColumn<String>('resident_id')!;

    final manager = $$ResidentsTableTableManager(
      $_db,
      $_db.residents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_residentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RoomsTable _roomIdTable(_$AppDatabase db) =>
      db.rooms.createAlias('maintenance_tickets__room_id__rooms__id');

  $$RoomsTableProcessedTableManager get roomId {
    final $_column = $_itemColumn<String>('room_id')!;

    final manager = $$RoomsTableTableManager(
      $_db,
      $_db.rooms,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roomIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MaintenanceTicketsTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenanceTicketsTable> {
  $$MaintenanceTicketsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
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

  ColumnFilters<String> get urgency => $composableBuilder(
    column: $table.urgency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$OrganizationsTableFilterComposer get organizationId {
    final $$OrganizationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableFilterComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ResidentsTableFilterComposer get residentId {
    final $$ResidentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.residentId,
      referencedTable: $db.residents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResidentsTableFilterComposer(
            $db: $db,
            $table: $db.residents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoomsTableFilterComposer get roomId {
    final $$RoomsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roomId,
      referencedTable: $db.rooms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableFilterComposer(
            $db: $db,
            $table: $db.rooms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceTicketsTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenanceTicketsTable> {
  $$MaintenanceTicketsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
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

  ColumnOrderings<String> get urgency => $composableBuilder(
    column: $table.urgency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrganizationsTableOrderingComposer get organizationId {
    final $$OrganizationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableOrderingComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ResidentsTableOrderingComposer get residentId {
    final $$ResidentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.residentId,
      referencedTable: $db.residents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResidentsTableOrderingComposer(
            $db: $db,
            $table: $db.residents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoomsTableOrderingComposer get roomId {
    final $$RoomsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roomId,
      referencedTable: $db.rooms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableOrderingComposer(
            $db: $db,
            $table: $db.rooms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceTicketsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenanceTicketsTable> {
  $$MaintenanceTicketsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get urgency =>
      $composableBuilder(column: $table.urgency, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$OrganizationsTableAnnotationComposer get organizationId {
    final $$OrganizationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableAnnotationComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ResidentsTableAnnotationComposer get residentId {
    final $$ResidentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.residentId,
      referencedTable: $db.residents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResidentsTableAnnotationComposer(
            $db: $db,
            $table: $db.residents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoomsTableAnnotationComposer get roomId {
    final $$RoomsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roomId,
      referencedTable: $db.rooms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableAnnotationComposer(
            $db: $db,
            $table: $db.rooms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceTicketsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaintenanceTicketsTable,
          MaintenanceTicket,
          $$MaintenanceTicketsTableFilterComposer,
          $$MaintenanceTicketsTableOrderingComposer,
          $$MaintenanceTicketsTableAnnotationComposer,
          $$MaintenanceTicketsTableCreateCompanionBuilder,
          $$MaintenanceTicketsTableUpdateCompanionBuilder,
          (MaintenanceTicket, $$MaintenanceTicketsTableReferences),
          MaintenanceTicket,
          PrefetchHooks Function({
            bool organizationId,
            bool residentId,
            bool roomId,
          })
        > {
  $$MaintenanceTicketsTableTableManager(
    _$AppDatabase db,
    $MaintenanceTicketsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenanceTicketsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaintenanceTicketsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaintenanceTicketsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<String> residentId = const Value.absent(),
                Value<String> roomId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> urgency = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> cost = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MaintenanceTicketsCompanion(
                id: id,
                organizationId: organizationId,
                residentId: residentId,
                roomId: roomId,
                title: title,
                description: description,
                urgency: urgency,
                status: status,
                cost: cost,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                required String residentId,
                required String roomId,
                required String title,
                required String description,
                Value<String> urgency = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> cost = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MaintenanceTicketsCompanion.insert(
                id: id,
                organizationId: organizationId,
                residentId: residentId,
                roomId: roomId,
                title: title,
                description: description,
                urgency: urgency,
                status: status,
                cost: cost,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MaintenanceTicketsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({organizationId = false, residentId = false, roomId = false}) {
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
                        if (organizationId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.organizationId,
                                    referencedTable:
                                        $$MaintenanceTicketsTableReferences
                                            ._organizationIdTable(db),
                                    referencedColumn:
                                        $$MaintenanceTicketsTableReferences
                                            ._organizationIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (residentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.residentId,
                                    referencedTable:
                                        $$MaintenanceTicketsTableReferences
                                            ._residentIdTable(db),
                                    referencedColumn:
                                        $$MaintenanceTicketsTableReferences
                                            ._residentIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (roomId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.roomId,
                                    referencedTable:
                                        $$MaintenanceTicketsTableReferences
                                            ._roomIdTable(db),
                                    referencedColumn:
                                        $$MaintenanceTicketsTableReferences
                                            ._roomIdTable(db)
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

typedef $$MaintenanceTicketsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaintenanceTicketsTable,
      MaintenanceTicket,
      $$MaintenanceTicketsTableFilterComposer,
      $$MaintenanceTicketsTableOrderingComposer,
      $$MaintenanceTicketsTableAnnotationComposer,
      $$MaintenanceTicketsTableCreateCompanionBuilder,
      $$MaintenanceTicketsTableUpdateCompanionBuilder,
      (MaintenanceTicket, $$MaintenanceTicketsTableReferences),
      MaintenanceTicket,
      PrefetchHooks Function({
        bool organizationId,
        bool residentId,
        bool roomId,
      })
    >;
typedef $$AuditLogsTableCreateCompanionBuilder =
    AuditLogsCompanion Function({
      required String id,
      required String organizationId,
      required String userId,
      required String action,
      required String description,
      Value<String?> ipAddress,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$AuditLogsTableUpdateCompanionBuilder =
    AuditLogsCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<String> userId,
      Value<String> action,
      Value<String> description,
      Value<String?> ipAddress,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$AuditLogsTableReferences
    extends BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog> {
  $$AuditLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrganizationsTable _organizationIdTable(_$AppDatabase db) => db
      .organizations
      .createAlias('audit_logs__organization_id__organizations__id');

  $$OrganizationsTableProcessedTableManager get organizationId {
    final $_column = $_itemColumn<String>('organization_id')!;

    final manager = $$OrganizationsTableTableManager(
      $_db,
      $_db.organizations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_organizationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UserProfilesTable _userIdTable(_$AppDatabase db) =>
      db.userProfiles.createAlias('audit_logs__user_id__user_profiles__id');

  $$UserProfilesTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UserProfilesTableTableManager(
      $_db,
      $_db.userProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AuditLogsTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ipAddress => $composableBuilder(
    column: $table.ipAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$OrganizationsTableFilterComposer get organizationId {
    final $$OrganizationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableFilterComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserProfilesTableFilterComposer get userId {
    final $$UserProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableFilterComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AuditLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ipAddress => $composableBuilder(
    column: $table.ipAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrganizationsTableOrderingComposer get organizationId {
    final $$OrganizationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableOrderingComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserProfilesTableOrderingComposer get userId {
    final $$UserProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AuditLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ipAddress =>
      $composableBuilder(column: $table.ipAddress, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$OrganizationsTableAnnotationComposer get organizationId {
    final $$OrganizationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.organizationId,
      referencedTable: $db.organizations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganizationsTableAnnotationComposer(
            $db: $db,
            $table: $db.organizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserProfilesTableAnnotationComposer get userId {
    final $$UserProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AuditLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditLogsTable,
          AuditLog,
          $$AuditLogsTableFilterComposer,
          $$AuditLogsTableOrderingComposer,
          $$AuditLogsTableAnnotationComposer,
          $$AuditLogsTableCreateCompanionBuilder,
          $$AuditLogsTableUpdateCompanionBuilder,
          (AuditLog, $$AuditLogsTableReferences),
          AuditLog,
          PrefetchHooks Function({bool organizationId, bool userId})
        > {
  $$AuditLogsTableTableManager(_$AppDatabase db, $AuditLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> ipAddress = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuditLogsCompanion(
                id: id,
                organizationId: organizationId,
                userId: userId,
                action: action,
                description: description,
                ipAddress: ipAddress,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                required String userId,
                required String action,
                required String description,
                Value<String?> ipAddress = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuditLogsCompanion.insert(
                id: id,
                organizationId: organizationId,
                userId: userId,
                action: action,
                description: description,
                ipAddress: ipAddress,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AuditLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({organizationId = false, userId = false}) {
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
                    if (organizationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.organizationId,
                                referencedTable: $$AuditLogsTableReferences
                                    ._organizationIdTable(db),
                                referencedColumn: $$AuditLogsTableReferences
                                    ._organizationIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable: $$AuditLogsTableReferences
                                    ._userIdTable(db),
                                referencedColumn: $$AuditLogsTableReferences
                                    ._userIdTable(db)
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

typedef $$AuditLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditLogsTable,
      AuditLog,
      $$AuditLogsTableFilterComposer,
      $$AuditLogsTableOrderingComposer,
      $$AuditLogsTableAnnotationComposer,
      $$AuditLogsTableCreateCompanionBuilder,
      $$AuditLogsTableUpdateCompanionBuilder,
      (AuditLog, $$AuditLogsTableReferences),
      AuditLog,
      PrefetchHooks Function({bool organizationId, bool userId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$OrganizationsTableTableManager get organizations =>
      $$OrganizationsTableTableManager(_db, _db.organizations);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$PropertiesTableTableManager get properties =>
      $$PropertiesTableTableManager(_db, _db.properties);
  $$PropertyManagersTableTableManager get propertyManagers =>
      $$PropertyManagersTableTableManager(_db, _db.propertyManagers);
  $$RoomsTableTableManager get rooms =>
      $$RoomsTableTableManager(_db, _db.rooms);
  $$ResidentsTableTableManager get residents =>
      $$ResidentsTableTableManager(_db, _db.residents);
  $$ContractsTableTableManager get contracts =>
      $$ContractsTableTableManager(_db, _db.contracts);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$PaymentItemsTableTableManager get paymentItems =>
      $$PaymentItemsTableTableManager(_db, _db.paymentItems);
  $$MaintenanceTicketsTableTableManager get maintenanceTickets =>
      $$MaintenanceTicketsTableTableManager(_db, _db.maintenanceTickets);
  $$AuditLogsTableTableManager get auditLogs =>
      $$AuditLogsTableTableManager(_db, _db.auditLogs);
}
