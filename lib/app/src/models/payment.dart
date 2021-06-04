import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'payment.g.dart';

@JsonSerializable(explicitToJson: true)
class Invoice {
  @JsonKey(name: 'Id', defaultValue: null, includeIfNull: false)
  final int id;

  @JsonKey(name: 'InvoiceNumber', defaultValue: null, includeIfNull: false)
  final String invoiceNumber;

  @JsonKey(name: 'PaymentMethodId', defaultValue: null, includeIfNull: false)
  final int paymentMethodId;

  @JsonKey(name: 'OrderId', defaultValue: null, includeIfNull: false)
  final String orderId;

  @JsonKey(name: 'TransactionId', defaultValue: null, includeIfNull: false)
  final String transactionId;

  @JsonKey(name: 'TransactionTime', defaultValue: null, includeIfNull: false)
  final String transactionTime;

  @JsonKey(name: 'TransactionStatus', defaultValue: null, includeIfNull: false)
  final int transactionStatus;

  @JsonKey(name: 'StatusCode', defaultValue: null, includeIfNull: false)
  final String statusCode;

  @JsonKey(name: 'StatusMessage', defaultValue: null, includeIfNull: false)
  final String statusMessage;

  @JsonKey(name: 'PaymentTime', defaultValue: null, includeIfNull: false)
  final String paymentTime;

  @JsonKey(name: 'PaymentType', defaultValue: null, includeIfNull: false)
  final String paymentType;

  @JsonKey(name: 'ApprovalTime', defaultValue: null, includeIfNull: false)
  final String approvalTime;

  @JsonKey(name: 'ApprovalBy', defaultValue: null, includeIfNull: false)
  final String approvalBy;

  @JsonKey(name: 'ToAccountNumber', defaultValue: null, includeIfNull: false)
  final String toAccountNumber;

  @JsonKey(name: 'ToAccountName', defaultValue: null, includeIfNull: false)
  final String toAccountName;

  @JsonKey(name: 'ToBankCode', defaultValue: null, includeIfNull: false)
  final String toBankCode;

  @JsonKey(name: 'FromAccountNumber', defaultValue: null, includeIfNull: false)
  final String fromAccountNumber;

  @JsonKey(name: 'FromAccountName', defaultValue: null, includeIfNull: false)
  final String fromAccountName;

  @JsonKey(name: 'FromBankCode', defaultValue: null, includeIfNull: false)
  final String fromBankCode;

  @JsonKey(name: 'PaymentNotes', defaultValue: null, includeIfNull: false)
  final String paymentNotes;

  @JsonKey(name: 'GrossAmount', defaultValue: null, includeIfNull: false)
  final double grossAmount;

  @JsonKey(name: 'PaidAmount', defaultValue: null, includeIfNull: false)
  final double paidAmount;

  @JsonKey(name: 'PaymentBalance', defaultValue: null, includeIfNull: false)
  final double paymentBalance;

  @JsonKey(name: 'SignatureKey', defaultValue: null, includeIfNull: false)
  final String signatureKey;

  @JsonKey(name: 'MerchantId', defaultValue: null, includeIfNull: false)
  final String merchantId;

  @JsonKey(name: 'FraudStatus', defaultValue: null, includeIfNull: false)
  final String fraudStatus;

  @JsonKey(name: 'Currency', defaultValue: null, includeIfNull: false)
  final String currency;

  @JsonKey(name: 'PaymentCode', defaultValue: null, includeIfNull: false)
  final int paymentCode;

  @JsonKey(name: 'AddDate', defaultValue: null, includeIfNull: false)
  final String addDate;

  @JsonKey(name: 'UserId', defaultValue: null, includeIfNull: false)
  final String userId;

  @JsonKey(
      name: 'PaymentAppointments', defaultValue: null, includeIfNull: false)
  final List<AppointmentPayment> paymentAppointments;

