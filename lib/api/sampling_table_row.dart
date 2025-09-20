import 'package:freezed_annotation/freezed_annotation.dart';

part 'sampling_table_row.freezed.dart';
part 'sampling_table_row.g.dart';

@freezed
class SamplingTableRow with _$SamplingTableRow {
  const factory SamplingTableRow({
    required int workOrderNumber,
    required String permanentShade,
    required String reference,
  }) = _SamplingTableRow;

  factory SamplingTableRow.fromJson(Map<String, dynamic> json) =>
      _$SamplingTableRowFromJson(json);
}
