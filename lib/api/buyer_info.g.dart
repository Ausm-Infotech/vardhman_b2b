// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buyer_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BuyerInfoImpl _$$BuyerInfoImplFromJson(Map<String, dynamic> json) =>
    _$BuyerInfoImpl(
      name: json['name'] as String,
      code: json['code'] as String,
      firstLightSource: json['firstLightSource'] as String,
      secondLightSource: json['secondLightSource'] as String,
    );

Map<String, dynamic> _$$BuyerInfoImplToJson(_$BuyerInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'firstLightSource': instance.firstLightSource,
      'secondLightSource': instance.secondLightSource,
    };
