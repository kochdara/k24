

import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/users/user_serial.dart';

import '../helper.dart';
import '../try_convert.dart';

part 'chat_serial.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToInt(), ToLists()])
class ChatSerial {
  List<ChatData?>? data;
  int limit = 0;

  ChatSerial({
    this.data,
    required this.limit,
  });

  factory ChatSerial.fromJson(Map<String, dynamic> json) => _$ChatSerialFromJson(json);
  Map toJson() => _$ChatSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToDateTime()])
class ChatData {
  String? id;
  String? adid;
  String? to_id;
  String? last_message_id;
  String? create_time;
  String? updated_time;
  DateTime? updated_date;
  String? type;
  LastMessage? last_message;
  ChatPost? post;
  ChatUser? user;

  ChatData({
    this.id,
    this.adid,
    this.to_id,
    this.last_message_id,
    this.create_time,
    this.updated_time,
    this.updated_date,
    this.type,
    this.last_message,
    this.post,
    this.user,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) => _$ChatDataFromJson(json);
  Map toJson() => _$ChatDataToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToDateTime(), ToBool()])
class LastMessage {
  String? id;
  String? message;
  DateTime? send_date;
  String? send_time;
  bool? is_read;
  String? folder;
  String? status;
  String? read_time;
  DateTime? read_date;

  LastMessage({
    this.id,
    this.message,
    this.send_date,
    this.send_time,
    this.is_read,
    this.folder,
    this.status,
    this.read_time,
    this.read_date,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => _$LastMessageFromJson(json);
  Map toJson() => _$LastMessageToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToLists(), ToInt()])
class ChatPost {
  String? id;
  String? title;
  String? price;
  String? userid;
  String? storeid;
  String? url;
  String? status;
  String? status_message;
  dynamic discount;
  List<String?>? photo_raw;
  String? photo;
  List<String?>? photos;
  String? thumbnail;
  List<String?>? thumbnails;
  double? lat;
  double? lng;
  int? zoon;
  String? file;
  String? type;
  String? size;
  String? name;

  ChatPost({
    this.id,
    this.title,
    this.price,
    this.userid,
    this.storeid,
    this.url,
    this.status,
    this.status_message,
    this.discount,
    this.photo_raw,
    this.photo,
    this.photos,
    this.thumbnail,
    this.thumbnails,
    this.lat,
    this.lng,
    this.zoon,
    this.file,
    this.type,
    this.size,
    this.name,
  });

  factory ChatPost.fromJson(Map json) => _$ChatPostFromJson(json);
  Map toJson() => _$ChatPostToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToBool()])
class ChatUser {
  String? id;
  String? name;
  String? username;
  bool? banned;
  String? banned_detail;
  CoverProfile? photo;
  OnlineStatusProfile? online_status;
  bool? is_verify;

  ChatUser({
    this.id,
    this.name,
    this.username,
    this.banned,
    this.banned_detail,
    this.photo,
    this.online_status,
    this.is_verify,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) => _$ChatUserFromJson(json);
  Map toJson() => _$ChatUserToJson(this);

}

