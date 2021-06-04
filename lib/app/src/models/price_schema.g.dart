// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponsePrice _$ResponsePriceFromJson(Map<String, dynamic> json) {
  return ResponsePrice(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['code'] as String,
    result: (json['Result'] as List)
        ?.map((e) =>
            e == null ? null : MasterPrice.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResponsePriceToJson(ResponsePrice instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'code': instance.code,
      'Result': instance.result?.map((e) => e?.toJson())?.toList(),
    };
