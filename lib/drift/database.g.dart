// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserDetailsTable extends UserDetails
    with TableInfo<$UserDetailsTable, UserDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _mobileNumberMeta =
      const VerificationMeta('mobileNumber');
  @override
  late final GeneratedColumn<String> mobileNumber = GeneratedColumn<String>(
      'mobile_number', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _soldToNumberMeta =
      const VerificationMeta('soldToNumber');
  @override
  late final GeneratedColumn<String> soldToNumber = GeneratedColumn<String>(
      'sold_to_number', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _companyCodeMeta =
      const VerificationMeta('companyCode');
  @override
  late final GeneratedColumn<String> companyCode = GeneratedColumn<String>(
      'company_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _companyNameMeta =
      const VerificationMeta('companyName');
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
      'company_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        mobileNumber,
        name,
        soldToNumber,
        companyCode,
        companyName,
        role,
        category
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_details';
  @override
  VerificationContext validateIntegrity(Insertable<UserDetail> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mobile_number')) {
      context.handle(
          _mobileNumberMeta,
          mobileNumber.isAcceptableOrUnknown(
              data['mobile_number']!, _mobileNumberMeta));
    } else if (isInserting) {
      context.missing(_mobileNumberMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sold_to_number')) {
      context.handle(
          _soldToNumberMeta,
          soldToNumber.isAcceptableOrUnknown(
              data['sold_to_number']!, _soldToNumberMeta));
    } else if (isInserting) {
      context.missing(_soldToNumberMeta);
    }
    if (data.containsKey('company_code')) {
      context.handle(
          _companyCodeMeta,
          companyCode.isAcceptableOrUnknown(
              data['company_code']!, _companyCodeMeta));
    } else if (isInserting) {
      context.missing(_companyCodeMeta);
    }
    if (data.containsKey('company_name')) {
      context.handle(
          _companyNameMeta,
          companyName.isAcceptableOrUnknown(
              data['company_name']!, _companyNameMeta));
    } else if (isInserting) {
      context.missing(_companyNameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserDetail(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      mobileNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mobile_number'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      soldToNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sold_to_number'])!,
      companyCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_code'])!,
      companyName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_name'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
    );
  }

  @override
  $UserDetailsTable createAlias(String alias) {
    return $UserDetailsTable(attachedDatabase, alias);
  }
}

class UserDetail extends DataClass implements Insertable<UserDetail> {
  final int id;
  final String mobileNumber;
  final String name;
  final String soldToNumber;
  final String companyCode;
  final String companyName;
  final String role;
  final String category;
  const UserDetail(
      {required this.id,
      required this.mobileNumber,
      required this.name,
      required this.soldToNumber,
      required this.companyCode,
      required this.companyName,
      required this.role,
      required this.category});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mobile_number'] = Variable<String>(mobileNumber);
    map['name'] = Variable<String>(name);
    map['sold_to_number'] = Variable<String>(soldToNumber);
    map['company_code'] = Variable<String>(companyCode);
    map['company_name'] = Variable<String>(companyName);
    map['role'] = Variable<String>(role);
    map['category'] = Variable<String>(category);
    return map;
  }

  UserDetailsCompanion toCompanion(bool nullToAbsent) {
    return UserDetailsCompanion(
      id: Value(id),
      mobileNumber: Value(mobileNumber),
      name: Value(name),
      soldToNumber: Value(soldToNumber),
      companyCode: Value(companyCode),
      companyName: Value(companyName),
      role: Value(role),
      category: Value(category),
    );
  }

  factory UserDetail.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserDetail(
      id: serializer.fromJson<int>(json['id']),
      mobileNumber: serializer.fromJson<String>(json['mobileNumber']),
      name: serializer.fromJson<String>(json['name']),
      soldToNumber: serializer.fromJson<String>(json['soldToNumber']),
      companyCode: serializer.fromJson<String>(json['companyCode']),
      companyName: serializer.fromJson<String>(json['companyName']),
      role: serializer.fromJson<String>(json['role']),
      category: serializer.fromJson<String>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mobileNumber': serializer.toJson<String>(mobileNumber),
      'name': serializer.toJson<String>(name),
      'soldToNumber': serializer.toJson<String>(soldToNumber),
      'companyCode': serializer.toJson<String>(companyCode),
      'companyName': serializer.toJson<String>(companyName),
      'role': serializer.toJson<String>(role),
      'category': serializer.toJson<String>(category),
    };
  }

  UserDetail copyWith(
          {int? id,
          String? mobileNumber,
          String? name,
          String? soldToNumber,
          String? companyCode,
          String? companyName,
          String? role,
          String? category}) =>
      UserDetail(
        id: id ?? this.id,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        name: name ?? this.name,
        soldToNumber: soldToNumber ?? this.soldToNumber,
        companyCode: companyCode ?? this.companyCode,
        companyName: companyName ?? this.companyName,
        role: role ?? this.role,
        category: category ?? this.category,
      );
  UserDetail copyWithCompanion(UserDetailsCompanion data) {
    return UserDetail(
      id: data.id.present ? data.id.value : this.id,
      mobileNumber: data.mobileNumber.present
          ? data.mobileNumber.value
          : this.mobileNumber,
      name: data.name.present ? data.name.value : this.name,
      soldToNumber: data.soldToNumber.present
          ? data.soldToNumber.value
          : this.soldToNumber,
      companyCode:
          data.companyCode.present ? data.companyCode.value : this.companyCode,
      companyName:
          data.companyName.present ? data.companyName.value : this.companyName,
      role: data.role.present ? data.role.value : this.role,
      category: data.category.present ? data.category.value : this.category,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserDetail(')
          ..write('id: $id, ')
          ..write('mobileNumber: $mobileNumber, ')
          ..write('name: $name, ')
          ..write('soldToNumber: $soldToNumber, ')
          ..write('companyCode: $companyCode, ')
          ..write('companyName: $companyName, ')
          ..write('role: $role, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, mobileNumber, name, soldToNumber,
      companyCode, companyName, role, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserDetail &&
          other.id == this.id &&
          other.mobileNumber == this.mobileNumber &&
          other.name == this.name &&
          other.soldToNumber == this.soldToNumber &&
          other.companyCode == this.companyCode &&
          other.companyName == this.companyName &&
          other.role == this.role &&
          other.category == this.category);
}

class UserDetailsCompanion extends UpdateCompanion<UserDetail> {
  final Value<int> id;
  final Value<String> mobileNumber;
  final Value<String> name;
  final Value<String> soldToNumber;
  final Value<String> companyCode;
  final Value<String> companyName;
  final Value<String> role;
  final Value<String> category;
  const UserDetailsCompanion({
    this.id = const Value.absent(),
    this.mobileNumber = const Value.absent(),
    this.name = const Value.absent(),
    this.soldToNumber = const Value.absent(),
    this.companyCode = const Value.absent(),
    this.companyName = const Value.absent(),
    this.role = const Value.absent(),
    this.category = const Value.absent(),
  });
  UserDetailsCompanion.insert({
    this.id = const Value.absent(),
    required String mobileNumber,
    required String name,
    required String soldToNumber,
    required String companyCode,
    required String companyName,
    required String role,
    required String category,
  })  : mobileNumber = Value(mobileNumber),
        name = Value(name),
        soldToNumber = Value(soldToNumber),
        companyCode = Value(companyCode),
        companyName = Value(companyName),
        role = Value(role),
        category = Value(category);
  static Insertable<UserDetail> custom({
    Expression<int>? id,
    Expression<String>? mobileNumber,
    Expression<String>? name,
    Expression<String>? soldToNumber,
    Expression<String>? companyCode,
    Expression<String>? companyName,
    Expression<String>? role,
    Expression<String>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mobileNumber != null) 'mobile_number': mobileNumber,
      if (name != null) 'name': name,
      if (soldToNumber != null) 'sold_to_number': soldToNumber,
      if (companyCode != null) 'company_code': companyCode,
      if (companyName != null) 'company_name': companyName,
      if (role != null) 'role': role,
      if (category != null) 'category': category,
    });
  }

  UserDetailsCompanion copyWith(
      {Value<int>? id,
      Value<String>? mobileNumber,
      Value<String>? name,
      Value<String>? soldToNumber,
      Value<String>? companyCode,
      Value<String>? companyName,
      Value<String>? role,
      Value<String>? category}) {
    return UserDetailsCompanion(
      id: id ?? this.id,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      name: name ?? this.name,
      soldToNumber: soldToNumber ?? this.soldToNumber,
      companyCode: companyCode ?? this.companyCode,
      companyName: companyName ?? this.companyName,
      role: role ?? this.role,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mobileNumber.present) {
      map['mobile_number'] = Variable<String>(mobileNumber.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (soldToNumber.present) {
      map['sold_to_number'] = Variable<String>(soldToNumber.value);
    }
    if (companyCode.present) {
      map['company_code'] = Variable<String>(companyCode.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserDetailsCompanion(')
          ..write('id: $id, ')
          ..write('mobileNumber: $mobileNumber, ')
          ..write('name: $name, ')
          ..write('soldToNumber: $soldToNumber, ')
          ..write('companyCode: $companyCode, ')
          ..write('companyName: $companyName, ')
          ..write('role: $role, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

class $RelatedCustomersTable extends RelatedCustomers
    with TableInfo<$RelatedCustomersTable, RelatedCustomer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RelatedCustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _managerSoldToMeta =
      const VerificationMeta('managerSoldTo');
  @override
  late final GeneratedColumn<String> managerSoldTo = GeneratedColumn<String>(
      'manager_sold_to', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _customerSoldToMeta =
      const VerificationMeta('customerSoldTo');
  @override
  late final GeneratedColumn<String> customerSoldTo = GeneratedColumn<String>(
      'customer_sold_to', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _customerNameMeta =
      const VerificationMeta('customerName');
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
      'customer_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, managerSoldTo, customerSoldTo, customerName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'related_customers';
  @override
  VerificationContext validateIntegrity(Insertable<RelatedCustomer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('manager_sold_to')) {
      context.handle(
          _managerSoldToMeta,
          managerSoldTo.isAcceptableOrUnknown(
              data['manager_sold_to']!, _managerSoldToMeta));
    } else if (isInserting) {
      context.missing(_managerSoldToMeta);
    }
    if (data.containsKey('customer_sold_to')) {
      context.handle(
          _customerSoldToMeta,
          customerSoldTo.isAcceptableOrUnknown(
              data['customer_sold_to']!, _customerSoldToMeta));
    } else if (isInserting) {
      context.missing(_customerSoldToMeta);
    }
    if (data.containsKey('customer_name')) {
      context.handle(
          _customerNameMeta,
          customerName.isAcceptableOrUnknown(
              data['customer_name']!, _customerNameMeta));
    } else if (isInserting) {
      context.missing(_customerNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RelatedCustomer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RelatedCustomer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      managerSoldTo: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}manager_sold_to'])!,
      customerSoldTo: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}customer_sold_to'])!,
      customerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_name'])!,
    );
  }

  @override
  $RelatedCustomersTable createAlias(String alias) {
    return $RelatedCustomersTable(attachedDatabase, alias);
  }
}

class RelatedCustomer extends DataClass implements Insertable<RelatedCustomer> {
  final int id;
  final String managerSoldTo;
  final String customerSoldTo;
  final String customerName;
  const RelatedCustomer(
      {required this.id,
      required this.managerSoldTo,
      required this.customerSoldTo,
      required this.customerName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['manager_sold_to'] = Variable<String>(managerSoldTo);
    map['customer_sold_to'] = Variable<String>(customerSoldTo);
    map['customer_name'] = Variable<String>(customerName);
    return map;
  }

  RelatedCustomersCompanion toCompanion(bool nullToAbsent) {
    return RelatedCustomersCompanion(
      id: Value(id),
      managerSoldTo: Value(managerSoldTo),
      customerSoldTo: Value(customerSoldTo),
      customerName: Value(customerName),
    );
  }

  factory RelatedCustomer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RelatedCustomer(
      id: serializer.fromJson<int>(json['id']),
      managerSoldTo: serializer.fromJson<String>(json['managerSoldTo']),
      customerSoldTo: serializer.fromJson<String>(json['customerSoldTo']),
      customerName: serializer.fromJson<String>(json['customerName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'managerSoldTo': serializer.toJson<String>(managerSoldTo),
      'customerSoldTo': serializer.toJson<String>(customerSoldTo),
      'customerName': serializer.toJson<String>(customerName),
    };
  }

  RelatedCustomer copyWith(
          {int? id,
          String? managerSoldTo,
          String? customerSoldTo,
          String? customerName}) =>
      RelatedCustomer(
        id: id ?? this.id,
        managerSoldTo: managerSoldTo ?? this.managerSoldTo,
        customerSoldTo: customerSoldTo ?? this.customerSoldTo,
        customerName: customerName ?? this.customerName,
      );
  RelatedCustomer copyWithCompanion(RelatedCustomersCompanion data) {
    return RelatedCustomer(
      id: data.id.present ? data.id.value : this.id,
      managerSoldTo: data.managerSoldTo.present
          ? data.managerSoldTo.value
          : this.managerSoldTo,
      customerSoldTo: data.customerSoldTo.present
          ? data.customerSoldTo.value
          : this.customerSoldTo,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RelatedCustomer(')
          ..write('id: $id, ')
          ..write('managerSoldTo: $managerSoldTo, ')
          ..write('customerSoldTo: $customerSoldTo, ')
          ..write('customerName: $customerName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, managerSoldTo, customerSoldTo, customerName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RelatedCustomer &&
          other.id == this.id &&
          other.managerSoldTo == this.managerSoldTo &&
          other.customerSoldTo == this.customerSoldTo &&
          other.customerName == this.customerName);
}

class RelatedCustomersCompanion extends UpdateCompanion<RelatedCustomer> {
  final Value<int> id;
  final Value<String> managerSoldTo;
  final Value<String> customerSoldTo;
  final Value<String> customerName;
  const RelatedCustomersCompanion({
    this.id = const Value.absent(),
    this.managerSoldTo = const Value.absent(),
    this.customerSoldTo = const Value.absent(),
    this.customerName = const Value.absent(),
  });
  RelatedCustomersCompanion.insert({
    this.id = const Value.absent(),
    required String managerSoldTo,
    required String customerSoldTo,
    required String customerName,
  })  : managerSoldTo = Value(managerSoldTo),
        customerSoldTo = Value(customerSoldTo),
        customerName = Value(customerName);
  static Insertable<RelatedCustomer> custom({
    Expression<int>? id,
    Expression<String>? managerSoldTo,
    Expression<String>? customerSoldTo,
    Expression<String>? customerName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (managerSoldTo != null) 'manager_sold_to': managerSoldTo,
      if (customerSoldTo != null) 'customer_sold_to': customerSoldTo,
      if (customerName != null) 'customer_name': customerName,
    });
  }

  RelatedCustomersCompanion copyWith(
      {Value<int>? id,
      Value<String>? managerSoldTo,
      Value<String>? customerSoldTo,
      Value<String>? customerName}) {
    return RelatedCustomersCompanion(
      id: id ?? this.id,
      managerSoldTo: managerSoldTo ?? this.managerSoldTo,
      customerSoldTo: customerSoldTo ?? this.customerSoldTo,
      customerName: customerName ?? this.customerName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (managerSoldTo.present) {
      map['manager_sold_to'] = Variable<String>(managerSoldTo.value);
    }
    if (customerSoldTo.present) {
      map['customer_sold_to'] = Variable<String>(customerSoldTo.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RelatedCustomersCompanion(')
          ..write('id: $id, ')
          ..write('managerSoldTo: $managerSoldTo, ')
          ..write('customerSoldTo: $customerSoldTo, ')
          ..write('customerName: $customerName')
          ..write(')'))
        .toString();
  }
}

class $BillingDetailsTable extends BillingDetails
    with TableInfo<$BillingDetailsTable, BillingDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillingDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _soldToNumberMeta =
      const VerificationMeta('soldToNumber');
  @override
  late final GeneratedColumn<String> soldToNumber = GeneratedColumn<String>(
      'sold_to_number', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
      'state', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pincodeMeta =
      const VerificationMeta('pincode');
  @override
  late final GeneratedColumn<String> pincode = GeneratedColumn<String>(
      'pincode', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countryMeta =
      const VerificationMeta('country');
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
      'country', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _branchPlantMeta =
      const VerificationMeta('branchPlant');
  @override
  late final GeneratedColumn<String> branchPlant = GeneratedColumn<String>(
      'branch_plant', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        soldToNumber,
        name,
        address,
        city,
        state,
        pincode,
        country,
        branchPlant
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'billing_details';
  @override
  VerificationContext validateIntegrity(Insertable<BillingDetail> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sold_to_number')) {
      context.handle(
          _soldToNumberMeta,
          soldToNumber.isAcceptableOrUnknown(
              data['sold_to_number']!, _soldToNumberMeta));
    } else if (isInserting) {
      context.missing(_soldToNumberMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('pincode')) {
      context.handle(_pincodeMeta,
          pincode.isAcceptableOrUnknown(data['pincode']!, _pincodeMeta));
    } else if (isInserting) {
      context.missing(_pincodeMeta);
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('branch_plant')) {
      context.handle(
          _branchPlantMeta,
          branchPlant.isAcceptableOrUnknown(
              data['branch_plant']!, _branchPlantMeta));
    } else if (isInserting) {
      context.missing(_branchPlantMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillingDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillingDetail(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      soldToNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sold_to_number'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city'])!,
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state'])!,
      pincode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pincode'])!,
      country: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country'])!,
      branchPlant: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_plant'])!,
    );
  }

  @override
  $BillingDetailsTable createAlias(String alias) {
    return $BillingDetailsTable(attachedDatabase, alias);
  }
}

class BillingDetail extends DataClass implements Insertable<BillingDetail> {
  final int id;
  final String soldToNumber;
  final String name;
  final String address;
  final String city;
  final String state;
  final String pincode;
  final String country;
  final String branchPlant;
  const BillingDetail(
      {required this.id,
      required this.soldToNumber,
      required this.name,
      required this.address,
      required this.city,
      required this.state,
      required this.pincode,
      required this.country,
      required this.branchPlant});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sold_to_number'] = Variable<String>(soldToNumber);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    map['city'] = Variable<String>(city);
    map['state'] = Variable<String>(state);
    map['pincode'] = Variable<String>(pincode);
    map['country'] = Variable<String>(country);
    map['branch_plant'] = Variable<String>(branchPlant);
    return map;
  }

  BillingDetailsCompanion toCompanion(bool nullToAbsent) {
    return BillingDetailsCompanion(
      id: Value(id),
      soldToNumber: Value(soldToNumber),
      name: Value(name),
      address: Value(address),
      city: Value(city),
      state: Value(state),
      pincode: Value(pincode),
      country: Value(country),
      branchPlant: Value(branchPlant),
    );
  }

  factory BillingDetail.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillingDetail(
      id: serializer.fromJson<int>(json['id']),
      soldToNumber: serializer.fromJson<String>(json['soldToNumber']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      city: serializer.fromJson<String>(json['city']),
      state: serializer.fromJson<String>(json['state']),
      pincode: serializer.fromJson<String>(json['pincode']),
      country: serializer.fromJson<String>(json['country']),
      branchPlant: serializer.fromJson<String>(json['branchPlant']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'soldToNumber': serializer.toJson<String>(soldToNumber),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'city': serializer.toJson<String>(city),
      'state': serializer.toJson<String>(state),
      'pincode': serializer.toJson<String>(pincode),
      'country': serializer.toJson<String>(country),
      'branchPlant': serializer.toJson<String>(branchPlant),
    };
  }

  BillingDetail copyWith(
          {int? id,
          String? soldToNumber,
          String? name,
          String? address,
          String? city,
          String? state,
          String? pincode,
          String? country,
          String? branchPlant}) =>
      BillingDetail(
        id: id ?? this.id,
        soldToNumber: soldToNumber ?? this.soldToNumber,
        name: name ?? this.name,
        address: address ?? this.address,
        city: city ?? this.city,
        state: state ?? this.state,
        pincode: pincode ?? this.pincode,
        country: country ?? this.country,
        branchPlant: branchPlant ?? this.branchPlant,
      );
  BillingDetail copyWithCompanion(BillingDetailsCompanion data) {
    return BillingDetail(
      id: data.id.present ? data.id.value : this.id,
      soldToNumber: data.soldToNumber.present
          ? data.soldToNumber.value
          : this.soldToNumber,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      city: data.city.present ? data.city.value : this.city,
      state: data.state.present ? data.state.value : this.state,
      pincode: data.pincode.present ? data.pincode.value : this.pincode,
      country: data.country.present ? data.country.value : this.country,
      branchPlant:
          data.branchPlant.present ? data.branchPlant.value : this.branchPlant,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillingDetail(')
          ..write('id: $id, ')
          ..write('soldToNumber: $soldToNumber, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('pincode: $pincode, ')
          ..write('country: $country, ')
          ..write('branchPlant: $branchPlant')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, soldToNumber, name, address, city, state,
      pincode, country, branchPlant);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillingDetail &&
          other.id == this.id &&
          other.soldToNumber == this.soldToNumber &&
          other.name == this.name &&
          other.address == this.address &&
          other.city == this.city &&
          other.state == this.state &&
          other.pincode == this.pincode &&
          other.country == this.country &&
          other.branchPlant == this.branchPlant);
}

class BillingDetailsCompanion extends UpdateCompanion<BillingDetail> {
  final Value<int> id;
  final Value<String> soldToNumber;
  final Value<String> name;
  final Value<String> address;
  final Value<String> city;
  final Value<String> state;
  final Value<String> pincode;
  final Value<String> country;
  final Value<String> branchPlant;
  const BillingDetailsCompanion({
    this.id = const Value.absent(),
    this.soldToNumber = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.pincode = const Value.absent(),
    this.country = const Value.absent(),
    this.branchPlant = const Value.absent(),
  });
  BillingDetailsCompanion.insert({
    this.id = const Value.absent(),
    required String soldToNumber,
    required String name,
    required String address,
    required String city,
    required String state,
    required String pincode,
    required String country,
    required String branchPlant,
  })  : soldToNumber = Value(soldToNumber),
        name = Value(name),
        address = Value(address),
        city = Value(city),
        state = Value(state),
        pincode = Value(pincode),
        country = Value(country),
        branchPlant = Value(branchPlant);
  static Insertable<BillingDetail> custom({
    Expression<int>? id,
    Expression<String>? soldToNumber,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? city,
    Expression<String>? state,
    Expression<String>? pincode,
    Expression<String>? country,
    Expression<String>? branchPlant,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (soldToNumber != null) 'sold_to_number': soldToNumber,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (pincode != null) 'pincode': pincode,
      if (country != null) 'country': country,
      if (branchPlant != null) 'branch_plant': branchPlant,
    });
  }

  BillingDetailsCompanion copyWith(
      {Value<int>? id,
      Value<String>? soldToNumber,
      Value<String>? name,
      Value<String>? address,
      Value<String>? city,
      Value<String>? state,
      Value<String>? pincode,
      Value<String>? country,
      Value<String>? branchPlant}) {
    return BillingDetailsCompanion(
      id: id ?? this.id,
      soldToNumber: soldToNumber ?? this.soldToNumber,
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      country: country ?? this.country,
      branchPlant: branchPlant ?? this.branchPlant,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (soldToNumber.present) {
      map['sold_to_number'] = Variable<String>(soldToNumber.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (pincode.present) {
      map['pincode'] = Variable<String>(pincode.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (branchPlant.present) {
      map['branch_plant'] = Variable<String>(branchPlant.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillingDetailsCompanion(')
          ..write('id: $id, ')
          ..write('soldToNumber: $soldToNumber, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('pincode: $pincode, ')
          ..write('country: $country, ')
          ..write('branchPlant: $branchPlant')
          ..write(')'))
        .toString();
  }
}

class $DeliveryDetailsTable extends DeliveryDetails
    with TableInfo<$DeliveryDetailsTable, DeliveryDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeliveryDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _soldToNumberMeta =
      const VerificationMeta('soldToNumber');
  @override
  late final GeneratedColumn<String> soldToNumber = GeneratedColumn<String>(
      'sold_to_number', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
      'state', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pincodeMeta =
      const VerificationMeta('pincode');
  @override
  late final GeneratedColumn<String> pincode = GeneratedColumn<String>(
      'pincode', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countryMeta =
      const VerificationMeta('country');
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
      'country', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, soldToNumber, name, address, city, state, pincode, country];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'delivery_details';
  @override
  VerificationContext validateIntegrity(Insertable<DeliveryDetail> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sold_to_number')) {
      context.handle(
          _soldToNumberMeta,
          soldToNumber.isAcceptableOrUnknown(
              data['sold_to_number']!, _soldToNumberMeta));
    } else if (isInserting) {
      context.missing(_soldToNumberMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('pincode')) {
      context.handle(_pincodeMeta,
          pincode.isAcceptableOrUnknown(data['pincode']!, _pincodeMeta));
    } else if (isInserting) {
      context.missing(_pincodeMeta);
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeliveryDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeliveryDetail(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      soldToNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sold_to_number'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city'])!,
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state'])!,
      pincode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pincode'])!,
      country: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country'])!,
    );
  }

  @override
  $DeliveryDetailsTable createAlias(String alias) {
    return $DeliveryDetailsTable(attachedDatabase, alias);
  }
}

class DeliveryDetail extends DataClass implements Insertable<DeliveryDetail> {
  final int id;
  final String soldToNumber;
  final String name;
  final String address;
  final String city;
  final String state;
  final String pincode;
  final String country;
  const DeliveryDetail(
      {required this.id,
      required this.soldToNumber,
      required this.name,
      required this.address,
      required this.city,
      required this.state,
      required this.pincode,
      required this.country});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sold_to_number'] = Variable<String>(soldToNumber);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    map['city'] = Variable<String>(city);
    map['state'] = Variable<String>(state);
    map['pincode'] = Variable<String>(pincode);
    map['country'] = Variable<String>(country);
    return map;
  }

  DeliveryDetailsCompanion toCompanion(bool nullToAbsent) {
    return DeliveryDetailsCompanion(
      id: Value(id),
      soldToNumber: Value(soldToNumber),
      name: Value(name),
      address: Value(address),
      city: Value(city),
      state: Value(state),
      pincode: Value(pincode),
      country: Value(country),
    );
  }

  factory DeliveryDetail.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeliveryDetail(
      id: serializer.fromJson<int>(json['id']),
      soldToNumber: serializer.fromJson<String>(json['soldToNumber']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      city: serializer.fromJson<String>(json['city']),
      state: serializer.fromJson<String>(json['state']),
      pincode: serializer.fromJson<String>(json['pincode']),
      country: serializer.fromJson<String>(json['country']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'soldToNumber': serializer.toJson<String>(soldToNumber),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'city': serializer.toJson<String>(city),
      'state': serializer.toJson<String>(state),
      'pincode': serializer.toJson<String>(pincode),
      'country': serializer.toJson<String>(country),
    };
  }

  DeliveryDetail copyWith(
          {int? id,
          String? soldToNumber,
          String? name,
          String? address,
          String? city,
          String? state,
          String? pincode,
          String? country}) =>
      DeliveryDetail(
        id: id ?? this.id,
        soldToNumber: soldToNumber ?? this.soldToNumber,
        name: name ?? this.name,
        address: address ?? this.address,
        city: city ?? this.city,
        state: state ?? this.state,
        pincode: pincode ?? this.pincode,
        country: country ?? this.country,
      );
  DeliveryDetail copyWithCompanion(DeliveryDetailsCompanion data) {
    return DeliveryDetail(
      id: data.id.present ? data.id.value : this.id,
      soldToNumber: data.soldToNumber.present
          ? data.soldToNumber.value
          : this.soldToNumber,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      city: data.city.present ? data.city.value : this.city,
      state: data.state.present ? data.state.value : this.state,
      pincode: data.pincode.present ? data.pincode.value : this.pincode,
      country: data.country.present ? data.country.value : this.country,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeliveryDetail(')
          ..write('id: $id, ')
          ..write('soldToNumber: $soldToNumber, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('pincode: $pincode, ')
          ..write('country: $country')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, soldToNumber, name, address, city, state, pincode, country);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeliveryDetail &&
          other.id == this.id &&
          other.soldToNumber == this.soldToNumber &&
          other.name == this.name &&
          other.address == this.address &&
          other.city == this.city &&
          other.state == this.state &&
          other.pincode == this.pincode &&
          other.country == this.country);
}

class DeliveryDetailsCompanion extends UpdateCompanion<DeliveryDetail> {
  final Value<int> id;
  final Value<String> soldToNumber;
  final Value<String> name;
  final Value<String> address;
  final Value<String> city;
  final Value<String> state;
  final Value<String> pincode;
  final Value<String> country;
  const DeliveryDetailsCompanion({
    this.id = const Value.absent(),
    this.soldToNumber = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.pincode = const Value.absent(),
    this.country = const Value.absent(),
  });
  DeliveryDetailsCompanion.insert({
    this.id = const Value.absent(),
    required String soldToNumber,
    required String name,
    required String address,
    required String city,
    required String state,
    required String pincode,
    required String country,
  })  : soldToNumber = Value(soldToNumber),
        name = Value(name),
        address = Value(address),
        city = Value(city),
        state = Value(state),
        pincode = Value(pincode),
        country = Value(country);
  static Insertable<DeliveryDetail> custom({
    Expression<int>? id,
    Expression<String>? soldToNumber,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? city,
    Expression<String>? state,
    Expression<String>? pincode,
    Expression<String>? country,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (soldToNumber != null) 'sold_to_number': soldToNumber,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (pincode != null) 'pincode': pincode,
      if (country != null) 'country': country,
    });
  }

  DeliveryDetailsCompanion copyWith(
      {Value<int>? id,
      Value<String>? soldToNumber,
      Value<String>? name,
      Value<String>? address,
      Value<String>? city,
      Value<String>? state,
      Value<String>? pincode,
      Value<String>? country}) {
    return DeliveryDetailsCompanion(
      id: id ?? this.id,
      soldToNumber: soldToNumber ?? this.soldToNumber,
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      country: country ?? this.country,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (soldToNumber.present) {
      map['sold_to_number'] = Variable<String>(soldToNumber.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (pincode.present) {
      map['pincode'] = Variable<String>(pincode.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeliveryDetailsCompanion(')
          ..write('id: $id, ')
          ..write('soldToNumber: $soldToNumber, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('pincode: $pincode, ')
          ..write('country: $country')
          ..write(')'))
        .toString();
  }
}

class $ItemMasterTable extends ItemMaster
    with TableInfo<$ItemMasterTable, ItemMasterData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemMasterTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemNumberMeta =
      const VerificationMeta('itemNumber');
  @override
  late final GeneratedColumn<String> itemNumber = GeneratedColumn<String>(
      'item_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _articleMeta =
      const VerificationMeta('article');
  @override
  late final GeneratedColumn<String> article = GeneratedColumn<String>(
      'article', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _articleDescriptionMeta =
      const VerificationMeta('articleDescription');
  @override
  late final GeneratedColumn<String> articleDescription =
      GeneratedColumn<String>('article_description', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _uomMeta = const VerificationMeta('uom');
  @override
  late final GeneratedColumn<String> uom = GeneratedColumn<String>(
      'uom', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _uomDescriptionMeta =
      const VerificationMeta('uomDescription');
  @override
  late final GeneratedColumn<String> uomDescription = GeneratedColumn<String>(
      'uom_description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shadeMeta = const VerificationMeta('shade');
  @override
  late final GeneratedColumn<String> shade = GeneratedColumn<String>(
      'shade', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isInShadeCardMeta =
      const VerificationMeta('isInShadeCard');
  @override
  late final GeneratedColumn<bool> isInShadeCard = GeneratedColumn<bool>(
      'is_in_shade_card', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_in_shade_card" IN (0, 1))'));
  static const VerificationMeta _lastUpdatedDateTimeMeta =
      const VerificationMeta('lastUpdatedDateTime');
  @override
  late final GeneratedColumn<DateTime> lastUpdatedDateTime =
      GeneratedColumn<DateTime>('last_updated_date_time', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        itemNumber,
        article,
        articleDescription,
        uom,
        uomDescription,
        shade,
        isInShadeCard,
        lastUpdatedDateTime
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'item_master';
  @override
  VerificationContext validateIntegrity(Insertable<ItemMasterData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_number')) {
      context.handle(
          _itemNumberMeta,
          itemNumber.isAcceptableOrUnknown(
              data['item_number']!, _itemNumberMeta));
    } else if (isInserting) {
      context.missing(_itemNumberMeta);
    }
    if (data.containsKey('article')) {
      context.handle(_articleMeta,
          article.isAcceptableOrUnknown(data['article']!, _articleMeta));
    } else if (isInserting) {
      context.missing(_articleMeta);
    }
    if (data.containsKey('article_description')) {
      context.handle(
          _articleDescriptionMeta,
          articleDescription.isAcceptableOrUnknown(
              data['article_description']!, _articleDescriptionMeta));
    } else if (isInserting) {
      context.missing(_articleDescriptionMeta);
    }
    if (data.containsKey('uom')) {
      context.handle(
          _uomMeta, uom.isAcceptableOrUnknown(data['uom']!, _uomMeta));
    } else if (isInserting) {
      context.missing(_uomMeta);
    }
    if (data.containsKey('uom_description')) {
      context.handle(
          _uomDescriptionMeta,
          uomDescription.isAcceptableOrUnknown(
              data['uom_description']!, _uomDescriptionMeta));
    } else if (isInserting) {
      context.missing(_uomDescriptionMeta);
    }
    if (data.containsKey('shade')) {
      context.handle(
          _shadeMeta, shade.isAcceptableOrUnknown(data['shade']!, _shadeMeta));
    } else if (isInserting) {
      context.missing(_shadeMeta);
    }
    if (data.containsKey('is_in_shade_card')) {
      context.handle(
          _isInShadeCardMeta,
          isInShadeCard.isAcceptableOrUnknown(
              data['is_in_shade_card']!, _isInShadeCardMeta));
    } else if (isInserting) {
      context.missing(_isInShadeCardMeta);
    }
    if (data.containsKey('last_updated_date_time')) {
      context.handle(
          _lastUpdatedDateTimeMeta,
          lastUpdatedDateTime.isAcceptableOrUnknown(
              data['last_updated_date_time']!, _lastUpdatedDateTimeMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedDateTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemNumber};
  @override
  ItemMasterData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemMasterData(
      itemNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_number'])!,
      article: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}article'])!,
      articleDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}article_description'])!,
      uom: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uom'])!,
      uomDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}uom_description'])!,
      shade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shade'])!,
      isInShadeCard: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_in_shade_card'])!,
      lastUpdatedDateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}last_updated_date_time'])!,
    );
  }

  @override
  $ItemMasterTable createAlias(String alias) {
    return $ItemMasterTable(attachedDatabase, alias);
  }
}

class ItemMasterData extends DataClass implements Insertable<ItemMasterData> {
  final String itemNumber;
  final String article;
  final String articleDescription;
  final String uom;
  final String uomDescription;
  final String shade;
  final bool isInShadeCard;
  final DateTime lastUpdatedDateTime;
  const ItemMasterData(
      {required this.itemNumber,
      required this.article,
      required this.articleDescription,
      required this.uom,
      required this.uomDescription,
      required this.shade,
      required this.isInShadeCard,
      required this.lastUpdatedDateTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_number'] = Variable<String>(itemNumber);
    map['article'] = Variable<String>(article);
    map['article_description'] = Variable<String>(articleDescription);
    map['uom'] = Variable<String>(uom);
    map['uom_description'] = Variable<String>(uomDescription);
    map['shade'] = Variable<String>(shade);
    map['is_in_shade_card'] = Variable<bool>(isInShadeCard);
    map['last_updated_date_time'] = Variable<DateTime>(lastUpdatedDateTime);
    return map;
  }

  ItemMasterCompanion toCompanion(bool nullToAbsent) {
    return ItemMasterCompanion(
      itemNumber: Value(itemNumber),
      article: Value(article),
      articleDescription: Value(articleDescription),
      uom: Value(uom),
      uomDescription: Value(uomDescription),
      shade: Value(shade),
      isInShadeCard: Value(isInShadeCard),
      lastUpdatedDateTime: Value(lastUpdatedDateTime),
    );
  }

  factory ItemMasterData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemMasterData(
      itemNumber: serializer.fromJson<String>(json['itemNumber']),
      article: serializer.fromJson<String>(json['article']),
      articleDescription:
          serializer.fromJson<String>(json['articleDescription']),
      uom: serializer.fromJson<String>(json['uom']),
      uomDescription: serializer.fromJson<String>(json['uomDescription']),
      shade: serializer.fromJson<String>(json['shade']),
      isInShadeCard: serializer.fromJson<bool>(json['isInShadeCard']),
      lastUpdatedDateTime:
          serializer.fromJson<DateTime>(json['lastUpdatedDateTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemNumber': serializer.toJson<String>(itemNumber),
      'article': serializer.toJson<String>(article),
      'articleDescription': serializer.toJson<String>(articleDescription),
      'uom': serializer.toJson<String>(uom),
      'uomDescription': serializer.toJson<String>(uomDescription),
      'shade': serializer.toJson<String>(shade),
      'isInShadeCard': serializer.toJson<bool>(isInShadeCard),
      'lastUpdatedDateTime': serializer.toJson<DateTime>(lastUpdatedDateTime),
    };
  }

  ItemMasterData copyWith(
          {String? itemNumber,
          String? article,
          String? articleDescription,
          String? uom,
          String? uomDescription,
          String? shade,
          bool? isInShadeCard,
          DateTime? lastUpdatedDateTime}) =>
      ItemMasterData(
        itemNumber: itemNumber ?? this.itemNumber,
        article: article ?? this.article,
        articleDescription: articleDescription ?? this.articleDescription,
        uom: uom ?? this.uom,
        uomDescription: uomDescription ?? this.uomDescription,
        shade: shade ?? this.shade,
        isInShadeCard: isInShadeCard ?? this.isInShadeCard,
        lastUpdatedDateTime: lastUpdatedDateTime ?? this.lastUpdatedDateTime,
      );
  ItemMasterData copyWithCompanion(ItemMasterCompanion data) {
    return ItemMasterData(
      itemNumber:
          data.itemNumber.present ? data.itemNumber.value : this.itemNumber,
      article: data.article.present ? data.article.value : this.article,
      articleDescription: data.articleDescription.present
          ? data.articleDescription.value
          : this.articleDescription,
      uom: data.uom.present ? data.uom.value : this.uom,
      uomDescription: data.uomDescription.present
          ? data.uomDescription.value
          : this.uomDescription,
      shade: data.shade.present ? data.shade.value : this.shade,
      isInShadeCard: data.isInShadeCard.present
          ? data.isInShadeCard.value
          : this.isInShadeCard,
      lastUpdatedDateTime: data.lastUpdatedDateTime.present
          ? data.lastUpdatedDateTime.value
          : this.lastUpdatedDateTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemMasterData(')
          ..write('itemNumber: $itemNumber, ')
          ..write('article: $article, ')
          ..write('articleDescription: $articleDescription, ')
          ..write('uom: $uom, ')
          ..write('uomDescription: $uomDescription, ')
          ..write('shade: $shade, ')
          ..write('isInShadeCard: $isInShadeCard, ')
          ..write('lastUpdatedDateTime: $lastUpdatedDateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(itemNumber, article, articleDescription, uom,
      uomDescription, shade, isInShadeCard, lastUpdatedDateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemMasterData &&
          other.itemNumber == this.itemNumber &&
          other.article == this.article &&
          other.articleDescription == this.articleDescription &&
          other.uom == this.uom &&
          other.uomDescription == this.uomDescription &&
          other.shade == this.shade &&
          other.isInShadeCard == this.isInShadeCard &&
          other.lastUpdatedDateTime == this.lastUpdatedDateTime);
}

class ItemMasterCompanion extends UpdateCompanion<ItemMasterData> {
  final Value<String> itemNumber;
  final Value<String> article;
  final Value<String> articleDescription;
  final Value<String> uom;
  final Value<String> uomDescription;
  final Value<String> shade;
  final Value<bool> isInShadeCard;
  final Value<DateTime> lastUpdatedDateTime;
  final Value<int> rowid;
  const ItemMasterCompanion({
    this.itemNumber = const Value.absent(),
    this.article = const Value.absent(),
    this.articleDescription = const Value.absent(),
    this.uom = const Value.absent(),
    this.uomDescription = const Value.absent(),
    this.shade = const Value.absent(),
    this.isInShadeCard = const Value.absent(),
    this.lastUpdatedDateTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItemMasterCompanion.insert({
    required String itemNumber,
    required String article,
    required String articleDescription,
    required String uom,
    required String uomDescription,
    required String shade,
    required bool isInShadeCard,
    required DateTime lastUpdatedDateTime,
    this.rowid = const Value.absent(),
  })  : itemNumber = Value(itemNumber),
        article = Value(article),
        articleDescription = Value(articleDescription),
        uom = Value(uom),
        uomDescription = Value(uomDescription),
        shade = Value(shade),
        isInShadeCard = Value(isInShadeCard),
        lastUpdatedDateTime = Value(lastUpdatedDateTime);
  static Insertable<ItemMasterData> custom({
    Expression<String>? itemNumber,
    Expression<String>? article,
    Expression<String>? articleDescription,
    Expression<String>? uom,
    Expression<String>? uomDescription,
    Expression<String>? shade,
    Expression<bool>? isInShadeCard,
    Expression<DateTime>? lastUpdatedDateTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (itemNumber != null) 'item_number': itemNumber,
      if (article != null) 'article': article,
      if (articleDescription != null) 'article_description': articleDescription,
      if (uom != null) 'uom': uom,
      if (uomDescription != null) 'uom_description': uomDescription,
      if (shade != null) 'shade': shade,
      if (isInShadeCard != null) 'is_in_shade_card': isInShadeCard,
      if (lastUpdatedDateTime != null)
        'last_updated_date_time': lastUpdatedDateTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItemMasterCompanion copyWith(
      {Value<String>? itemNumber,
      Value<String>? article,
      Value<String>? articleDescription,
      Value<String>? uom,
      Value<String>? uomDescription,
      Value<String>? shade,
      Value<bool>? isInShadeCard,
      Value<DateTime>? lastUpdatedDateTime,
      Value<int>? rowid}) {
    return ItemMasterCompanion(
      itemNumber: itemNumber ?? this.itemNumber,
      article: article ?? this.article,
      articleDescription: articleDescription ?? this.articleDescription,
      uom: uom ?? this.uom,
      uomDescription: uomDescription ?? this.uomDescription,
      shade: shade ?? this.shade,
      isInShadeCard: isInShadeCard ?? this.isInShadeCard,
      lastUpdatedDateTime: lastUpdatedDateTime ?? this.lastUpdatedDateTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemNumber.present) {
      map['item_number'] = Variable<String>(itemNumber.value);
    }
    if (article.present) {
      map['article'] = Variable<String>(article.value);
    }
    if (articleDescription.present) {
      map['article_description'] = Variable<String>(articleDescription.value);
    }
    if (uom.present) {
      map['uom'] = Variable<String>(uom.value);
    }
    if (uomDescription.present) {
      map['uom_description'] = Variable<String>(uomDescription.value);
    }
    if (shade.present) {
      map['shade'] = Variable<String>(shade.value);
    }
    if (isInShadeCard.present) {
      map['is_in_shade_card'] = Variable<bool>(isInShadeCard.value);
    }
    if (lastUpdatedDateTime.present) {
      map['last_updated_date_time'] =
          Variable<DateTime>(lastUpdatedDateTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemMasterCompanion(')
          ..write('itemNumber: $itemNumber, ')
          ..write('article: $article, ')
          ..write('articleDescription: $articleDescription, ')
          ..write('uom: $uom, ')
          ..write('uomDescription: $uomDescription, ')
          ..write('shade: $shade, ')
          ..write('isInShadeCard: $isInShadeCard, ')
          ..write('lastUpdatedDateTime: $lastUpdatedDateTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CartTableTable extends CartTable
    with TableInfo<$CartTableTable, CartTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CartTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _soldToMeta = const VerificationMeta('soldTo');
  @override
  late final GeneratedColumn<String> soldTo = GeneratedColumn<String>(
      'sold_to', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _articleMeta =
      const VerificationMeta('article');
  @override
  late final GeneratedColumn<String> article = GeneratedColumn<String>(
      'article', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _uomMeta = const VerificationMeta('uom');
  @override
  late final GeneratedColumn<String> uom = GeneratedColumn<String>(
      'uom', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shadeMeta = const VerificationMeta('shade');
  @override
  late final GeneratedColumn<String> shade = GeneratedColumn<String>(
      'shade', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [soldTo, article, uom, shade, quantity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cart_table';
  @override
  VerificationContext validateIntegrity(Insertable<CartTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('sold_to')) {
      context.handle(_soldToMeta,
          soldTo.isAcceptableOrUnknown(data['sold_to']!, _soldToMeta));
    } else if (isInserting) {
      context.missing(_soldToMeta);
    }
    if (data.containsKey('article')) {
      context.handle(_articleMeta,
          article.isAcceptableOrUnknown(data['article']!, _articleMeta));
    } else if (isInserting) {
      context.missing(_articleMeta);
    }
    if (data.containsKey('uom')) {
      context.handle(
          _uomMeta, uom.isAcceptableOrUnknown(data['uom']!, _uomMeta));
    } else if (isInserting) {
      context.missing(_uomMeta);
    }
    if (data.containsKey('shade')) {
      context.handle(
          _shadeMeta, shade.isAcceptableOrUnknown(data['shade']!, _shadeMeta));
    } else if (isInserting) {
      context.missing(_shadeMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {soldTo, article, uom, shade};
  @override
  CartTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CartTableData(
      soldTo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sold_to'])!,
      article: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}article'])!,
      uom: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uom'])!,
      shade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shade'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
    );
  }

  @override
  $CartTableTable createAlias(String alias) {
    return $CartTableTable(attachedDatabase, alias);
  }
}

class CartTableData extends DataClass implements Insertable<CartTableData> {
  final String soldTo;
  final String article;
  final String uom;
  final String shade;
  final int quantity;
  const CartTableData(
      {required this.soldTo,
      required this.article,
      required this.uom,
      required this.shade,
      required this.quantity});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['sold_to'] = Variable<String>(soldTo);
    map['article'] = Variable<String>(article);
    map['uom'] = Variable<String>(uom);
    map['shade'] = Variable<String>(shade);
    map['quantity'] = Variable<int>(quantity);
    return map;
  }

  CartTableCompanion toCompanion(bool nullToAbsent) {
    return CartTableCompanion(
      soldTo: Value(soldTo),
      article: Value(article),
      uom: Value(uom),
      shade: Value(shade),
      quantity: Value(quantity),
    );
  }

  factory CartTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CartTableData(
      soldTo: serializer.fromJson<String>(json['soldTo']),
      article: serializer.fromJson<String>(json['article']),
      uom: serializer.fromJson<String>(json['uom']),
      shade: serializer.fromJson<String>(json['shade']),
      quantity: serializer.fromJson<int>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'soldTo': serializer.toJson<String>(soldTo),
      'article': serializer.toJson<String>(article),
      'uom': serializer.toJson<String>(uom),
      'shade': serializer.toJson<String>(shade),
      'quantity': serializer.toJson<int>(quantity),
    };
  }

  CartTableData copyWith(
          {String? soldTo,
          String? article,
          String? uom,
          String? shade,
          int? quantity}) =>
      CartTableData(
        soldTo: soldTo ?? this.soldTo,
        article: article ?? this.article,
        uom: uom ?? this.uom,
        shade: shade ?? this.shade,
        quantity: quantity ?? this.quantity,
      );
  CartTableData copyWithCompanion(CartTableCompanion data) {
    return CartTableData(
      soldTo: data.soldTo.present ? data.soldTo.value : this.soldTo,
      article: data.article.present ? data.article.value : this.article,
      uom: data.uom.present ? data.uom.value : this.uom,
      shade: data.shade.present ? data.shade.value : this.shade,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CartTableData(')
          ..write('soldTo: $soldTo, ')
          ..write('article: $article, ')
          ..write('uom: $uom, ')
          ..write('shade: $shade, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(soldTo, article, uom, shade, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartTableData &&
          other.soldTo == this.soldTo &&
          other.article == this.article &&
          other.uom == this.uom &&
          other.shade == this.shade &&
          other.quantity == this.quantity);
}

class CartTableCompanion extends UpdateCompanion<CartTableData> {
  final Value<String> soldTo;
  final Value<String> article;
  final Value<String> uom;
  final Value<String> shade;
  final Value<int> quantity;
  final Value<int> rowid;
  const CartTableCompanion({
    this.soldTo = const Value.absent(),
    this.article = const Value.absent(),
    this.uom = const Value.absent(),
    this.shade = const Value.absent(),
    this.quantity = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CartTableCompanion.insert({
    required String soldTo,
    required String article,
    required String uom,
    required String shade,
    required int quantity,
    this.rowid = const Value.absent(),
  })  : soldTo = Value(soldTo),
        article = Value(article),
        uom = Value(uom),
        shade = Value(shade),
        quantity = Value(quantity);
  static Insertable<CartTableData> custom({
    Expression<String>? soldTo,
    Expression<String>? article,
    Expression<String>? uom,
    Expression<String>? shade,
    Expression<int>? quantity,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (soldTo != null) 'sold_to': soldTo,
      if (article != null) 'article': article,
      if (uom != null) 'uom': uom,
      if (shade != null) 'shade': shade,
      if (quantity != null) 'quantity': quantity,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CartTableCompanion copyWith(
      {Value<String>? soldTo,
      Value<String>? article,
      Value<String>? uom,
      Value<String>? shade,
      Value<int>? quantity,
      Value<int>? rowid}) {
    return CartTableCompanion(
      soldTo: soldTo ?? this.soldTo,
      article: article ?? this.article,
      uom: uom ?? this.uom,
      shade: shade ?? this.shade,
      quantity: quantity ?? this.quantity,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (soldTo.present) {
      map['sold_to'] = Variable<String>(soldTo.value);
    }
    if (article.present) {
      map['article'] = Variable<String>(article.value);
    }
    if (uom.present) {
      map['uom'] = Variable<String>(uom.value);
    }
    if (shade.present) {
      map['shade'] = Variable<String>(shade.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartTableCompanion(')
          ..write('soldTo: $soldTo, ')
          ..write('article: $article, ')
          ..write('uom: $uom, ')
          ..write('shade: $shade, ')
          ..write('quantity: $quantity, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $UserDetailsTable userDetails = $UserDetailsTable(this);
  late final $RelatedCustomersTable relatedCustomers =
      $RelatedCustomersTable(this);
  late final $BillingDetailsTable billingDetails = $BillingDetailsTable(this);
  late final $DeliveryDetailsTable deliveryDetails =
      $DeliveryDetailsTable(this);
  late final $ItemMasterTable itemMaster = $ItemMasterTable(this);
  late final $CartTableTable cartTable = $CartTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        userDetails,
        relatedCustomers,
        billingDetails,
        deliveryDetails,
        itemMaster,
        cartTable
      ];
}

typedef $$UserDetailsTableCreateCompanionBuilder = UserDetailsCompanion
    Function({
  Value<int> id,
  required String mobileNumber,
  required String name,
  required String soldToNumber,
  required String companyCode,
  required String companyName,
  required String role,
  required String category,
});
typedef $$UserDetailsTableUpdateCompanionBuilder = UserDetailsCompanion
    Function({
  Value<int> id,
  Value<String> mobileNumber,
  Value<String> name,
  Value<String> soldToNumber,
  Value<String> companyCode,
  Value<String> companyName,
  Value<String> role,
  Value<String> category,
});

class $$UserDetailsTableFilterComposer
    extends Composer<_$Database, $UserDetailsTable> {
  $$UserDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mobileNumber => $composableBuilder(
      column: $table.mobileNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get soldToNumber => $composableBuilder(
      column: $table.soldToNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get companyCode => $composableBuilder(
      column: $table.companyCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get companyName => $composableBuilder(
      column: $table.companyName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));
}

class $$UserDetailsTableOrderingComposer
    extends Composer<_$Database, $UserDetailsTable> {
  $$UserDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mobileNumber => $composableBuilder(
      column: $table.mobileNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get soldToNumber => $composableBuilder(
      column: $table.soldToNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get companyCode => $composableBuilder(
      column: $table.companyCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get companyName => $composableBuilder(
      column: $table.companyName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));
}

class $$UserDetailsTableAnnotationComposer
    extends Composer<_$Database, $UserDetailsTable> {
  $$UserDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mobileNumber => $composableBuilder(
      column: $table.mobileNumber, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get soldToNumber => $composableBuilder(
      column: $table.soldToNumber, builder: (column) => column);

  GeneratedColumn<String> get companyCode => $composableBuilder(
      column: $table.companyCode, builder: (column) => column);

  GeneratedColumn<String> get companyName => $composableBuilder(
      column: $table.companyName, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);
}

class $$UserDetailsTableTableManager extends RootTableManager<
    _$Database,
    $UserDetailsTable,
    UserDetail,
    $$UserDetailsTableFilterComposer,
    $$UserDetailsTableOrderingComposer,
    $$UserDetailsTableAnnotationComposer,
    $$UserDetailsTableCreateCompanionBuilder,
    $$UserDetailsTableUpdateCompanionBuilder,
    (UserDetail, BaseReferences<_$Database, $UserDetailsTable, UserDetail>),
    UserDetail,
    PrefetchHooks Function()> {
  $$UserDetailsTableTableManager(_$Database db, $UserDetailsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserDetailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserDetailsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> mobileNumber = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> soldToNumber = const Value.absent(),
            Value<String> companyCode = const Value.absent(),
            Value<String> companyName = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> category = const Value.absent(),
          }) =>
              UserDetailsCompanion(
            id: id,
            mobileNumber: mobileNumber,
            name: name,
            soldToNumber: soldToNumber,
            companyCode: companyCode,
            companyName: companyName,
            role: role,
            category: category,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String mobileNumber,
            required String name,
            required String soldToNumber,
            required String companyCode,
            required String companyName,
            required String role,
            required String category,
          }) =>
              UserDetailsCompanion.insert(
            id: id,
            mobileNumber: mobileNumber,
            name: name,
            soldToNumber: soldToNumber,
            companyCode: companyCode,
            companyName: companyName,
            role: role,
            category: category,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserDetailsTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $UserDetailsTable,
    UserDetail,
    $$UserDetailsTableFilterComposer,
    $$UserDetailsTableOrderingComposer,
    $$UserDetailsTableAnnotationComposer,
    $$UserDetailsTableCreateCompanionBuilder,
    $$UserDetailsTableUpdateCompanionBuilder,
    (UserDetail, BaseReferences<_$Database, $UserDetailsTable, UserDetail>),
    UserDetail,
    PrefetchHooks Function()>;
typedef $$RelatedCustomersTableCreateCompanionBuilder
    = RelatedCustomersCompanion Function({
  Value<int> id,
  required String managerSoldTo,
  required String customerSoldTo,
  required String customerName,
});
typedef $$RelatedCustomersTableUpdateCompanionBuilder
    = RelatedCustomersCompanion Function({
  Value<int> id,
  Value<String> managerSoldTo,
  Value<String> customerSoldTo,
  Value<String> customerName,
});

class $$RelatedCustomersTableFilterComposer
    extends Composer<_$Database, $RelatedCustomersTable> {
  $$RelatedCustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get managerSoldTo => $composableBuilder(
      column: $table.managerSoldTo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customerSoldTo => $composableBuilder(
      column: $table.customerSoldTo,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customerName => $composableBuilder(
      column: $table.customerName, builder: (column) => ColumnFilters(column));
}

class $$RelatedCustomersTableOrderingComposer
    extends Composer<_$Database, $RelatedCustomersTable> {
  $$RelatedCustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get managerSoldTo => $composableBuilder(
      column: $table.managerSoldTo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customerSoldTo => $composableBuilder(
      column: $table.customerSoldTo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customerName => $composableBuilder(
      column: $table.customerName,
      builder: (column) => ColumnOrderings(column));
}

class $$RelatedCustomersTableAnnotationComposer
    extends Composer<_$Database, $RelatedCustomersTable> {
  $$RelatedCustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get managerSoldTo => $composableBuilder(
      column: $table.managerSoldTo, builder: (column) => column);

  GeneratedColumn<String> get customerSoldTo => $composableBuilder(
      column: $table.customerSoldTo, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
      column: $table.customerName, builder: (column) => column);
}

class $$RelatedCustomersTableTableManager extends RootTableManager<
    _$Database,
    $RelatedCustomersTable,
    RelatedCustomer,
    $$RelatedCustomersTableFilterComposer,
    $$RelatedCustomersTableOrderingComposer,
    $$RelatedCustomersTableAnnotationComposer,
    $$RelatedCustomersTableCreateCompanionBuilder,
    $$RelatedCustomersTableUpdateCompanionBuilder,
    (
      RelatedCustomer,
      BaseReferences<_$Database, $RelatedCustomersTable, RelatedCustomer>
    ),
    RelatedCustomer,
    PrefetchHooks Function()> {
  $$RelatedCustomersTableTableManager(
      _$Database db, $RelatedCustomersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RelatedCustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RelatedCustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RelatedCustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> managerSoldTo = const Value.absent(),
            Value<String> customerSoldTo = const Value.absent(),
            Value<String> customerName = const Value.absent(),
          }) =>
              RelatedCustomersCompanion(
            id: id,
            managerSoldTo: managerSoldTo,
            customerSoldTo: customerSoldTo,
            customerName: customerName,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String managerSoldTo,
            required String customerSoldTo,
            required String customerName,
          }) =>
              RelatedCustomersCompanion.insert(
            id: id,
            managerSoldTo: managerSoldTo,
            customerSoldTo: customerSoldTo,
            customerName: customerName,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RelatedCustomersTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $RelatedCustomersTable,
    RelatedCustomer,
    $$RelatedCustomersTableFilterComposer,
    $$RelatedCustomersTableOrderingComposer,
    $$RelatedCustomersTableAnnotationComposer,
    $$RelatedCustomersTableCreateCompanionBuilder,
    $$RelatedCustomersTableUpdateCompanionBuilder,
    (
      RelatedCustomer,
      BaseReferences<_$Database, $RelatedCustomersTable, RelatedCustomer>
    ),
    RelatedCustomer,
    PrefetchHooks Function()>;
typedef $$BillingDetailsTableCreateCompanionBuilder = BillingDetailsCompanion
    Function({
  Value<int> id,
  required String soldToNumber,
  required String name,
  required String address,
  required String city,
  required String state,
  required String pincode,
  required String country,
  required String branchPlant,
});
typedef $$BillingDetailsTableUpdateCompanionBuilder = BillingDetailsCompanion
    Function({
  Value<int> id,
  Value<String> soldToNumber,
  Value<String> name,
  Value<String> address,
  Value<String> city,
  Value<String> state,
  Value<String> pincode,
  Value<String> country,
  Value<String> branchPlant,
});

class $$BillingDetailsTableFilterComposer
    extends Composer<_$Database, $BillingDetailsTable> {
  $$BillingDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get soldToNumber => $composableBuilder(
      column: $table.soldToNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pincode => $composableBuilder(
      column: $table.pincode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get branchPlant => $composableBuilder(
      column: $table.branchPlant, builder: (column) => ColumnFilters(column));
}

class $$BillingDetailsTableOrderingComposer
    extends Composer<_$Database, $BillingDetailsTable> {
  $$BillingDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get soldToNumber => $composableBuilder(
      column: $table.soldToNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pincode => $composableBuilder(
      column: $table.pincode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get branchPlant => $composableBuilder(
      column: $table.branchPlant, builder: (column) => ColumnOrderings(column));
}

class $$BillingDetailsTableAnnotationComposer
    extends Composer<_$Database, $BillingDetailsTable> {
  $$BillingDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get soldToNumber => $composableBuilder(
      column: $table.soldToNumber, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get pincode =>
      $composableBuilder(column: $table.pincode, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get branchPlant => $composableBuilder(
      column: $table.branchPlant, builder: (column) => column);
}

class $$BillingDetailsTableTableManager extends RootTableManager<
    _$Database,
    $BillingDetailsTable,
    BillingDetail,
    $$BillingDetailsTableFilterComposer,
    $$BillingDetailsTableOrderingComposer,
    $$BillingDetailsTableAnnotationComposer,
    $$BillingDetailsTableCreateCompanionBuilder,
    $$BillingDetailsTableUpdateCompanionBuilder,
    (
      BillingDetail,
      BaseReferences<_$Database, $BillingDetailsTable, BillingDetail>
    ),
    BillingDetail,
    PrefetchHooks Function()> {
  $$BillingDetailsTableTableManager(_$Database db, $BillingDetailsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillingDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillingDetailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillingDetailsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> soldToNumber = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> address = const Value.absent(),
            Value<String> city = const Value.absent(),
            Value<String> state = const Value.absent(),
            Value<String> pincode = const Value.absent(),
            Value<String> country = const Value.absent(),
            Value<String> branchPlant = const Value.absent(),
          }) =>
              BillingDetailsCompanion(
            id: id,
            soldToNumber: soldToNumber,
            name: name,
            address: address,
            city: city,
            state: state,
            pincode: pincode,
            country: country,
            branchPlant: branchPlant,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String soldToNumber,
            required String name,
            required String address,
            required String city,
            required String state,
            required String pincode,
            required String country,
            required String branchPlant,
          }) =>
              BillingDetailsCompanion.insert(
            id: id,
            soldToNumber: soldToNumber,
            name: name,
            address: address,
            city: city,
            state: state,
            pincode: pincode,
            country: country,
            branchPlant: branchPlant,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BillingDetailsTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $BillingDetailsTable,
    BillingDetail,
    $$BillingDetailsTableFilterComposer,
    $$BillingDetailsTableOrderingComposer,
    $$BillingDetailsTableAnnotationComposer,
    $$BillingDetailsTableCreateCompanionBuilder,
    $$BillingDetailsTableUpdateCompanionBuilder,
    (
      BillingDetail,
      BaseReferences<_$Database, $BillingDetailsTable, BillingDetail>
    ),
    BillingDetail,
    PrefetchHooks Function()>;
typedef $$DeliveryDetailsTableCreateCompanionBuilder = DeliveryDetailsCompanion
    Function({
  Value<int> id,
  required String soldToNumber,
  required String name,
  required String address,
  required String city,
  required String state,
  required String pincode,
  required String country,
});
typedef $$DeliveryDetailsTableUpdateCompanionBuilder = DeliveryDetailsCompanion
    Function({
  Value<int> id,
  Value<String> soldToNumber,
  Value<String> name,
  Value<String> address,
  Value<String> city,
  Value<String> state,
  Value<String> pincode,
  Value<String> country,
});

class $$DeliveryDetailsTableFilterComposer
    extends Composer<_$Database, $DeliveryDetailsTable> {
  $$DeliveryDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get soldToNumber => $composableBuilder(
      column: $table.soldToNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pincode => $composableBuilder(
      column: $table.pincode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnFilters(column));
}

class $$DeliveryDetailsTableOrderingComposer
    extends Composer<_$Database, $DeliveryDetailsTable> {
  $$DeliveryDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get soldToNumber => $composableBuilder(
      column: $table.soldToNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pincode => $composableBuilder(
      column: $table.pincode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnOrderings(column));
}

class $$DeliveryDetailsTableAnnotationComposer
    extends Composer<_$Database, $DeliveryDetailsTable> {
  $$DeliveryDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get soldToNumber => $composableBuilder(
      column: $table.soldToNumber, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get pincode =>
      $composableBuilder(column: $table.pincode, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);
}

class $$DeliveryDetailsTableTableManager extends RootTableManager<
    _$Database,
    $DeliveryDetailsTable,
    DeliveryDetail,
    $$DeliveryDetailsTableFilterComposer,
    $$DeliveryDetailsTableOrderingComposer,
    $$DeliveryDetailsTableAnnotationComposer,
    $$DeliveryDetailsTableCreateCompanionBuilder,
    $$DeliveryDetailsTableUpdateCompanionBuilder,
    (
      DeliveryDetail,
      BaseReferences<_$Database, $DeliveryDetailsTable, DeliveryDetail>
    ),
    DeliveryDetail,
    PrefetchHooks Function()> {
  $$DeliveryDetailsTableTableManager(_$Database db, $DeliveryDetailsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeliveryDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeliveryDetailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeliveryDetailsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> soldToNumber = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> address = const Value.absent(),
            Value<String> city = const Value.absent(),
            Value<String> state = const Value.absent(),
            Value<String> pincode = const Value.absent(),
            Value<String> country = const Value.absent(),
          }) =>
              DeliveryDetailsCompanion(
            id: id,
            soldToNumber: soldToNumber,
            name: name,
            address: address,
            city: city,
            state: state,
            pincode: pincode,
            country: country,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String soldToNumber,
            required String name,
            required String address,
            required String city,
            required String state,
            required String pincode,
            required String country,
          }) =>
              DeliveryDetailsCompanion.insert(
            id: id,
            soldToNumber: soldToNumber,
            name: name,
            address: address,
            city: city,
            state: state,
            pincode: pincode,
            country: country,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DeliveryDetailsTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $DeliveryDetailsTable,
    DeliveryDetail,
    $$DeliveryDetailsTableFilterComposer,
    $$DeliveryDetailsTableOrderingComposer,
    $$DeliveryDetailsTableAnnotationComposer,
    $$DeliveryDetailsTableCreateCompanionBuilder,
    $$DeliveryDetailsTableUpdateCompanionBuilder,
    (
      DeliveryDetail,
      BaseReferences<_$Database, $DeliveryDetailsTable, DeliveryDetail>
    ),
    DeliveryDetail,
    PrefetchHooks Function()>;
typedef $$ItemMasterTableCreateCompanionBuilder = ItemMasterCompanion Function({
  required String itemNumber,
  required String article,
  required String articleDescription,
  required String uom,
  required String uomDescription,
  required String shade,
  required bool isInShadeCard,
  required DateTime lastUpdatedDateTime,
  Value<int> rowid,
});
typedef $$ItemMasterTableUpdateCompanionBuilder = ItemMasterCompanion Function({
  Value<String> itemNumber,
  Value<String> article,
  Value<String> articleDescription,
  Value<String> uom,
  Value<String> uomDescription,
  Value<String> shade,
  Value<bool> isInShadeCard,
  Value<DateTime> lastUpdatedDateTime,
  Value<int> rowid,
});

class $$ItemMasterTableFilterComposer
    extends Composer<_$Database, $ItemMasterTable> {
  $$ItemMasterTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get itemNumber => $composableBuilder(
      column: $table.itemNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get article => $composableBuilder(
      column: $table.article, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get articleDescription => $composableBuilder(
      column: $table.articleDescription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uom => $composableBuilder(
      column: $table.uom, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uomDescription => $composableBuilder(
      column: $table.uomDescription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shade => $composableBuilder(
      column: $table.shade, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isInShadeCard => $composableBuilder(
      column: $table.isInShadeCard, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdatedDateTime => $composableBuilder(
      column: $table.lastUpdatedDateTime,
      builder: (column) => ColumnFilters(column));
}

class $$ItemMasterTableOrderingComposer
    extends Composer<_$Database, $ItemMasterTable> {
  $$ItemMasterTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get itemNumber => $composableBuilder(
      column: $table.itemNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get article => $composableBuilder(
      column: $table.article, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get articleDescription => $composableBuilder(
      column: $table.articleDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uom => $composableBuilder(
      column: $table.uom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uomDescription => $composableBuilder(
      column: $table.uomDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shade => $composableBuilder(
      column: $table.shade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isInShadeCard => $composableBuilder(
      column: $table.isInShadeCard,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdatedDateTime => $composableBuilder(
      column: $table.lastUpdatedDateTime,
      builder: (column) => ColumnOrderings(column));
}

class $$ItemMasterTableAnnotationComposer
    extends Composer<_$Database, $ItemMasterTable> {
  $$ItemMasterTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get itemNumber => $composableBuilder(
      column: $table.itemNumber, builder: (column) => column);

  GeneratedColumn<String> get article =>
      $composableBuilder(column: $table.article, builder: (column) => column);

  GeneratedColumn<String> get articleDescription => $composableBuilder(
      column: $table.articleDescription, builder: (column) => column);

  GeneratedColumn<String> get uom =>
      $composableBuilder(column: $table.uom, builder: (column) => column);

  GeneratedColumn<String> get uomDescription => $composableBuilder(
      column: $table.uomDescription, builder: (column) => column);

  GeneratedColumn<String> get shade =>
      $composableBuilder(column: $table.shade, builder: (column) => column);

  GeneratedColumn<bool> get isInShadeCard => $composableBuilder(
      column: $table.isInShadeCard, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdatedDateTime => $composableBuilder(
      column: $table.lastUpdatedDateTime, builder: (column) => column);
}

class $$ItemMasterTableTableManager extends RootTableManager<
    _$Database,
    $ItemMasterTable,
    ItemMasterData,
    $$ItemMasterTableFilterComposer,
    $$ItemMasterTableOrderingComposer,
    $$ItemMasterTableAnnotationComposer,
    $$ItemMasterTableCreateCompanionBuilder,
    $$ItemMasterTableUpdateCompanionBuilder,
    (
      ItemMasterData,
      BaseReferences<_$Database, $ItemMasterTable, ItemMasterData>
    ),
    ItemMasterData,
    PrefetchHooks Function()> {
  $$ItemMasterTableTableManager(_$Database db, $ItemMasterTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemMasterTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemMasterTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemMasterTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> itemNumber = const Value.absent(),
            Value<String> article = const Value.absent(),
            Value<String> articleDescription = const Value.absent(),
            Value<String> uom = const Value.absent(),
            Value<String> uomDescription = const Value.absent(),
            Value<String> shade = const Value.absent(),
            Value<bool> isInShadeCard = const Value.absent(),
            Value<DateTime> lastUpdatedDateTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ItemMasterCompanion(
            itemNumber: itemNumber,
            article: article,
            articleDescription: articleDescription,
            uom: uom,
            uomDescription: uomDescription,
            shade: shade,
            isInShadeCard: isInShadeCard,
            lastUpdatedDateTime: lastUpdatedDateTime,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String itemNumber,
            required String article,
            required String articleDescription,
            required String uom,
            required String uomDescription,
            required String shade,
            required bool isInShadeCard,
            required DateTime lastUpdatedDateTime,
            Value<int> rowid = const Value.absent(),
          }) =>
              ItemMasterCompanion.insert(
            itemNumber: itemNumber,
            article: article,
            articleDescription: articleDescription,
            uom: uom,
            uomDescription: uomDescription,
            shade: shade,
            isInShadeCard: isInShadeCard,
            lastUpdatedDateTime: lastUpdatedDateTime,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ItemMasterTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $ItemMasterTable,
    ItemMasterData,
    $$ItemMasterTableFilterComposer,
    $$ItemMasterTableOrderingComposer,
    $$ItemMasterTableAnnotationComposer,
    $$ItemMasterTableCreateCompanionBuilder,
    $$ItemMasterTableUpdateCompanionBuilder,
    (
      ItemMasterData,
      BaseReferences<_$Database, $ItemMasterTable, ItemMasterData>
    ),
    ItemMasterData,
    PrefetchHooks Function()>;
typedef $$CartTableTableCreateCompanionBuilder = CartTableCompanion Function({
  required String soldTo,
  required String article,
  required String uom,
  required String shade,
  required int quantity,
  Value<int> rowid,
});
typedef $$CartTableTableUpdateCompanionBuilder = CartTableCompanion Function({
  Value<String> soldTo,
  Value<String> article,
  Value<String> uom,
  Value<String> shade,
  Value<int> quantity,
  Value<int> rowid,
});

class $$CartTableTableFilterComposer
    extends Composer<_$Database, $CartTableTable> {
  $$CartTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get soldTo => $composableBuilder(
      column: $table.soldTo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get article => $composableBuilder(
      column: $table.article, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uom => $composableBuilder(
      column: $table.uom, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shade => $composableBuilder(
      column: $table.shade, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));
}

class $$CartTableTableOrderingComposer
    extends Composer<_$Database, $CartTableTable> {
  $$CartTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get soldTo => $composableBuilder(
      column: $table.soldTo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get article => $composableBuilder(
      column: $table.article, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uom => $composableBuilder(
      column: $table.uom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shade => $composableBuilder(
      column: $table.shade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));
}

class $$CartTableTableAnnotationComposer
    extends Composer<_$Database, $CartTableTable> {
  $$CartTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get soldTo =>
      $composableBuilder(column: $table.soldTo, builder: (column) => column);

  GeneratedColumn<String> get article =>
      $composableBuilder(column: $table.article, builder: (column) => column);

  GeneratedColumn<String> get uom =>
      $composableBuilder(column: $table.uom, builder: (column) => column);

  GeneratedColumn<String> get shade =>
      $composableBuilder(column: $table.shade, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);
}

class $$CartTableTableTableManager extends RootTableManager<
    _$Database,
    $CartTableTable,
    CartTableData,
    $$CartTableTableFilterComposer,
    $$CartTableTableOrderingComposer,
    $$CartTableTableAnnotationComposer,
    $$CartTableTableCreateCompanionBuilder,
    $$CartTableTableUpdateCompanionBuilder,
    (CartTableData, BaseReferences<_$Database, $CartTableTable, CartTableData>),
    CartTableData,
    PrefetchHooks Function()> {
  $$CartTableTableTableManager(_$Database db, $CartTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CartTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CartTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CartTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> soldTo = const Value.absent(),
            Value<String> article = const Value.absent(),
            Value<String> uom = const Value.absent(),
            Value<String> shade = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CartTableCompanion(
            soldTo: soldTo,
            article: article,
            uom: uom,
            shade: shade,
            quantity: quantity,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String soldTo,
            required String article,
            required String uom,
            required String shade,
            required int quantity,
            Value<int> rowid = const Value.absent(),
          }) =>
              CartTableCompanion.insert(
            soldTo: soldTo,
            article: article,
            uom: uom,
            shade: shade,
            quantity: quantity,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CartTableTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $CartTableTable,
    CartTableData,
    $$CartTableTableFilterComposer,
    $$CartTableTableOrderingComposer,
    $$CartTableTableAnnotationComposer,
    $$CartTableTableCreateCompanionBuilder,
    $$CartTableTableUpdateCompanionBuilder,
    (CartTableData, BaseReferences<_$Database, $CartTableTable, CartTableData>),
    CartTableData,
    PrefetchHooks Function()>;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$UserDetailsTableTableManager get userDetails =>
      $$UserDetailsTableTableManager(_db, _db.userDetails);
  $$RelatedCustomersTableTableManager get relatedCustomers =>
      $$RelatedCustomersTableTableManager(_db, _db.relatedCustomers);
  $$BillingDetailsTableTableManager get billingDetails =>
      $$BillingDetailsTableTableManager(_db, _db.billingDetails);
  $$DeliveryDetailsTableTableManager get deliveryDetails =>
      $$DeliveryDetailsTableTableManager(_db, _db.deliveryDetails);
  $$ItemMasterTableTableManager get itemMaster =>
      $$ItemMasterTableTableManager(_db, _db.itemMaster);
  $$CartTableTableTableManager get cartTable =>
      $$CartTableTableTableManager(_db, _db.cartTable);
}
