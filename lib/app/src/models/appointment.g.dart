// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  return Appointment(
    startDateTime: json['StartDateTime'] as String,
    endDateTime: json['EndDateTime'] as String,
    id: json['Id'] as int,
    bookingCode: json['BookingCode'] as String,
    userId: json['UserId'] as String,
    partnerId: json['PartnerId'] as String,
    masterPriceId: json['MasterPriceId'] as int,
    price: (json['Price'] as num)?.toDouble(),
    startDate: json['StartDate'] as String,
    startTime: json['StartTime'] as String,
    startTimezone: json['StartTimezone'] as String,
    endDate: json['EndDate'] as String,
    endTime: json['EndTime'] as String,
    endTimezone: json['EndTimezone'] as String,
    appointmentStatusId: json['AppointmentStatusId'] as int,
    appointmentStatusDescription:
        json['AppointmentStatusDescription'] as String,
    productServicesId: json['ProductServicesId'] as int,
    productServiceDescription: json['ProductServiceDescription'] as String,
    recurrenceRule: json['RecurrenceRule'] as String,
    location: json['Location'] as String,
    notes: json['Notes'] as String,
    isBlock: json['IsBlock'] as bool,
    isAllDay: json['IsAllDay'] as bool,
    addDate: json['AddDate'] as String,
    addBy: json['AddBy'] as String,
    editDate: json['EditDate'] as String,
    editBy: json['EditBy'] as String,
    productServiceId: json['ProductServiceId'] as int,
    priceSchemaId: json['PriceSchemaId'] as int,
    partnerPriceId: json['PartnerPriceId'] as int,
    isRescheduled: json['IsRescheduled'] as bool,
    rescheduledConfirmed: json['RescheduledConfirmed'] as bool,
    rescheduledBookingCode: json['RescheduledBookingCode'] as String,
    rescheduledByUser: json['RescheduledByUser'] as bool,
    reschedulePreId: json['ReschedulePreId'] as int,
    isOnPayment: json['IsOnPayment'] as bool,
    appointmentStatus: json['AppointmentStatus'] == null
        ? null
        : StaticData.fromJson(
            json['AppointmentStatus'] as Map<String, dynamic>),
    partner: json['Partner'] == null
        ? null
        : Partner.fromJson(json['Partner'] as Map<String, dynamic>),
    user: json['User'] == null
        ? null
        : User.fromJson(json['User'] as Map<String, dynamic>),
    appointmentRating: json['AppointmentRating'] as int,
    userFirstName: json['UserFirstName'] as String,
    userLastName: json['UserLastName'] as String,
    userMobileNumber: json['UserMobileNumber'] as String,
    userPictureUrl: json['UserPictureUrl'] as String,
    partnerPictureUrl: json['PartnerPictureUrl'] as String,
    partnerFirstName: json['PartnerFirstName'] as String,
    partnerLastName: json['PartnerLastName'] as String,
  );
}

