import 'package:json_annotation/json_annotation.dart';

part 'general.g.dart';

@JsonSerializable(explicitToJson: true)
class ResponseString {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  final bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  final String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  final String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  final String result;

  ResponseString({this.status, this.message, this.code, this.result});
  factory ResponseString.fromJson(Map<String, dynamic> json) =>
      _$ResponseStringFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseStringToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResponseListString {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  final bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  final String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  final String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  final List<String> result;

  ResponseListString({this.status, this.message, this.code, this.result});
  factory ResponseListString.fromJson(Map<String, dynamic> json) =>
      _$ResponseListStringFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseListStringToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResponseBool {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  final bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  final String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  final String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  final bool result;

  ResponseBool({this.status, this.message, this.code, this.result});
  factory ResponseBool.fromJson(Map<String, dynamic> json) =>
      _$ResponseBoolFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseBoolToJson(this);
}
