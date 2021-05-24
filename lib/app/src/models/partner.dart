import 'package:json_annotation/json_annotation.dart';
import 'person.dart';

part 'partner.g.dart';

@JsonSerializable(explicitToJson: true)
class Partner extends Person {
  @JsonKey(name: 'Id')
  String id;
  @JsonKey(name: 'Email', defaultValue: null, includeIfNull: false)
  String email;
  @JsonKey(name: 'Level', defaultValue: null, includeIfNull: false)
  final String level;
  @JsonKey(name: 'PartnerPrices', defaultValue: null, includeIfNull: false)
  final List<PartnerPrice> partnerPrices;

  Partner(
      {this.id,
      this.email,
      this.level,
      this.partnerPrices,
      firstName,
      lastName,
      salutation,
      sex,
      dateOfBirth,
      idNumber,
      idType,
      phoneNumber,
      mobileNumber,
      address,
      maritalStatus,
      ethnic,
      religion,
      occupation,
      pictureUrl,
      country,
      region1,
      region2,
      region3,
      region4,
      zipCode,
      lastEducation})
      : super(
            firstName: firstName,
            lastName: lastName,
            salutation: salutation,
            sex: sex,
            dateOfBirth: dateOfBirth,
            idNumber: idNumber,
            idType: idType,
            phoneNumber: phoneNumber,
            mobileNumber: mobileNumber,
            address: address,
            maritalStatus: maritalStatus,
            ethnic: ethnic,
            religion: religion,
            occupation: occupation,
            pictureUrl: pictureUrl,
            country: country,
            region1: region1,
            region2: region2,
            region3: region3,
            region4: region4,
            zipCode: zipCode,
            lastEducation: lastEducation);

  factory Partner.fromJson(Map<String, dynamic> json) =>
      _$PartnerFromJson(json);
  Map<String, dynamic> toJson() => _$PartnerToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PartnerPrice {
  @JsonKey(name: 'Id')
  final int id;

  @JsonKey(name: 'PartnerId', defaultValue: null)
  final String partnerId;

  @JsonKey(name: 'PriceSchemaId', defaultValue: null)
  final int priceSchemaId;

  @JsonKey(name: 'PriceLevelId', defaultValue: null)
  final int priceLevelId;

  @JsonKey(name: 'ServiceCategoryId', defaultValue: null)
  final int serviceCategoryId;

  @JsonKey(name: 'PriceSchema', defaultValue: null)
  final MasterPrice priceSchema;

  PartnerPrice(
      {this.id,
      this.partnerId,
      this.priceSchemaId,
      this.priceLevelId,
      this.serviceCategoryId,
      this.priceSchema});

  factory PartnerPrice.fromJson(Map<String, dynamic> json) =>
      _$PartnerPriceFromJson(json);
  Map<String, dynamic> toJson() => _$PartnerPriceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MasterPrice {
  @JsonKey(name: 'Id')
  final int id;

  @JsonKey(name: 'PriceLevelId', defaultValue: null)
  final int priceLevelId;

  @JsonKey(name: 'ServiceCategoryId', defaultValue: null)
  final int serviceCategoryId;

  @JsonKey(name: 'Name', defaultValue: null)
  final String name;

  @JsonKey(name: 'Description', defaultValue: null)
  final String description;

  @JsonKey(name: 'BasePrice', defaultValue: null)
  final double basePrice;

  @JsonKey(name: 'isEnabled', defaultValue: null, includeIfNull: false)
  bool isEnabled;

  @JsonKey(name: 'isDeleted', defaultValue: null, includeIfNull: false)
  bool isDeleted;

  MasterPrice(
      {this.id,
      this.priceLevelId,
      this.serviceCategoryId,
      this.name,
      this.description,
      this.basePrice});

  factory MasterPrice.fromJson(Map<String, dynamic> json) =>
      _$MasterPriceFromJson(json);
  Map<String, dynamic> toJson() => _$MasterPriceToJson(this);
}
