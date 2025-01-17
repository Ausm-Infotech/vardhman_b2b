// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InvoiceInfo _$InvoiceInfoFromJson(Map<String, dynamic> json) {
  return _InvoiceInfo.fromJson(json);
}

/// @nodoc
mixin _$InvoiceInfo {
  double get openAmount => throw _privateConstructorUsedError;
  double get grossAmount => throw _privateConstructorUsedError;
  double get discountAmount => throw _privateConstructorUsedError;
  double get taxableAmount => throw _privateConstructorUsedError;
  double get tax => throw _privateConstructorUsedError;
  String get customerNumber => throw _privateConstructorUsedError;
  String get company => throw _privateConstructorUsedError;
  String get docType => throw _privateConstructorUsedError;
  int get invoiceNumber => throw _privateConstructorUsedError;
  int get salesOrderNumber => throw _privateConstructorUsedError;
  String get salesOrderType => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  DateTime get discountDueDate => throw _privateConstructorUsedError;
  bool get isOpen => throw _privateConstructorUsedError;
  InvoiceStatus get status => throw _privateConstructorUsedError;
  String get receiptNumber => throw _privateConstructorUsedError;
  DateTime get receiptDate => throw _privateConstructorUsedError;

  /// Serializes this InvoiceInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InvoiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvoiceInfoCopyWith<InvoiceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceInfoCopyWith<$Res> {
  factory $InvoiceInfoCopyWith(
          InvoiceInfo value, $Res Function(InvoiceInfo) then) =
      _$InvoiceInfoCopyWithImpl<$Res, InvoiceInfo>;
  @useResult
  $Res call(
      {double openAmount,
      double grossAmount,
      double discountAmount,
      double taxableAmount,
      double tax,
      String customerNumber,
      String company,
      String docType,
      int invoiceNumber,
      int salesOrderNumber,
      String salesOrderType,
      DateTime date,
      DateTime discountDueDate,
      bool isOpen,
      InvoiceStatus status,
      String receiptNumber,
      DateTime receiptDate});
}

