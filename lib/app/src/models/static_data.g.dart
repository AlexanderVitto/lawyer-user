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
