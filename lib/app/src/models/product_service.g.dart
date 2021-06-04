// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductService _$ProductServiceFromJson(Map<String, dynamic> json) {
  return ProductService(
    id: json['Id'] as int,
    name: json['Name'] as String,
    description: json['Description'] as String,
    masterExpertiseId: json['MasterExpertiseId'] as int,
    priceSchemaId: json['PriceSchemaId'] as int,
    isBundled: json['IsBundled'] as bool,
    bundleParentId: json['BundleParentId'] as int,
    sellingPrice: (json['SellingPrice'] as num)?.toDouble(),
    productCount: json['ProductCount'] as int,
    isEnabled: json['IsEnabled'] as bool,
    isDeleted: json['IsDeleted'] as bool,
    startDate: json['StartDate'] as String,
    endDate: json['EndDate'] as String,
  );
}

Map<String, dynamic> _$ProductServiceToJson(ProductService instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('Name', instance.name);
  writeNotNull('Description', instance.description);
  writeNotNull('MasterExpertiseId', instance.masterExpertiseId);
  writeNotNull('PriceSchemaId', instance.priceSchemaId);
  writeNotNull('IsBundled', instance.isBundled);
  writeNotNull('BundleParentId', instance.bundleParentId);
  writeNotNull('SellingPrice', instance.sellingPrice);
  writeNotNull('ProductCount', instance.productCount);
  writeNotNull('IsEnabled', instance.isEnabled);
  writeNotNull('IsDeleted', instance.isDeleted);
  writeNotNull('StartDate', instance.startDate);
  writeNotNull('EndDate', instance.endDate);
  return val;
}

ResponseListProductService _$ResponseListProductServiceFromJson(
    Map<String, dynamic> json) {
  return ResponseListProductService(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: (json['Result'] as List)
        ?.map((e) => e == null
            ? null
            : ProductService.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResponseListProductServiceToJson(
        ResponseListProductService instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result?.map((e) => e?.toJson())?.toList(),
    };
