// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_catalog_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemCatalogInfoImpl _$$ItemCatalogInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$ItemCatalogInfoImpl(
      article: json['article'] as String,
      uom: json['uom'] as String,
      category: json['category'] as String,
      categoryDesc: json['categoryDesc'] as String,
      subSegment: json['subSegment'] as String,
      subSegmentDesc: json['subSegmentDesc'] as String,
      brand: json['brand'] as String,
      brandDesc: json['brandDesc'] as String,
      substrate: json['substrate'] as String,
      substrateDesc: json['substrateDesc'] as String,
      count: json['count'] as String,
      length: json['length'] as String,
      ticket: json['ticket'] as String,
      tex: json['tex'] as String,
      variant: json['variant'] as String,
    );

Map<String, dynamic> _$$ItemCatalogInfoImplToJson(
        _$ItemCatalogInfoImpl instance) =>
    <String, dynamic>{
      'article': instance.article,
      'uom': instance.uom,
      'category': instance.category,
      'categoryDesc': instance.categoryDesc,
      'subSegment': instance.subSegment,
      'subSegmentDesc': instance.subSegmentDesc,
      'brand': instance.brand,
      'brandDesc': instance.brandDesc,
      'substrate': instance.substrate,
      'substrateDesc': instance.substrateDesc,
      'count': instance.count,
      'length': instance.length,
      'ticket': instance.ticket,
      'tex': instance.tex,
      'variant': instance.variant,
    };
