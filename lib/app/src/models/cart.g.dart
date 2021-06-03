// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) {
  return Cart(
    userName: json['UserFullName'] as String,
    partnerName: json['PartnerFullName'] as String,
    startSession: json['StartSession'] as String,
    endSession: json['EndSession'] as String,
    appointmentId: json['AppointmentId'] as int,
    bookingCode: json['BookingCode'] as String,
    userId: json['UserId'] as String,
    userFirstName: json['UserFirstName'] as String,
    userLastName: json['UserLastName'] as String,
    partnerId: json['PartnerId'] as String,
    partnerFirstName: json['PartnerFirstName'] as String,
    partnerLastName: json['PartnerLastName'] as String,
    price: (json['Price'] as num)?.toDouble(),
    startDate: json['StartDate'] as String,
    startTime: json['StartTime'] as String,
    endDate: json['EndDate'] as String,
    endTime: json['EndTime'] as String,
    appointmentStatusId: json['AppointmentStatusId'] as int,
    appointmentStatusDescription:
        json['AppointmentStatusDescription'] as String,
    productServiceId: json['ProductServiceId'] as int,
    productServiceDescription: json['ProductServiceDescription'] as String,
    priceSchemaId: json['PriceSchemaId'] as int,
    priceSchemaDescription: json['PriceSchemaDescription'] as String,
    partnerPriceId: json['PartnerPriceId'] as int,
    isRescheduled: json['IsRescheduled'] as bool,
    rescheduledConfirmed: json['RescheduledConfirmed'] as bool,
    rescheduledBookingCode: json['RescheduledBookingCode'] as String,
    rescheduledByUser: json['RescheduledByUser'] as bool,
    reschedulePreId: json['ReschedulePreId'] as int,
    paymentStatusId: json['PaymentStatusId'] as int,
    paymentStatusDescription: json['PaymentStatusDescription'] as String,
    invoiceNumber: json['InvoiceNumber'] as String,
    paymentMethodId: json['PaymentMethodId'] as int,
    paymentMethodDescription: json['PaymentMethodDescription'] as String,
    paymentId: json['PaymentId'] as int,
    orderId: json['OrderId'] as int,
    transactionId: json['TransactionId'] as int,
    transactionStatus: json['TransactionStatus'] as int,
    transactionStatusDescription:
        json['TransactionStatusDescription'] as String,
    paymentType: json['PaymentType'] as int,
    toBankCode: json['ToBankCode'] as int,
    toBankName: json['ToBankName'] as String,
    toAccountNumber: json['ToAccountNumber'] as int,
    paidAmount: (json['PaidAmount'] as num)?.toDouble(),
    expiredIn: json['ExpiredIn'] as String,
  );
}

Map<String, dynamic> _$CartToJson(Cart instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('UserFullName', instance.userName);
  writeNotNull('PartnerFullName', instance.partnerName);
  writeNotNull('StartSession', instance.startSession);
  writeNotNull('EndSession', instance.endSession);
  writeNotNull('AppointmentId', instance.appointmentId);
  writeNotNull('BookingCode', instance.bookingCode);
  writeNotNull('UserId', instance.userId);
  writeNotNull('UserFirstName', instance.userFirstName);
  writeNotNull('UserLastName', instance.userLastName);
  writeNotNull('PartnerId', instance.partnerId);
  writeNotNull('PartnerFirstName', instance.partnerFirstName);
  writeNotNull('PartnerLastName', instance.partnerLastName);
  writeNotNull('Price', instance.price);
  writeNotNull('StartDate', instance.startDate);
  writeNotNull('StartTime', instance.startTime);
  writeNotNull('EndDate', instance.endDate);
  writeNotNull('EndTime', instance.endTime);
  writeNotNull('AppointmentStatusId', instance.appointmentStatusId);
  writeNotNull(
      'AppointmentStatusDescription', instance.appointmentStatusDescription);
  writeNotNull('ProductServiceId', instance.productServiceId);
  writeNotNull('ProductServiceDescription', instance.productServiceDescription);
  writeNotNull('PriceSchemaId', instance.priceSchemaId);
  writeNotNull('PriceSchemaDescription', instance.priceSchemaDescription);
  writeNotNull('PartnerPriceId', instance.partnerPriceId);
  writeNotNull('IsRescheduled', instance.isRescheduled);
  writeNotNull('RescheduledConfirmed', instance.rescheduledConfirmed);
  writeNotNull('RescheduledBookingCode', instance.rescheduledBookingCode);
  writeNotNull('RescheduledByUser', instance.rescheduledByUser);
  writeNotNull('ReschedulePreId', instance.reschedulePreId);
  writeNotNull('PaymentStatusId', instance.paymentStatusId);
  writeNotNull('PaymentStatusDescription', instance.paymentStatusDescription);
  writeNotNull('InvoiceNumber', instance.invoiceNumber);
  writeNotNull('PaymentMethodId', instance.paymentMethodId);
  writeNotNull('PaymentMethodDescription', instance.paymentMethodDescription);
  writeNotNull('PaymentId', instance.paymentId);
  writeNotNull('OrderId', instance.orderId);
  writeNotNull('TransactionId', instance.transactionId);
  writeNotNull('TransactionStatus', instance.transactionStatus);
  writeNotNull(
      'TransactionStatusDescription', instance.transactionStatusDescription);
  writeNotNull('PaymentType', instance.paymentType);
  writeNotNull('ToBankCode', instance.toBankCode);
  writeNotNull('ToBankName', instance.toBankName);
  writeNotNull('ToAccountNumber', instance.toAccountNumber);
  writeNotNull('PaidAmount', instance.paidAmount);
  writeNotNull('ExpiredIn', instance.expiredIn);
  return val;
}

ResponseCart _$ResponseCartFromJson(Map<String, dynamic> json) {
  return ResponseCart(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: (json['Result'] as List)
        ?.map(
            (e) => e == null ? null : Cart.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResponseCartToJson(ResponseCart instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result?.map((e) => e?.toJson())?.toList(),
    };
