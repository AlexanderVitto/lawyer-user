// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twilio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Channel _$ChannelFromJson(Map<String, dynamic> json) {
  return Channel(
    sid: json['sid'] as String,
    accountSid: json['account_sid'] as String,
    serviceSid: json['service_sid'] as String,
    channelSid: json['channel_sid'] as String,
    friendlyName: json['friendly_name'] as String,
    uniqueName: json['unique_name'] as String,
    attributes: json['attributes'] as String,
    type: json['type'] as String,
    dateCreated: json['date_created'] as String,
    dateUpdated: json['date_updated'] as String,
    createdBy: json['created_by'] as String,
    membersCount: json['members_count'] as int,
    messagesCount: json['messages_count'] as int,
    links: json['links'] == null
        ? null
        : Links.fromJson(json['links'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChannelToJson(Channel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sid', instance.sid);
  writeNotNull('account_sid', instance.accountSid);
  writeNotNull('service_sid', instance.serviceSid);
  writeNotNull('channel_sid', instance.channelSid);
  writeNotNull('friendly_name', instance.friendlyName);
  writeNotNull('unique_name', instance.uniqueName);
  writeNotNull('attributes', instance.attributes);
  writeNotNull('type', instance.type);
  writeNotNull('date_created', instance.dateCreated);
  writeNotNull('date_updated', instance.dateUpdated);
  writeNotNull('created_by', instance.createdBy);
  writeNotNull('members_count', instance.membersCount);
  writeNotNull('messages_count', instance.messagesCount);
  writeNotNull('links', instance.links?.toJson());
  return val;
}

Links _$LinksFromJson(Map<String, dynamic> json) {
  return Links(
    webhooks: json['webhooks'] as String,
    messages: json['messages'] as String,
    invites: json['invites'] as String,
    members: json['members'] as String,
    lastMessage: json['last_message'] as String,
  );
}

Map<String, dynamic> _$LinksToJson(Links instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('webhooks', instance.webhooks);
  writeNotNull('messages', instance.messages);
  writeNotNull('invites', instance.invites);
  writeNotNull('members', instance.members);
  writeNotNull('last_message', instance.lastMessage);
  return val;
}

CreateChannelRequest _$CreateChannelRequestFromJson(Map<String, dynamic> json) {
  return CreateChannelRequest(
    userId: json['userId'] as String,
    partnerId: json['partnerId'] as String,
    bookingCode: json['bookingCode'] as String,
    appointmentStart: json['appointmentStart'] as String,
    appointmentEnd: json['appointmentEnd'] as String,
  );
}

Map<String, dynamic> _$CreateChannelRequestToJson(
    CreateChannelRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userId', instance.userId);
  writeNotNull('partnerId', instance.partnerId);
  writeNotNull('bookingCode', instance.bookingCode);
  writeNotNull('appointmentStart', instance.appointmentStart);
  writeNotNull('appointmentEnd', instance.appointmentEnd);
  return val;
}

ChannelResponse _$ChannelResponseFromJson(Map<String, dynamic> json) {
  return ChannelResponse(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: json['Result'] == null
        ? null
        : Channel.fromJson(json['Result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChannelResponseToJson(ChannelResponse instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result?.toJson(),
    };
