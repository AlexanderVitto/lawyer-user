import 'package:json_annotation/json_annotation.dart';

part 'twilio.g.dart';

@JsonSerializable(explicitToJson: true)
class Channel {
  @JsonKey(name: 'sid', defaultValue: null, includeIfNull: false)
  final String sid;

  @JsonKey(name: 'account_sid', defaultValue: null, includeIfNull: false)
  final String accountSid;

  @JsonKey(name: 'service_sid', defaultValue: null, includeIfNull: false)
  final String serviceSid;

  @JsonKey(name: 'channel_sid', defaultValue: null, includeIfNull: false)
  final String channelSid;

  @JsonKey(name: 'friendly_name', defaultValue: null, includeIfNull: false)
  final String friendlyName;

  @JsonKey(name: 'unique_name', defaultValue: null, includeIfNull: false)
  final String uniqueName;

  @JsonKey(name: 'attributes', defaultValue: null, includeIfNull: false)
  final String attributes;

  @JsonKey(name: 'type', defaultValue: null, includeIfNull: false)
  final String type;

  @JsonKey(name: 'date_created', defaultValue: null, includeIfNull: false)
  final String dateCreated;

  @JsonKey(name: 'date_updated', defaultValue: null, includeIfNull: false)
  final String dateUpdated;

  @JsonKey(name: 'created_by', defaultValue: null, includeIfNull: false)
  final String createdBy;

  @JsonKey(name: 'members_count', defaultValue: null, includeIfNull: false)
  final int membersCount;

  @JsonKey(name: 'messages_count', defaultValue: null, includeIfNull: false)
  final int messagesCount;

  @JsonKey(name: 'links', defaultValue: null, includeIfNull: false)
  final Links links;

  Channel(
      {this.sid,
      this.accountSid,
      this.serviceSid,
      this.channelSid,
      this.friendlyName,
      this.uniqueName,
      this.attributes,
      this.type,
      this.dateCreated,
      this.dateUpdated,
      this.createdBy,
      this.membersCount,
      this.messagesCount,
      this.links});

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);
  Map<String, dynamic> toJson() => _$ChannelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Links {
  @JsonKey(name: 'webhooks', defaultValue: null, includeIfNull: false)
  final String webhooks;

  @JsonKey(name: 'messages', defaultValue: null, includeIfNull: false)
  final String messages;

  @JsonKey(name: 'invites', defaultValue: null, includeIfNull: false)
  final String invites;

  @JsonKey(name: 'members', defaultValue: null, includeIfNull: false)
  final String members;

  @JsonKey(name: 'last_message', defaultValue: null, includeIfNull: false)
  final String lastMessage;

  Links(
      {this.webhooks,
      this.messages,
      this.invites,
      this.members,
      this.lastMessage});

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateChannelRequest {
  @JsonKey(name: 'userId', defaultValue: null, includeIfNull: false)
  final String userId;

  @JsonKey(name: 'partnerId', defaultValue: null, includeIfNull: false)
  final String partnerId;

  @JsonKey(name: 'bookingCode', defaultValue: null, includeIfNull: false)
  final String bookingCode;

  @JsonKey(name: 'appointmentStart', defaultValue: null, includeIfNull: false)
  final String appointmentStart;

  @JsonKey(name: 'appointmentEnd', defaultValue: null, includeIfNull: false)
  final String appointmentEnd;

  CreateChannelRequest(
      {this.userId,
      this.partnerId,
      this.bookingCode,
      this.appointmentStart,
      this.appointmentEnd});

  factory CreateChannelRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateChannelRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateChannelRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChannelResponse {
  @JsonKey(name: 'Status')
  final bool status;

  @JsonKey(name: 'Messages', defaultValue: null)
  final String message;

  @JsonKey(name: 'Code', defaultValue: null)
  final String code;

  @JsonKey(name: 'Result', defaultValue: null)
  final Channel result;

  ChannelResponse({this.status, this.message, this.code, this.result});

  factory ChannelResponse.fromJson(Map<String, dynamic> json) =>
      _$ChannelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChannelResponseToJson(this);
}
