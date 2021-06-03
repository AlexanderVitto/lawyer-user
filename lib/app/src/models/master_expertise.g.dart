// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_expertise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMasterExpertise _$ResponseMasterExpertiseFromJson(
    Map<String, dynamic> json) {
  return ResponseMasterExpertise(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: json['Result'] == null
        ? null
        : StaticData.fromJson(json['Result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResponseMasterExpertiseToJson(
        ResponseMasterExpertise instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result?.toJson(),
    };

ResponseListMasterExpertise _$ResponseListMasterExpertiseFromJson(
    Map<String, dynamic> json) {
  return ResponseListMasterExpertise(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: (json['Result'] as List)
        ?.map((e) =>
            e == null ? null : StaticData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResponseListMasterExpertiseToJson(
        ResponseListMasterExpertise instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result?.map((e) => e?.toJson())?.toList(),
    };
