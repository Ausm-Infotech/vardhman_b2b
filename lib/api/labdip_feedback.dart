import 'package:freezed_annotation/freezed_annotation.dart';

part 'labdip_feedback.freezed.dart';
part 'labdip_feedback.g.dart';

@freezed
class LabdipFeedback with _$LabdipFeedback {
  const factory LabdipFeedback({
    required int orderNumber,
    required double lineNumber,
    required String reason,
    required bool isPositive,
    required bool shouldRematch,
  }) = _LabdipFeedback;

  factory LabdipFeedback.fromJson(Map<String, dynamic> json) =>
      _$LabdipFeedbackFromJson(json);
}
