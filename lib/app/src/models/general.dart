import 'package:json_annotation/json_annotation.dart';

part 'general.g.dart';

@JsonSerializable(explicitToJson: true)
class StringResponse {
  @JsonKey(name: 'Status')
  final bool status;

  @JsonKey(name: 'Messages')
  final String message;

  @JsonKey(name: 'Code')
  final String code;

  @JsonKey(name: 'Result', defaultValue: null)
  final String result;

  StringResponse({this.status, this.message, this.code, this.result});
  factory StringResponse.fromJson(Map<String, dynamic> json) =>
      _$StringResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StringResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BoolResponse {
  @JsonKey(name: 'Status')
  final bool status;

  @JsonKey(name: 'Messages')
  final String message;

  @JsonKey(name: 'Code')
  final String code;

  @JsonKey(name: 'Result', defaultValue: null)
  final bool result;

  BoolResponse({this.status, this.message, this.code, this.result});
  factory BoolResponse.fromJson(Map<String, dynamic> json) =>
      _$BoolResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BoolResponseToJson(this);
}
