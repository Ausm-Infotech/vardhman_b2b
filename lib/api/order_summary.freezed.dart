// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderSummary _$OrderSummaryFromJson(Map<String, dynamic> json) {
  return _OrderSummary.fromJson(json);
}

/// @nodoc
mixin _$OrderSummary {
  String get customerCode => throw _privateConstructorUsedError; //AN8
  String get customerName => throw _privateConstructorUsedError; //
  String get portalOrder => throw _privateConstructorUsedError; //EDBT
  String get jdeOrder => throw _privateConstructorUsedError; //DOCO
  String get orderType => throw _privateConstructorUsedError; //EDCT
  String get orderDate => throw _privateConstructorUsedError; //EDDT
  String get orderRemark => throw _privateConstructorUsedError;

  /// Serializes this OrderSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderSummaryCopyWith<OrderSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderSummaryCopyWith<$Res> {
  factory $OrderSummaryCopyWith(
          OrderSummary value, $Res Function(OrderSummary) then) =
      _$OrderSummaryCopyWithImpl<$Res, OrderSummary>;
  @useResult
  $Res call(
      {String customerCode,
      String customerName,
      String portalOrder,
      String jdeOrder,
      String orderType,
      String orderDate,
      String orderRemark});
}

/// @nodoc
class _$OrderSummaryCopyWithImpl<$Res, $Val extends OrderSummary>
    implements $OrderSummaryCopyWith<$Res> {
  _$OrderSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerCode = null,
    Object? customerName = null,
    Object? portalOrder = null,
    Object? jdeOrder = null,
    Object? orderType = null,
    Object? orderDate = null,
    Object? orderRemark = null,
  }) {
    return _then(_value.copyWith(
      customerCode: null == customerCode
          ? _value.customerCode
          : customerCode // ignore: cast_nullable_to_non_nullable
              as String,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      portalOrder: null == portalOrder
          ? _value.portalOrder
          : portalOrder // ignore: cast_nullable_to_non_nullable
              as String,
      jdeOrder: null == jdeOrder
          ? _value.jdeOrder
          : jdeOrder // ignore: cast_nullable_to_non_nullable
              as String,
      orderType: null == orderType
          ? _value.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as String,
      orderDate: null == orderDate
          ? _value.orderDate
          : orderDate // ignore: cast_nullable_to_non_nullable
              as String,
      orderRemark: null == orderRemark
          ? _value.orderRemark
          : orderRemark // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderSummaryImplCopyWith<$Res>
    implements $OrderSummaryCopyWith<$Res> {
  factory _$$OrderSummaryImplCopyWith(
          _$OrderSummaryImpl value, $Res Function(_$OrderSummaryImpl) then) =
      __$$OrderSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String customerCode,
      String customerName,
      String portalOrder,
      String jdeOrder,
      String orderType,
      String orderDate,
      String orderRemark});
}

/// @nodoc
class __$$OrderSummaryImplCopyWithImpl<$Res>
    extends _$OrderSummaryCopyWithImpl<$Res, _$OrderSummaryImpl>
    implements _$$OrderSummaryImplCopyWith<$Res> {
  __$$OrderSummaryImplCopyWithImpl(
      _$OrderSummaryImpl _value, $Res Function(_$OrderSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerCode = null,
    Object? customerName = null,
    Object? portalOrder = null,
    Object? jdeOrder = null,
    Object? orderType = null,
    Object? orderDate = null,
    Object? orderRemark = null,
  }) {
    return _then(_$OrderSummaryImpl(
      customerCode: null == customerCode
          ? _value.customerCode
          : customerCode // ignore: cast_nullable_to_non_nullable
              as String,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      portalOrder: null == portalOrder
          ? _value.portalOrder
          : portalOrder // ignore: cast_nullable_to_non_nullable
              as String,
      jdeOrder: null == jdeOrder
          ? _value.jdeOrder
          : jdeOrder // ignore: cast_nullable_to_non_nullable
              as String,
      orderType: null == orderType
          ? _value.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as String,
      orderDate: null == orderDate
          ? _value.orderDate
          : orderDate // ignore: cast_nullable_to_non_nullable
              as String,
      orderRemark: null == orderRemark
          ? _value.orderRemark
          : orderRemark // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderSummaryImpl implements _OrderSummary {
  const _$OrderSummaryImpl(
      {required this.customerCode,
      required this.customerName,
      required this.portalOrder,
      required this.jdeOrder,
      required this.orderType,
      required this.orderDate,
      required this.orderRemark});

  factory _$OrderSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderSummaryImplFromJson(json);

  @override
  final String customerCode;
//AN8
  @override
  final String customerName;
//
  @override
  final String portalOrder;
//EDBT
  @override
  final String jdeOrder;
//DOCO
  @override
  final String orderType;
//EDCT
  @override
  final String orderDate;
//EDDT
  @override
  final String orderRemark;

  @override
  String toString() {
    return 'OrderSummary(customerCode: $customerCode, customerName: $customerName, portalOrder: $portalOrder, jdeOrder: $jdeOrder, orderType: $orderType, orderDate: $orderDate, orderRemark: $orderRemark)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderSummaryImpl &&
            (identical(other.customerCode, customerCode) ||
                other.customerCode == customerCode) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.portalOrder, portalOrder) ||
                other.portalOrder == portalOrder) &&
            (identical(other.jdeOrder, jdeOrder) ||
                other.jdeOrder == jdeOrder) &&
            (identical(other.orderType, orderType) ||
                other.orderType == orderType) &&
            (identical(other.orderDate, orderDate) ||
                other.orderDate == orderDate) &&
            (identical(other.orderRemark, orderRemark) ||
                other.orderRemark == orderRemark));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, customerCode, customerName,
      portalOrder, jdeOrder, orderType, orderDate, orderRemark);

  /// Create a copy of OrderSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderSummaryImplCopyWith<_$OrderSummaryImpl> get copyWith =>
      __$$OrderSummaryImplCopyWithImpl<_$OrderSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderSummaryImplToJson(
      this,
    );
  }
}

abstract class _OrderSummary implements OrderSummary {
  const factory _OrderSummary(
      {required final String customerCode,
      required final String customerName,
      required final String portalOrder,
      required final String jdeOrder,
      required final String orderType,
      required final String orderDate,
      required final String orderRemark}) = _$OrderSummaryImpl;

  factory _OrderSummary.fromJson(Map<String, dynamic> json) =
      _$OrderSummaryImpl.fromJson;

  @override
  String get customerCode; //AN8
  @override
  String get customerName; //
  @override
  String get portalOrder; //EDBT
  @override
  String get jdeOrder; //DOCO
  @override
  String get orderType; //EDCT
  @override
  String get orderDate; //EDDT
  @override
  String get orderRemark;

  /// Create a copy of OrderSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderSummaryImplCopyWith<_$OrderSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
