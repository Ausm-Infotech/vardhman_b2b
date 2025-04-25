import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_summary.freezed.dart';
part 'order_summary.g.dart';

@freezed
class OrderSummary with _$OrderSummary {
  const factory OrderSummary({
    required String customerCode, //AN8
    required String customerName, //
    required String portalOrder, //EDBT
    required String jdeOrder, //DOCO
    required String orderType, //EDCT
    required String orderDate, //EDDT
    required String orderRemark, //PNID
  }) = _OrderSummary;

  factory OrderSummary.fromJson(Map<String, dynamic> json) =>
      _$OrderSummaryFromJson(json);
}
