// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sampling_table_row.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SamplingTableRowImpl _$$SamplingTableRowImplFromJson(
        Map<String, dynamic> json) =>
    _$SamplingTableRowImpl(
      workOrderNumber: (json['workOrderNumber'] as num).toInt(),
      permanentShade: json['permanentShade'] as String,
      reference: json['reference'] as String,
    );

Map<String, dynamic> _$$SamplingTableRowImplToJson(
        _$SamplingTableRowImpl instance) =>
    <String, dynamic>{
      'workOrderNumber': instance.workOrderNumber,
      'permanentShade': instance.permanentShade,
      'reference': instance.reference,
    };
