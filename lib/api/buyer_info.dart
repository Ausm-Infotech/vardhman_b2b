import 'package:freezed_annotation/freezed_annotation.dart';

part 'buyer_info.freezed.dart';
part 'buyer_info.g.dart';

@freezed
class BuyerInfo with _$BuyerInfo {
  const factory BuyerInfo({
    required String name,
    required String code,
    required String firstLightSource,
    required String secondLightSource,
  }) = _BuyerInfo;

  factory BuyerInfo.fromJson(Map<String, dynamic> json) =>
      _$BuyerInfoFromJson(json);
}
