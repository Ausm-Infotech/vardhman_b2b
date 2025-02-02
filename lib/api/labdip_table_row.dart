import 'package:freezed_annotation/freezed_annotation.dart';

part 'labdip_table_row.freezed.dart';
part 'labdip_table_row.g.dart';

@freezed
class LabdipTableRow with _$LabdipTableRow {
  const factory LabdipTableRow({
    required int workOrderNumber,
    required String permanentShade,
    required String reference,
  }) = _LabdipTableRow;

  factory LabdipTableRow.fromJson(Map<String, dynamic> json) =>
      _$LabdipTableRowFromJson(json);
}
