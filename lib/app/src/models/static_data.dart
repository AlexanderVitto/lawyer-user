import 'package:json_annotation/json_annotation.dart';

part 'static_data.g.dart';

@JsonSerializable(explicitToJson: true)
class StaticData {
  @JsonKey(name: 'Id', defaultValue: null, includeIfNull: false)
  final int id;

  @JsonKey(name: 'Name', defaultValue: null, includeIfNull: false)
  final String name;

  @JsonKey(name: 'Sequence', defaultValue: null, includeIfNull: false)
  final int sequence;

  @JsonKey(name: 'Description', defaultValue: null, includeIfNull: false)
  final String description;

  @JsonKey(name: 'Icon', defaultValue: null, includeIfNull: false)
  final String icon;

  StaticData({this.id, this.name, this.sequence, this.description, this.icon});

  factory StaticData.fromJson(Map<String, dynamic> json) =>
      _$StaticDataFromJson(json);

  Map<String, dynamic> toJson() => _$StaticDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResponseListStaticData {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  List<StaticData> result;

  ResponseListStaticData({this.status, this.message, this.code, this.result});

  factory ResponseListStaticData.fromJson(Map<String, dynamic> json) =>
      _$ResponseListStaticDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseListStaticDataToJson(this);
}
