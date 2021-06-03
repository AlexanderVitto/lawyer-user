// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterBank _$MasterBankFromJson(Map<String, dynamic> json) {
  return MasterBank(
    bankCode: json['BankCode'] as String,
    bankName: json['BankName'] as String,
    imageData: json['ImageData'] as String,
    imageUrl: json['ImageUrl'] as String,
  );
}

Map<String, dynamic> _$MasterBankToJson(MasterBank instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('BankCode', instance.bankCode);
  writeNotNull('BankName', instance.bankName);
  writeNotNull('ImageData', instance.imageData);
  writeNotNull('ImageUrl', instance.imageUrl);
  return val;
}

ResponseMasterBank _$ResponseMasterBankFromJson(Map<String, dynamic> json) {
  return ResponseMasterBank(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: json['Result'] == null
        ? null
        : MasterBank.fromJson(json['Result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResponseMasterBankToJson(ResponseMasterBank instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result?.toJson(),
    };

ResponseListMasterBank _$ResponseListMasterBankFromJson(
    Map<String, dynamic> json) {
  return ResponseListMasterBank(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: (json['Result'] as List)
        ?.map((e) =>
            e == null ? null : MasterBank.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResponseListMasterBankToJson(
        ResponseListMasterBank instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result?.map((e) => e?.toJson())?.toList(),
    };
