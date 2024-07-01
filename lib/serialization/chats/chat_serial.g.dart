// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_serial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatSerial _$ChatSerialFromJson(Map json) => ChatSerial(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ChatData.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      limit: const ToInt().fromJson(json['limit']),
    );

Map<String, dynamic> _$ChatSerialToJson(ChatSerial instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e?.toJson()).toList(),
      'limit': const ToInt().toJson(instance.limit),
    };

ChatData _$ChatDataFromJson(Map json) => ChatData(
      id: const ToString().fromJson(json['id']),
      adid: const ToString().fromJson(json['adid']),
      toId: const ToString().fromJson(json['toId']),
      last_message_id: const ToString().fromJson(json['last_message_id']),
      create_time: const ToString().fromJson(json['create_time']),
      updated_time: const ToString().fromJson(json['updated_time']),
      updated_date: const ToDateTime().fromJson(json['updated_date']),
      type: const ToString().fromJson(json['type']),
      last_message: json['last_message'] == null
          ? null
          : LastMessage.fromJson(
              Map<String, dynamic>.from(json['last_message'] as Map)),
      post:
          json['post'] == null ? null : ChatPost.fromJson(json['post'] as Map),
      user: json['user'] == null
          ? null
          : ChatUser.fromJson(Map<String, dynamic>.from(json['user'] as Map)),
    );

Map<String, dynamic> _$ChatDataToJson(ChatData instance) => <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'adid': const ToString().toJson(instance.adid),
      'toId': const ToString().toJson(instance.toId),
      'last_message_id': const ToString().toJson(instance.last_message_id),
      'create_time': const ToString().toJson(instance.create_time),
      'updated_time': const ToString().toJson(instance.updated_time),
      'updated_date': const ToDateTime().toJson(instance.updated_date),
      'type': const ToString().toJson(instance.type),
      'last_message': instance.last_message?.toJson(),
      'post': instance.post?.toJson(),
      'user': instance.user?.toJson(),
    };

LastMessage _$LastMessageFromJson(Map json) => LastMessage(
      id: const ToString().fromJson(json['id']),
      message: const ToString().fromJson(json['message']),
      send_date: const ToDateTime().fromJson(json['send_date']),
      send_time: const ToString().fromJson(json['send_time']),
      is_read: const ToBool().fromJson(json['is_read']),
      folder: const ToString().fromJson(json['folder']),
      status: const ToString().fromJson(json['status']),
      read_time: const ToString().fromJson(json['read_time']),
      read_date: const ToDateTime().fromJson(json['read_date']),
    );

