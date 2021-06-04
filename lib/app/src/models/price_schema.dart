import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'price_schema.g.dart';

@JsonSerializable(explicitToJson: true)
class ResponsePrice {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  final bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  final String message;

  @JsonKey(name: 'code', defaultValue: null, nullable: true)
  final String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  final List<MasterPrice> result;

  ResponsePrice({
    this.status,
    this.message,
    this.code,
    this.result,
  });
  factory ResponsePrice.fromJson(Map<String, dynamic> json) =>
      _$ResponsePriceFromJson(json);
  Map<String, dynamic> toJson() => _$ResponsePriceToJson(this);
}
