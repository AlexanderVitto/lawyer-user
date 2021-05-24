// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationBody _$ApplicationBodyFromJson(Map<String, dynamic> json) {
  return ApplicationBody(
    firebaseId: json['firebaseId'] as String,
    deviceToken: json['deviceToken'] as String,
    deviceOs: json['deviceOs'] as String,
    deviceModel: json['deviceModel'] as String,
    osVersion: json['osVersion'] as String,
    deviceManufacturer: json['deviceManufacturer'] as String,
    deviceType: json['deviceType'] as String,
    isPhysicalDevice: json['isPhysicalDevice'] as bool,
  );
}

Map<String, dynamic> _$ApplicationBodyToJson(ApplicationBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('firebaseId', instance.firebaseId);
  writeNotNull('deviceToken', instance.deviceToken);
  writeNotNull('deviceOs', instance.deviceOs);
  writeNotNull('deviceModel', instance.deviceModel);
  writeNotNull('osVersion', instance.osVersion);
  writeNotNull('deviceManufacturer', instance.deviceManufacturer);
  writeNotNull('deviceType', instance.deviceType);
  writeNotNull('isPhysicalDevice', instance.isPhysicalDevice);
  return val;
}
