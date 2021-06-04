import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User extends Person {
  @JsonKey(name: 'id', defaultValue: null, includeIfNull: false)
  String id;
  @JsonKey(name: 'Email', defaultValue: null, includeIfNull: false)
  String email;

  User(
      {this.id,
      this.email,
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

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserResponse {
  @JsonKey(name: 'Status')
  final bool status;

  @JsonKey(name: 'Messages')
  final String message;

  @JsonKey(name: 'Code')
  final String code;

  @JsonKey(name: 'Result', defaultValue: null)
  final User result;

  UserResponse({this.status, this.message, this.code, this.result});
  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
