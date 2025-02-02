// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_header_line.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderHeaderLine _$OrderHeaderLineFromJson(Map<String, dynamic> json) {
  return _OrderHeaderLine.fromJson(json);
}

/// @nodoc
mixin _$OrderHeaderLine {
  int get orderNumber => throw _privateConstructorUsedError;
  String get orderType => throw _privateConstructorUsedError;
  String get orderCompany => throw _privateConstructorUsedError;
  DateTime get orderDate => throw _privateConstructorUsedError;
  String get orderReference => throw _privateConstructorUsedError;
  String get holdCode => throw _privateConstructorUsedError;
  int get shipTo => throw _privateConstructorUsedError;
  int get quantityOrdered => throw _privateConstructorUsedError;
  int get quantityShipped => throw _privateConstructorUsedError;
  int get quantityCancelled => throw _privateConstructorUsedError;
  String get orderStatus => throw _privateConstructorUsedError;
  double get orderAmount => throw _privateConstructorUsedError;
  int get quantityBackOrdered => throw _privateConstructorUsedError;
  bool get canIndent => throw _privateConstructorUsedError;
  bool get isDTM => throw _privateConstructorUsedError;

  /// Serializes this OrderHeaderLine to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderHeaderLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderHeaderLineCopyWith<OrderHeaderLine> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderHeaderLineCopyWith<$Res> {
  factory $OrderHeaderLineCopyWith(
          OrderHeaderLine value, $Res Function(OrderHeaderLine) then) =
      _$OrderHeaderLineCopyWithImpl<$Res, OrderHeaderLine>;
  @useResult
  $Res call(
      {int orderNumber,
      String orderType,
      String orderCompany,
      DateTime orderDate,
      String orderReference,
      String holdCode,
      int shipTo,
      int quantityOrdered,
      int quantityShipped,
      int quantityCancelled,
      String orderStatus,
      double orderAmount,
      int quantityBackOrdered,
      bool canIndent,
      bool isDTM});
}

