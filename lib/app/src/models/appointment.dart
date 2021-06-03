import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'appointment.g.dart';

@JsonSerializable(explicitToJson: true)
class Appointment {
  @JsonKey(name: 'StartDateTime', defaultValue: null, includeIfNull: false)
  String startDateTime;

  @JsonKey(name: 'EndDateTime', defaultValue: null, includeIfNull: false)
  String endDateTime;

  @JsonKey(name: 'Id', defaultValue: null, includeIfNull: false)
  int id;

  @JsonKey(name: 'BookingCode', defaultValue: null, includeIfNull: false)
  String bookingCode;

  @JsonKey(name: 'UserId', defaultValue: null, includeIfNull: false)
  String userId;

  @JsonKey(name: 'PartnerId', defaultValue: null, includeIfNull: false)
  String partnerId;

  @JsonKey(name: 'MasterPriceId', defaultValue: null, includeIfNull: false)
  int masterPriceId;

  @JsonKey(name: 'Price', defaultValue: null, includeIfNull: false)
  double price;

  @JsonKey(name: 'StartDate', defaultValue: null, includeIfNull: false)
  String startDate;

  @JsonKey(name: 'StartTime', defaultValue: null, includeIfNull: false)
  String startTime;

  @JsonKey(name: 'StartTimezone', defaultValue: null, includeIfNull: false)
  String startTimezone;

  @JsonKey(name: 'EndDate', defaultValue: null, includeIfNull: false)
  String endDate;

  @JsonKey(name: 'EndTime', defaultValue: null, includeIfNull: false)
  String endTime;

  @JsonKey(name: 'EndTimezone', defaultValue: null, includeIfNull: false)
  String endTimezone;

  @JsonKey(
      name: 'AppointmentStatusId', defaultValue: null, includeIfNull: false)
  int appointmentStatusId;

  @JsonKey(
      name: 'AppointmentStatusDescription',
      defaultValue: null,
      includeIfNull: false)
  String appointmentStatusDescription;

  @JsonKey(name: 'ProductServicesId', defaultValue: null, includeIfNull: false)
  int productServicesId;

  @JsonKey(
      name: 'ProductServiceDescription',
      defaultValue: null,
      includeIfNull: false)
  String productServiceDescription;

  @JsonKey(name: 'RecurrenceRule', defaultValue: null, includeIfNull: false)
  String recurrenceRule;

  @JsonKey(name: 'Location', defaultValue: null, includeIfNull: false)
  String location;

  @JsonKey(name: 'Notes', defaultValue: null, includeIfNull: false)
  String notes;

  @JsonKey(name: 'IsBlock', defaultValue: null, includeIfNull: false)
  bool isBlock;

  @JsonKey(name: 'IsAllDay', defaultValue: null, includeIfNull: false)
  bool isAllDay;

  @JsonKey(name: 'AddDate', defaultValue: null, includeIfNull: false)
  String addDate;

  @JsonKey(name: 'AddBy', defaultValue: null, includeIfNull: false)
  String addBy;

  @JsonKey(name: 'EditDate', defaultValue: null, includeIfNull: false)
  String editDate;

  @JsonKey(name: 'EditBy', defaultValue: null, includeIfNull: false)
  String editBy;

  @JsonKey(name: 'ProductServiceId', defaultValue: null, includeIfNull: false)
  int productServiceId;

  @JsonKey(name: 'PriceSchemaId', defaultValue: null, includeIfNull: false)
  int priceSchemaId;

  @JsonKey(name: 'PartnerPriceId', defaultValue: null, includeIfNull: false)
  int partnerPriceId;

  @JsonKey(name: 'IsRescheduled', defaultValue: null, includeIfNull: false)
  bool isRescheduled;

  @JsonKey(
      name: 'RescheduledConfirmed', defaultValue: null, includeIfNull: false)
  bool rescheduledConfirmed;

  @JsonKey(
      name: 'RescheduledBookingCode', defaultValue: null, includeIfNull: false)
  String rescheduledBookingCode;

  @JsonKey(name: 'RescheduledByUser', defaultValue: null, includeIfNull: false)
  bool rescheduledByUser;

  @JsonKey(name: 'ReschedulePreId', defaultValue: null, includeIfNull: false)
  int reschedulePreId;

  @JsonKey(name: 'IsOnPayment', defaultValue: null, includeIfNull: false)
  bool isOnPayment;

  @JsonKey(name: 'AppointmentStatus', defaultValue: null, includeIfNull: false)
  StaticData appointmentStatus;

  @JsonKey(name: 'Partner', defaultValue: null, includeIfNull: false)
  Partner partner;

  @JsonKey(name: 'User', defaultValue: null, includeIfNull: false)
  User user;

