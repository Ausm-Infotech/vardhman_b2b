// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'labdip_table_row.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LabdipTableRow _$LabdipTableRowFromJson(Map<String, dynamic> json) {
  return _LabdipTableRow.fromJson(json);
}

/// @nodoc
mixin _$LabdipTableRow {
  int get workOrderNumber => throw _privateConstructorUsedError;
  String get permanentShade => throw _privateConstructorUsedError;
  String get reference => throw _privateConstructorUsedError;

  /// Serializes this LabdipTableRow to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LabdipTableRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LabdipTableRowCopyWith<LabdipTableRow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LabdipTableRowCopyWith<$Res> {
  factory $LabdipTableRowCopyWith(
          LabdipTableRow value, $Res Function(LabdipTableRow) then) =
      _$LabdipTableRowCopyWithImpl<$Res, LabdipTableRow>;
  @useResult
  $Res call({int workOrderNumber, String permanentShade, String reference});
}

/// @nodoc
class _$LabdipTableRowCopyWithImpl<$Res, $Val extends LabdipTableRow>
    implements $LabdipTableRowCopyWith<$Res> {
  _$LabdipTableRowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LabdipTableRow
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
abstract class _$$LabdipTableRowImplCopyWith<$Res>
    implements $LabdipTableRowCopyWith<$Res> {
  factory _$$LabdipTableRowImplCopyWith(_$LabdipTableRowImpl value,
          $Res Function(_$LabdipTableRowImpl) then) =
      __$$LabdipTableRowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int workOrderNumber, String permanentShade, String reference});
}

/// @nodoc
class __$$LabdipTableRowImplCopyWithImpl<$Res>
    extends _$LabdipTableRowCopyWithImpl<$Res, _$LabdipTableRowImpl>
    implements _$$LabdipTableRowImplCopyWith<$Res> {
  __$$LabdipTableRowImplCopyWithImpl(
      _$LabdipTableRowImpl _value, $Res Function(_$LabdipTableRowImpl) _then)
      : super(_value, _then);

  /// Create a copy of LabdipTableRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workOrderNumber = null,
    Object? permanentShade = null,
    Object? reference = null,
  }) {
    return _then(_$LabdipTableRowImpl(
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
class _$LabdipTableRowImpl implements _LabdipTableRow {
  const _$LabdipTableRowImpl(
      {required this.workOrderNumber,
      required this.permanentShade,
      required this.reference});

  factory _$LabdipTableRowImpl.fromJson(Map<String, dynamic> json) =>
      _$$LabdipTableRowImplFromJson(json);

  @override
  final int workOrderNumber;
  @override
  final String permanentShade;
  @override
  final String reference;

  @override
  String toString() {
    return 'LabdipTableRow(workOrderNumber: $workOrderNumber, permanentShade: $permanentShade, reference: $reference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LabdipTableRowImpl &&
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

  /// Create a copy of LabdipTableRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LabdipTableRowImplCopyWith<_$LabdipTableRowImpl> get copyWith =>
      __$$LabdipTableRowImplCopyWithImpl<_$LabdipTableRowImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LabdipTableRowImplToJson(
      this,
    );
  }
}

abstract class _LabdipTableRow implements LabdipTableRow {
  const factory _LabdipTableRow(
      {required final int workOrderNumber,
      required final String permanentShade,
      required final String reference}) = _$LabdipTableRowImpl;

  factory _LabdipTableRow.fromJson(Map<String, dynamic> json) =
      _$LabdipTableRowImpl.fromJson;

  @override
  int get workOrderNumber;
  @override
  String get permanentShade;
  @override
  String get reference;

  /// Create a copy of LabdipTableRow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LabdipTableRowImplCopyWith<_$LabdipTableRowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
