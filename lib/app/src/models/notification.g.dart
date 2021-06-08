// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) {
  return Notification(
    id: json['Id'] as int,
    firebaseId: json['Fbid'] as String,
    title: json['Title'] as String,
    body: json['Body'] as String,
    icon: json['Icon'] as String,
    addDate: json['AddDate'] as String,
    priority: json['Priority'] as int,
    isRead: json['IsRead'] as bool,
    readDate: json['ReadDate'] as String,
    isDeleted: json['IsDeleted'] as bool,
    deletedDate: json['DeletedDate'] as String,
    filterId: json['filterId'] as int,
    filterName: json['filterName'] as String,
  );
}

Map<String, dynamic> _$NotificationToJson(Notification instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('Fbid', instance.firebaseId);
  writeNotNull('Title', instance.title);
  writeNotNull('Body', instance.body);
  writeNotNull('Icon', instance.icon);
  writeNotNull('AddDate', instance.addDate);
  writeNotNull('Priority', instance.priority);
  writeNotNull('IsRead', instance.isRead);
  writeNotNull('ReadDate', instance.readDate);
  writeNotNull('IsDeleted', instance.isDeleted);
  writeNotNull('DeletedDate', instance.deletedDate);
  val['filterId'] = instance.filterId;
  val['filterName'] = instance.filterName;
  return val;
}

AllNotification _$AllNotificationFromJson(Map<String, dynamic> json) {
  return AllNotification(
    notificationInfos: (json['NotificationInfos'] as List)
        ?.map((e) =>
            e == null ? null : Notification.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    notificationPromos: (json['NotificationPromos'] as List)
        ?.map((e) =>
            e == null ? null : Notification.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    notificationTransactions: (json['NotificationTransactions'] as List)
        ?.map((e) =>
            e == null ? null : Notification.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AllNotificationToJson(AllNotification instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('NotificationInfos',
      instance.notificationInfos?.map((e) => e?.toJson())?.toList());
  writeNotNull('NotificationPromos',
      instance.notificationPromos?.map((e) => e?.toJson())?.toList());
  writeNotNull('NotificationTransactions',
      instance.notificationTransactions?.map((e) => e?.toJson())?.toList());
  return val;
}

NotificationBody _$NotificationBodyFromJson(Map<String, dynamic> json) {
  return NotificationBody(
    contentData: json['contentData'] as int,
  );
}

Map<String, dynamic> _$NotificationBodyToJson(NotificationBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('contentData', instance.contentData);
  return val;
}

ResponseNotification _$ResponseNotificationFromJson(Map<String, dynamic> json) {
  return ResponseNotification(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: json['Result'] == null
        ? null
        : Notification.fromJson(json['Result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResponseNotificationToJson(
        ResponseNotification instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result?.toJson(),
    };

ResponseAllNotification _$ResponseAllNotificationFromJson(
    Map<String, dynamic> json) {
  return ResponseAllNotification(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: json['Result'] == null
        ? null
        : AllNotification.fromJson(json['Result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResponseAllNotificationToJson(
        ResponseAllNotification instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result?.toJson(),
    };