Map<String, dynamic> _$LastMessageToJson(LastMessage instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'message': const ToString().toJson(instance.message),
      'send_date': const ToDateTime().toJson(instance.send_date),
      'send_time': const ToString().toJson(instance.send_time),
      'is_read': _$JsonConverterToJson<Object?, bool>(
          instance.is_read, const ToBool().toJson),
      'folder': const ToString().toJson(instance.folder),
      'status': const ToString().toJson(instance.status),
      'read_time': const ToString().toJson(instance.read_time),
      'read_date': const ToDateTime().toJson(instance.read_date),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

ChatPost _$ChatPostFromJson(Map json) => ChatPost(
      id: const ToString().fromJson(json['id']),
      title: const ToString().fromJson(json['title']),
      price: const ToString().fromJson(json['price']),
      userid: const ToString().fromJson(json['userid']),
      storeid: const ToString().fromJson(json['storeid']),
      url: const ToString().fromJson(json['url']),
      status: const ToString().fromJson(json['status']),
      status_message: const ToString().fromJson(json['status_message']),
      discount: json['discount'],
      photo_raw: (json['photo_raw'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      photo: const ToString().fromJson(json['photo']),
      photos: (json['photos'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      thumbnail: const ToString().fromJson(json['thumbnail']),
      thumbnails: (json['thumbnails'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      zoon: const ToInt().fromJson(json['zoon']),
      file: const ToString().fromJson(json['file']),
      type: const ToString().fromJson(json['type']),
      size: const ToString().fromJson(json['size']),
      name: const ToString().fromJson(json['name']),
    );

Map<String, dynamic> _$ChatPostToJson(ChatPost instance) => <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'title': const ToString().toJson(instance.title),
      'price': const ToString().toJson(instance.price),
      'userid': const ToString().toJson(instance.userid),
      'storeid': const ToString().toJson(instance.storeid),
      'url': const ToString().toJson(instance.url),
      'status': const ToString().toJson(instance.status),
      'status_message': const ToString().toJson(instance.status_message),
      'discount': instance.discount,
      'photo_raw': instance.photo_raw?.map(const ToString().toJson).toList(),
      'photo': const ToString().toJson(instance.photo),
      'photos': instance.photos?.map(const ToString().toJson).toList(),
      'thumbnail': const ToString().toJson(instance.thumbnail),
      'thumbnails': instance.thumbnails?.map(const ToString().toJson).toList(),
      'lat': instance.lat,
      'lng': instance.lng,
      'zoon': _$JsonConverterToJson<Object?, int>(
          instance.zoon, const ToInt().toJson),
      'file': const ToString().toJson(instance.file),
      'type': const ToString().toJson(instance.type),
      'size': const ToString().toJson(instance.size),
      'name': const ToString().toJson(instance.name),
    };

ChatUser _$ChatUserFromJson(Map json) => ChatUser(
      id: const ToString().fromJson(json['id']),
      name: const ToString().fromJson(json['name']),
      username: const ToString().fromJson(json['username']),
      banned: const ToBool().fromJson(json['banned']),
      banned_detail: const ToString().fromJson(json['banned_detail']),
      photo: json['photo'] == null
          ? null
          : ChatPhoto.fromJson(Map<String, dynamic>.from(json['photo'] as Map)),
      online_status: json['online_status'] == null
          ? null
          : OnlineStatus.fromJson(
              Map<String, dynamic>.from(json['online_status'] as Map)),
      is_verify: const ToBool().fromJson(json['is_verify']),
    );

Map<String, dynamic> _$ChatUserToJson(ChatUser instance) => <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'name': const ToString().toJson(instance.name),
      'username': const ToString().toJson(instance.username),
      'banned': _$JsonConverterToJson<Object?, bool>(
          instance.banned, const ToBool().toJson),
      'banned_detail': const ToString().toJson(instance.banned_detail),
      'photo': instance.photo?.toJson(),
      'online_status': instance.online_status?.toJson(),
      'is_verify': _$JsonConverterToJson<Object?, bool>(
          instance.is_verify, const ToBool().toJson),
    };

OnlineStatus _$OnlineStatusFromJson(Map json) => OnlineStatus(
      is_active: const ToBool().fromJson(json['is_active']),
      last_active: const ToString().fromJson(json['last_active']),
      time: json['time'],
      date: const ToDateTime().fromJson(json['date']),
    );

Map<String, dynamic> _$OnlineStatusToJson(OnlineStatus instance) =>
    <String, dynamic>{
      'is_active': _$JsonConverterToJson<Object?, bool>(
          instance.is_active, const ToBool().toJson),
      'last_active': const ToString().toJson(instance.last_active),
      'time': instance.time,
      'date': const ToDateTime().toJson(instance.date),
    };

ChatPhoto _$ChatPhotoFromJson(Map json) => ChatPhoto(
      url: const ToString().fromJson(json['url']),
      width: const ToString().fromJson(json['width']),
      height: const ToString().fromJson(json['height']),
      small: json['small'] == null
          ? null
          : ChatLarge.fromJson(Map<String, dynamic>.from(json['small'] as Map)),
      medium: json['medium'] == null
          ? null
          : ChatLarge.fromJson(
              Map<String, dynamic>.from(json['medium'] as Map)),
      large: json['large'] == null
          ? null
          : ChatLarge.fromJson(Map<String, dynamic>.from(json['large'] as Map)),
    );

Map<String, dynamic> _$ChatPhotoToJson(ChatPhoto instance) => <String, dynamic>{
      'url': const ToString().toJson(instance.url),
      'width': const ToString().toJson(instance.width),
      'height': const ToString().toJson(instance.height),
      'small': instance.small?.toJson(),
      'medium': instance.medium?.toJson(),
      'large': instance.large?.toJson(),
    };

ChatLarge _$ChatLargeFromJson(Map json) => ChatLarge(
      url: const ToString().fromJson(json['url']),
      width: const ToString().fromJson(json['width']),
      height: const ToString().fromJson(json['height']),
    );

Map<String, dynamic> _$ChatLargeToJson(ChatLarge instance) => <String, dynamic>{
      'url': const ToString().toJson(instance.url),
      'width': const ToString().toJson(instance.width),
      'height': const ToString().toJson(instance.height),
    };
