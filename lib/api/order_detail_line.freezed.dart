// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_detail_line.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderDetailLine _$OrderDetailLineFromJson(Map<String, dynamic> json) {
  return _OrderDetailLine.fromJson(json);
}

/// @nodoc
mixin _$OrderDetailLine {
  String get company => throw _privateConstructorUsedError;
  int get orderNumber => throw _privateConstructorUsedError;
  String get orderType => throw _privateConstructorUsedError;
  double get lineNumber => throw _privateConstructorUsedError;
  DateTime? get dateShipped => throw _privateConstructorUsedError;
  DateTime? get dateInvoiced => throw _privateConstructorUsedError;
  String get item => throw _privateConstructorUsedError;
  String get itemDescription => throw _privateConstructorUsedError;
  String get nextStatus => throw _privateConstructorUsedError;
  String get nextStatusDescription => throw _privateConstructorUsedError;
  String get lastStatus => throw _privateConstructorUsedError;
  String get lastStatusDescription => throw _privateConstructorUsedError;
  int get quantityOrdered => throw _privateConstructorUsedError;
  int get quantityCancelled => throw _privateConstructorUsedError;
  int get quantityBackordered => throw _privateConstructorUsedError;
  int get invoiceNumber => throw _privateConstructorUsedError;
  String get invoiceType => throw _privateConstructorUsedError;
  String get invoiceCompany => throw _privateConstructorUsedError;

  /// Serializes this OrderDetailLine to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderDetailLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderDetailLineCopyWith<OrderDetailLine> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderDetailLineCopyWith<$Res> {
  factory $OrderDetailLineCopyWith(
          OrderDetailLine value, $Res Function(OrderDetailLine) then) =
      _$OrderDetailLineCopyWithImpl<$Res, OrderDetailLine>;
  @useResult
  $Res call(
      {String company,
      int orderNumber,
      String orderType,
      double lineNumber,
      DateTime? dateShipped,
      DateTime? dateInvoiced,
      String item,
      String itemDescription,
      String nextStatus,
      String nextStatusDescription,
      String lastStatus,
      String lastStatusDescription,
      int quantityOrdered,
      int quantityCancelled,
      int quantityBackordered,
      int invoiceNumber,
      String invoiceType,
      String invoiceCompany});
}