Map<String, dynamic> _$AppointmentToJson(Appointment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('StartDateTime', instance.startDateTime);
  writeNotNull('EndDateTime', instance.endDateTime);
  writeNotNull('Id', instance.id);
  writeNotNull('BookingCode', instance.bookingCode);
  writeNotNull('UserId', instance.userId);
  writeNotNull('PartnerId', instance.partnerId);
  writeNotNull('MasterPriceId', instance.masterPriceId);
  writeNotNull('Price', instance.price);
  writeNotNull('StartDate', instance.startDate);
  writeNotNull('StartTime', instance.startTime);
  writeNotNull('StartTimezone', instance.startTimezone);
  writeNotNull('EndDate', instance.endDate);
  writeNotNull('EndTime', instance.endTime);
  writeNotNull('EndTimezone', instance.endTimezone);
  writeNotNull('AppointmentStatusId', instance.appointmentStatusId);
  writeNotNull(
      'AppointmentStatusDescription', instance.appointmentStatusDescription);
  writeNotNull('ProductServicesId', instance.productServicesId);
  writeNotNull('ProductServiceDescription', instance.productServiceDescription);
  writeNotNull('RecurrenceRule', instance.recurrenceRule);
  writeNotNull('Location', instance.location);
  writeNotNull('Notes', instance.notes);
  writeNotNull('IsBlock', instance.isBlock);
  writeNotNull('IsAllDay', instance.isAllDay);
  writeNotNull('AddDate', instance.addDate);
  writeNotNull('AddBy', instance.addBy);
  writeNotNull('EditDate', instance.editDate);
  writeNotNull('EditBy', instance.editBy);
  writeNotNull('ProductServiceId', instance.productServiceId);
  writeNotNull('PriceSchemaId', instance.priceSchemaId);
  writeNotNull('PartnerPriceId', instance.partnerPriceId);
  writeNotNull('IsRescheduled', instance.isRescheduled);
  writeNotNull('RescheduledConfirmed', instance.rescheduledConfirmed);
  writeNotNull('RescheduledBookingCode', instance.rescheduledBookingCode);
  writeNotNull('RescheduledByUser', instance.rescheduledByUser);
  writeNotNull('ReschedulePreId', instance.reschedulePreId);
  writeNotNull('IsOnPayment', instance.isOnPayment);
  writeNotNull('AppointmentStatus', instance.appointmentStatus?.toJson());
  writeNotNull('Partner', instance.partner?.toJson());
  writeNotNull('User', instance.user?.toJson());
  writeNotNull('AppointmentRating', instance.appointmentRating);
  writeNotNull('UserFirstName', instance.userFirstName);
  writeNotNull('UserLastName', instance.userLastName);
  writeNotNull('UserMobileNumber', instance.userMobileNumber);
  writeNotNull('UserPictureUrl', instance.userPictureUrl);
  writeNotNull('PartnerPictureUrl', instance.partnerPictureUrl);
  writeNotNull('PartnerFirstName', instance.partnerFirstName);
  writeNotNull('PartnerLastName', instance.partnerLastName);
  return val;
}

UpdateAppointmentStatus _$UpdateAppointmentStatusFromJson(
    Map<String, dynamic> json) {
  return UpdateAppointmentStatus(
    id: json['id'] as int,
    appointmentStatusId: json['appointmentStatusId'] as int,
    appointmentNotes: json['appointmentNotes'] as String,
  );
}

Map<String, dynamic> _$UpdateAppointmentStatusToJson(
    UpdateAppointmentStatus instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('appointmentStatusId', instance.appointmentStatusId);
  writeNotNull('appointmentNotes', instance.appointmentNotes);
  return val;
}

CompleteAppointment _$CompleteAppointmentFromJson(Map<String, dynamic> json) {
  return CompleteAppointment(
    bookingCode: json['bookingCode'] as String,
    appointmentId: json['appointmentId'] as int,
  );
}

Map<String, dynamic> _$CompleteAppointmentToJson(CompleteAppointment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bookingCode', instance.bookingCode);
  writeNotNull('appointmentId', instance.appointmentId);
  return val;
}

RateAppointment _$RateAppointmentFromJson(Map<String, dynamic> json) {
  return RateAppointment(
    appointmentId: json['appointmentId'] as int,
    rating: json['ratings'] as int,
    comment: json['comment'] as String,
    showName: json['showName'] as bool,
  );
}

Map<String, dynamic> _$RateAppointmentToJson(RateAppointment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('appointmentId', instance.appointmentId);
  writeNotNull('ratings', instance.rating);
  writeNotNull('comment', instance.comment);
  writeNotNull('showName', instance.showName);
  return val;
}

ResetAppointment _$ResetAppointmentFromJson(Map<String, dynamic> json) {
  return ResetAppointment(
    contentData: json['contentData'] as int,
  );
}

Map<String, dynamic> _$ResetAppointmentToJson(ResetAppointment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('contentData', instance.contentData);
  return val;
}

ResponseAppointment _$ResponseAppointmentFromJson(Map<String, dynamic> json) {
  return ResponseAppointment(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: json['Result'] == null
        ? null
        : Appointment.fromJson(json['Result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResponseAppointmentToJson(
        ResponseAppointment instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result?.toJson(),
    };

ResponseListAppointment _$ResponseListAppointmentFromJson(
    Map<String, dynamic> json) {
  return ResponseListAppointment(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: (json['Result'] as List)
        ?.map((e) =>
            e == null ? null : Appointment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResponseListAppointmentToJson(
        ResponseListAppointment instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result?.map((e) => e?.toJson())?.toList(),
    };
