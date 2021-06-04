import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable(explicitToJson: true)
class Person {
  @JsonKey(name: 'FirstName', defaultValue: null, includeIfNull: false)
  String firstName;
  @JsonKey(name: 'LastName', defaultValue: null, includeIfNull: false)
  String lastName;
  @JsonKey(name: 'Salutation', defaultValue: null, includeIfNull: false)
  String salutation;
  @JsonKey(name: 'SexId', defaultValue: null, includeIfNull: false)
  int sexId;
  @JsonKey(name: 'DateOfBirth', defaultValue: null, includeIfNull: false)
  String dateOfBirth;
  @JsonKey(
      name: 'IdentificationNumber', defaultValue: null, includeIfNull: false)
  String idNumber;
  @JsonKey(
      name: 'IdentificationTypeId', defaultValue: null, includeIfNull: false)
  int idType;
  @JsonKey(name: 'PhoneNumber', defaultValue: null, includeIfNull: false)
  String phoneNumber;
  @JsonKey(name: 'MobileNumber', defaultValue: null, includeIfNull: false)
  String mobileNumber;
  @JsonKey(name: 'Address', defaultValue: null, includeIfNull: false)
  String address;
  @JsonKey(name: 'Country', defaultValue: null, includeIfNull: false)
  String country;
  @JsonKey(name: 'Region1', defaultValue: null, includeIfNull: false)
  String region1;
  @JsonKey(name: 'Region2', defaultValue: null, includeIfNull: false)
  String region2;
  @JsonKey(name: 'Region3', defaultValue: null, includeIfNull: false)
  String region3;
  @JsonKey(name: 'Region4', defaultValue: null, includeIfNull: false)
  String region4;
  @JsonKey(name: 'ZipCode', defaultValue: null, includeIfNull: false)
  String zipCode;

  @JsonKey(name: 'MaritalStatusId', defaultValue: null, includeIfNull: false)
  int maritalStatusId;
  @JsonKey(name: 'Ethnic', defaultValue: null, includeIfNull: false)
  String ethnic;
  @JsonKey(name: 'ReligionId', defaultValue: null, includeIfNull: false)
  int religionId;
  @JsonKey(name: 'OccupationId', defaultValue: null, includeIfNull: false)
  int occupation;
  @JsonKey(name: 'PictureUrl', defaultValue: null, includeIfNull: false)
  String pictureUrl;
  @JsonKey(name: 'EducationId', defaultValue: null, includeIfNull: false)
  int lastEducation;

  Person({
    this.firstName,
    this.lastName,
    this.salutation,
    this.sexId,
    this.dateOfBirth,
    this.idNumber,
    this.idType,
    this.phoneNumber,
    this.mobileNumber,
    this.address,
    this.maritalStatusId,
    this.ethnic,
    this.religionId,
    this.occupation,
    this.pictureUrl,
    this.country,
    this.region1,
    this.region2,
    this.region3,
    this.region4,
    this.zipCode,
    this.lastEducation,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
