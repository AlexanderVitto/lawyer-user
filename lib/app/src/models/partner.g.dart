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
    masterExpertiseId: json['MasterExpertiseId'] as int,
    priceSchemaId: json['PriceSchemaId'] as int,
    priceName: json['PriceName'] as String,
    serviceId: json['ServiceId'] as int,
    serviceName: json['ServiceName'] as String,
    servicePrice: (json['ServicePrice'] as num)?.toDouble(),
    partnerExpertises: (json['PartnerExpertises'] as List)
        ?.map((e) => e == null
            ? null
            : PartnerExpertise.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    partnerPrices: (json['PartnerPrices'] as List)
        ?.map((e) =>
            e == null ? null : PartnerPrice.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    experiences: json['Experiences'] as int,
    locality: json['Locality'] as String,
    isSuspended: json['IsSuspended'] as bool,
    suspendUntil: json['SuspendUntil'] as String,
    titleBack: json['TitleBack'] as String,
    titleFront: json['TitleFront'] as String,
    identificataionType: json['IdentificataionType'] == null
        ? null
        : StaticData.fromJson(
            json['IdentificataionType'] as Map<String, dynamic>),
    maritalStatus: json['MaritalStatus'] == null
        ? null
        : StaticData.fromJson(json['MaritalStatus'] as Map<String, dynamic>),
    religion: json['Religion'] == null
        ? null
        : StaticData.fromJson(json['Religion'] as Map<String, dynamic>),
    sex: json['Sex'] == null
        ? null
        : StaticData.fromJson(json['Sex'] as Map<String, dynamic>),
    partnerSchedules: (json['PartnerSchedules'] as List)
        ?.map((e) => e == null
            ? null
            : PartnerSchedule.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    firstName: json['FirstName'],
    lastName: json['LastName'],
    salutation: json['Salutation'],
    sexId: json['SexId'],
    dateOfBirth: json['DateOfBirth'],
    idNumber: json['IdentificationNumber'],
    idType: json['IdentificationTypeId'],
    phoneNumber: json['PhoneNumber'],
    mobileNumber: json['MobileNumber'],
    address: json['Address'],
    maritalStatusId: json['MaritalStatusId'],
    ethnic: json['Ethnic'],
    religionId: json['ReligionId'],
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
  writeNotNull('SexId', instance.sexId);
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
  writeNotNull('MaritalStatusId', instance.maritalStatusId);
  writeNotNull('Ethnic', instance.ethnic);
  writeNotNull('ReligionId', instance.religionId);
  writeNotNull('OccupationId', instance.occupation);
  writeNotNull('PictureUrl', instance.pictureUrl);
  writeNotNull('EducationId', instance.lastEducation);
  val['Id'] = instance.id;
  writeNotNull('Email', instance.email);
  writeNotNull('Level', instance.level);
  writeNotNull('MasterExpertiseId', instance.masterExpertiseId);
  writeNotNull('PriceSchemaId', instance.priceSchemaId);
  writeNotNull('PriceName', instance.priceName);
  writeNotNull('ServiceId', instance.serviceId);
  writeNotNull('ServiceName', instance.serviceName);
  writeNotNull('ServicePrice', instance.servicePrice);
  writeNotNull('Experiences', instance.experiences);
  writeNotNull('Locality', instance.locality);
  writeNotNull('IsSuspended', instance.isSuspended);
  writeNotNull('SuspendUntil', instance.suspendUntil);
  writeNotNull('TitleBack', instance.titleBack);
  writeNotNull('TitleFront', instance.titleFront);
  writeNotNull('IdentificataionType', instance.identificataionType?.toJson());
  writeNotNull('MaritalStatus', instance.maritalStatus?.toJson());
  writeNotNull('Religion', instance.religion?.toJson());
  writeNotNull('Sex', instance.sex?.toJson());
  writeNotNull('PartnerExpertises',
      instance.partnerExpertises?.map((e) => e?.toJson())?.toList());
  writeNotNull('PartnerPrices',
      instance.partnerPrices?.map((e) => e?.toJson())?.toList());
  writeNotNull('PartnerSchedules',
      instance.partnerSchedules?.map((e) => e?.toJson())?.toList());
  return val;
}

PartnerExpertise _$PartnerExpertiseFromJson(Map<String, dynamic> json) {
  return PartnerExpertise(
    id: json['Id'] as int,
    partnerId: json['PartnerId'] as String,
    masterExpertiseId: json['MasterExpertiseId'] as int,
    serviceEligible: json['ServiceEligible'] as bool,
    serviceEnable: json['ServiceEnable'] as bool,
  );
}

Map<String, dynamic> _$PartnerExpertiseToJson(PartnerExpertise instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('PartnerId', instance.partnerId);
  writeNotNull('MasterExpertiseId', instance.masterExpertiseId);
  writeNotNull('ServiceEligible', instance.serviceEligible);
  writeNotNull('ServiceEnable', instance.serviceEnable);
  return val;
}

PartnerPrice _$PartnerPriceFromJson(Map<String, dynamic> json) {
  return PartnerPrice(
    id: json['Id'] as int,
    partnerId: json['PartnerId'] as String,
    masterPriceId: json['MasterPriceId'] as int,
    priceCategoryId: json['PriceCategoryId'] as int,
    priceName: json['PriceName'] as String,
    price: (json['Price'] as num)?.toDouble(),
    priceSchemaId: json['PriceSchemaId'] as int,
    priceLevelId: json['PriceLevelId'] as int,
    serviceCategoryId: json['ServiceCategoryId'] as int,
    priceSchema: json['PriceSchema'] == null
        ? null
        : MasterPrice.fromJson(json['PriceSchema'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PartnerPriceToJson(PartnerPrice instance) {
  final val = <String, dynamic>{
    'Id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PartnerId', instance.partnerId);
  writeNotNull('MasterPriceId', instance.masterPriceId);
  writeNotNull('PriceCategoryId', instance.priceCategoryId);
  writeNotNull('PriceName', instance.priceName);
  writeNotNull('Price', instance.price);
  writeNotNull('PriceSchemaId', instance.priceSchemaId);
  writeNotNull('PriceLevelId', instance.priceLevelId);
  writeNotNull('ServiceCategoryId', instance.serviceCategoryId);
  writeNotNull('PriceSchema', instance.priceSchema?.toJson());
  return val;
}

MasterPrice _$MasterPriceFromJson(Map<String, dynamic> json) {
  return MasterPrice(
    id: json['Id'] as int,
    priceLevelId: json['PriceLevelId'] as int,
    serviceCategoryId: json['ServiceCategoryId'] as int,
    name: json['Name'] as String,
    description: json['Description'] as String,
    basePrice: (json['BasePrice'] as num)?.toDouble(),
    serviceCount: json['ServiceCount'] as int,
    isEnabled: json['IsEnabled'] as bool,
    isDeleted: json['IsDeleted'] as bool,
  );
}

Map<String, dynamic> _$MasterPriceToJson(MasterPrice instance) {
  final val = <String, dynamic>{
    'Id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PriceLevelId', instance.priceLevelId);
  writeNotNull('ServiceCategoryId', instance.serviceCategoryId);
  writeNotNull('Name', instance.name);
  writeNotNull('Description', instance.description);
  writeNotNull('BasePrice', instance.basePrice);
  writeNotNull('ServiceCount', instance.serviceCount);
  writeNotNull('IsEnabled', instance.isEnabled);
  writeNotNull('IsDeleted', instance.isDeleted);
  return val;
}

PartnerSchedule _$PartnerScheduleFromJson(Map<String, dynamic> json) {
  return PartnerSchedule(
    id: json['Id'] as int,
    partnerId: json['PartnerId'] as String,
    startDate: json['StartDate'] as String,
    startTime: json['StartTime'] as String,
    startTimezone: json['StartTimezone'] as String,
    endDate: json['EndDate'] as String,
    endTime: json['EndTime'] as String,
    endTimezone: json['EndTimezone'] as String,
    eventTypeId: json['EventTypeId'] as int,
    recurrenceRule: json['RecurrenceRule'] as String,
    location: json['Location'] as String,
    isBlock: json['IsBlock'] as bool,
    isAllDay: json['IsAllDay'] as bool,
    effectiveDate: json['EffectiveDate'] as String,
    isEnabled: json['IsEnabled'] as bool,
    isDeleted: json['IsDeleted'] as bool,
  );
}

Map<String, dynamic> _$PartnerScheduleToJson(PartnerSchedule instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('PartnerId', instance.partnerId);
  writeNotNull('StartDate', instance.startDate);
  writeNotNull('StartTime', instance.startTime);
  writeNotNull('StartTimezone', instance.startTimezone);
  writeNotNull('EndDate', instance.endDate);
  writeNotNull('EndTime', instance.endTime);
  writeNotNull('EndTimezone', instance.endTimezone);
  writeNotNull('EventTypeId', instance.eventTypeId);
  writeNotNull('RecurrenceRule', instance.recurrenceRule);
  writeNotNull('Location', instance.location);
  writeNotNull('IsBlock', instance.isBlock);
  writeNotNull('IsAllDay', instance.isAllDay);
  writeNotNull('EffectiveDate', instance.effectiveDate);
  writeNotNull('IsEnabled', instance.isEnabled);
  writeNotNull('IsDeleted', instance.isDeleted);
  return val;
}

ScheduleResource _$ScheduleResourceFromJson(Map<String, dynamic> json) {
  return ScheduleResource(
    scheduleRules: (json['ScheduleRules'] as List)
        ?.map((e) => e == null
            ? null
            : PartnerSchedule.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    appointmentResources: (json['AppointmentResources'] as List)
        ?.map((e) => e == null
            ? null
            : PartnerSchedule.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ScheduleResourceToJson(ScheduleResource instance) =>
    <String, dynamic>{
      'ScheduleRules':
          instance.scheduleRules?.map((e) => e?.toJson())?.toList(),
      'AppointmentResources':
          instance.appointmentResources?.map((e) => e?.toJson())?.toList(),
    };

ResponseListPartner _$ResponseListPartnerFromJson(Map<String, dynamic> json) {
  return ResponseListPartner(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['code'] as String,
    result: (json['Result'] as List)
        ?.map((e) =>
            e == null ? null : Partner.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    currentPage: json['CurrentPage'] as int,
    totalPage: json['TotalPage'] as int,
    pageSize: json['PageSize'] as int,
    rowCount: json['RowCount'] as int,
    hasPreviousPage: json['HasPreviousPage'] as bool,
    hasNextPage: json['HasNextPage'] as bool,
    firstRowOnPage: json['FirstRowOnPage'] as int,
    lastRowOnPage: json['LastRowOnPage'] as int,
  );
}

Map<String, dynamic> _$ResponseListPartnerToJson(
        ResponseListPartner instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'code': instance.code,
      'Result': instance.result?.map((e) => e?.toJson())?.toList(),
      'CurrentPage': instance.currentPage,
      'TotalPage': instance.totalPage,
      'PageSize': instance.pageSize,
      'RowCount': instance.rowCount,
      'HasPreviousPage': instance.hasPreviousPage,
      'HasNextPage': instance.hasNextPage,
      'FirstRowOnPage': instance.firstRowOnPage,
      'LastRowOnPage': instance.lastRowOnPage,
    };

ResponsePartner _$ResponsePartnerFromJson(Map<String, dynamic> json) {
  return ResponsePartner(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['code'] as String,
    result: json['Result'] == null
        ? null
        : Partner.fromJson(json['Result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResponsePartnerToJson(ResponsePartner instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'code': instance.code,
      'Result': instance.result?.toJson(),
    };

ResponseScheduleResource _$ResponseScheduleResourceFromJson(
    Map<String, dynamic> json) {
  return ResponseScheduleResource(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['code'] as String,
    result: json['Result'] == null
        ? null
        : ScheduleResource.fromJson(json['Result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResponseScheduleResourceToJson(
        ResponseScheduleResource instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'code': instance.code,
      'Result': instance.result?.toJson(),
    };

ResponsePartnerPrice _$ResponsePartnerPriceFromJson(Map<String, dynamic> json) {
  return ResponsePartnerPrice(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['code'] as String,
    result: (json['Result'] as List)
        ?.map((e) =>
            e == null ? null : PartnerPrice.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResponsePartnerPriceToJson(
        ResponsePartnerPrice instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'code': instance.code,
      'Result': instance.result?.map((e) => e?.toJson())?.toList(),
    };

Availability _$AvailabilityFromJson(Map<String, dynamic> json) {
  return Availability(
    id: (json['id'] as List)?.map((e) => e as int)?.toList(),
    day: _$enumDecodeNullable(_$DaysOfWeekEnumMap, json['day']),
    startTime: json['startTime'] == null
        ? null
        : DateTime.parse(json['startTime'] as String),
    endTime: json['endTime'] == null
        ? null
        : DateTime.parse(json['endTime'] as String),
  );
}

Map<String, dynamic> _$AvailabilityToJson(Availability instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('day', _$DaysOfWeekEnumMap[instance.day]);
  writeNotNull('startTime', instance.startTime?.toIso8601String());
  writeNotNull('endTime', instance.endTime?.toIso8601String());
  return val;
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$DaysOfWeekEnumMap = {
  DaysOfWeek.mon: 'mon',
  DaysOfWeek.tus: 'tus',
  DaysOfWeek.wed: 'wed',
  DaysOfWeek.thur: 'thur',
  DaysOfWeek.fri: 'fri',
  DaysOfWeek.sat: 'sat',
  DaysOfWeek.sun: 'sun',
};
