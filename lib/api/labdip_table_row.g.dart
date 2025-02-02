// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'labdip_table_row.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LabdipTableRowImpl _$$LabdipTableRowImplFromJson(Map<String, dynamic> json) =>
    _$LabdipTableRowImpl(
      workOrderNumber: (json['workOrderNumber'] as num).toInt(),
      permanentShade: json['permanentShade'] as String,
      reference: json['reference'] as String,
    );

Map<String, dynamic> _$$LabdipTableRowImplToJson(
        _$LabdipTableRowImpl instance) =>
    <String, dynamic>{
      'workOrderNumber': instance.workOrderNumber,
      'permanentShade': instance.permanentShade,
      'reference': instance.reference,
    };
