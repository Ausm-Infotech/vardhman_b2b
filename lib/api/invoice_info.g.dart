// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvoiceInfoImpl _$$InvoiceInfoImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceInfoImpl(
      openAmount: (json['openAmount'] as num).toDouble(),
      grossAmount: (json['grossAmount'] as num).toDouble(),
      discountAmount: (json['discountAmount'] as num).toDouble(),
      taxableAmount: (json['taxableAmount'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      customerNumber: json['customerNumber'] as String,
      company: json['company'] as String,
      docType: json['docType'] as String,
      invoiceNumber: (json['invoiceNumber'] as num).toInt(),
      salesOrderNumber: (json['salesOrderNumber'] as num).toInt(),
      salesOrderType: json['salesOrderType'] as String,
      date: DateTime.parse(json['date'] as String),
      discountDueDate: DateTime.parse(json['discountDueDate'] as String),
      isOpen: json['isOpen'] as bool,
      status: $enumDecode(_$InvoiceStatusEnumMap, json['status']),
      receiptNumber: json['receiptNumber'] as String,
      receiptDate: DateTime.parse(json['receiptDate'] as String),
    );

Map<String, dynamic> _$$InvoiceInfoImplToJson(_$InvoiceInfoImpl instance) =>
    <String, dynamic>{
      'openAmount': instance.openAmount,
      'grossAmount': instance.grossAmount,
      'discountAmount': instance.discountAmount,
      'taxableAmount': instance.taxableAmount,
      'tax': instance.tax,
      'customerNumber': instance.customerNumber,
      'company': instance.company,
      'docType': instance.docType,
      'invoiceNumber': instance.invoiceNumber,
      'salesOrderNumber': instance.salesOrderNumber,
      'salesOrderType': instance.salesOrderType,
      'date': instance.date.toIso8601String(),
      'discountDueDate': instance.discountDueDate.toIso8601String(),
      'isOpen': instance.isOpen,
      'status': _$InvoiceStatusEnumMap[instance.status]!,
      'receiptNumber': instance.receiptNumber,
      'receiptDate': instance.receiptDate.toIso8601String(),
    };

const _$InvoiceStatusEnumMap = {
  InvoiceStatus.paid: 'paid',
  InvoiceStatus.creditNote: 'creditNote',
  InvoiceStatus.overdue: 'overdue',
  InvoiceStatus.partiallyPaid: 'partiallyPaid',
  InvoiceStatus.notDue: 'notDue',
  InvoiceStatus.discounted: 'discounted',
  InvoiceStatus.processing: 'processing',
  InvoiceStatus.onHold: 'onHold',
};
