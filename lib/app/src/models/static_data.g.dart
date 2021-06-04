// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaticData _$StaticDataFromJson(Map<String, dynamic> json) {
  return StaticData(
    id: json['Id'] as int,
    name: json['Name'] as String,
    sequence: json['Sequence'] as int,
    description: json['Description'] as String,
    icon: json['Icon'] as String,
  );
}

Map<String, dynamic> _$StaticDataToJson(StaticData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('Name', instance.name);
  writeNotNull('Sequence', instance.sequence);
  writeNotNull('Description', instance.description);
  writeNotNull('Icon', instance.icon);
  return val;
}

ResponseListStaticData _$ResponseListStaticDataFromJson(
    Map<String, dynamic> json) {
  return ResponseListStaticData(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: (json['Result'] as List)
        ?.map((e) =>
            e == null ? null : StaticData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResponseListStaticDataToJson(
        ResponseListStaticData instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result?.map((e) => e?.toJson())?.toList(),
    };
