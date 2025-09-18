// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sampling_feedback.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SamplingFeedback _$SamplingFeedbackFromJson(Map<String, dynamic> json) {
  return _SamplingFeedback.fromJson(json);
}

/// @nodoc
mixin _$SamplingFeedback {
  int get orderNumber => throw _privateConstructorUsedError;
  double get lineNumber => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  bool get isPositive => throw _privateConstructorUsedError;
  bool get shouldRematch => throw _privateConstructorUsedError;

  /// Serializes this SamplingFeedback to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SamplingFeedback
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SamplingFeedbackCopyWith<SamplingFeedback> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SamplingFeedbackCopyWith<$Res> {
  factory $SamplingFeedbackCopyWith(
          SamplingFeedback value, $Res Function(SamplingFeedback) then) =
      _$SamplingFeedbackCopyWithImpl<$Res, SamplingFeedback>;
  @useResult
  $Res call(
      {int orderNumber,
      double lineNumber,
      String reason,
      bool isPositive,
      bool shouldRematch});
}

/// @nodoc
class _$SamplingFeedbackCopyWithImpl<$Res, $Val extends SamplingFeedback>
    implements $SamplingFeedbackCopyWith<$Res> {
  _$SamplingFeedbackCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SamplingFeedback
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderNumber = null,
    Object? lineNumber = null,
    Object? reason = null,
    Object? isPositive = null,
    Object? shouldRematch = null,
  }) {
    return _then(_value.copyWith(
      orderNumber: null == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int,
      lineNumber: null == lineNumber
          ? _value.lineNumber
          : lineNumber // ignore: cast_nullable_to_non_nullable
              as double,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      isPositive: null == isPositive
          ? _value.isPositive
          : isPositive // ignore: cast_nullable_to_non_nullable
              as bool,
      shouldRematch: null == shouldRematch
          ? _value.shouldRematch
          : shouldRematch // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SamplingFeedbackImplCopyWith<$Res>
    implements $SamplingFeedbackCopyWith<$Res> {
  factory _$$SamplingFeedbackImplCopyWith(_$SamplingFeedbackImpl value,
          $Res Function(_$SamplingFeedbackImpl) then) =
      __$$SamplingFeedbackImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int orderNumber,
      double lineNumber,
      String reason,
      bool isPositive,
      bool shouldRematch});
}

/// @nodoc
class __$$SamplingFeedbackImplCopyWithImpl<$Res>
    extends _$SamplingFeedbackCopyWithImpl<$Res, _$SamplingFeedbackImpl>
    implements _$$SamplingFeedbackImplCopyWith<$Res> {
  __$$SamplingFeedbackImplCopyWithImpl(_$SamplingFeedbackImpl _value,
      $Res Function(_$SamplingFeedbackImpl) _then)
      : super(_value, _then);

  /// Create a copy of SamplingFeedback
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderNumber = null,
    Object? lineNumber = null,
    Object? reason = null,
    Object? isPositive = null,
    Object? shouldRematch = null,
  }) {
    return _then(_$SamplingFeedbackImpl(
      orderNumber: null == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int,
      lineNumber: null == lineNumber
          ? _value.lineNumber
          : lineNumber // ignore: cast_nullable_to_non_nullable
              as double,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      isPositive: null == isPositive
          ? _value.isPositive
          : isPositive // ignore: cast_nullable_to_non_nullable
              as bool,
      shouldRematch: null == shouldRematch
          ? _value.shouldRematch
          : shouldRematch // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SamplingFeedbackImpl implements _SamplingFeedback {
  const _$SamplingFeedbackImpl(
      {required this.orderNumber,
      required this.lineNumber,
      required this.reason,
      required this.isPositive,
      required this.shouldRematch});

  factory _$SamplingFeedbackImpl.fromJson(Map<String, dynamic> json) =>
      _$$SamplingFeedbackImplFromJson(json);

  @override
  final int orderNumber;
  @override
  final double lineNumber;
  @override
  final String reason;
  @override
  final bool isPositive;
  @override
  final bool shouldRematch;

  @override
  String toString() {
    return 'SamplingFeedback(orderNumber: $orderNumber, lineNumber: $lineNumber, reason: $reason, isPositive: $isPositive, shouldRematch: $shouldRematch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SamplingFeedbackImpl &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            (identical(other.lineNumber, lineNumber) ||
                other.lineNumber == lineNumber) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.isPositive, isPositive) ||
                other.isPositive == isPositive) &&
            (identical(other.shouldRematch, shouldRematch) ||
                other.shouldRematch == shouldRematch));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, orderNumber, lineNumber, reason, isPositive, shouldRematch);

  /// Create a copy of SamplingFeedback
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SamplingFeedbackImplCopyWith<_$SamplingFeedbackImpl> get copyWith =>
      __$$SamplingFeedbackImplCopyWithImpl<_$SamplingFeedbackImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SamplingFeedbackImplToJson(
      this,
    );
  }
}

abstract class _SamplingFeedback implements SamplingFeedback {
  const factory _SamplingFeedback(
      {required final int orderNumber,
      required final double lineNumber,
      required final String reason,
      required final bool isPositive,
      required final bool shouldRematch}) = _$SamplingFeedbackImpl;

  factory _SamplingFeedback.fromJson(Map<String, dynamic> json) =
      _$SamplingFeedbackImpl.fromJson;

  @override
  int get orderNumber;
  @override
  double get lineNumber;
  @override
  String get reason;
  @override
  bool get isPositive;
  @override
  bool get shouldRematch;

  /// Create a copy of SamplingFeedback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SamplingFeedbackImplCopyWith<_$SamplingFeedbackImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
