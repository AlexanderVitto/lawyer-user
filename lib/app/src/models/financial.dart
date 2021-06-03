import 'package:json_annotation/json_annotation.dart';

part 'financial.g.dart';

@JsonSerializable(explicitToJson: true)
class Withdrawal {
  @JsonKey(name: 'Id', defaultValue: null, includeIfNull: false)
  final int id;

  @JsonKey(name: 'InvoiceNumber', defaultValue: null, includeIfNull: false)
  final String invoiceNumber;

  @JsonKey(name: 'userId', defaultValue: null, includeIfNull: false)
  final String userId;

  @JsonKey(name: 'ToBankId', defaultValue: null, includeIfNull: false)
  final int toBankId;

  @JsonKey(name: 'RequestDate', defaultValue: null, includeIfNull: false)
  final String requestDate;

  @JsonKey(name: 'RequestStatus', defaultValue: null, includeIfNull: false)
  final int requestStatus;

  @JsonKey(name: 'Notes', defaultValue: null, includeIfNull: false)
  final String notes;

  @JsonKey(name: 'LastUpdate', defaultValue: null, includeIfNull: false)
  final String lastUpdate;

  @JsonKey(name: 'WithdrawMethod', defaultValue: null, includeIfNull: false)
  final int withdrawMethod;

  @JsonKey(name: 'IsAutoGenerate', defaultValue: null, includeIfNull: false)
  final bool isAutoGenerate;

  @JsonKey(name: 'WithdrawAmount', defaultValue: null, includeIfNull: false)
  final double withdrawAmount;

  @JsonKey(name: 'AdminFee', defaultValue: null, includeIfNull: false)
  final double adminFee;

  @JsonKey(name: 'RefCode', defaultValue: null, includeIfNull: false)
  final String refCode;

  Withdrawal(
      {this.id,
      this.invoiceNumber,
      this.userId,
      this.toBankId,
      this.requestDate,
      this.requestStatus,
      this.notes,
      this.lastUpdate,
      this.withdrawMethod,
      this.isAutoGenerate,
      this.withdrawAmount,
      this.adminFee,
      this.refCode});

  factory Withdrawal.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawalToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RequestWithdrawal {
  @JsonKey(name: 'userId', defaultValue: null, includeIfNull: false)
  String userId;

  @JsonKey(name: 'bankCode', defaultValue: null, includeIfNull: false)
  String bankCode;

  @JsonKey(name: 'withdrawMethodId', defaultValue: null, includeIfNull: false)
  int withdrawMethodId;

  @JsonKey(name: 'withdrawAmount', defaultValue: null, includeIfNull: false)
  double withdrawAmount;

  @JsonKey(name: 'adminFee', defaultValue: null, includeIfNull: false)
  double adminFee;

  @JsonKey(name: 'notes', defaultValue: null, includeIfNull: false)
  String notes;

  @JsonKey(name: 'accountNumber', defaultValue: null, includeIfNull: false)
  String accountNumber;

  @JsonKey(name: 'accountName', defaultValue: null, includeIfNull: false)
  String accountName;

  @JsonKey(name: 'refCode', defaultValue: null, includeIfNull: false)
  String refCode;

  RequestWithdrawal(
      {this.userId,
      this.bankCode,
      this.withdrawMethodId,
      this.withdrawAmount,
      this.adminFee,
      this.notes,
      this.accountName,
      this.accountNumber,
      this.refCode});

  factory RequestWithdrawal.fromJson(Map<String, dynamic> json) =>
      _$RequestWithdrawalFromJson(json);

  Map<String, dynamic> toJson() => _$RequestWithdrawalToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResponseBalance {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  final bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  final String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  final String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  final double result;

  ResponseBalance({this.status, this.message, this.code, this.result});

  factory ResponseBalance.fromJson(Map<String, dynamic> json) =>
      _$ResponseBalanceFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseBalanceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResponseWithdrawal {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  final bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  final String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  final String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  final Withdrawal result;

  ResponseWithdrawal({this.status, this.message, this.code, this.result});

  factory ResponseWithdrawal.fromJson(Map<String, dynamic> json) =>
      _$ResponseWithdrawalFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseWithdrawalToJson(this);
}
