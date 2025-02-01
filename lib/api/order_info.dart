import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_info.freezed.dart';
part 'order_info.g.dart';

@freezed
class OrderInfo with _$OrderInfo {
  const factory OrderInfo({
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
  }) = _OrderInfo;

  const OrderInfo._();

  String get orderNumberString => orderReference.trim().isNotEmpty
      ? orderReference
      : orderNumber.toString();

  factory OrderInfo.fromJson(Map<String, dynamic> json) =>
      _$OrderInfoFromJson(json);
}
