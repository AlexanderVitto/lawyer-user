import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'product_service.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductService {
  @JsonKey(name: 'Id', defaultValue: null, includeIfNull: false)
  final int id;

  @JsonKey(name: 'Name', defaultValue: null, includeIfNull: false)
  final String name;

  @JsonKey(name: 'Description', defaultValue: null, includeIfNull: false)
  final String description;

  @JsonKey(name: 'MasterExpertiseId', defaultValue: null, includeIfNull: false)
  final int masterExpertiseId;

  @JsonKey(name: 'PriceSchemaId', defaultValue: null, includeIfNull: false)
  final int priceSchemaId;

  @JsonKey(name: 'IsBundled', defaultValue: null, includeIfNull: false)
  final bool isBundled;

  @JsonKey(name: 'BundleParentId', defaultValue: null, includeIfNull: false)
  final int bundleParentId;

  @JsonKey(name: 'SellingPrice', defaultValue: null, includeIfNull: false)
  final double sellingPrice;

  @JsonKey(name: 'ProductCount', defaultValue: null, includeIfNull: false)
  final int productCount;

  @JsonKey(name: 'IsEnabled', defaultValue: null, includeIfNull: false)
  final bool isEnabled;

  @JsonKey(name: 'IsDeleted', defaultValue: null, includeIfNull: false)
  final bool isDeleted;

  @JsonKey(name: 'StartDate', defaultValue: null, includeIfNull: false)
  final String startDate;

  @JsonKey(name: 'EndDate', defaultValue: null, includeIfNull: false)
  final String endDate;

  ProductService(
      {this.id,
      this.name,
      this.description,
      this.masterExpertiseId,
      this.priceSchemaId,
      this.isBundled,
      this.bundleParentId,
      this.sellingPrice,
      this.productCount,
      this.isEnabled,
      this.isDeleted,
      this.startDate,
      this.endDate});

  factory ProductService.fromJson(Map<String, dynamic> json) =>
      _$ProductServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ProductServiceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResponseListProductService {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  List<ProductService> result;

  ResponseListProductService(
      {this.status, this.message, this.code, this.result});

  factory ResponseListProductService.fromJson(Map<String, dynamic> json) =>
      _$ResponseListProductServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseListProductServiceToJson(this);
}
