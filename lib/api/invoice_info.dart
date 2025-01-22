import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vardhman_b2b/constants.dart';

part 'invoice_info.freezed.dart';
part 'invoice_info.g.dart';

@freezed
class InvoiceInfo with _$InvoiceInfo {
  const factory InvoiceInfo({
    required double openAmount,
    required double grossAmount,
    required double discountAmount,
    required double taxableAmount,
    required double tax,
    required String customerNumber,
    required String company,
    required String docType,
    required int invoiceNumber,
    required int salesOrderNumber,
    required String salesOrderType,
    required DateTime date,
    required DateTime discountDueDate,
    required bool isOpen,
    required InvoiceStatus status,
    required String receiptNumber,
    required DateTime receiptDate,
  }) = _InvoiceInfo;

  factory InvoiceInfo.fromJson(Map<String, dynamic> json) =>
      _$InvoiceInfoFromJson(json);
}

enum InvoiceStatus {
  paid,
  creditNote,
  overdue,
  partiallyPaid,
  notDue,
  discounted,
  processing,
}

InvoiceInfo getInvoiceInfoWithStatusAndDiscount(InvoiceInfo invoiceInfo) {
  return invoiceInfo.copyWith(
    status: _getInvoiceStatus(invoiceInfo),
    discountAmount: _getDiscountAmount(invoiceInfo),
  );
}

InvoiceStatus _getInvoiceStatus(InvoiceInfo invoiceInfo) {
  DateTime now = DateTime.now();

  if (invoiceInfo.isOpen) {
    if (invoiceInfo.openAmount.isNegative) {
      return InvoiceStatus.creditNote;
    } else if (now.isAfter(invoiceInfo.discountDueDate)) {
      return InvoiceStatus.overdue;
    } else if (invoiceInfo.openAmount != invoiceInfo.grossAmount) {
      return InvoiceStatus.partiallyPaid;
    } else if (_getDiscountAmount(invoiceInfo) > 0) {
      return InvoiceStatus.discounted;
    } else {
      return InvoiceStatus.notDue;
    }
  } else {
    return InvoiceStatus.paid;
  }
}

String getInvoiceStatusText(InvoiceStatus invoiceStatus) {
  switch (invoiceStatus) {
    case InvoiceStatus.creditNote:
      return 'Credit Note';
    case InvoiceStatus.paid:
      return 'Paid';
    case InvoiceStatus.overdue:
      return 'Overdue';
    case InvoiceStatus.partiallyPaid:
      return 'Partially Paid';
    case InvoiceStatus.notDue:
      return 'Not Due';
    case InvoiceStatus.processing:
      return 'Payment Processing';
    case InvoiceStatus.discounted:
      return 'Discount Applicable';
  }
}

Color getInvoiceStatusColor(InvoiceStatus invoiceStatus) {
  switch (invoiceStatus) {
    case InvoiceStatus.creditNote:
    case InvoiceStatus.paid:
    case InvoiceStatus.partiallyPaid:
    case InvoiceStatus.discounted:
      return VardhmanColors.green;
    case InvoiceStatus.overdue:
      return VardhmanColors.red;
    case InvoiceStatus.notDue:
    case InvoiceStatus.processing:
      return VardhmanColors.darkGrey;
  }
}

double _getDiscountAmount(InvoiceInfo invoiceInfo) {
  double discountAmount = 0;

  DateTime discountExpiryDate = invoiceInfo.date.add(
    const Duration(days: 7),
  );

  if (DateTime.now().isBefore(discountExpiryDate)) {
    discountAmount = invoiceInfo.openAmount * 0.97;
  }

  return discountAmount;
}