  Invoice(
      {this.id,
      this.invoiceNumber,
      this.paymentMethodId,
      this.orderId,
      this.transactionId,
      this.transactionTime,
      this.transactionStatus,
      this.statusCode,
      this.statusMessage,
      this.paymentTime,
      this.paymentType,
      this.approvalTime,
      this.approvalBy,
      this.toAccountNumber,
      this.toAccountName,
      this.toBankCode,
      this.fromAccountNumber,
      this.fromAccountName,
      this.fromBankCode,
      this.paymentNotes,
      this.grossAmount,
      this.paidAmount,
      this.paymentBalance,
      this.signatureKey,
      this.merchantId,
      this.fraudStatus,
      this.currency,
      this.paymentCode,
      this.addDate,
      this.userId,
      this.paymentAppointments});

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AppointmentPayment {
  @JsonKey(name: 'Id', defaultValue: null, includeIfNull: false)
  final int id;

  @JsonKey(name: 'AppointmentId', defaultValue: null, includeIfNull: false)
  final int appointmentId;

  @JsonKey(name: 'PaymentId', defaultValue: null, includeIfNull: false)
  final int paymentId;

  @JsonKey(name: 'Appointment', defaultValue: null, includeIfNull: false)
  final Appointment appointment;

  AppointmentPayment(
      {this.id, this.appointmentId, this.paymentId, this.appointment});

  factory AppointmentPayment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentPaymentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ConfirmBankBody {
  @JsonKey(name: 'paymentId', defaultValue: null)
  int paymentId;

  @JsonKey(name: 'fromBankCode', defaultValue: null)
  String fromBankCode;

  @JsonKey(name: 'fromAccountNumber', defaultValue: null)
  String fromAccountNumber;

  @JsonKey(name: 'fromAccountName', defaultValue: null)
  String fromAccountName;

  @JsonKey(name: 'toBankCode', defaultValue: null)
  String toBankCode;

  @JsonKey(name: 'toAccountNumber', defaultValue: null)
  String toAccountNumber;

  @JsonKey(name: 'toAccountName', defaultValue: null)
  String toAccountName;

  @JsonKey(name: 'paymentDate', defaultValue: null)
  String paymentDate;

  @JsonKey(name: 'paidAmount', defaultValue: null)
  double paidAmount;

  @JsonKey(name: 'referenceCode', defaultValue: null)
  String referenceCode;

  @JsonKey(name: 'notes', defaultValue: null)
  String notes;

  ConfirmBankBody(
      {this.paymentId,
      this.fromBankCode,
      this.fromAccountNumber,
      this.fromAccountName,
      this.toBankCode,
      this.toAccountNumber,
      this.toAccountName,
      this.paymentDate,
      this.paidAmount,
      this.referenceCode,
      this.notes});

  factory ConfirmBankBody.fromJson(Map<String, dynamic> json) =>
      _$ConfirmBankBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmBankBodyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class InitPaymentBody {
  @JsonKey(name: 'invoices', defaultValue: null)
  final List<int> invoices;

  @JsonKey(name: 'grossAmount', defaultValue: null)
  final double grossAmount;

  @JsonKey(name: 'paymentMethod', defaultValue: null)
  final int paymentMethod;

  @JsonKey(name: 'userId', defaultValue: null)
  final String userId;

  InitPaymentBody(
      {this.invoices, this.grossAmount, this.paymentMethod, this.userId});

  factory InitPaymentBody.fromJson(Map<String, dynamic> json) =>
      _$InitPaymentBodyFromJson(json);

  Map<String, dynamic> toJson() => _$InitPaymentBodyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class InitPaymentMidtransBody {
  @JsonKey(name: 'invoices', defaultValue: null)
  final List<int> invoices;

  @JsonKey(name: 'grossAmount', defaultValue: null)
  final double grossAmount;

  @JsonKey(name: 'paymentMethod', defaultValue: null)
  final int paymentMethod;

  @JsonKey(name: 'userId', defaultValue: null)
  final String userId;

  @JsonKey(name: 'orderId', defaultValue: null)
  final String orderId;

  @JsonKey(name: 'paymentType', defaultValue: null)
  final String paymentType;

  @JsonKey(name: 'virtualAccountNumber', defaultValue: null)
  final String virtualAccountNumber;

  @JsonKey(name: 'bankCode', defaultValue: null)
  final String bankCode;

  InitPaymentMidtransBody(
      {this.invoices,
      this.grossAmount,
      this.paymentMethod,
      this.userId,
      this.orderId,
      this.paymentType,
      this.virtualAccountNumber,
      this.bankCode});

  factory InitPaymentMidtransBody.fromJson(Map<String, dynamic> json) =>
      _$InitPaymentMidtransBodyFromJson(json);

  Map<String, dynamic> toJson() => _$InitPaymentMidtransBodyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResponseInvoice {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  Invoice result;

  ResponseInvoice({this.status, this.message, this.code, this.result});

  factory ResponseInvoice.fromJson(Map<String, dynamic> json) =>
      _$ResponseInvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseInvoiceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResponseListInvoice {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  List<Invoice> result;

  ResponseListInvoice({this.status, this.message, this.code, this.result});

  factory ResponseListInvoice.fromJson(Map<String, dynamic> json) =>
      _$ResponseListInvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseListInvoiceToJson(this);
}
