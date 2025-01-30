// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indent_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IndentInfoImpl _$$IndentInfoImplFromJson(Map<String, dynamic> json) =>
    _$IndentInfoImpl(
      lotQuantity: (json['lotQuantity'] as num).toInt(),
      article: json['article'] as String,
      uom: json['uom'] as String,
    );

Map<String, dynamic> _$$IndentInfoImplToJson(_$IndentInfoImpl instance) =>
    <String, dynamic>{
      'lotQuantity': instance.lotQuantity,
      'article': instance.article,
      'uom': instance.uom,
    };
