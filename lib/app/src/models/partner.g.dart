// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Partner _$PartnerFromJson(Map<String, dynamic> json) {
  return Partner(
    id: json['Id'] as String,
    email: json['Email'] as String,
    level: json['Level'] as String,
    partnerPrices: (json['PartnerPrices'] as List)
        ?.map((e) =>
            e == null ? null : PartnerPrice.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    firstName: json['FirstName'],
    lastName: json['LastName'],
    salutation: json['Salutation'],
    sex: json['SexId'],
    dateOfBirth: json['DateOfBirth'],
    idNumber: json['IdentificationNumber'],
    idType: json['IdentificationTypeId'],
    phoneNumber: json['PhoneNumber'],
    mobileNumber: json['MobileNumber'],
    address: json['Address'],
    maritalStatus: json['MaritalStatusId'],
    ethnic: json['Ethnic'],
    religion: json['ReligionId'],
    occupation: json['OccupationId'],
    pictureUrl: json['PictureUrl'],
    country: json['Country'],
    region1: json['Region1'],
    region2: json['Region2'],
    region3: json['Region3'],
    region4: json['Region4'],
    zipCode: json['ZipCode'],
    lastEducation: json['EducationId'],
  );
}

Map<String, dynamic> _$PartnerToJson(Partner instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('FirstName', instance.firstName);
  writeNotNull('LastName', instance.lastName);
  writeNotNull('Salutation', instance.salutation);
  writeNotNull('SexId', instance.sex);
  writeNotNull('DateOfBirth', instance.dateOfBirth);
  writeNotNull('IdentificationNumber', instance.idNumber);
  writeNotNull('IdentificationTypeId', instance.idType);
  writeNotNull('PhoneNumber', instance.phoneNumber);
  writeNotNull('MobileNumber', instance.mobileNumber);
  writeNotNull('Address', instance.address);
  writeNotNull('Country', instance.country);
  writeNotNull('Region1', instance.region1);
  writeNotNull('Region2', instance.region2);
  writeNotNull('Region3', instance.region3);
  writeNotNull('Region4', instance.region4);
  writeNotNull('ZipCode', instance.zipCode);
  writeNotNull('MaritalStatusId', instance.maritalStatus);
  writeNotNull('Ethnic', instance.ethnic);
  writeNotNull('ReligionId', instance.religion);
  writeNotNull('OccupationId', instance.occupation);
  writeNotNull('PictureUrl', instance.pictureUrl);
  writeNotNull('EducationId', instance.lastEducation);
  val['Id'] = instance.id;
  writeNotNull('Email', instance.email);
  writeNotNull('Level', instance.level);
  writeNotNull('PartnerPrices',
      instance.partnerPrices?.map((e) => e?.toJson())?.toList());
  return val;
}

PartnerPrice _$PartnerPriceFromJson(Map<String, dynamic> json) {
  return PartnerPrice(
    id: json['Id'] as int,
    partnerId: json['PartnerId'] as String,
    priceSchemaId: json['PriceSchemaId'] as int,
    priceLevelId: json['PriceLevelId'] as int,
    serviceCategoryId: json['ServiceCategoryId'] as int,
    priceSchema: json['PriceSchema'] == null
        ? null
        : MasterPrice.fromJson(json['PriceSchema'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PartnerPriceToJson(PartnerPrice instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'PartnerId': instance.partnerId,
      'PriceSchemaId': instance.priceSchemaId,
      'PriceLevelId': instance.priceLevelId,
      'ServiceCategoryId': instance.serviceCategoryId,
      'PriceSchema': instance.priceSchema?.toJson(),
    };

MasterPrice _$MasterPriceFromJson(Map<String, dynamic> json) {
  return MasterPrice(
    id: json['Id'] as int,
    priceLevelId: json['PriceLevelId'] as int,
    serviceCategoryId: json['ServiceCategoryId'] as int,
    name: json['Name'] as String,
    description: json['Description'] as String,
    basePrice: (json['BasePrice'] as num)?.toDouble(),
  )
    ..isEnabled = json['isEnabled'] as bool
    ..isDeleted = json['isDeleted'] as bool;
}

Map<String, dynamic> _$MasterPriceToJson(MasterPrice instance) {
  final val = <String, dynamic>{
    'Id': instance.id,
    'PriceLevelId': instance.priceLevelId,
    'ServiceCategoryId': instance.serviceCategoryId,
    'Name': instance.name,
    'Description': instance.description,
    'BasePrice': instance.basePrice,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('isEnabled', instance.isEnabled);
  writeNotNull('isDeleted', instance.isDeleted);
  return val;
}
