import 'package:freezed_annotation/freezed_annotation.dart';

part 'indent_info.freezed.dart';
part 'indent_info.g.dart';

@freezed
class IndentInfo with _$IndentInfo {
  const factory IndentInfo({
    required int lotQuantity,
    required String article,
    required String uom,
  }) = _IndentInfo;

  factory IndentInfo.fromJson(Map<String, dynamic> json) =>
      _$IndentInfoFromJson(json);
}
