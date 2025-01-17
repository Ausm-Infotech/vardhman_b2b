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

class $OrderStatusTable extends OrderStatus
    with TableInfo<$OrderStatusTable, OrderStatusData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderStatusTable(this.attachedDatabase, [this._alias]);
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
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderNumberMeta =
      const VerificationMeta('orderNumber');
  @override
  late final GeneratedColumn<int> orderNumber = GeneratedColumn<int>(
      'order_number', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _orderTypeMeta =
      const VerificationMeta('orderType');
  @override
  late final GeneratedColumn<String> orderType = GeneratedColumn<String>(
      'order_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderCompanyMeta =
      const VerificationMeta('orderCompany');
  @override
  late final GeneratedColumn<String> orderCompany = GeneratedColumn<String>(
      'order_company', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderDateMeta =
      const VerificationMeta('orderDate');
  @override
  late final GeneratedColumn<DateTime> orderDate = GeneratedColumn<DateTime>(
      'order_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _orderReferenceMeta =
      const VerificationMeta('orderReference');
  @override
  late final GeneratedColumn<String> orderReference = GeneratedColumn<String>(
      'order_reference', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _holdCodeMeta =
      const VerificationMeta('holdCode');
  @override
  late final GeneratedColumn<String> holdCode = GeneratedColumn<String>(
      'hold_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shipToMeta = const VerificationMeta('shipTo');
  @override
  late final GeneratedColumn<int> shipTo = GeneratedColumn<int>(
      'ship_to', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _quantityOrderedMeta =
      const VerificationMeta('quantityOrdered');
  @override
  late final GeneratedColumn<int> quantityOrdered = GeneratedColumn<int>(
      'quantity_ordered', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _quantityShippedMeta =
      const VerificationMeta('quantityShipped');
  @override
  late final GeneratedColumn<int> quantityShipped = GeneratedColumn<int>(
      'quantity_shipped', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _quantityCancelledMeta =
      const VerificationMeta('quantityCancelled');
  @override
  late final GeneratedColumn<int> quantityCancelled = GeneratedColumn<int>(
      'quantity_cancelled', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _orderStatusMeta =
      const VerificationMeta('orderStatus');
  @override
  late final GeneratedColumn<String> orderStatus = GeneratedColumn<String>(
      'order_status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderAmountMeta =
      const VerificationMeta('orderAmount');
  @override
  late final GeneratedColumn<double> orderAmount = GeneratedColumn<double>(
      'order_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        soldToNumber,
        orderNumber,
        orderType,
        orderCompany,
        orderDate,
        orderReference,
        holdCode,
        shipTo,
        quantityOrdered,
        quantityShipped,
        quantityCancelled,
        orderStatus,
        orderAmount
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_status';
  @override
  VerificationContext validateIntegrity(Insertable<OrderStatusData> instance,
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
    if (data.containsKey('order_number')) {
      context.handle(
          _orderNumberMeta,
          orderNumber.isAcceptableOrUnknown(
              data['order_number']!, _orderNumberMeta));
    } else if (isInserting) {
      context.missing(_orderNumberMeta);
    }
    if (data.containsKey('order_type')) {
      context.handle(_orderTypeMeta,
          orderType.isAcceptableOrUnknown(data['order_type']!, _orderTypeMeta));
    } else if (isInserting) {
      context.missing(_orderTypeMeta);
    }
    if (data.containsKey('order_company')) {
      context.handle(
          _orderCompanyMeta,
          orderCompany.isAcceptableOrUnknown(
              data['order_company']!, _orderCompanyMeta));
    } else if (isInserting) {
      context.missing(_orderCompanyMeta);
    }
    if (data.containsKey('order_date')) {
      context.handle(_orderDateMeta,
          orderDate.isAcceptableOrUnknown(data['order_date']!, _orderDateMeta));
    } else if (isInserting) {
      context.missing(_orderDateMeta);
    }
    if (data.containsKey('order_reference')) {
      context.handle(
          _orderReferenceMeta,
          orderReference.isAcceptableOrUnknown(
              data['order_reference']!, _orderReferenceMeta));
    } else if (isInserting) {
      context.missing(_orderReferenceMeta);
    }
    if (data.containsKey('hold_code')) {
      context.handle(_holdCodeMeta,
          holdCode.isAcceptableOrUnknown(data['hold_code']!, _holdCodeMeta));
    } else if (isInserting) {
      context.missing(_holdCodeMeta);
    }
    if (data.containsKey('ship_to')) {
      context.handle(_shipToMeta,
          shipTo.isAcceptableOrUnknown(data['ship_to']!, _shipToMeta));
    } else if (isInserting) {
      context.missing(_shipToMeta);
    }
    if (data.containsKey('quantity_ordered')) {
      context.handle(
          _quantityOrderedMeta,
          quantityOrdered.isAcceptableOrUnknown(
              data['quantity_ordered']!, _quantityOrderedMeta));
    } else if (isInserting) {
      context.missing(_quantityOrderedMeta);
    }
    if (data.containsKey('quantity_shipped')) {
      context.handle(
          _quantityShippedMeta,
          quantityShipped.isAcceptableOrUnknown(
              data['quantity_shipped']!, _quantityShippedMeta));
    } else if (isInserting) {
      context.missing(_quantityShippedMeta);
    }
    if (data.containsKey('quantity_cancelled')) {
      context.handle(
          _quantityCancelledMeta,
          quantityCancelled.isAcceptableOrUnknown(
              data['quantity_cancelled']!, _quantityCancelledMeta));
    } else if (isInserting) {
      context.missing(_quantityCancelledMeta);
    }
    if (data.containsKey('order_status')) {
      context.handle(
          _orderStatusMeta,
          orderStatus.isAcceptableOrUnknown(
              data['order_status']!, _orderStatusMeta));
    } else if (isInserting) {
      context.missing(_orderStatusMeta);
    }
    if (data.containsKey('order_amount')) {
      context.handle(
          _orderAmountMeta,
          orderAmount.isAcceptableOrUnknown(
              data['order_amount']!, _orderAmountMeta));
    } else if (isInserting) {
      context.missing(_orderAmountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderStatusData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderStatusData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      soldToNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sold_to_number'])!,
      orderNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_number'])!,
      orderType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_type'])!,
      orderCompany: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_company'])!,
      orderDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}order_date'])!,
      orderReference: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}order_reference'])!,
      holdCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hold_code'])!,
      shipTo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ship_to'])!,
      quantityOrdered: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity_ordered'])!,
      quantityShipped: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity_shipped'])!,
      quantityCancelled: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}quantity_cancelled'])!,
      orderStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_status'])!,
      orderAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}order_amount'])!,
    );
  }

  @override
  $OrderStatusTable createAlias(String alias) {
    return $OrderStatusTable(attachedDatabase, alias);
  }
}

class OrderStatusData extends DataClass implements Insertable<OrderStatusData> {
  final int id;
  final String soldToNumber;
  final int orderNumber;
  final String orderType;
  final String orderCompany;
  final DateTime orderDate;
  final String orderReference;
  final String holdCode;
  final int shipTo;
  final int quantityOrdered;
  final int quantityShipped;
  final int quantityCancelled;
  final String orderStatus;
  final double orderAmount;
  const OrderStatusData(
      {required this.id,
      required this.soldToNumber,
      required this.orderNumber,
      required this.orderType,
      required this.orderCompany,
      required this.orderDate,
      required this.orderReference,
      required this.holdCode,
      required this.shipTo,
      required this.quantityOrdered,
      required this.quantityShipped,
      required this.quantityCancelled,
      required this.orderStatus,
      required this.orderAmount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sold_to_number'] = Variable<String>(soldToNumber);
    map['order_number'] = Variable<int>(orderNumber);
    map['order_type'] = Variable<String>(orderType);
    map['order_company'] = Variable<String>(orderCompany);
    map['order_date'] = Variable<DateTime>(orderDate);
    map['order_reference'] = Variable<String>(orderReference);
    map['hold_code'] = Variable<String>(holdCode);
    map['ship_to'] = Variable<int>(shipTo);
    map['quantity_ordered'] = Variable<int>(quantityOrdered);
    map['quantity_shipped'] = Variable<int>(quantityShipped);
    map['quantity_cancelled'] = Variable<int>(quantityCancelled);
    map['order_status'] = Variable<String>(orderStatus);
    map['order_amount'] = Variable<double>(orderAmount);
    return map;
  }

  OrderStatusCompanion toCompanion(bool nullToAbsent) {
    return OrderStatusCompanion(
      id: Value(id),
      soldToNumber: Value(soldToNumber),
      orderNumber: Value(orderNumber),
      orderType: Value(orderType),
      orderCompany: Value(orderCompany),
      orderDate: Value(orderDate),
      orderReference: Value(orderReference),
      holdCode: Value(holdCode),
      shipTo: Value(shipTo),
      quantityOrdered: Value(quantityOrdered),
      quantityShipped: Value(quantityShipped),
      quantityCancelled: Value(quantityCancelled),
      orderStatus: Value(orderStatus),
      orderAmount: Value(orderAmount),
    );
  }

  factory OrderStatusData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderStatusData(
      id: serializer.fromJson<int>(json['id']),
      soldToNumber: serializer.fromJson<String>(json['soldToNumber']),
      orderNumber: serializer.fromJson<int>(json['orderNumber']),
      orderType: serializer.fromJson<String>(json['orderType']),
      orderCompany: serializer.fromJson<String>(json['orderCompany']),
      orderDate: serializer.fromJson<DateTime>(json['orderDate']),
      orderReference: serializer.fromJson<String>(json['orderReference']),
      holdCode: serializer.fromJson<String>(json['holdCode']),
      shipTo: serializer.fromJson<int>(json['shipTo']),
      quantityOrdered: serializer.fromJson<int>(json['quantityOrdered']),
      quantityShipped: serializer.fromJson<int>(json['quantityShipped']),
      quantityCancelled: serializer.fromJson<int>(json['quantityCancelled']),
      orderStatus: serializer.fromJson<String>(json['orderStatus']),
      orderAmount: serializer.fromJson<double>(json['orderAmount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'soldToNumber': serializer.toJson<String>(soldToNumber),
      'orderNumber': serializer.toJson<int>(orderNumber),
      'orderType': serializer.toJson<String>(orderType),
      'orderCompany': serializer.toJson<String>(orderCompany),
      'orderDate': serializer.toJson<DateTime>(orderDate),
      'orderReference': serializer.toJson<String>(orderReference),
      'holdCode': serializer.toJson<String>(holdCode),
      'shipTo': serializer.toJson<int>(shipTo),
      'quantityOrdered': serializer.toJson<int>(quantityOrdered),
      'quantityShipped': serializer.toJson<int>(quantityShipped),
      'quantityCancelled': serializer.toJson<int>(quantityCancelled),
      'orderStatus': serializer.toJson<String>(orderStatus),
      'orderAmount': serializer.toJson<double>(orderAmount),
    };
  }

  OrderStatusData copyWith(
          {int? id,
          String? soldToNumber,
          int? orderNumber,
          String? orderType,
          String? orderCompany,
          DateTime? orderDate,
          String? orderReference,
          String? holdCode,
          int? shipTo,
          int? quantityOrdered,
          int? quantityShipped,
          int? quantityCancelled,
          String? orderStatus,
          double? orderAmount}) =>
      OrderStatusData(
        id: id ?? this.id,
        soldToNumber: soldToNumber ?? this.soldToNumber,
        orderNumber: orderNumber ?? this.orderNumber,
        orderType: orderType ?? this.orderType,
        orderCompany: orderCompany ?? this.orderCompany,
        orderDate: orderDate ?? this.orderDate,
        orderReference: orderReference ?? this.orderReference,
        holdCode: holdCode ?? this.holdCode,
        shipTo: shipTo ?? this.shipTo,
        quantityOrdered: quantityOrdered ?? this.quantityOrdered,
        quantityShipped: quantityShipped ?? this.quantityShipped,
        quantityCancelled: quantityCancelled ?? this.quantityCancelled,
        orderStatus: orderStatus ?? this.orderStatus,
        orderAmount: orderAmount ?? this.orderAmount,
      );
  OrderStatusData copyWithCompanion(OrderStatusCompanion data) {
    return OrderStatusData(
      id: data.id.present ? data.id.value : this.id,
      soldToNumber: data.soldToNumber.present
          ? data.soldToNumber.value
          : this.soldToNumber,
      orderNumber:
          data.orderNumber.present ? data.orderNumber.value : this.orderNumber,
      orderType: data.orderType.present ? data.orderType.value : this.orderType,
      orderCompany: data.orderCompany.present
          ? data.orderCompany.value
          : this.orderCompany,
      orderDate: data.orderDate.present ? data.orderDate.value : this.orderDate,
      orderReference: data.orderReference.present
          ? data.orderReference.value
          : this.orderReference,
      holdCode: data.holdCode.present ? data.holdCode.value : this.holdCode,
      shipTo: data.shipTo.present ? data.shipTo.value : this.shipTo,
      quantityOrdered: data.quantityOrdered.present
          ? data.quantityOrdered.value
          : this.quantityOrdered,
      quantityShipped: data.quantityShipped.present
          ? data.quantityShipped.value
          : this.quantityShipped,
      quantityCancelled: data.quantityCancelled.present
          ? data.quantityCancelled.value
          : this.quantityCancelled,
      orderStatus:
          data.orderStatus.present ? data.orderStatus.value : this.orderStatus,
      orderAmount:
          data.orderAmount.present ? data.orderAmount.value : this.orderAmount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderStatusData(')
          ..write('id: $id, ')
          ..write('soldToNumber: $soldToNumber, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('orderType: $orderType, ')
          ..write('orderCompany: $orderCompany, ')
          ..write('orderDate: $orderDate, ')
          ..write('orderReference: $orderReference, ')
          ..write('holdCode: $holdCode, ')
          ..write('shipTo: $shipTo, ')
          ..write('quantityOrdered: $quantityOrdered, ')
          ..write('quantityShipped: $quantityShipped, ')
          ..write('quantityCancelled: $quantityCancelled, ')
          ..write('orderStatus: $orderStatus, ')
          ..write('orderAmount: $orderAmount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      soldToNumber,
      orderNumber,
      orderType,
      orderCompany,
      orderDate,
      orderReference,
      holdCode,
      shipTo,
      quantityOrdered,
      quantityShipped,
      quantityCancelled,
      orderStatus,
      orderAmount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderStatusData &&
          other.id == this.id &&
          other.soldToNumber == this.soldToNumber &&
          other.orderNumber == this.orderNumber &&
          other.orderType == this.orderType &&
          other.orderCompany == this.orderCompany &&
          other.orderDate == this.orderDate &&
          other.orderReference == this.orderReference &&
          other.holdCode == this.holdCode &&
          other.shipTo == this.shipTo &&
          other.quantityOrdered == this.quantityOrdered &&
          other.quantityShipped == this.quantityShipped &&
          other.quantityCancelled == this.quantityCancelled &&
          other.orderStatus == this.orderStatus &&
          other.orderAmount == this.orderAmount);
}

class OrderStatusCompanion extends UpdateCompanion<OrderStatusData> {
  final Value<int> id;
  final Value<String> soldToNumber;
  final Value<int> orderNumber;
  final Value<String> orderType;
  final Value<String> orderCompany;
  final Value<DateTime> orderDate;
  final Value<String> orderReference;
  final Value<String> holdCode;
  final Value<int> shipTo;
  final Value<int> quantityOrdered;
  final Value<int> quantityShipped;
  final Value<int> quantityCancelled;
  final Value<String> orderStatus;
  final Value<double> orderAmount;
  const OrderStatusCompanion({
    this.id = const Value.absent(),
    this.soldToNumber = const Value.absent(),
    this.orderNumber = const Value.absent(),
    this.orderType = const Value.absent(),
    this.orderCompany = const Value.absent(),
    this.orderDate = const Value.absent(),
    this.orderReference = const Value.absent(),
    this.holdCode = const Value.absent(),
    this.shipTo = const Value.absent(),
    this.quantityOrdered = const Value.absent(),
    this.quantityShipped = const Value.absent(),
    this.quantityCancelled = const Value.absent(),
    this.orderStatus = const Value.absent(),
    this.orderAmount = const Value.absent(),
  });
  OrderStatusCompanion.insert({
    this.id = const Value.absent(),
    required String soldToNumber,
    required int orderNumber,
    required String orderType,
    required String orderCompany,
    required DateTime orderDate,
    required String orderReference,
    required String holdCode,
    required int shipTo,
    required int quantityOrdered,
    required int quantityShipped,
    required int quantityCancelled,
    required String orderStatus,
    required double orderAmount,
  })  : soldToNumber = Value(soldToNumber),
        orderNumber = Value(orderNumber),
        orderType = Value(orderType),
        orderCompany = Value(orderCompany),
        orderDate = Value(orderDate),
        orderReference = Value(orderReference),
        holdCode = Value(holdCode),
        shipTo = Value(shipTo),
        quantityOrdered = Value(quantityOrdered),
        quantityShipped = Value(quantityShipped),
        quantityCancelled = Value(quantityCancelled),
        orderStatus = Value(orderStatus),
        orderAmount = Value(orderAmount);
  static Insertable<OrderStatusData> custom({
    Expression<int>? id,
    Expression<String>? soldToNumber,
    Expression<int>? orderNumber,
    Expression<String>? orderType,
    Expression<String>? orderCompany,
    Expression<DateTime>? orderDate,
    Expression<String>? orderReference,
    Expression<String>? holdCode,
    Expression<int>? shipTo,
    Expression<int>? quantityOrdered,
    Expression<int>? quantityShipped,
    Expression<int>? quantityCancelled,
    Expression<String>? orderStatus,
    Expression<double>? orderAmount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (soldToNumber != null) 'sold_to_number': soldToNumber,
      if (orderNumber != null) 'order_number': orderNumber,
      if (orderType != null) 'order_type': orderType,
      if (orderCompany != null) 'order_company': orderCompany,
      if (orderDate != null) 'order_date': orderDate,
      if (orderReference != null) 'order_reference': orderReference,
      if (holdCode != null) 'hold_code': holdCode,
      if (shipTo != null) 'ship_to': shipTo,
      if (quantityOrdered != null) 'quantity_ordered': quantityOrdered,
      if (quantityShipped != null) 'quantity_shipped': quantityShipped,
      if (quantityCancelled != null) 'quantity_cancelled': quantityCancelled,
      if (orderStatus != null) 'order_status': orderStatus,
      if (orderAmount != null) 'order_amount': orderAmount,
    });
  }

  OrderStatusCompanion copyWith(
      {Value<int>? id,
      Value<String>? soldToNumber,
      Value<int>? orderNumber,
      Value<String>? orderType,
      Value<String>? orderCompany,
      Value<DateTime>? orderDate,
      Value<String>? orderReference,
      Value<String>? holdCode,
      Value<int>? shipTo,
      Value<int>? quantityOrdered,
      Value<int>? quantityShipped,
      Value<int>? quantityCancelled,
      Value<String>? orderStatus,
      Value<double>? orderAmount}) {
    return OrderStatusCompanion(
      id: id ?? this.id,
      soldToNumber: soldToNumber ?? this.soldToNumber,
      orderNumber: orderNumber ?? this.orderNumber,
      orderType: orderType ?? this.orderType,
      orderCompany: orderCompany ?? this.orderCompany,
      orderDate: orderDate ?? this.orderDate,
      orderReference: orderReference ?? this.orderReference,
      holdCode: holdCode ?? this.holdCode,
      shipTo: shipTo ?? this.shipTo,
      quantityOrdered: quantityOrdered ?? this.quantityOrdered,
      quantityShipped: quantityShipped ?? this.quantityShipped,
      quantityCancelled: quantityCancelled ?? this.quantityCancelled,
      orderStatus: orderStatus ?? this.orderStatus,
      orderAmount: orderAmount ?? this.orderAmount,
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
    if (orderNumber.present) {
      map['order_number'] = Variable<int>(orderNumber.value);
    }
    if (orderType.present) {
      map['order_type'] = Variable<String>(orderType.value);
    }
    if (orderCompany.present) {
      map['order_company'] = Variable<String>(orderCompany.value);
    }
    if (orderDate.present) {
      map['order_date'] = Variable<DateTime>(orderDate.value);
    }
    if (orderReference.present) {
      map['order_reference'] = Variable<String>(orderReference.value);
    }
    if (holdCode.present) {
      map['hold_code'] = Variable<String>(holdCode.value);
    }
    if (shipTo.present) {
      map['ship_to'] = Variable<int>(shipTo.value);
    }
    if (quantityOrdered.present) {
      map['quantity_ordered'] = Variable<int>(quantityOrdered.value);
    }
    if (quantityShipped.present) {
      map['quantity_shipped'] = Variable<int>(quantityShipped.value);
    }
    if (quantityCancelled.present) {
      map['quantity_cancelled'] = Variable<int>(quantityCancelled.value);
    }
    if (orderStatus.present) {
      map['order_status'] = Variable<String>(orderStatus.value);
    }
    if (orderAmount.present) {
      map['order_amount'] = Variable<double>(orderAmount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderStatusCompanion(')
          ..write('id: $id, ')
          ..write('soldToNumber: $soldToNumber, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('orderType: $orderType, ')
          ..write('orderCompany: $orderCompany, ')
          ..write('orderDate: $orderDate, ')
          ..write('orderReference: $orderReference, ')
          ..write('holdCode: $holdCode, ')
          ..write('shipTo: $shipTo, ')
          ..write('quantityOrdered: $quantityOrdered, ')
          ..write('quantityShipped: $quantityShipped, ')
          ..write('quantityCancelled: $quantityCancelled, ')
          ..write('orderStatus: $orderStatus, ')
          ..write('orderAmount: $orderAmount')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $UserDetailsTable userDetails = $UserDetailsTable(this);
  late final $BillingDetailsTable billingDetails = $BillingDetailsTable(this);
  late final $DeliveryDetailsTable deliveryDetails =
      $DeliveryDetailsTable(this);
  late final $RelatedCustomersTable relatedCustomers =
      $RelatedCustomersTable(this);
  late final $OrderStatusTable orderStatus = $OrderStatusTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        userDetails,
        billingDetails,
        deliveryDetails,
        relatedCustomers,
        orderStatus
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
typedef $$OrderStatusTableCreateCompanionBuilder = OrderStatusCompanion
    Function({
  Value<int> id,
  required String soldToNumber,
  required int orderNumber,
  required String orderType,
  required String orderCompany,
  required DateTime orderDate,
  required String orderReference,
  required String holdCode,
  required int shipTo,
  required int quantityOrdered,
  required int quantityShipped,
  required int quantityCancelled,
  required String orderStatus,
  required double orderAmount,
});
typedef $$OrderStatusTableUpdateCompanionBuilder = OrderStatusCompanion
    Function({
  Value<int> id,
  Value<String> soldToNumber,
  Value<int> orderNumber,
  Value<String> orderType,
  Value<String> orderCompany,
  Value<DateTime> orderDate,
  Value<String> orderReference,
  Value<String> holdCode,
  Value<int> shipTo,
  Value<int> quantityOrdered,
  Value<int> quantityShipped,
  Value<int> quantityCancelled,
  Value<String> orderStatus,
  Value<double> orderAmount,
});

class $$OrderStatusTableFilterComposer
    extends Composer<_$Database, $OrderStatusTable> {
  $$OrderStatusTableFilterComposer({
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

  ColumnFilters<int> get orderNumber => $composableBuilder(
      column: $table.orderNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderType => $composableBuilder(
      column: $table.orderType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderCompany => $composableBuilder(
      column: $table.orderCompany, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get orderDate => $composableBuilder(
      column: $table.orderDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderReference => $composableBuilder(
      column: $table.orderReference,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get holdCode => $composableBuilder(
      column: $table.holdCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get shipTo => $composableBuilder(
      column: $table.shipTo, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantityOrdered => $composableBuilder(
      column: $table.quantityOrdered,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantityShipped => $composableBuilder(
      column: $table.quantityShipped,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantityCancelled => $composableBuilder(
      column: $table.quantityCancelled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderStatus => $composableBuilder(
      column: $table.orderStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get orderAmount => $composableBuilder(
      column: $table.orderAmount, builder: (column) => ColumnFilters(column));
}

class $$OrderStatusTableOrderingComposer
    extends Composer<_$Database, $OrderStatusTable> {
  $$OrderStatusTableOrderingComposer({
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

  ColumnOrderings<int> get orderNumber => $composableBuilder(
      column: $table.orderNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderType => $composableBuilder(
      column: $table.orderType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderCompany => $composableBuilder(
      column: $table.orderCompany,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get orderDate => $composableBuilder(
      column: $table.orderDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderReference => $composableBuilder(
      column: $table.orderReference,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get holdCode => $composableBuilder(
      column: $table.holdCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get shipTo => $composableBuilder(
      column: $table.shipTo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantityOrdered => $composableBuilder(
      column: $table.quantityOrdered,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantityShipped => $composableBuilder(
      column: $table.quantityShipped,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantityCancelled => $composableBuilder(
      column: $table.quantityCancelled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderStatus => $composableBuilder(
      column: $table.orderStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get orderAmount => $composableBuilder(
      column: $table.orderAmount, builder: (column) => ColumnOrderings(column));
}

class $$OrderStatusTableAnnotationComposer
    extends Composer<_$Database, $OrderStatusTable> {
  $$OrderStatusTableAnnotationComposer({
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

  GeneratedColumn<int> get orderNumber => $composableBuilder(
      column: $table.orderNumber, builder: (column) => column);

  GeneratedColumn<String> get orderType =>
      $composableBuilder(column: $table.orderType, builder: (column) => column);

  GeneratedColumn<String> get orderCompany => $composableBuilder(
      column: $table.orderCompany, builder: (column) => column);

  GeneratedColumn<DateTime> get orderDate =>
      $composableBuilder(column: $table.orderDate, builder: (column) => column);

  GeneratedColumn<String> get orderReference => $composableBuilder(
      column: $table.orderReference, builder: (column) => column);

  GeneratedColumn<String> get holdCode =>
      $composableBuilder(column: $table.holdCode, builder: (column) => column);

  GeneratedColumn<int> get shipTo =>
      $composableBuilder(column: $table.shipTo, builder: (column) => column);

  GeneratedColumn<int> get quantityOrdered => $composableBuilder(
      column: $table.quantityOrdered, builder: (column) => column);

  GeneratedColumn<int> get quantityShipped => $composableBuilder(
      column: $table.quantityShipped, builder: (column) => column);

  GeneratedColumn<int> get quantityCancelled => $composableBuilder(
      column: $table.quantityCancelled, builder: (column) => column);

  GeneratedColumn<String> get orderStatus => $composableBuilder(
      column: $table.orderStatus, builder: (column) => column);

  GeneratedColumn<double> get orderAmount => $composableBuilder(
      column: $table.orderAmount, builder: (column) => column);
}

class $$OrderStatusTableTableManager extends RootTableManager<
    _$Database,
    $OrderStatusTable,
    OrderStatusData,
    $$OrderStatusTableFilterComposer,
    $$OrderStatusTableOrderingComposer,
    $$OrderStatusTableAnnotationComposer,
    $$OrderStatusTableCreateCompanionBuilder,
    $$OrderStatusTableUpdateCompanionBuilder,
    (
      OrderStatusData,
      BaseReferences<_$Database, $OrderStatusTable, OrderStatusData>
    ),
    OrderStatusData,
    PrefetchHooks Function()> {
  $$OrderStatusTableTableManager(_$Database db, $OrderStatusTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrderStatusTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrderStatusTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrderStatusTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> soldToNumber = const Value.absent(),
            Value<int> orderNumber = const Value.absent(),
            Value<String> orderType = const Value.absent(),
            Value<String> orderCompany = const Value.absent(),
            Value<DateTime> orderDate = const Value.absent(),
            Value<String> orderReference = const Value.absent(),
            Value<String> holdCode = const Value.absent(),
            Value<int> shipTo = const Value.absent(),
            Value<int> quantityOrdered = const Value.absent(),
            Value<int> quantityShipped = const Value.absent(),
            Value<int> quantityCancelled = const Value.absent(),
            Value<String> orderStatus = const Value.absent(),
            Value<double> orderAmount = const Value.absent(),
          }) =>
              OrderStatusCompanion(
            id: id,
            soldToNumber: soldToNumber,
            orderNumber: orderNumber,
            orderType: orderType,
            orderCompany: orderCompany,
            orderDate: orderDate,
            orderReference: orderReference,
            holdCode: holdCode,
            shipTo: shipTo,
            quantityOrdered: quantityOrdered,
            quantityShipped: quantityShipped,
            quantityCancelled: quantityCancelled,
            orderStatus: orderStatus,
            orderAmount: orderAmount,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String soldToNumber,
            required int orderNumber,
            required String orderType,
            required String orderCompany,
            required DateTime orderDate,
            required String orderReference,
            required String holdCode,
            required int shipTo,
            required int quantityOrdered,
            required int quantityShipped,
            required int quantityCancelled,
            required String orderStatus,
            required double orderAmount,
          }) =>
              OrderStatusCompanion.insert(
            id: id,
            soldToNumber: soldToNumber,
            orderNumber: orderNumber,
            orderType: orderType,
            orderCompany: orderCompany,
            orderDate: orderDate,
            orderReference: orderReference,
            holdCode: holdCode,
            shipTo: shipTo,
            quantityOrdered: quantityOrdered,
            quantityShipped: quantityShipped,
            quantityCancelled: quantityCancelled,
            orderStatus: orderStatus,
            orderAmount: orderAmount,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OrderStatusTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $OrderStatusTable,
    OrderStatusData,
    $$OrderStatusTableFilterComposer,
    $$OrderStatusTableOrderingComposer,
    $$OrderStatusTableAnnotationComposer,
    $$OrderStatusTableCreateCompanionBuilder,
    $$OrderStatusTableUpdateCompanionBuilder,
    (
      OrderStatusData,
      BaseReferences<_$Database, $OrderStatusTable, OrderStatusData>
    ),
    OrderStatusData,
    PrefetchHooks Function()>;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$UserDetailsTableTableManager get userDetails =>
      $$UserDetailsTableTableManager(_db, _db.userDetails);
  $$BillingDetailsTableTableManager get billingDetails =>
      $$BillingDetailsTableTableManager(_db, _db.billingDetails);
  $$DeliveryDetailsTableTableManager get deliveryDetails =>
      $$DeliveryDetailsTableTableManager(_db, _db.deliveryDetails);
  $$RelatedCustomersTableTableManager get relatedCustomers =>
      $$RelatedCustomersTableTableManager(_db, _db.relatedCustomers);
  $$OrderStatusTableTableManager get orderStatus =>
      $$OrderStatusTableTableManager(_db, _db.orderStatus);
}
