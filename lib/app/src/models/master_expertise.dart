import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'master_expertise.g.dart';

@JsonSerializable(explicitToJson: true)
class ResponseMasterExpertise {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  final bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  final String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  final String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  final StaticData result;

  ResponseMasterExpertise({this.status, this.message, this.code, this.result});
  factory ResponseMasterExpertise.fromJson(Map<String, dynamic> json) =>
      _$ResponseMasterExpertiseFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseMasterExpertiseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResponseListMasterExpertise {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  final bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  final String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  final String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  final List<StaticData> result;

  ResponseListMasterExpertise(
      {this.status, this.message, this.code, this.result});
  factory ResponseListMasterExpertise.fromJson(Map<String, dynamic> json) =>
      _$ResponseListMasterExpertiseFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseListMasterExpertiseToJson(this);
}
