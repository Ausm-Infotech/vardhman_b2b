// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderSummaryImpl _$$OrderSummaryImplFromJson(Map<String, dynamic> json) =>
    _$OrderSummaryImpl(
      customerCode: json['customerCode'] as String,
      customerName: json['customerName'] as String,
      portalOrder: json['portalOrder'] as String,
      jdeOrder: json['jdeOrder'] as String,
      orderType: json['orderType'] as String,
      orderDate: json['orderDate'] as String,
      orderRemark: json['orderRemark'] as String,
    );

Map<String, dynamic> _$$OrderSummaryImplToJson(_$OrderSummaryImpl instance) =>
    <String, dynamic>{
      'customerCode': instance.customerCode,
      'customerName': instance.customerName,
      'portalOrder': instance.portalOrder,
      'jdeOrder': instance.jdeOrder,
      'orderType': instance.orderType,
      'orderDate': instance.orderDate,
      'orderRemark': instance.orderRemark,
    };
