// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserAddressImpl _$$UserAddressImplFromJson(Map<String, dynamic> json) =>
    _$UserAddressImpl(
      alphaName: json['alphaName'] as String,
      addressLine1: json['addressLine1'] as String,
      addressLine2: json['addressLine2'] as String,
      addressLine3: json['addressLine3'] as String,
      addressLine4: json['addressLine4'] as String,
      city: json['city'] as String,
      postalCode: json['postalCode'] as String,
      state: json['state'] as String,
      stateCode: json['stateCode'] as String,
      country: json['country'] as String,
      countryCode: json['countryCode'] as String,
      deliveryAddressNumber: (json['deliveryAddressNumber'] as num).toInt(),
      branchPlant: json['branchPlant'] as String?,
      branchPlantEmail: json['branchPlantEmail'] as String?,
      branchPlantPhone: json['branchPlantPhone'] as String?,
      branchPlantWhatsApp: json['branchPlantWhatsApp'] as String?,
    );

Map<String, dynamic> _$$UserAddressImplToJson(_$UserAddressImpl instance) =>
    <String, dynamic>{
      'alphaName': instance.alphaName,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'addressLine3': instance.addressLine3,
      'addressLine4': instance.addressLine4,
      'city': instance.city,
      'postalCode': instance.postalCode,
      'state': instance.state,
      'stateCode': instance.stateCode,
      'country': instance.country,
      'countryCode': instance.countryCode,
      'deliveryAddressNumber': instance.deliveryAddressNumber,
      'branchPlant': instance.branchPlant,
      'branchPlantEmail': instance.branchPlantEmail,
      'branchPlantPhone': instance.branchPlantPhone,
      'branchPlantWhatsApp': instance.branchPlantWhatsApp,
    };
