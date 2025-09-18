// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sampling_table_row.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SamplingTableRow _$SamplingTableRowFromJson(Map<String, dynamic> json) {
  return _SamplingTableRow.fromJson(json);
}

/// @nodoc
mixin _$SamplingTableRow {
  int get workOrderNumber => throw _privateConstructorUsedError;
  String get permanentShade => throw _privateConstructorUsedError;
  String get reference => throw _privateConstructorUsedError;

  /// Serializes this SamplingTableRow to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SamplingTableRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SamplingTableRowCopyWith<SamplingTableRow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SamplingTableRowCopyWith<$Res> {
  factory $SamplingTableRowCopyWith(
          SamplingTableRow value, $Res Function(SamplingTableRow) then) =
      _$SamplingTableRowCopyWithImpl<$Res, SamplingTableRow>;
  @useResult
  $Res call({int workOrderNumber, String permanentShade, String reference});
}

/// @nodoc
class _$SamplingTableRowCopyWithImpl<$Res, $Val extends SamplingTableRow>
    implements $SamplingTableRowCopyWith<$Res> {
  _$SamplingTableRowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SamplingTableRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workOrderNumber = null,
    Object? permanentShade = null,
    Object? reference = null,
  }) {
    return _then(_value.copyWith(
      workOrderNumber: null == workOrderNumber
          ? _value.workOrderNumber
          : workOrderNumber // ignore: cast_nullable_to_non_nullable
              as int,
      permanentShade: null == permanentShade
          ? _value.permanentShade
          : permanentShade // ignore: cast_nullable_to_non_nullable
              as String,
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SamplingTableRowImplCopyWith<$Res>
    implements $SamplingTableRowCopyWith<$Res> {
  factory _$$SamplingTableRowImplCopyWith(_$SamplingTableRowImpl value,
          $Res Function(_$SamplingTableRowImpl) then) =
      __$$SamplingTableRowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int workOrderNumber, String permanentShade, String reference});
}

/// @nodoc
class __$$SamplingTableRowImplCopyWithImpl<$Res>
    extends _$SamplingTableRowCopyWithImpl<$Res, _$SamplingTableRowImpl>
    implements _$$SamplingTableRowImplCopyWith<$Res> {
  __$$SamplingTableRowImplCopyWithImpl(_$SamplingTableRowImpl _value,
      $Res Function(_$SamplingTableRowImpl) _then)
      : super(_value, _then);

  /// Create a copy of SamplingTableRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workOrderNumber = null,
    Object? permanentShade = null,
    Object? reference = null,
  }) {
    return _then(_$SamplingTableRowImpl(
      workOrderNumber: null == workOrderNumber
          ? _value.workOrderNumber
          : workOrderNumber // ignore: cast_nullable_to_non_nullable
              as int,
      permanentShade: null == permanentShade
          ? _value.permanentShade
          : permanentShade // ignore: cast_nullable_to_non_nullable
              as String,
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SamplingTableRowImpl implements _SamplingTableRow {
  const _$SamplingTableRowImpl(
      {required this.workOrderNumber,
      required this.permanentShade,
      required this.reference});

  factory _$SamplingTableRowImpl.fromJson(Map<String, dynamic> json) =>
      _$$SamplingTableRowImplFromJson(json);

  @override
  final int workOrderNumber;
  @override
  final String permanentShade;
  @override
  final String reference;

  @override
  String toString() {
    return 'SamplingTableRow(workOrderNumber: $workOrderNumber, permanentShade: $permanentShade, reference: $reference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SamplingTableRowImpl &&
            (identical(other.workOrderNumber, workOrderNumber) ||
                other.workOrderNumber == workOrderNumber) &&
            (identical(other.permanentShade, permanentShade) ||
                other.permanentShade == permanentShade) &&
            (identical(other.reference, reference) ||
                other.reference == reference));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, workOrderNumber, permanentShade, reference);

  /// Create a copy of SamplingTableRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SamplingTableRowImplCopyWith<_$SamplingTableRowImpl> get copyWith =>
      __$$SamplingTableRowImplCopyWithImpl<_$SamplingTableRowImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SamplingTableRowImplToJson(
      this,
    );
  }
}

abstract class _SamplingTableRow implements SamplingTableRow {
  const factory _SamplingTableRow(
      {required final int workOrderNumber,
      required final String permanentShade,
      required final String reference}) = _$SamplingTableRowImpl;

  factory _SamplingTableRow.fromJson(Map<String, dynamic> json) =
      _$SamplingTableRowImpl.fromJson;

  @override
  int get workOrderNumber;
  @override
  String get permanentShade;
  @override
  String get reference;

  /// Create a copy of SamplingTableRow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SamplingTableRowImplCopyWith<_$SamplingTableRowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
