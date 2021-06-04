// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
  return Invoice(
    id: json['Id'] as int,
    invoiceNumber: json['InvoiceNumber'] as String,
    paymentMethodId: json['PaymentMethodId'] as int,
    orderId: json['OrderId'] as String,
    transactionId: json['TransactionId'] as String,
    transactionTime: json['TransactionTime'] as String,
    transactionStatus: json['TransactionStatus'] as int,
    statusCode: json['StatusCode'] as String,
    statusMessage: json['StatusMessage'] as String,
    paymentTime: json['PaymentTime'] as String,
    paymentType: json['PaymentType'] as String,
    approvalTime: json['ApprovalTime'] as String,
    approvalBy: json['ApprovalBy'] as String,
    toAccountNumber: json['ToAccountNumber'] as String,
    toAccountName: json['ToAccountName'] as String,
    toBankCode: json['ToBankCode'] as String,
    fromAccountNumber: json['FromAccountNumber'] as String,
    fromAccountName: json['FromAccountName'] as String,
    fromBankCode: json['FromBankCode'] as String,
    paymentNotes: json['PaymentNotes'] as String,
    grossAmount: (json['GrossAmount'] as num)?.toDouble(),
    paidAmount: (json['PaidAmount'] as num)?.toDouble(),
    paymentBalance: (json['PaymentBalance'] as num)?.toDouble(),
    signatureKey: json['SignatureKey'] as String,
    merchantId: json['MerchantId'] as String,
    fraudStatus: json['FraudStatus'] as String,
    currency: json['Currency'] as String,
    paymentCode: json['PaymentCode'] as int,
    addDate: json['AddDate'] as String,
    userId: json['UserId'] as String,
    paymentAppointments: (json['PaymentAppointments'] as List)
        ?.map((e) => e == null
            ? null
            : AppointmentPayment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$InvoiceToJson(Invoice instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('InvoiceNumber', instance.invoiceNumber);
  writeNotNull('PaymentMethodId', instance.paymentMethodId);
  writeNotNull('OrderId', instance.orderId);
  writeNotNull('TransactionId', instance.transactionId);
  writeNotNull('TransactionTime', instance.transactionTime);
  writeNotNull('TransactionStatus', instance.transactionStatus);
  writeNotNull('StatusCode', instance.statusCode);
  writeNotNull('StatusMessage', instance.statusMessage);
  writeNotNull('PaymentTime', instance.paymentTime);
  writeNotNull('PaymentType', instance.paymentType);
  writeNotNull('ApprovalTime', instance.approvalTime);
  writeNotNull('ApprovalBy', instance.approvalBy);
  writeNotNull('ToAccountNumber', instance.toAccountNumber);
  writeNotNull('ToAccountName', instance.toAccountName);
  writeNotNull('ToBankCode', instance.toBankCode);
  writeNotNull('FromAccountNumber', instance.fromAccountNumber);
  writeNotNull('FromAccountName', instance.fromAccountName);
  writeNotNull('FromBankCode', instance.fromBankCode);
  writeNotNull('PaymentNotes', instance.paymentNotes);
  writeNotNull('GrossAmount', instance.grossAmount);
  writeNotNull('PaidAmount', instance.paidAmount);
  writeNotNull('PaymentBalance', instance.paymentBalance);
  writeNotNull('SignatureKey', instance.signatureKey);
  writeNotNull('MerchantId', instance.merchantId);
  writeNotNull('FraudStatus', instance.fraudStatus);
  writeNotNull('Currency', instance.currency);
  writeNotNull('PaymentCode', instance.paymentCode);
  writeNotNull('AddDate', instance.addDate);
  writeNotNull('UserId', instance.userId);
  writeNotNull('PaymentAppointments',
      instance.paymentAppointments?.map((e) => e?.toJson())?.toList());
  return val;
}

AppointmentPayment _$AppointmentPaymentFromJson(Map<String, dynamic> json) {
  return AppointmentPayment(
    id: json['Id'] as int,
    appointmentId: json['AppointmentId'] as int,
    paymentId: json['PaymentId'] as int,
    appointment: json['Appointment'] == null
        ? null
        : Appointment.fromJson(json['Appointment'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppointmentPaymentToJson(AppointmentPayment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('AppointmentId', instance.appointmentId);
  writeNotNull('PaymentId', instance.paymentId);
  writeNotNull('Appointment', instance.appointment?.toJson());
  return val;
}

ConfirmBankBody _$ConfirmBankBodyFromJson(Map<String, dynamic> json) {
  return ConfirmBankBody(
    paymentId: json['paymentId'] as int,
    fromBankCode: json['fromBankCode'] as String,
    fromAccountNumber: json['fromAccountNumber'] as String,
    fromAccountName: json['fromAccountName'] as String,
    toBankCode: json['toBankCode'] as String,
    toAccountNumber: json['toAccountNumber'] as String,
    toAccountName: json['toAccountName'] as String,
    paymentDate: json['paymentDate'] as String,
    paidAmount: (json['paidAmount'] as num)?.toDouble(),
    referenceCode: json['referenceCode'] as String,
    notes: json['notes'] as String,
  );
}

Map<String, dynamic> _$ConfirmBankBodyToJson(ConfirmBankBody instance) =>
    <String, dynamic>{
      'paymentId': instance.paymentId,
      'fromBankCode': instance.fromBankCode,
      'fromAccountNumber': instance.fromAccountNumber,
      'fromAccountName': instance.fromAccountName,
      'toBankCode': instance.toBankCode,
      'toAccountNumber': instance.toAccountNumber,
      'toAccountName': instance.toAccountName,
      'paymentDate': instance.paymentDate,
      'paidAmount': instance.paidAmount,
      'referenceCode': instance.referenceCode,
      'notes': instance.notes,
    };

InitPaymentBody _$InitPaymentBodyFromJson(Map<String, dynamic> json) {
  return InitPaymentBody(
    invoices: (json['invoices'] as List)?.map((e) => e as int)?.toList(),
    grossAmount: (json['grossAmount'] as num)?.toDouble(),
    paymentMethod: json['paymentMethod'] as int,
    userId: json['userId'] as String,
  );
}

Map<String, dynamic> _$InitPaymentBodyToJson(InitPaymentBody instance) =>
    <String, dynamic>{
      'invoices': instance.invoices,
      'grossAmount': instance.grossAmount,
      'paymentMethod': instance.paymentMethod,
      'userId': instance.userId,
    };

InitPaymentMidtransBody _$InitPaymentMidtransBodyFromJson(
    Map<String, dynamic> json) {
  return InitPaymentMidtransBody(
    invoices: (json['invoices'] as List)?.map((e) => e as int)?.toList(),
    grossAmount: (json['grossAmount'] as num)?.toDouble(),
    paymentMethod: json['paymentMethod'] as int,
    userId: json['userId'] as String,
    orderId: json['orderId'] as String,
    paymentType: json['paymentType'] as String,
    virtualAccountNumber: json['virtualAccountNumber'] as String,
    bankCode: json['bankCode'] as String,
  );
}

Map<String, dynamic> _$InitPaymentMidtransBodyToJson(
        InitPaymentMidtransBody instance) =>
    <String, dynamic>{
      'invoices': instance.invoices,
      'grossAmount': instance.grossAmount,
      'paymentMethod': instance.paymentMethod,
      'userId': instance.userId,
      'orderId': instance.orderId,
      'paymentType': instance.paymentType,
      'virtualAccountNumber': instance.virtualAccountNumber,
      'bankCode': instance.bankCode,
    };

ResponseInvoice _$ResponseInvoiceFromJson(Map<String, dynamic> json) {
  return ResponseInvoice(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: json['Result'] == null
        ? null
        : Invoice.fromJson(json['Result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResponseInvoiceToJson(ResponseInvoice instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result?.toJson(),
    };

ResponseListInvoice _$ResponseListInvoiceFromJson(Map<String, dynamic> json) {
  return ResponseListInvoice(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: (json['Result'] as List)
        ?.map((e) =>
            e == null ? null : Invoice.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResponseListInvoiceToJson(
        ResponseListInvoice instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result?.map((e) => e?.toJson())?.toList(),
    };