/// @nodoc
class _$OrderDetailLineCopyWithImpl<$Res, $Val extends OrderDetailLine>
    implements $OrderDetailLineCopyWith<$Res> {
  _$OrderDetailLineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderDetailLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? company = null,
    Object? orderNumber = null,
    Object? orderType = null,
    Object? lineNumber = null,
    Object? dateShipped = freezed,
    Object? dateInvoiced = freezed,
    Object? item = null,
    Object? itemDescription = null,
    Object? nextStatus = null,
    Object? nextStatusDescription = null,
    Object? lastStatus = null,
    Object? lastStatusDescription = null,
    Object? quantityOrdered = null,
    Object? quantityCancelled = null,
    Object? quantityBackordered = null,
    Object? invoiceNumber = null,
    Object? invoiceType = null,
    Object? invoiceCompany = null,
  }) {
    return _then(_value.copyWith(
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      orderNumber: null == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int,
      orderType: null == orderType
          ? _value.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as String,
      lineNumber: null == lineNumber
          ? _value.lineNumber
          : lineNumber // ignore: cast_nullable_to_non_nullable
              as double,
      dateShipped: freezed == dateShipped
          ? _value.dateShipped
          : dateShipped // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateInvoiced: freezed == dateInvoiced
          ? _value.dateInvoiced
          : dateInvoiced // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      itemDescription: null == itemDescription
          ? _value.itemDescription
          : itemDescription // ignore: cast_nullable_to_non_nullable
              as String,
      nextStatus: null == nextStatus
          ? _value.nextStatus
          : nextStatus // ignore: cast_nullable_to_non_nullable
              as String,
      nextStatusDescription: null == nextStatusDescription
          ? _value.nextStatusDescription
          : nextStatusDescription // ignore: cast_nullable_to_non_nullable
              as String,
      lastStatus: null == lastStatus
          ? _value.lastStatus
          : lastStatus // ignore: cast_nullable_to_non_nullable
              as String,
      lastStatusDescription: null == lastStatusDescription
          ? _value.lastStatusDescription
          : lastStatusDescription // ignore: cast_nullable_to_non_nullable
              as String,
      quantityOrdered: null == quantityOrdered
          ? _value.quantityOrdered
          : quantityOrdered // ignore: cast_nullable_to_non_nullable
              as int,
      quantityCancelled: null == quantityCancelled
          ? _value.quantityCancelled
          : quantityCancelled // ignore: cast_nullable_to_non_nullable
              as int,
      quantityBackordered: null == quantityBackordered
          ? _value.quantityBackordered
          : quantityBackordered // ignore: cast_nullable_to_non_nullable
              as int,
      invoiceNumber: null == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as int,
      invoiceType: null == invoiceType
          ? _value.invoiceType
          : invoiceType // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceCompany: null == invoiceCompany
          ? _value.invoiceCompany
          : invoiceCompany // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderDetailLineImplCopyWith<$Res>
    implements $OrderDetailLineCopyWith<$Res> {
  factory _$$OrderDetailLineImplCopyWith(_$OrderDetailLineImpl value,
          $Res Function(_$OrderDetailLineImpl) then) =
      __$$OrderDetailLineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String company,
      int orderNumber,
      String orderType,
      double lineNumber,
      DateTime? dateShipped,
      DateTime? dateInvoiced,
      String item,
      String itemDescription,
      String nextStatus,
      String nextStatusDescription,
      String lastStatus,
      String lastStatusDescription,
      int quantityOrdered,
      int quantityCancelled,
      int quantityBackordered,
      int invoiceNumber,
      String invoiceType,
      String invoiceCompany});
}

/// @nodoc
class __$$OrderDetailLineImplCopyWithImpl<$Res>
    extends _$OrderDetailLineCopyWithImpl<$Res, _$OrderDetailLineImpl>
    implements _$$OrderDetailLineImplCopyWith<$Res> {
  __$$OrderDetailLineImplCopyWithImpl(
      _$OrderDetailLineImpl _value, $Res Function(_$OrderDetailLineImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderDetailLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? company = null,
    Object? orderNumber = null,
    Object? orderType = null,
    Object? lineNumber = null,
    Object? dateShipped = freezed,
    Object? dateInvoiced = freezed,
    Object? item = null,
    Object? itemDescription = null,
    Object? nextStatus = null,
    Object? nextStatusDescription = null,
    Object? lastStatus = null,
    Object? lastStatusDescription = null,
    Object? quantityOrdered = null,
    Object? quantityCancelled = null,
    Object? quantityBackordered = null,
    Object? invoiceNumber = null,
    Object? invoiceType = null,
    Object? invoiceCompany = null,
  }) {
    return _then(_$OrderDetailLineImpl(
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      orderNumber: null == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int,
      orderType: null == orderType
          ? _value.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as String,
      lineNumber: null == lineNumber
          ? _value.lineNumber
          : lineNumber // ignore: cast_nullable_to_non_nullable
              as double,
      dateShipped: freezed == dateShipped
          ? _value.dateShipped
          : dateShipped // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateInvoiced: freezed == dateInvoiced
          ? _value.dateInvoiced
          : dateInvoiced // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      itemDescription: null == itemDescription
          ? _value.itemDescription
          : itemDescription // ignore: cast_nullable_to_non_nullable
              as String,
      nextStatus: null == nextStatus
          ? _value.nextStatus
          : nextStatus // ignore: cast_nullable_to_non_nullable
              as String,
      nextStatusDescription: null == nextStatusDescription
          ? _value.nextStatusDescription
          : nextStatusDescription // ignore: cast_nullable_to_non_nullable
              as String,
      lastStatus: null == lastStatus
          ? _value.lastStatus
          : lastStatus // ignore: cast_nullable_to_non_nullable
              as String,
      lastStatusDescription: null == lastStatusDescription
          ? _value.lastStatusDescription
          : lastStatusDescription // ignore: cast_nullable_to_non_nullable
              as String,
      quantityOrdered: null == quantityOrdered
          ? _value.quantityOrdered
          : quantityOrdered // ignore: cast_nullable_to_non_nullable
              as int,
      quantityCancelled: null == quantityCancelled
          ? _value.quantityCancelled
          : quantityCancelled // ignore: cast_nullable_to_non_nullable
              as int,
      quantityBackordered: null == quantityBackordered
          ? _value.quantityBackordered
          : quantityBackordered // ignore: cast_nullable_to_non_nullable
              as int,
      invoiceNumber: null == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as int,
      invoiceType: null == invoiceType
          ? _value.invoiceType
          : invoiceType // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceCompany: null == invoiceCompany
          ? _value.invoiceCompany
          : invoiceCompany // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderDetailLineImpl implements _OrderDetailLine {
  const _$OrderDetailLineImpl(
      {required this.company,
      required this.orderNumber,
      required this.orderType,
      required this.lineNumber,
      required this.dateShipped,
      required this.dateInvoiced,
      required this.item,
      required this.itemDescription,
      required this.nextStatus,
      required this.nextStatusDescription,
      required this.lastStatus,
      required this.lastStatusDescription,
      required this.quantityOrdered,
      required this.quantityCancelled,
      required this.quantityBackordered,
      required this.invoiceNumber,
      required this.invoiceType,
      required this.invoiceCompany});

  factory _$OrderDetailLineImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderDetailLineImplFromJson(json);

  @override
  final String company;
  @override
  final int orderNumber;
  @override
  final String orderType;
  @override
  final double lineNumber;
  @override
  final DateTime? dateShipped;
  @override
  final DateTime? dateInvoiced;
  @override
  final String item;
  @override
  final String itemDescription;
  @override
  final String nextStatus;
  @override
  final String nextStatusDescription;
  @override
  final String lastStatus;
  @override
  final String lastStatusDescription;
  @override
  final int quantityOrdered;
  @override
  final int quantityCancelled;
  @override
  final int quantityBackordered;
  @override
  final int invoiceNumber;
  @override
  final String invoiceType;
  @override
  final String invoiceCompany;

  @override
  String toString() {
    return 'OrderDetailLine(company: $company, orderNumber: $orderNumber, orderType: $orderType, lineNumber: $lineNumber, dateShipped: $dateShipped, dateInvoiced: $dateInvoiced, item: $item, itemDescription: $itemDescription, nextStatus: $nextStatus, nextStatusDescription: $nextStatusDescription, lastStatus: $lastStatus, lastStatusDescription: $lastStatusDescription, quantityOrdered: $quantityOrdered, quantityCancelled: $quantityCancelled, quantityBackordered: $quantityBackordered, invoiceNumber: $invoiceNumber, invoiceType: $invoiceType, invoiceCompany: $invoiceCompany)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderDetailLineImpl &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            (identical(other.orderType, orderType) ||
                other.orderType == orderType) &&
            (identical(other.lineNumber, lineNumber) ||
                other.lineNumber == lineNumber) &&
            (identical(other.dateShipped, dateShipped) ||
                other.dateShipped == dateShipped) &&
            (identical(other.dateInvoiced, dateInvoiced) ||
                other.dateInvoiced == dateInvoiced) &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.itemDescription, itemDescription) ||
                other.itemDescription == itemDescription) &&
            (identical(other.nextStatus, nextStatus) ||
                other.nextStatus == nextStatus) &&
            (identical(other.nextStatusDescription, nextStatusDescription) ||
                other.nextStatusDescription == nextStatusDescription) &&
            (identical(other.lastStatus, lastStatus) ||
                other.lastStatus == lastStatus) &&
            (identical(other.lastStatusDescription, lastStatusDescription) ||
                other.lastStatusDescription == lastStatusDescription) &&
            (identical(other.quantityOrdered, quantityOrdered) ||
                other.quantityOrdered == quantityOrdered) &&
            (identical(other.quantityCancelled, quantityCancelled) ||
                other.quantityCancelled == quantityCancelled) &&
            (identical(other.quantityBackordered, quantityBackordered) ||
                other.quantityBackordered == quantityBackordered) &&
            (identical(other.invoiceNumber, invoiceNumber) ||
                other.invoiceNumber == invoiceNumber) &&
            (identical(other.invoiceType, invoiceType) ||
                other.invoiceType == invoiceType) &&
            (identical(other.invoiceCompany, invoiceCompany) ||
                other.invoiceCompany == invoiceCompany));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      company,
      orderNumber,
      orderType,
      lineNumber,
      dateShipped,
      dateInvoiced,
      item,
      itemDescription,
      nextStatus,
      nextStatusDescription,
      lastStatus,
      lastStatusDescription,
      quantityOrdered,
      quantityCancelled,
      quantityBackordered,
      invoiceNumber,
      invoiceType,
      invoiceCompany);

  /// Create a copy of OrderDetailLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderDetailLineImplCopyWith<_$OrderDetailLineImpl> get copyWith =>
      __$$OrderDetailLineImplCopyWithImpl<_$OrderDetailLineImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderDetailLineImplToJson(
      this,
    );
  }
}

