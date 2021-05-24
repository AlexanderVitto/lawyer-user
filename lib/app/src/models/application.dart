import 'package:json_annotation/json_annotation.dart';

part 'application.g.dart';

@JsonSerializable(explicitToJson: true)
class ApplicationBody {
  @JsonKey(name: 'firebaseId', defaultValue: null, includeIfNull: false)
  final String firebaseId;

  @JsonKey(name: 'deviceToken', defaultValue: null, includeIfNull: false)
  final String deviceToken;

  @JsonKey(name: 'deviceOs', defaultValue: null, includeIfNull: false)
  final String deviceOs;

  @JsonKey(name: 'deviceModel', defaultValue: null, includeIfNull: false)
  final String deviceModel;

  @JsonKey(name: 'osVersion', defaultValue: null, includeIfNull: false)
  final String osVersion;

  @JsonKey(name: 'deviceManufacturer', defaultValue: null, includeIfNull: false)
  final String deviceManufacturer;

  @JsonKey(name: 'deviceType', defaultValue: null, includeIfNull: false)
  final String deviceType;

  @JsonKey(name: 'isPhysicalDevice', defaultValue: null, includeIfNull: false)
  final bool isPhysicalDevice;

  ApplicationBody(
      {this.firebaseId,
      this.deviceToken,
      this.deviceOs,
      this.deviceModel,
      this.osVersion,
      this.deviceManufacturer,
      this.deviceType,
      this.isPhysicalDevice});

  factory ApplicationBody.fromJson(Map<String, dynamic> json) =>
      _$ApplicationBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationBodyToJson(this);
}
