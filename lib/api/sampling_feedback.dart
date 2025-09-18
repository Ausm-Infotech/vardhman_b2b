import 'package:freezed_annotation/freezed_annotation.dart';

part 'sampling_feedback.freezed.dart';
part 'sampling_feedback.g.dart';

@freezed
class SamplingFeedback with _$SamplingFeedback {
  const factory SamplingFeedback({
    required int orderNumber,
    required double lineNumber,
    required String reason,
    required bool isPositive,
    required bool shouldRematch,
  }) = _SamplingFeedback;

  factory SamplingFeedback.fromJson(Map<String, dynamic> json) =>
      _$SamplingFeedbackFromJson(json);
}
