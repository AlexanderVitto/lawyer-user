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
