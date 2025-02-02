// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_header_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderHeaderLineImpl _$$OrderHeaderLineImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderHeaderLineImpl(
      orderNumber: (json['orderNumber'] as num).toInt(),
      orderType: json['orderType'] as String,
      orderCompany: json['orderCompany'] as String,
      orderDate: DateTime.parse(json['orderDate'] as String),
      orderReference: json['orderReference'] as String,
      holdCode: json['holdCode'] as String,
      shipTo: (json['shipTo'] as num).toInt(),
      quantityOrdered: (json['quantityOrdered'] as num).toInt(),
      quantityShipped: (json['quantityShipped'] as num).toInt(),
      quantityCancelled: (json['quantityCancelled'] as num).toInt(),
      orderStatus: json['orderStatus'] as String,
      orderAmount: (json['orderAmount'] as num).toDouble(),
      quantityBackOrdered: (json['quantityBackOrdered'] as num).toInt(),
      canIndent: json['canIndent'] as bool,
      isDTM: json['isDTM'] as bool,
    );

Map<String, dynamic> _$$OrderHeaderLineImplToJson(
        _$OrderHeaderLineImpl instance) =>
    <String, dynamic>{
      'orderNumber': instance.orderNumber,
      'orderType': instance.orderType,
      'orderCompany': instance.orderCompany,
      'orderDate': instance.orderDate.toIso8601String(),
      'orderReference': instance.orderReference,
      'holdCode': instance.holdCode,
      'shipTo': instance.shipTo,
      'quantityOrdered': instance.quantityOrdered,
      'quantityShipped': instance.quantityShipped,
      'quantityCancelled': instance.quantityCancelled,
      'orderStatus': instance.orderStatus,
      'orderAmount': instance.orderAmount,
      'quantityBackOrdered': instance.quantityBackOrdered,
      'canIndent': instance.canIndent,
      'isDTM': instance.isDTM,
    };
