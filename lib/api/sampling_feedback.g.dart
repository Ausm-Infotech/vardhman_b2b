// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sampling_feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SamplingFeedbackImpl _$$SamplingFeedbackImplFromJson(
        Map<String, dynamic> json) =>
    _$SamplingFeedbackImpl(
      orderNumber: (json['orderNumber'] as num).toInt(),
      lineNumber: (json['lineNumber'] as num).toDouble(),
      reason: json['reason'] as String,
      isPositive: json['isPositive'] as bool,
      shouldRematch: json['shouldRematch'] as bool,
    );

Map<String, dynamic> _$$SamplingFeedbackImplToJson(
        _$SamplingFeedbackImpl instance) =>
    <String, dynamic>{
      'orderNumber': instance.orderNumber,
      'lineNumber': instance.lineNumber,
      'reason': instance.reason,
      'isPositive': instance.isPositive,
      'shouldRematch': instance.shouldRematch,
    };
