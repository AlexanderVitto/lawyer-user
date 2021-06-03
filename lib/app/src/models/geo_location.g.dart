// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoLocation _$GeoLocationFromJson(Map<String, dynamic> json) {
  return GeoLocation(
    id: json['Id'] as int,
    iso: json['Iso'] as String,
    country: json['Country'] as String,
    language: json['Language'] as String,
    region1: json['Region1'] as String,
    region2: json['Region2'] as String,
    region3: json['Region3'] as String,
    region4: json['Region4'] as String,
    locality: json['Locality'] as String,
    postalCode: json['PostalCode'] as String,
    suburb: json['Suburb'] as String,
    elevation: json['Elevation'] as String,
    iso2: json['Iso2'] as String,
    fips: json['Fips'] as String,
    nuts: json['Nuts'] as String,
    hasc: json['Hasc'] as String,
    stat: json['Stat'] as String,
    timezone: json['Timezone'] as String,
    utc: json['Utc'] as String,
    dst: json['Dst'] as String,
  );
}

Map<String, dynamic> _$GeoLocationToJson(GeoLocation instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('Iso', instance.iso);
  writeNotNull('Country', instance.country);
  writeNotNull('Language', instance.language);
  writeNotNull('Region1', instance.region1);
  writeNotNull('Region2', instance.region2);
  writeNotNull('Region3', instance.region3);
  writeNotNull('Region4', instance.region4);
  writeNotNull('Locality', instance.locality);
  writeNotNull('PostalCode', instance.postalCode);
  writeNotNull('Suburb', instance.suburb);
  writeNotNull('Elevation', instance.elevation);
  writeNotNull('Iso2', instance.iso2);
  writeNotNull('Fips', instance.fips);
  writeNotNull('Nuts', instance.nuts);
  writeNotNull('Hasc', instance.hasc);
  writeNotNull('Stat', instance.stat);
  val['Timezone'] = instance.timezone;
  writeNotNull('Utc', instance.utc);
  writeNotNull('Dst', instance.dst);
  return val;
}

ResponseGeoLocation _$ResponseGeoLocationFromJson(Map<String, dynamic> json) {
  return ResponseGeoLocation(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: (json['Result'] as List)
        ?.map((e) =>
            e == null ? null : GeoLocation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResponseGeoLocationToJson(
        ResponseGeoLocation instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result?.map((e) => e?.toJson())?.toList(),
    };
