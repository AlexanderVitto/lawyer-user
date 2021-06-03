// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Withdrawal _$WithdrawalFromJson(Map<String, dynamic> json) {
  return Withdrawal(
    id: json['Id'] as int,
    invoiceNumber: json['InvoiceNumber'] as String,
    userId: json['userId'] as String,
    toBankId: json['ToBankId'] as int,
    requestDate: json['RequestDate'] as String,
    requestStatus: json['RequestStatus'] as int,
    notes: json['Notes'] as String,
    lastUpdate: json['LastUpdate'] as String,
    withdrawMethod: json['WithdrawMethod'] as int,
    isAutoGenerate: json['IsAutoGenerate'] as bool,
    withdrawAmount: (json['WithdrawAmount'] as num)?.toDouble(),
    adminFee: (json['AdminFee'] as num)?.toDouble(),
    refCode: json['RefCode'] as String,
  );
}

Map<String, dynamic> _$WithdrawalToJson(Withdrawal instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('InvoiceNumber', instance.invoiceNumber);
  writeNotNull('userId', instance.userId);
  writeNotNull('ToBankId', instance.toBankId);
  writeNotNull('RequestDate', instance.requestDate);
  writeNotNull('RequestStatus', instance.requestStatus);
  writeNotNull('Notes', instance.notes);
  writeNotNull('LastUpdate', instance.lastUpdate);
  writeNotNull('WithdrawMethod', instance.withdrawMethod);
  writeNotNull('IsAutoGenerate', instance.isAutoGenerate);
  writeNotNull('WithdrawAmount', instance.withdrawAmount);
  writeNotNull('AdminFee', instance.adminFee);
  writeNotNull('RefCode', instance.refCode);
  return val;
}

RequestWithdrawal _$RequestWithdrawalFromJson(Map<String, dynamic> json) {
  return RequestWithdrawal(
    userId: json['userId'] as String,
    bankCode: json['bankCode'] as String,
    withdrawMethodId: json['withdrawMethodId'] as int,
    withdrawAmount: (json['withdrawAmount'] as num)?.toDouble(),
    adminFee: (json['adminFee'] as num)?.toDouble(),
    notes: json['notes'] as String,
    accountName: json['accountName'] as String,
    accountNumber: json['accountNumber'] as String,
    refCode: json['refCode'] as String,
  );
}

Map<String, dynamic> _$RequestWithdrawalToJson(RequestWithdrawal instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userId', instance.userId);
  writeNotNull('bankCode', instance.bankCode);
  writeNotNull('withdrawMethodId', instance.withdrawMethodId);
  writeNotNull('withdrawAmount', instance.withdrawAmount);
  writeNotNull('adminFee', instance.adminFee);
  writeNotNull('notes', instance.notes);
  writeNotNull('accountNumber', instance.accountNumber);
  writeNotNull('accountName', instance.accountName);
  writeNotNull('refCode', instance.refCode);
  return val;
}

ResponseBalance _$ResponseBalanceFromJson(Map<String, dynamic> json) {
  return ResponseBalance(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: (json['Result'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ResponseBalanceToJson(ResponseBalance instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result,
    };

ResponseWithdrawal _$ResponseWithdrawalFromJson(Map<String, dynamic> json) {
  return ResponseWithdrawal(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: json['Result'] == null
        ? null
        : Withdrawal.fromJson(json['Result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResponseWithdrawalToJson(ResponseWithdrawal instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result?.toJson(),
    };
