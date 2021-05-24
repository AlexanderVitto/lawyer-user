// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StringResponse _$StringResponseFromJson(Map<String, dynamic> json) {
  return StringResponse(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: json['Result'] as String,
  );
}

Map<String, dynamic> _$StringResponseToJson(StringResponse instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result,
    };

BoolResponse _$BoolResponseFromJson(Map<String, dynamic> json) {
  return BoolResponse(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: json['Result'] as bool,
  );
}

Map<String, dynamic> _$BoolResponseToJson(BoolResponse instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result,
    };
