// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
    firstName: json['FirstName'] as String,
    lastName: json['LastName'] as String,
    salutation: json['Salutation'] as String,
    sex: json['SexId'] as int,
    dateOfBirth: json['DateOfBirth'] as String,
    idNumber: json['IdentificationNumber'] as String,
    idType: json['IdentificationTypeId'] as int,
    phoneNumber: json['PhoneNumber'] as String,
    mobileNumber: json['MobileNumber'] as String,
    address: json['Address'] as String,
    maritalStatus: json['MaritalStatusId'] as int,
    ethnic: json['Ethnic'] as String,
    religion: json['ReligionId'] as int,
    occupation: json['OccupationId'] as int,
    pictureUrl: json['PictureUrl'] as String,
    country: json['Country'] as String,
    region1: json['Region1'] as String,
    region2: json['Region2'] as String,
    region3: json['Region3'] as String,
    region4: json['Region4'] as String,
    zipCode: json['ZipCode'] as String,
    lastEducation: json['EducationId'] as int,
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) {
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
  return val;
}
