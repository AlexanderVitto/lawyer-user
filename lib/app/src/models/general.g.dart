// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseString _$ResponseStringFromJson(Map<String, dynamic> json) {
  return ResponseString(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: json['Result'] as String,
  );
}

Map<String, dynamic> _$ResponseStringToJson(ResponseString instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result,
    };

ResponseListString _$ResponseListStringFromJson(Map<String, dynamic> json) {
  return ResponseListString(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: (json['Result'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ResponseListStringToJson(ResponseListString instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result,
    };

ResponseBool _$ResponseBoolFromJson(Map<String, dynamic> json) {
  return ResponseBool(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: json['Result'] as bool,
  );
}

Map<String, dynamic> _$ResponseBoolToJson(ResponseBool instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result,
    };
