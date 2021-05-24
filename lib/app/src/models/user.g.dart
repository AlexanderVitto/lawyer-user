// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    email: json['Email'] as String,
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

Map<String, dynamic> _$UserToJson(User instance) {
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
  writeNotNull('id', instance.id);
  writeNotNull('Email', instance.email);
  return val;
}

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) {
  return UserResponse(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: json['Result'] == null
        ? null
        : User.fromJson(json['Result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result?.toJson(),
    };