/// @nodoc
class _$InvoiceInfoCopyWithImpl<$Res, $Val extends InvoiceInfo>
    implements $InvoiceInfoCopyWith<$Res> {
  _$InvoiceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvoiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? openAmount = null,
    Object? grossAmount = null,
    Object? discountAmount = null,
    Object? taxableAmount = null,
    Object? tax = null,
    Object? customerNumber = null,
    Object? company = null,
    Object? docType = null,
    Object? invoiceNumber = null,
    Object? salesOrderNumber = null,
    Object? salesOrderType = null,
    Object? date = null,
    Object? discountDueDate = null,
    Object? isOpen = null,
    Object? status = null,
    Object? receiptNumber = null,
    Object? receiptDate = null,
  }) {
    return _then(_value.copyWith(
      openAmount: null == openAmount
          ? _value.openAmount
          : openAmount // ignore: cast_nullable_to_non_nullable
              as double,
      grossAmount: null == grossAmount
          ? _value.grossAmount
          : grossAmount // ignore: cast_nullable_to_non_nullable
              as double,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double,
      taxableAmount: null == taxableAmount
          ? _value.taxableAmount
          : taxableAmount // ignore: cast_nullable_to_non_nullable
              as double,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      customerNumber: null == customerNumber
          ? _value.customerNumber
          : customerNumber // ignore: cast_nullable_to_non_nullable
              as String,
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      docType: null == docType
          ? _value.docType
          : docType // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceNumber: null == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as int,
      salesOrderNumber: null == salesOrderNumber
          ? _value.salesOrderNumber
          : salesOrderNumber // ignore: cast_nullable_to_non_nullable
              as int,
      salesOrderType: null == salesOrderType
          ? _value.salesOrderType
          : salesOrderType // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      discountDueDate: null == discountDueDate
          ? _value.discountDueDate
          : discountDueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isOpen: null == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as InvoiceStatus,
      receiptNumber: null == receiptNumber
          ? _value.receiptNumber
          : receiptNumber // ignore: cast_nullable_to_non_nullable
              as String,
      receiptDate: null == receiptDate
          ? _value.receiptDate
          : receiptDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoiceInfoImplCopyWith<$Res>
    implements $InvoiceInfoCopyWith<$Res> {
  factory _$$InvoiceInfoImplCopyWith(
          _$InvoiceInfoImpl value, $Res Function(_$InvoiceInfoImpl) then) =
      __$$InvoiceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double openAmount,
      double grossAmount,
      double discountAmount,
      double taxableAmount,
      double tax,
      String customerNumber,
      String company,
      String docType,
      int invoiceNumber,
      int salesOrderNumber,
      String salesOrderType,
      DateTime date,
      DateTime discountDueDate,
      bool isOpen,
      InvoiceStatus status,
      String receiptNumber,
      DateTime receiptDate});
}

/// @nodoc
class __$$InvoiceInfoImplCopyWithImpl<$Res>
    extends _$InvoiceInfoCopyWithImpl<$Res, _$InvoiceInfoImpl>
    implements _$$InvoiceInfoImplCopyWith<$Res> {
  __$$InvoiceInfoImplCopyWithImpl(
      _$InvoiceInfoImpl _value, $Res Function(_$InvoiceInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of InvoiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? openAmount = null,
    Object? grossAmount = null,
    Object? discountAmount = null,
    Object? taxableAmount = null,
    Object? tax = null,
    Object? customerNumber = null,
    Object? company = null,
    Object? docType = null,
    Object? invoiceNumber = null,
    Object? salesOrderNumber = null,
    Object? salesOrderType = null,
    Object? date = null,
    Object? discountDueDate = null,
    Object? isOpen = null,
    Object? status = null,
    Object? receiptNumber = null,
    Object? receiptDate = null,
  }) {
    return _then(_$InvoiceInfoImpl(
      openAmount: null == openAmount
          ? _value.openAmount
          : openAmount // ignore: cast_nullable_to_non_nullable
              as double,
      grossAmount: null == grossAmount
          ? _value.grossAmount
          : grossAmount // ignore: cast_nullable_to_non_nullable
              as double,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double,
      taxableAmount: null == taxableAmount
          ? _value.taxableAmount
          : taxableAmount // ignore: cast_nullable_to_non_nullable
              as double,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      customerNumber: null == customerNumber
          ? _value.customerNumber
          : customerNumber // ignore: cast_nullable_to_non_nullable
              as String,
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      docType: null == docType
          ? _value.docType
          : docType // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceNumber: null == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as int,
      salesOrderNumber: null == salesOrderNumber
          ? _value.salesOrderNumber
          : salesOrderNumber // ignore: cast_nullable_to_non_nullable
              as int,
      salesOrderType: null == salesOrderType
          ? _value.salesOrderType
          : salesOrderType // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      discountDueDate: null == discountDueDate
          ? _value.discountDueDate
          : discountDueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isOpen: null == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as InvoiceStatus,
      receiptNumber: null == receiptNumber
          ? _value.receiptNumber
          : receiptNumber // ignore: cast_nullable_to_non_nullable
              as String,
      receiptDate: null == receiptDate
          ? _value.receiptDate
          : receiptDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceInfoImpl implements _InvoiceInfo {
  const _$InvoiceInfoImpl(
      {required this.openAmount,
      required this.grossAmount,
      required this.discountAmount,
      required this.taxableAmount,
      required this.tax,
      required this.customerNumber,
      required this.company,
      required this.docType,
      required this.invoiceNumber,
      required this.salesOrderNumber,
      required this.salesOrderType,
      required this.date,
      required this.discountDueDate,
      required this.isOpen,
      required this.status,
      required this.receiptNumber,
      required this.receiptDate});

  factory _$InvoiceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceInfoImplFromJson(json);

  @override
  final double openAmount;
  @override
  final double grossAmount;
  @override
  final double discountAmount;
  @override
  final double taxableAmount;
  @override
  final double tax;
  @override
  final String customerNumber;
  @override
  final String company;
  @override
  final String docType;
  @override
  final int invoiceNumber;
  @override
  final int salesOrderNumber;
  @override
  final String salesOrderType;
  @override
  final DateTime date;
  @override
  final DateTime discountDueDate;
  @override
  final bool isOpen;
  @override
  final InvoiceStatus status;
  @override
  final String receiptNumber;
  @override
  final DateTime receiptDate;

  @override
  String toString() {
    return 'InvoiceInfo(openAmount: $openAmount, grossAmount: $grossAmount, discountAmount: $discountAmount, taxableAmount: $taxableAmount, tax: $tax, customerNumber: $customerNumber, company: $company, docType: $docType, invoiceNumber: $invoiceNumber, salesOrderNumber: $salesOrderNumber, salesOrderType: $salesOrderType, date: $date, discountDueDate: $discountDueDate, isOpen: $isOpen, status: $status, receiptNumber: $receiptNumber, receiptDate: $receiptDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceInfoImpl &&
            (identical(other.openAmount, openAmount) ||
                other.openAmount == openAmount) &&
            (identical(other.grossAmount, grossAmount) ||
                other.grossAmount == grossAmount) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.taxableAmount, taxableAmount) ||
                other.taxableAmount == taxableAmount) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.customerNumber, customerNumber) ||
                other.customerNumber == customerNumber) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.docType, docType) || other.docType == docType) &&
            (identical(other.invoiceNumber, invoiceNumber) ||
                other.invoiceNumber == invoiceNumber) &&
            (identical(other.salesOrderNumber, salesOrderNumber) ||
                other.salesOrderNumber == salesOrderNumber) &&
            (identical(other.salesOrderType, salesOrderType) ||
                other.salesOrderType == salesOrderType) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.discountDueDate, discountDueDate) ||
                other.discountDueDate == discountDueDate) &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.receiptNumber, receiptNumber) ||
                other.receiptNumber == receiptNumber) &&
            (identical(other.receiptDate, receiptDate) ||
                other.receiptDate == receiptDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      openAmount,
      grossAmount,
      discountAmount,
      taxableAmount,
      tax,
      customerNumber,
      company,
      docType,
      invoiceNumber,
      salesOrderNumber,
      salesOrderType,
      date,
      discountDueDate,
      isOpen,
      status,
      receiptNumber,
      receiptDate);

  /// Create a copy of InvoiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceInfoImplCopyWith<_$InvoiceInfoImpl> get copyWith =>
      __$$InvoiceInfoImplCopyWithImpl<_$InvoiceInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceInfoImplToJson(
      this,
    );
  }
}

