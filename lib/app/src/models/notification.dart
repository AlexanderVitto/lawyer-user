import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable(explicitToJson: true)
class Notification with ChangeNotifier {
  @JsonKey(name: 'Id', defaultValue: null, includeIfNull: false)
  final int id;

  @JsonKey(name: 'Fbid', defaultValue: null, includeIfNull: false)
  final String firebaseId;

  @JsonKey(name: 'Title', defaultValue: null, includeIfNull: false)
  final String title;

  @JsonKey(name: 'Body', defaultValue: null, includeIfNull: false)
  final String body;

  @JsonKey(name: 'Icon', defaultValue: null, includeIfNull: false)
  final String icon;

  @JsonKey(name: 'AddDate', defaultValue: null, includeIfNull: false)
  final String addDate;

  @JsonKey(name: 'Priority', defaultValue: null, includeIfNull: false)
  final int priority;

  @JsonKey(name: 'IsRead', defaultValue: null, includeIfNull: false)
  bool isRead;

  @JsonKey(name: 'ReadDate', defaultValue: null, includeIfNull: false)
  final String readDate;

  @JsonKey(name: 'IsDeleted', defaultValue: null, includeIfNull: false)
  final bool isDeleted;

  @JsonKey(name: 'DeletedDate', defaultValue: null, includeIfNull: false)
  final String deletedDate;

  int filterId;
  String filterName;

  Notification(
      {this.id,
      this.firebaseId,
      this.title,
      this.body,
      this.icon,
      this.addDate,
      this.priority,
      this.isRead,
      this.readDate,
      this.isDeleted,
      this.deletedDate,
      this.filterId = 0,
      this.filterName = ''});

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  isReadStatus() {
    isRead = true;
    print(isRead);

    notifyListeners();
  }
}

@JsonSerializable(explicitToJson: true)
class AllNotification {
  @JsonKey(name: 'NotificationInfos', defaultValue: null, includeIfNull: false)
  final List<Notification> notificationInfos;

  @JsonKey(name: 'NotificationPromos', defaultValue: null, includeIfNull: false)
  final List<Notification> notificationPromos;

  @JsonKey(
      name: 'NotificationTransactions',
      defaultValue: null,
      includeIfNull: false)
  final List<Notification> notificationTransactions;

  AllNotification(
      {this.notificationInfos,
      this.notificationPromos,
      this.notificationTransactions});

  factory AllNotification.fromJson(Map<String, dynamic> json) =>
      _$AllNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$AllNotificationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NotificationBody {
  @JsonKey(name: 'contentData', defaultValue: null, includeIfNull: false)
  final int contentData;

  NotificationBody({this.contentData});

  factory NotificationBody.fromJson(Map<String, dynamic> json) =>
      _$NotificationBodyFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationBodyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResponseNotification {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  final bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  final String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  final String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  final Notification result;

  ResponseNotification({this.status, this.message, this.code, this.result});
  factory ResponseNotification.fromJson(Map<String, dynamic> json) =>
      _$ResponseNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseNotificationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResponseAllNotification {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  final bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  final String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  final String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  final AllNotification result;

  ResponseAllNotification({this.status, this.message, this.code, this.result});
  factory ResponseAllNotification.fromJson(Map<String, dynamic> json) =>
      _$ResponseAllNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseAllNotificationToJson(this);
}
