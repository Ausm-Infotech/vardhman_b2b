// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'labdip_feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LabdipFeedbackImpl _$$LabdipFeedbackImplFromJson(Map<String, dynamic> json) =>
    _$LabdipFeedbackImpl(
      orderNumber: (json['orderNumber'] as num).toInt(),
      lineNumber: (json['lineNumber'] as num).toInt(),
      feedback: json['feedback'] as String,
      isPositive: json['isPositive'] as bool,
    );

Map<String, dynamic> _$$LabdipFeedbackImplToJson(
        _$LabdipFeedbackImpl instance) =>
    <String, dynamic>{
      'orderNumber': instance.orderNumber,
      'lineNumber': instance.lineNumber,
      'feedback': instance.feedback,
      'isPositive': instance.isPositive,
    };
