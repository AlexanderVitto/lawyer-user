import 'package:json_annotation/json_annotation.dart';

part 'geo_location.g.dart';

@JsonSerializable(explicitToJson: true)
class GeoLocation {
  @JsonKey(name: 'Id', defaultValue: null, includeIfNull: false)
  final int id;

  @JsonKey(name: 'Iso', defaultValue: null, includeIfNull: false)
  String iso;

  @JsonKey(name: 'Country', defaultValue: null, includeIfNull: false)
  String country;

  @JsonKey(name: 'Language', defaultValue: null, includeIfNull: false)
  String language;

  @JsonKey(name: 'Region1', defaultValue: null, includeIfNull: false)
  String region1;

  @JsonKey(name: 'Region2', defaultValue: null, includeIfNull: false)
  String region2;

  @JsonKey(name: 'Region3', defaultValue: null, includeIfNull: false)
  String region3;

  @JsonKey(name: 'Region4', defaultValue: null, includeIfNull: false)
  String region4;

  @JsonKey(name: 'Locality', defaultValue: null, includeIfNull: false)
  String locality;

  @JsonKey(name: 'PostalCode', defaultValue: null, includeIfNull: false)
  String postalCode;

  @JsonKey(name: 'Suburb', defaultValue: null, includeIfNull: false)
  String suburb;

  @JsonKey(name: 'Elevation', defaultValue: null, includeIfNull: false)
  String elevation;

  @JsonKey(name: 'Iso2', defaultValue: null, includeIfNull: false)
  String iso2;

  @JsonKey(name: 'Fips', defaultValue: null, includeIfNull: false)
  String fips;

  @JsonKey(name: 'Nuts', defaultValue: null, includeIfNull: false)
  String nuts;

  @JsonKey(name: 'Hasc', defaultValue: null, includeIfNull: false)
  String hasc;

  @JsonKey(name: 'Stat', defaultValue: null, includeIfNull: false)
  String stat;

  @JsonKey(name: 'Timezone', defaultValue: null)
  String timezone;

  @JsonKey(name: 'Utc', defaultValue: null, includeIfNull: false)
  String utc;

  @JsonKey(name: 'Dst', defaultValue: null, includeIfNull: false)
  String dst;

  GeoLocation({
    this.id,
    this.iso,
    this.country,
    this.language,
    this.region1,
    this.region2,
    this.region3,
    this.region4,
    this.locality,
    this.postalCode,
    this.suburb,
    this.elevation,
    this.iso2,
    this.fips,
    this.nuts,
    this.hasc,
    this.stat,
    this.timezone,
    this.utc,
    this.dst,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationFromJson(json);
  Map<String, dynamic> toJson() => _$GeoLocationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResponseGeoLocation {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  final bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  final String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  final String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  final List<GeoLocation> result;

  ResponseGeoLocation({this.status, this.message, this.code, this.result});
  factory ResponseGeoLocation.fromJson(Map<String, dynamic> json) =>
      _$ResponseGeoLocationFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseGeoLocationToJson(this);
}
