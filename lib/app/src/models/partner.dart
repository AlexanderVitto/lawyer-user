import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'partner.g.dart';

@JsonSerializable(explicitToJson: true)
class Partner extends Person {
  @JsonKey(name: 'Id')
  String id;

  @JsonKey(name: 'Email', defaultValue: null, includeIfNull: false)
  String email;

  @JsonKey(name: 'Level', defaultValue: null, includeIfNull: false)
  final String level;

  @JsonKey(name: 'MasterExpertiseId', defaultValue: null, includeIfNull: false)
  final int masterExpertiseId;

  @JsonKey(name: 'PriceSchemaId', defaultValue: null, includeIfNull: false)
  final int priceSchemaId;

  @JsonKey(name: 'PriceName', defaultValue: null, includeIfNull: false)
  final String priceName;

  @JsonKey(name: 'ServiceId', defaultValue: null, includeIfNull: false)
  final int serviceId;

  @JsonKey(name: 'ServiceName', defaultValue: null, includeIfNull: false)
  final String serviceName;

  @JsonKey(name: 'ServicePrice', defaultValue: null, includeIfNull: false)
  final double servicePrice;

  @JsonKey(name: 'Experiences', defaultValue: null, includeIfNull: false)
  final int experiences;

  @JsonKey(name: 'Locality', defaultValue: null, includeIfNull: false)
  final String locality;

  @JsonKey(name: 'IsSuspended', defaultValue: null, includeIfNull: false)
  final bool isSuspended;

  @JsonKey(name: 'SuspendUntil', defaultValue: null, includeIfNull: false)
  final String suspendUntil;

  @JsonKey(name: 'TitleBack', defaultValue: null, includeIfNull: false)
  final String titleBack;

  @JsonKey(name: 'TitleFront', defaultValue: null, includeIfNull: false)
  final String titleFront;

  @JsonKey(
      name: 'IdentificataionType', defaultValue: null, includeIfNull: false)
  final StaticData identificataionType;

  @JsonKey(name: 'MaritalStatus', defaultValue: null, includeIfNull: false)
  final StaticData maritalStatus;

  @JsonKey(name: 'Religion', defaultValue: null, includeIfNull: false)
  final StaticData religion;

  @JsonKey(name: 'Sex', defaultValue: null, includeIfNull: false)
  final StaticData sex;

  @JsonKey(name: 'PartnerExpertises', defaultValue: null, includeIfNull: false)
  final List<PartnerExpertise> partnerExpertises;

  @JsonKey(name: 'PartnerPrices', defaultValue: null, includeIfNull: false)
  final List<PartnerPrice> partnerPrices;

  @JsonKey(name: 'PartnerSchedules', defaultValue: null, includeIfNull: false)
  final List<PartnerSchedule> partnerSchedules;