  @JsonKey(name: 'AppointmentRating', defaultValue: null, includeIfNull: false)
  int appointmentRating;

  @JsonKey(name: 'UserFirstName', defaultValue: null, includeIfNull: false)
  String userFirstName;

  @JsonKey(name: 'UserLastName', defaultValue: null, includeIfNull: false)
  String userLastName;

  @JsonKey(name: 'UserMobileNumber', defaultValue: null, includeIfNull: false)
  String userMobileNumber;

  @JsonKey(name: 'UserPictureUrl', defaultValue: null, includeIfNull: false)
  String userPictureUrl;

  @JsonKey(name: 'PartnerPictureUrl', defaultValue: null, includeIfNull: false)
  String partnerPictureUrl;

  @JsonKey(name: 'PartnerFirstName', defaultValue: null, includeIfNull: false)
  String partnerFirstName;

  @JsonKey(name: 'PartnerLastName', defaultValue: null, includeIfNull: false)
  String partnerLastName;

  Appointment(
      {this.startDateTime,
      this.endDateTime,
      this.id,
      this.bookingCode,
      this.userId,
      this.partnerId,
      this.masterPriceId,
      this.price,
      this.startDate,
      this.startTime,
      this.startTimezone,
      this.endDate,
      this.endTime,
      this.endTimezone,
      this.appointmentStatusId,
      this.appointmentStatusDescription,
      this.productServicesId,
      this.productServiceDescription,
      this.recurrenceRule,
      this.location,
      this.notes,
      this.isBlock,
      this.isAllDay,
      this.addDate,
      this.addBy,
      this.editDate,
      this.editBy,
      this.productServiceId,
      this.priceSchemaId,
      this.partnerPriceId,
      this.isRescheduled,
      this.rescheduledConfirmed,
      this.rescheduledBookingCode,
      this.rescheduledByUser,
      this.reschedulePreId,
      this.isOnPayment,
      this.appointmentStatus,
      this.partner,
      this.user,
      this.appointmentRating,
      this.userFirstName,
      this.userLastName,
      this.userMobileNumber,
      this.userPictureUrl,
      this.partnerPictureUrl,
      this.partnerFirstName,
      this.partnerLastName});

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateAppointmentStatus {
  @JsonKey(name: 'id', defaultValue: null, includeIfNull: false)
  int id;

  @JsonKey(
      name: 'appointmentStatusId', defaultValue: null, includeIfNull: false)
  int appointmentStatusId;

  @JsonKey(name: 'appointmentNotes', defaultValue: null, includeIfNull: false)
  String appointmentNotes;

  UpdateAppointmentStatus(
      {this.id, this.appointmentStatusId, this.appointmentNotes});

  factory UpdateAppointmentStatus.fromJson(Map<String, dynamic> json) =>
      _$UpdateAppointmentStatusFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateAppointmentStatusToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CompleteAppointment {
  @JsonKey(name: 'bookingCode', defaultValue: null, includeIfNull: false)
  String bookingCode;

  @JsonKey(name: 'appointmentId', defaultValue: null, includeIfNull: false)
  int appointmentId;

  CompleteAppointment({this.bookingCode, this.appointmentId});

  factory CompleteAppointment.fromJson(Map<String, dynamic> json) =>
      _$CompleteAppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$CompleteAppointmentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RateAppointment {
  @JsonKey(name: 'appointmentId', defaultValue: null, includeIfNull: false)
  int appointmentId;

  @JsonKey(name: 'ratings', defaultValue: null, includeIfNull: false)
  int rating;

  @JsonKey(name: 'comment', defaultValue: null, includeIfNull: false)
  String comment;

  @JsonKey(name: 'showName', defaultValue: null, includeIfNull: false)
  bool showName;

  RateAppointment(
      {this.appointmentId, this.rating, this.comment, this.showName});

  factory RateAppointment.fromJson(Map<String, dynamic> json) =>
      _$RateAppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$RateAppointmentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResetAppointment {
  @JsonKey(name: 'contentData', defaultValue: null, includeIfNull: false)
  int contentData;

  ResetAppointment({this.contentData});

  factory ResetAppointment.fromJson(Map<String, dynamic> json) =>
      _$ResetAppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$ResetAppointmentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResponseAppointment {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  Appointment result;

  ResponseAppointment({this.status, this.message, this.code, this.result});

  factory ResponseAppointment.fromJson(Map<String, dynamic> json) =>
      _$ResponseAppointmentFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseAppointmentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResponseListAppointment {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  List<Appointment> result;

  ResponseListAppointment({this.status, this.message, this.code, this.result});

  factory ResponseListAppointment.fromJson(Map<String, dynamic> json) =>
      _$ResponseListAppointmentFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseListAppointmentToJson(this);
}
