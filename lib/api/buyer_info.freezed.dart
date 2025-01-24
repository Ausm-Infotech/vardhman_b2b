// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'buyer_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BuyerInfo _$BuyerInfoFromJson(Map<String, dynamic> json) {
  return _BuyerInfo.fromJson(json);
}

/// @nodoc
mixin _$BuyerInfo {
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get firstLightSource => throw _privateConstructorUsedError;
  String get secondLightSource => throw _privateConstructorUsedError;

  /// Serializes this BuyerInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BuyerInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BuyerInfoCopyWith<BuyerInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuyerInfoCopyWith<$Res> {
  factory $BuyerInfoCopyWith(BuyerInfo value, $Res Function(BuyerInfo) then) =
      _$BuyerInfoCopyWithImpl<$Res, BuyerInfo>;
  @useResult
  $Res call(
      {String name,
      String code,
      String firstLightSource,
      String secondLightSource});
}

/// @nodoc
class _$BuyerInfoCopyWithImpl<$Res, $Val extends BuyerInfo>
    implements $BuyerInfoCopyWith<$Res> {
  _$BuyerInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BuyerInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? code = null,
    Object? firstLightSource = null,
    Object? secondLightSource = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      firstLightSource: null == firstLightSource
          ? _value.firstLightSource
          : firstLightSource // ignore: cast_nullable_to_non_nullable
              as String,
      secondLightSource: null == secondLightSource
          ? _value.secondLightSource
          : secondLightSource // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BuyerInfoImplCopyWith<$Res>
    implements $BuyerInfoCopyWith<$Res> {
  factory _$$BuyerInfoImplCopyWith(
          _$BuyerInfoImpl value, $Res Function(_$BuyerInfoImpl) then) =
      __$$BuyerInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String code,
      String firstLightSource,
      String secondLightSource});
}

/// @nodoc
class __$$BuyerInfoImplCopyWithImpl<$Res>
    extends _$BuyerInfoCopyWithImpl<$Res, _$BuyerInfoImpl>
    implements _$$BuyerInfoImplCopyWith<$Res> {
  __$$BuyerInfoImplCopyWithImpl(
      _$BuyerInfoImpl _value, $Res Function(_$BuyerInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of BuyerInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? code = null,
    Object? firstLightSource = null,
    Object? secondLightSource = null,
  }) {
    return _then(_$BuyerInfoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      firstLightSource: null == firstLightSource
          ? _value.firstLightSource
          : firstLightSource // ignore: cast_nullable_to_non_nullable
              as String,
      secondLightSource: null == secondLightSource
          ? _value.secondLightSource
          : secondLightSource // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BuyerInfoImpl implements _BuyerInfo {
  const _$BuyerInfoImpl(
      {required this.name,
      required this.code,
      required this.firstLightSource,
      required this.secondLightSource});

  factory _$BuyerInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BuyerInfoImplFromJson(json);

  @override
  final String name;
  @override
  final String code;
  @override
  final String firstLightSource;
  @override
  final String secondLightSource;

  @override
  String toString() {
    return 'BuyerInfo(name: $name, code: $code, firstLightSource: $firstLightSource, secondLightSource: $secondLightSource)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BuyerInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.firstLightSource, firstLightSource) ||
                other.firstLightSource == firstLightSource) &&
            (identical(other.secondLightSource, secondLightSource) ||
                other.secondLightSource == secondLightSource));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, code, firstLightSource, secondLightSource);

  /// Create a copy of BuyerInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BuyerInfoImplCopyWith<_$BuyerInfoImpl> get copyWith =>
      __$$BuyerInfoImplCopyWithImpl<_$BuyerInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BuyerInfoImplToJson(
      this,
    );
  }
}

abstract class _BuyerInfo implements BuyerInfo {
  const factory _BuyerInfo(
      {required final String name,
      required final String code,
      required final String firstLightSource,
      required final String secondLightSource}) = _$BuyerInfoImpl;

  factory _BuyerInfo.fromJson(Map<String, dynamic> json) =
      _$BuyerInfoImpl.fromJson;

  @override
  String get name;
  @override
  String get code;
  @override
  String get firstLightSource;
  @override
  String get secondLightSource;

  /// Create a copy of BuyerInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BuyerInfoImplCopyWith<_$BuyerInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