  Partner(
      {this.id,
      this.email,
      this.level,
      this.masterExpertiseId,
      this.priceSchemaId,
      this.priceName,
      this.serviceId,
      this.serviceName,
      this.servicePrice,
      this.partnerExpertises,
      this.partnerPrices,
      this.experiences,
      this.locality,
      this.isSuspended,
      this.suspendUntil,
      this.titleBack,
      this.titleFront,
      this.identificataionType,
      this.maritalStatus,
      this.religion,
      this.sex,
      this.partnerSchedules,
      firstName,
      lastName,
      salutation,
      sexId,
      dateOfBirth,
      idNumber,
      idType,
      phoneNumber,
      mobileNumber,
      address,
      maritalStatusId,
      ethnic,
      religionId,
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
            sexId: sexId,
            dateOfBirth: dateOfBirth,
            idNumber: idNumber,
            idType: idType,
            phoneNumber: phoneNumber,
            mobileNumber: mobileNumber,
            address: address,
            maritalStatusId: maritalStatusId,
            ethnic: ethnic,
            religionId: religionId,
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
class PartnerExpertise {
  @JsonKey(name: 'Id', defaultValue: null, includeIfNull: false)
  final int id;

  @JsonKey(name: 'PartnerId', defaultValue: null, includeIfNull: false)
  final String partnerId;

  @JsonKey(name: 'MasterExpertiseId', defaultValue: null, includeIfNull: false)
  final String masterExpertiseId;

  @JsonKey(name: 'ServiceEligible', defaultValue: null, includeIfNull: false)
  final String serviceEligible;

  @JsonKey(name: 'ServiceEnable', defaultValue: null, includeIfNull: false)
  final String serviceEnable;

  PartnerExpertise(
      {this.id,
      this.partnerId,
      this.masterExpertiseId,
      this.serviceEligible,
      this.serviceEnable});

  factory PartnerExpertise.fromJson(Map<String, dynamic> json) =>
      _$PartnerExpertiseFromJson(json);
  Map<String, dynamic> toJson() => _$PartnerExpertiseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PartnerPrice {
  @JsonKey(name: 'Id')
  final int id;

  @JsonKey(name: 'PartnerId', defaultValue: null, includeIfNull: false)
  final String partnerId;

  @JsonKey(name: 'PriceSchemaId', defaultValue: null, includeIfNull: false)
  final int priceSchemaId;

  @JsonKey(name: 'PriceLevelId', defaultValue: null, includeIfNull: false)
  final int priceLevelId;

  @JsonKey(name: 'ServiceCategoryId', defaultValue: null, includeIfNull: false)
  final int serviceCategoryId;

  @JsonKey(name: 'PriceSchema', defaultValue: null, includeIfNull: false)
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

  @JsonKey(name: 'PriceLevelId', defaultValue: null, includeIfNull: false)
  final int priceLevelId;

  @JsonKey(name: 'ServiceCategoryId', defaultValue: null, includeIfNull: false)
  final int serviceCategoryId;

  @JsonKey(name: 'Name', defaultValue: null, includeIfNull: false)
  final String name;

  @JsonKey(name: 'Description', defaultValue: null, includeIfNull: false)
  final String description;

  @JsonKey(name: 'BasePrice', defaultValue: null, includeIfNull: false)
  final double basePrice;

  @JsonKey(name: 'ServiceCount', defaultValue: null, includeIfNull: false)
  final int serviceCount;

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
      this.basePrice,
      this.serviceCount,
      this.isEnabled,
      this.isDeleted});

  factory MasterPrice.fromJson(Map<String, dynamic> json) =>
      _$MasterPriceFromJson(json);
  Map<String, dynamic> toJson() => _$MasterPriceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PartnerSchedule {
  @JsonKey(name: 'Id', defaultValue: null, includeIfNull: false)
  final int id;

  @JsonKey(name: 'PartnerId', defaultValue: null, includeIfNull: false)
  final String partnerId;

  @JsonKey(name: 'StartDate', defaultValue: null, includeIfNull: false)
  final String startDate;

  @JsonKey(name: 'StartTime', defaultValue: null, includeIfNull: false)
  final String startTime;

  @JsonKey(name: 'StartTimezone', defaultValue: null, includeIfNull: false)
  final String startTimezone;

  @JsonKey(name: 'EndDate', defaultValue: null, includeIfNull: false)
  final String endDate;

  @JsonKey(name: 'EndTime', defaultValue: null, includeIfNull: false)
  final String endTime;

  @JsonKey(name: 'EndTimezone', defaultValue: null, includeIfNull: false)
  final String endTimezone;

  @JsonKey(name: 'EventTypeId', defaultValue: null, includeIfNull: false)
  final int eventTypeId;

  @JsonKey(name: 'RecurrenceRule', defaultValue: null, includeIfNull: false)
  final String recurrenceRule;

  @JsonKey(name: 'Location', defaultValue: null, includeIfNull: false)
  final String location;

  @JsonKey(name: 'IsBlock', defaultValue: null, includeIfNull: false)
  final bool isBlock;

  @JsonKey(name: 'IsAllDay', defaultValue: null, includeIfNull: false)
  final bool isAllDay;

  @JsonKey(name: 'EffectiveDate', defaultValue: null, includeIfNull: false)
  final String effectiveDate;

  @JsonKey(name: 'IsEnabled', defaultValue: null, includeIfNull: false)
  final bool isEnabled;

  @JsonKey(name: 'IsDeleted', defaultValue: null, includeIfNull: false)
  final bool isDeleted;

  PartnerSchedule(
      {this.id,
      this.partnerId,
      this.startDate,
      this.startTime,
      this.startTimezone,
      this.endDate,
      this.endTime,
      this.endTimezone,
      this.eventTypeId,
      this.recurrenceRule,
      this.location,
      this.isBlock,
      this.isAllDay,
      this.effectiveDate,
      this.isEnabled,
      this.isDeleted});

  factory PartnerSchedule.fromJson(Map<String, dynamic> json) =>
      _$PartnerScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$PartnerScheduleToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResponseListPartner {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  final bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  final String message;

  @JsonKey(name: 'code', defaultValue: null, nullable: true)
  final String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  final List<Partner> result;

  @JsonKey(name: 'CurrentPage', defaultValue: null, nullable: true)
  final int currentPage;

  @JsonKey(name: 'TotalPage', defaultValue: null, nullable: true)
  final int totalPage;

  @JsonKey(name: 'PageSize', defaultValue: null, nullable: true)
  final int pageSize;

  @JsonKey(name: 'RowCount', defaultValue: null, nullable: true)
  final int rowCount;

  @JsonKey(name: 'HasPreviousPage', defaultValue: null, nullable: true)
  final bool hasPreviousPage;

  @JsonKey(name: 'HasNextPage', defaultValue: null, nullable: true)
  final bool hasNextPage;

  @JsonKey(name: 'FirstRowOnPage', defaultValue: null, nullable: true)
  final int firstRowOnPage;

  @JsonKey(name: 'LastRowOnPage', defaultValue: null, nullable: true)
  final int lastRowOnPage;

  ResponseListPartner({
    this.status,
    this.message,
    this.code,
    this.result,
    this.currentPage,
    this.totalPage,
    this.pageSize,
    this.rowCount,
    this.hasPreviousPage,
    this.hasNextPage,
    this.firstRowOnPage,
    this.lastRowOnPage,
  });
  factory ResponseListPartner.fromJson(Map<String, dynamic> json) =>
      _$ResponseListPartnerFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseListPartnerToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResponsePartner {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  final bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  final String message;

  @JsonKey(name: 'code', defaultValue: null, nullable: true)
  final String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  final Partner result;

  ResponsePartner({
    this.status,
    this.message,
    this.code,
    this.result,
  });
  factory ResponsePartner.fromJson(Map<String, dynamic> json) =>
      _$ResponsePartnerFromJson(json);
  Map<String, dynamic> toJson() => _$ResponsePartnerToJson(this);
}
