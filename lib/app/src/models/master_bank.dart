import 'package:json_annotation/json_annotation.dart';

part 'master_bank.g.dart';

@JsonSerializable(explicitToJson: true)
class MasterBank {
  @JsonKey(name: 'BankCode', defaultValue: null, includeIfNull: false)
  final String bankCode;

  @JsonKey(name: 'BankName', defaultValue: null, includeIfNull: false)
  final String bankName;

  @JsonKey(name: 'ImageData', defaultValue: null, includeIfNull: false)
  final String imageData;

  @JsonKey(name: 'ImageUrl', defaultValue: null, includeIfNull: false)
  final String imageUrl;

  @JsonKey(name: 'IsSelect', defaultValue: false, ignore: true)
  bool isSelect;

  MasterBank(
      {this.bankCode,
      this.bankName,
      this.imageData,
      this.imageUrl,
      this.isSelect = false});

  factory MasterBank.fromJson(Map<String, dynamic> json) =>
      _$MasterBankFromJson(json);

  Map<String, dynamic> toJson() => _$MasterBankToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResponseMasterBank {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  final bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  final String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  final String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  final MasterBank result;

  ResponseMasterBank({this.status, this.message, this.code, this.result});
  factory ResponseMasterBank.fromJson(Map<String, dynamic> json) =>
      _$ResponseMasterBankFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseMasterBankToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResponseListMasterBank {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  final bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  final String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  final String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  final List<MasterBank> result;

  ResponseListMasterBank({this.status, this.message, this.code, this.result});
  factory ResponseListMasterBank.fromJson(Map<String, dynamic> json) =>
      _$ResponseListMasterBankFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseListMasterBankToJson(this);
}