abstract class _InvoiceInfo implements InvoiceInfo {
  const factory _InvoiceInfo(
      {required final double openAmount,
      required final double grossAmount,
      required final double discountAmount,
      required final double taxableAmount,
      required final double tax,
      required final String customerNumber,
      required final String company,
      required final String docType,
      required final int invoiceNumber,
      required final int salesOrderNumber,
      required final String salesOrderType,
      required final DateTime date,
      required final DateTime discountDueDate,
      required final bool isOpen,
      required final InvoiceStatus status,
      required final String receiptNumber,
      required final DateTime receiptDate}) = _$InvoiceInfoImpl;

  factory _InvoiceInfo.fromJson(Map<String, dynamic> json) =
      _$InvoiceInfoImpl.fromJson;

  @override
  double get openAmount;
  @override
  double get grossAmount;
  @override
  double get discountAmount;
  @override
  double get taxableAmount;
  @override
  double get tax;
  @override
  String get customerNumber;
  @override
  String get company;
  @override
  String get docType;
  @override
  int get invoiceNumber;
  @override
  int get salesOrderNumber;
  @override
  String get salesOrderType;
  @override
  DateTime get date;
  @override
  DateTime get discountDueDate;
  @override
  bool get isOpen;
  @override
  InvoiceStatus get status;
  @override
  String get receiptNumber;
  @override
  DateTime get receiptDate;

  /// Create a copy of InvoiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvoiceInfoImplCopyWith<_$InvoiceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