/// @nodoc
class _$OrderHeaderLineCopyWithImpl<$Res, $Val extends OrderHeaderLine>
    implements $OrderHeaderLineCopyWith<$Res> {
  _$OrderHeaderLineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderHeaderLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderNumber = null,
    Object? orderType = null,
    Object? orderCompany = null,
    Object? orderDate = null,
    Object? orderReference = null,
    Object? holdCode = null,
    Object? shipTo = null,
    Object? quantityOrdered = null,
    Object? quantityShipped = null,
    Object? quantityCancelled = null,
    Object? orderStatus = null,
    Object? orderAmount = null,
    Object? quantityBackOrdered = null,
    Object? canIndent = null,
    Object? isDTM = null,
  }) {
    return _then(_value.copyWith(
      orderNumber: null == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int,
      orderType: null == orderType
          ? _value.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as String,
      orderCompany: null == orderCompany
          ? _value.orderCompany
          : orderCompany // ignore: cast_nullable_to_non_nullable
              as String,
      orderDate: null == orderDate
          ? _value.orderDate
          : orderDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      orderReference: null == orderReference
          ? _value.orderReference
          : orderReference // ignore: cast_nullable_to_non_nullable
              as String,
      holdCode: null == holdCode
          ? _value.holdCode
          : holdCode // ignore: cast_nullable_to_non_nullable
              as String,
      shipTo: null == shipTo
          ? _value.shipTo
          : shipTo // ignore: cast_nullable_to_non_nullable
              as int,
      quantityOrdered: null == quantityOrdered
          ? _value.quantityOrdered
          : quantityOrdered // ignore: cast_nullable_to_non_nullable
              as int,
      quantityShipped: null == quantityShipped
          ? _value.quantityShipped
          : quantityShipped // ignore: cast_nullable_to_non_nullable
              as int,
      quantityCancelled: null == quantityCancelled
          ? _value.quantityCancelled
          : quantityCancelled // ignore: cast_nullable_to_non_nullable
              as int,
      orderStatus: null == orderStatus
          ? _value.orderStatus
          : orderStatus // ignore: cast_nullable_to_non_nullable
              as String,
      orderAmount: null == orderAmount
          ? _value.orderAmount
          : orderAmount // ignore: cast_nullable_to_non_nullable
              as double,
      quantityBackOrdered: null == quantityBackOrdered
          ? _value.quantityBackOrdered
          : quantityBackOrdered // ignore: cast_nullable_to_non_nullable
              as int,
      canIndent: null == canIndent
          ? _value.canIndent
          : canIndent // ignore: cast_nullable_to_non_nullable
              as bool,
      isDTM: null == isDTM
          ? _value.isDTM
          : isDTM // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderHeaderLineImplCopyWith<$Res>
    implements $OrderHeaderLineCopyWith<$Res> {
  factory _$$OrderHeaderLineImplCopyWith(_$OrderHeaderLineImpl value,
          $Res Function(_$OrderHeaderLineImpl) then) =
      __$$OrderHeaderLineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int orderNumber,
      String orderType,
      String orderCompany,
      DateTime orderDate,
      String orderReference,
      String holdCode,
      int shipTo,
      int quantityOrdered,
      int quantityShipped,
      int quantityCancelled,
      String orderStatus,
      double orderAmount,
      int quantityBackOrdered,
      bool canIndent,
      bool isDTM});
}

/// @nodoc
class __$$OrderHeaderLineImplCopyWithImpl<$Res>
    extends _$OrderHeaderLineCopyWithImpl<$Res, _$OrderHeaderLineImpl>
    implements _$$OrderHeaderLineImplCopyWith<$Res> {
  __$$OrderHeaderLineImplCopyWithImpl(
      _$OrderHeaderLineImpl _value, $Res Function(_$OrderHeaderLineImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderHeaderLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderNumber = null,
    Object? orderType = null,
    Object? orderCompany = null,
    Object? orderDate = null,
    Object? orderReference = null,
    Object? holdCode = null,
    Object? shipTo = null,
    Object? quantityOrdered = null,
    Object? quantityShipped = null,
    Object? quantityCancelled = null,
    Object? orderStatus = null,
    Object? orderAmount = null,
    Object? quantityBackOrdered = null,
    Object? canIndent = null,
    Object? isDTM = null,
  }) {
    return _then(_$OrderHeaderLineImpl(
      orderNumber: null == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int,
      orderType: null == orderType
          ? _value.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as String,
      orderCompany: null == orderCompany
          ? _value.orderCompany
          : orderCompany // ignore: cast_nullable_to_non_nullable
              as String,
      orderDate: null == orderDate
          ? _value.orderDate
          : orderDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      orderReference: null == orderReference
          ? _value.orderReference
          : orderReference // ignore: cast_nullable_to_non_nullable
              as String,
      holdCode: null == holdCode
          ? _value.holdCode
          : holdCode // ignore: cast_nullable_to_non_nullable
              as String,
      shipTo: null == shipTo
          ? _value.shipTo
          : shipTo // ignore: cast_nullable_to_non_nullable
              as int,
      quantityOrdered: null == quantityOrdered
          ? _value.quantityOrdered
          : quantityOrdered // ignore: cast_nullable_to_non_nullable
              as int,
      quantityShipped: null == quantityShipped
          ? _value.quantityShipped
          : quantityShipped // ignore: cast_nullable_to_non_nullable
              as int,
      quantityCancelled: null == quantityCancelled
          ? _value.quantityCancelled
          : quantityCancelled // ignore: cast_nullable_to_non_nullable
              as int,
      orderStatus: null == orderStatus
          ? _value.orderStatus
          : orderStatus // ignore: cast_nullable_to_non_nullable
              as String,
      orderAmount: null == orderAmount
          ? _value.orderAmount
          : orderAmount // ignore: cast_nullable_to_non_nullable
              as double,
      quantityBackOrdered: null == quantityBackOrdered
          ? _value.quantityBackOrdered
          : quantityBackOrdered // ignore: cast_nullable_to_non_nullable
              as int,
      canIndent: null == canIndent
          ? _value.canIndent
          : canIndent // ignore: cast_nullable_to_non_nullable
              as bool,
      isDTM: null == isDTM
          ? _value.isDTM
          : isDTM // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderHeaderLineImpl extends _OrderHeaderLine {
  const _$OrderHeaderLineImpl(
      {required this.orderNumber,
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
      required this.orderAmount,
      required this.quantityBackOrdered,
      required this.canIndent,
      required this.isDTM})
      : super._();

  factory _$OrderHeaderLineImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderHeaderLineImplFromJson(json);

  @override
  final int orderNumber;
  @override
  final String orderType;
  @override
  final String orderCompany;
  @override
  final DateTime orderDate;
  @override
  final String orderReference;
  @override
  final String holdCode;
  @override
  final int shipTo;
  @override
  final int quantityOrdered;
  @override
  final int quantityShipped;
  @override
  final int quantityCancelled;
  @override
  final String orderStatus;
  @override
  final double orderAmount;
  @override
  final int quantityBackOrdered;
  @override
  final bool canIndent;
  @override
  final bool isDTM;

  @override
  String toString() {
    return 'OrderHeaderLine(orderNumber: $orderNumber, orderType: $orderType, orderCompany: $orderCompany, orderDate: $orderDate, orderReference: $orderReference, holdCode: $holdCode, shipTo: $shipTo, quantityOrdered: $quantityOrdered, quantityShipped: $quantityShipped, quantityCancelled: $quantityCancelled, orderStatus: $orderStatus, orderAmount: $orderAmount, quantityBackOrdered: $quantityBackOrdered, canIndent: $canIndent, isDTM: $isDTM)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderHeaderLineImpl &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            (identical(other.orderType, orderType) ||
                other.orderType == orderType) &&
            (identical(other.orderCompany, orderCompany) ||
                other.orderCompany == orderCompany) &&
            (identical(other.orderDate, orderDate) ||
                other.orderDate == orderDate) &&
            (identical(other.orderReference, orderReference) ||
                other.orderReference == orderReference) &&
            (identical(other.holdCode, holdCode) ||
                other.holdCode == holdCode) &&
            (identical(other.shipTo, shipTo) || other.shipTo == shipTo) &&
            (identical(other.quantityOrdered, quantityOrdered) ||
                other.quantityOrdered == quantityOrdered) &&
            (identical(other.quantityShipped, quantityShipped) ||
                other.quantityShipped == quantityShipped) &&
            (identical(other.quantityCancelled, quantityCancelled) ||
                other.quantityCancelled == quantityCancelled) &&
            (identical(other.orderStatus, orderStatus) ||
                other.orderStatus == orderStatus) &&
            (identical(other.orderAmount, orderAmount) ||
                other.orderAmount == orderAmount) &&
            (identical(other.quantityBackOrdered, quantityBackOrdered) ||
                other.quantityBackOrdered == quantityBackOrdered) &&
            (identical(other.canIndent, canIndent) ||
                other.canIndent == canIndent) &&
            (identical(other.isDTM, isDTM) || other.isDTM == isDTM));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
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
      orderAmount,
      quantityBackOrdered,
      canIndent,
      isDTM);

  /// Create a copy of OrderHeaderLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderHeaderLineImplCopyWith<_$OrderHeaderLineImpl> get copyWith =>
      __$$OrderHeaderLineImplCopyWithImpl<_$OrderHeaderLineImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderHeaderLineImplToJson(
      this,
    );
  }
}

abstract class _OrderHeaderLine extends OrderHeaderLine {
  const factory _OrderHeaderLine(
      {required final int orderNumber,
      required final String orderType,
      required final String orderCompany,
      required final DateTime orderDate,
      required final String orderReference,
      required final String holdCode,
      required final int shipTo,
      required final int quantityOrdered,
      required final int quantityShipped,
      required final int quantityCancelled,
      required final String orderStatus,
      required final double orderAmount,
      required final int quantityBackOrdered,
      required final bool canIndent,
      required final bool isDTM}) = _$OrderHeaderLineImpl;
  const _OrderHeaderLine._() : super._();

  factory _OrderHeaderLine.fromJson(Map<String, dynamic> json) =
      _$OrderHeaderLineImpl.fromJson;

  @override
  int get orderNumber;
  @override
  String get orderType;
  @override
  String get orderCompany;
  @override
  DateTime get orderDate;
  @override
  String get orderReference;
  @override
  String get holdCode;
  @override
  int get shipTo;
  @override
  int get quantityOrdered;
  @override
  int get quantityShipped;
  @override
  int get quantityCancelled;
  @override
  String get orderStatus;
  @override
  double get orderAmount;
  @override
  int get quantityBackOrdered;
  @override
  bool get canIndent;
  @override
  bool get isDTM;

  /// Create a copy of OrderHeaderLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderHeaderLineImplCopyWith<_$OrderHeaderLineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
