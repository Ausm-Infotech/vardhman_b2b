// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'indent_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IndentInfo _$IndentInfoFromJson(Map<String, dynamic> json) {
  return _IndentInfo.fromJson(json);
}

/// @nodoc
mixin _$IndentInfo {
  int get lotQuantity => throw _privateConstructorUsedError;
  String get article => throw _privateConstructorUsedError;
  String get uom => throw _privateConstructorUsedError;

  /// Serializes this IndentInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IndentInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IndentInfoCopyWith<IndentInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IndentInfoCopyWith<$Res> {
  factory $IndentInfoCopyWith(
          IndentInfo value, $Res Function(IndentInfo) then) =
      _$IndentInfoCopyWithImpl<$Res, IndentInfo>;
  @useResult
  $Res call({int lotQuantity, String article, String uom});
}

/// @nodoc
class _$IndentInfoCopyWithImpl<$Res, $Val extends IndentInfo>
    implements $IndentInfoCopyWith<$Res> {
  _$IndentInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IndentInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lotQuantity = null,
    Object? article = null,
    Object? uom = null,
  }) {
    return _then(_value.copyWith(
      lotQuantity: null == lotQuantity
          ? _value.lotQuantity
          : lotQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      article: null == article
          ? _value.article
          : article // ignore: cast_nullable_to_non_nullable
              as String,
      uom: null == uom
          ? _value.uom
          : uom // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IndentInfoImplCopyWith<$Res>
    implements $IndentInfoCopyWith<$Res> {
  factory _$$IndentInfoImplCopyWith(
          _$IndentInfoImpl value, $Res Function(_$IndentInfoImpl) then) =
      __$$IndentInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int lotQuantity, String article, String uom});
}

/// @nodoc
class __$$IndentInfoImplCopyWithImpl<$Res>
    extends _$IndentInfoCopyWithImpl<$Res, _$IndentInfoImpl>
    implements _$$IndentInfoImplCopyWith<$Res> {
  __$$IndentInfoImplCopyWithImpl(
      _$IndentInfoImpl _value, $Res Function(_$IndentInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of IndentInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lotQuantity = null,
    Object? article = null,
    Object? uom = null,
  }) {
    return _then(_$IndentInfoImpl(
      lotQuantity: null == lotQuantity
          ? _value.lotQuantity
          : lotQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      article: null == article
          ? _value.article
          : article // ignore: cast_nullable_to_non_nullable
              as String,
      uom: null == uom
          ? _value.uom
          : uom // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IndentInfoImpl implements _IndentInfo {
  const _$IndentInfoImpl(
      {required this.lotQuantity, required this.article, required this.uom});

  factory _$IndentInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$IndentInfoImplFromJson(json);

  @override
  final int lotQuantity;
  @override
  final String article;
  @override
  final String uom;

  @override
  String toString() {
    return 'IndentInfo(lotQuantity: $lotQuantity, article: $article, uom: $uom)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IndentInfoImpl &&
            (identical(other.lotQuantity, lotQuantity) ||
                other.lotQuantity == lotQuantity) &&
            (identical(other.article, article) || other.article == article) &&
            (identical(other.uom, uom) || other.uom == uom));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lotQuantity, article, uom);

  /// Create a copy of IndentInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IndentInfoImplCopyWith<_$IndentInfoImpl> get copyWith =>
      __$$IndentInfoImplCopyWithImpl<_$IndentInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IndentInfoImplToJson(
      this,
    );
  }
}

abstract class _IndentInfo implements IndentInfo {
  const factory _IndentInfo(
      {required final int lotQuantity,
      required final String article,
      required final String uom}) = _$IndentInfoImpl;

  factory _IndentInfo.fromJson(Map<String, dynamic> json) =
      _$IndentInfoImpl.fromJson;

  @override
  int get lotQuantity;
  @override
  String get article;
  @override
  String get uom;

  /// Create a copy of IndentInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IndentInfoImplCopyWith<_$IndentInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