abstract class _OrderDetailLine implements OrderDetailLine {
  const factory _OrderDetailLine(
      {required final String company,
      required final int orderNumber,
      required final String orderType,
      required final double lineNumber,
      required final DateTime? dateShipped,
      required final DateTime? dateInvoiced,
      required final String item,
      required final String itemDescription,
      required final String nextStatus,
      required final String nextStatusDescription,
      required final String lastStatus,
      required final String lastStatusDescription,
      required final int quantityOrdered,
      required final int quantityCancelled,
      required final int quantityBackordered,
      required final int invoiceNumber,
      required final String invoiceType,
      required final String invoiceCompany}) = _$OrderDetailLineImpl;

  factory _OrderDetailLine.fromJson(Map<String, dynamic> json) =
      _$OrderDetailLineImpl.fromJson;

  @override
  String get company;
  @override
  int get orderNumber;
  @override
  String get orderType;
  @override
  double get lineNumber;
  @override
  DateTime? get dateShipped;
  @override
  DateTime? get dateInvoiced;
  @override
  String get item;
  @override
  String get itemDescription;
  @override
  String get nextStatus;
  @override
  String get nextStatusDescription;
  @override
  String get lastStatus;
  @override
  String get lastStatusDescription;
  @override
  int get quantityOrdered;
  @override
  int get quantityCancelled;
  @override
  int get quantityBackordered;
  @override
  int get invoiceNumber;
  @override
  String get invoiceType;
  @override
  String get invoiceCompany;

  /// Create a copy of OrderDetailLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderDetailLineImplCopyWith<_$OrderDetailLineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
