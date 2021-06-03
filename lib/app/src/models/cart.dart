import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable(explicitToJson: true)
class Cart with ChangeNotifier {
  @JsonKey(name: 'UserFullName', defaultValue: null, includeIfNull: false)
  final String userName;

  @JsonKey(name: 'PartnerFullName', defaultValue: null, includeIfNull: false)
  final String partnerName;

  @JsonKey(name: 'StartSession', defaultValue: null, includeIfNull: false)
  final String startSession;

  @JsonKey(name: 'EndSession', defaultValue: null, includeIfNull: false)
  final String endSession;

  @JsonKey(name: 'AppointmentId', defaultValue: null, includeIfNull: false)
  final int appointmentId;

  @JsonKey(name: 'BookingCode', defaultValue: null, includeIfNull: false)
  final String bookingCode;

  @JsonKey(name: 'UserId', defaultValue: null, includeIfNull: false)
  final String userId;

  @JsonKey(name: 'UserFirstName', defaultValue: null, includeIfNull: false)
  final String userFirstName;

  @JsonKey(name: 'UserLastName', defaultValue: null, includeIfNull: false)
  final String userLastName;

  @JsonKey(name: 'PartnerId', defaultValue: null, includeIfNull: false)
  final String partnerId;

  @JsonKey(name: 'PartnerFirstName', defaultValue: null, includeIfNull: false)
  final String partnerFirstName;

  @JsonKey(name: 'PartnerLastName', defaultValue: null, includeIfNull: false)
  final String partnerLastName;

  @JsonKey(name: 'Price', defaultValue: null, includeIfNull: false)
  final double price;

  @JsonKey(name: 'StartDate', defaultValue: null, includeIfNull: false)
  final String startDate;

  @JsonKey(name: 'StartTime', defaultValue: null, includeIfNull: false)
  final String startTime;

  @JsonKey(name: 'EndDate', defaultValue: null, includeIfNull: false)
  final String endDate;

  @JsonKey(name: 'EndTime', defaultValue: null, includeIfNull: false)
  final String endTime;

  @JsonKey(
      name: 'AppointmentStatusId', defaultValue: null, includeIfNull: false)
  final int appointmentStatusId;

  @JsonKey(
      name: 'AppointmentStatusDescription',
      defaultValue: null,
      includeIfNull: false)
  final String appointmentStatusDescription;

  @JsonKey(name: 'ProductServiceId', defaultValue: null, includeIfNull: false)
  final int productServiceId;

  @JsonKey(
      name: 'ProductServiceDescription',
      defaultValue: null,
      includeIfNull: false)
  final String productServiceDescription;

  @JsonKey(name: 'PriceSchemaId', defaultValue: null, includeIfNull: false)
  final int priceSchemaId;

  @JsonKey(
      name: 'PriceSchemaDescription', defaultValue: null, includeIfNull: false)
  final String priceSchemaDescription;

  @JsonKey(name: 'PartnerPriceId', defaultValue: null, includeIfNull: false)
  final int partnerPriceId;

  @JsonKey(name: 'IsRescheduled', defaultValue: null, includeIfNull: false)
  final bool isRescheduled;

  @JsonKey(
      name: 'RescheduledConfirmed', defaultValue: null, includeIfNull: false)
  final bool rescheduledConfirmed;

  @JsonKey(
      name: 'RescheduledBookingCode', defaultValue: null, includeIfNull: false)
  final String rescheduledBookingCode;

  @JsonKey(name: 'RescheduledByUser', defaultValue: null, includeIfNull: false)
  final bool rescheduledByUser;

  @JsonKey(name: 'ReschedulePreId', defaultValue: null, includeIfNull: false)
  final int reschedulePreId;

  @JsonKey(name: 'PaymentStatusId', defaultValue: null, includeIfNull: false)
  final int paymentStatusId;

  @JsonKey(
      name: 'PaymentStatusDescription',
      defaultValue: null,
      includeIfNull: false)
  final String paymentStatusDescription;

  @JsonKey(name: 'InvoiceNumber', defaultValue: null, includeIfNull: false)
  final String invoiceNumber;

  @JsonKey(name: 'PaymentMethodId', defaultValue: null, includeIfNull: false)
  final int paymentMethodId;

  @JsonKey(
      name: 'PaymentMethodDescription',
      defaultValue: null,
      includeIfNull: false)
  final String paymentMethodDescription;

  @JsonKey(name: 'PaymentId', defaultValue: null, includeIfNull: false)
  final int paymentId;

  @JsonKey(name: 'OrderId', defaultValue: null, includeIfNull: false)
  final int orderId;

  @JsonKey(name: 'TransactionId', defaultValue: null, includeIfNull: false)
  final int transactionId;

  @JsonKey(name: 'TransactionStatus', defaultValue: null, includeIfNull: false)
  final int transactionStatus;

  @JsonKey(
      name: 'TransactionStatusDescription',
      defaultValue: null,
      includeIfNull: false)
  final String transactionStatusDescription;

  @JsonKey(name: 'PaymentType', defaultValue: null, includeIfNull: false)
  final int paymentType;

  @JsonKey(name: 'ToBankCode', defaultValue: null, includeIfNull: false)
  final int toBankCode;

  @JsonKey(name: 'ToBankName', defaultValue: null, includeIfNull: false)
  final String toBankName;

  @JsonKey(name: 'ToAccountNumber', defaultValue: null, includeIfNull: false)
  final int toAccountNumber;

  @JsonKey(name: 'PaidAmount', defaultValue: null, includeIfNull: false)
  final double paidAmount;

  @JsonKey(name: 'ExpiredIn', defaultValue: null, includeIfNull: false)
  final String expiredIn;

  @JsonKey(name: 'isSelected', ignore: true)
  bool isSelected;

  Cart(
      {this.userName,
      this.partnerName,
      this.startSession,
      this.endSession,
      this.appointmentId,
      this.bookingCode,
      this.userId,
      this.userFirstName,
      this.userLastName,
      this.partnerId,
      this.partnerFirstName,
      this.partnerLastName,
      this.price,
      this.startDate,
      this.startTime,
      this.endDate,
      this.endTime,
      this.appointmentStatusId,
      this.appointmentStatusDescription,
      this.productServiceId,
      this.productServiceDescription,
      this.priceSchemaId,
      this.priceSchemaDescription,
      this.partnerPriceId,
      this.isRescheduled,
      this.rescheduledConfirmed,
      this.rescheduledBookingCode,
      this.rescheduledByUser,
      this.reschedulePreId,
      this.paymentStatusId,
      this.paymentStatusDescription,
      this.invoiceNumber,
      this.paymentMethodId,
      this.paymentMethodDescription,
      this.paymentId,
      this.orderId,
      this.transactionId,
      this.transactionStatus,
      this.transactionStatusDescription,
      this.paymentType,
      this.toBankCode,
      this.toBankName,
      this.toAccountNumber,
      this.paidAmount,
      this.expiredIn,
      this.isSelected = false});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);

  toggleButtons() {
    this.isSelected = !isSelected;

    notifyListeners();
  }
}

@JsonSerializable(explicitToJson: true)
class ResponseCart {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  final bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  final String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  final String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  final List<Cart> result;

  ResponseCart({this.status, this.message, this.code, this.result});

  factory ResponseCart.fromJson(Map<String, dynamic> json) =>
      _$ResponseCartFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseCartToJson(this);
}
