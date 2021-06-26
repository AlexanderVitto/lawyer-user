// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'midtrans.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MidtransResponse _$MidtransResponseFromJson(Map<String, dynamic> json) {
  return MidtransResponse(
    orderId: json['order_id'] as String,
    transactionId: json['transaction_id'] as String,
    status: json['status'] as String,
    paymentType: json['payment_type'] as String,
    permataVaNumber: json['permata_va_number'] as String,
    bcaVaNumber: json['bca_va_number'] as String,
    bniVaNumber: json['bni_va_number'] as String,
    briVaNumber: json['bri_va_number'] as String,
    paymentCode: json['payment_code'] as String,
    bank: json['bank'] as String,
  );
}

Map<String, dynamic> _$MidtransResponseToJson(MidtransResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('order_id', instance.orderId);
  writeNotNull('transaction_id', instance.transactionId);
  writeNotNull('status', instance.status);
  writeNotNull('payment_type', instance.paymentType);
  writeNotNull('permata_va_number', instance.permataVaNumber);
  writeNotNull('bca_va_number', instance.bcaVaNumber);
  writeNotNull('bni_va_number', instance.bniVaNumber);
  writeNotNull('bri_va_number', instance.briVaNumber);
  writeNotNull('payment_code', instance.paymentCode);
  writeNotNull('bank', instance.bank);
  return val;
}
