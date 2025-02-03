import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_header_line.freezed.dart';
part 'order_header_line.g.dart';

@freezed
class OrderHeaderLine with _$OrderHeaderLine {
  const factory OrderHeaderLine({
    required int orderNumber,
    required String orderType,
    required String orderCompany,
    required DateTime orderDate,
    required String orderReference,
    required String holdCode,
    required int shipTo,
    required int quantityOrdered,
    required int quantityShipped,
    required int quantityCancelled,
    required String orderStatus,
    required double orderAmount,
    required int quantityBackOrdered,
    required bool canIndent,
    required bool isDTM,
  }) = _OrderHeaderLine;

  const OrderHeaderLine._();

  String get orderNumberString => orderReference.trim().isNotEmpty
      ? orderReference
      : orderNumber.toString();

  factory OrderHeaderLine.fromJson(Map<String, dynamic> json) =>
      _$OrderHeaderLineFromJson(json);
}
