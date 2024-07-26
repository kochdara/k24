// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nortify_serial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotifySerial _$NotifySerialFromJson(Map json) => NotifySerial(
      data: (json['data'] as List<dynamic>)
          .map((e) => NotifyDatum.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      limit: const ToInt().fromJson(json['limit']),
    );

Map<String, dynamic> _$NotifySerialToJson(NotifySerial instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'limit': const ToInt().toJson(instance.limit),
    };

NotifyBadges _$NotifyBadgesFromJson(Map json) => NotifyBadges(
      notification: const ToString().fromJson(json['notification']),
      chat: const ToString().fromJson(json['chat']),
      comment: const ToString().fromJson(json['comment']),
    );

Map<String, dynamic> _$NotifyBadgesToJson(NotifyBadges instance) =>
    <String, dynamic>{
      'notification': const ToString().toJson(instance.notification),
      'chat': const ToString().toJson(instance.chat),
      'comment': const ToString().toJson(instance.comment),
    };

NotifyDatum _$NotifyDatumFromJson(Map json) => NotifyDatum(
      notid: const ToString().fromJson(json['notid']),
      title: const ToString().fromJson(json['title']),
      message: const ToString().fromJson(json['message']),
      is_open: const ToBool().fromJson(json['is_open']),
      open_date: const ToDateTime().fromJson(json['open_date']),
      send_date: const ToDateTime().fromJson(json['send_date']),
      id: const ToString().fromJson(json['id']),
      id_type: json['id_type'],
      type: const ToString().fromJson(json['type']),
      data: json['data'] == null
          ? null
          : NotifyData.fromJson(Map<String, dynamic>.from(json['data'] as Map)),
    );

Map<String, dynamic> _$NotifyDatumToJson(NotifyDatum instance) =>
    <String, dynamic>{
      'notid': const ToString().toJson(instance.notid),
      'title': const ToString().toJson(instance.title),
      'message': const ToString().toJson(instance.message),
      'is_open': _$JsonConverterToJson<Object?, bool>(
          instance.is_open, const ToBool().toJson),
      'open_date': const ToDateTime().toJson(instance.open_date),
      'send_date': const ToDateTime().toJson(instance.send_date),
      'id': const ToString().toJson(instance.id),
      'id_type': instance.id_type,
      'type': const ToString().toJson(instance.type),
      'data': instance.data?.toJson(),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

NotifyData _$NotifyDataFromJson(Map json) => NotifyData(
      type: const ToString().fromJson(json['type']),
      post: json['post'] == null ? null : Data_.fromJson(json['post'] as Map),
      user: json['user'] == null
          ? null
          : User_.fromJson(Map<String, dynamic>.from(json['user'] as Map)),
      comment: json['comment'] == null
          ? null
          : CommentDatum.fromJson(
              Map<String, dynamic>.from(json['comment'] as Map)),
      id: const ToString().fromJson(json['id']),
      adid: const ToString().fromJson(json['adid']),
    );

Map<String, dynamic> _$NotifyDataToJson(NotifyData instance) =>
    <String, dynamic>{
      'type': const ToString().toJson(instance.type),
      'post': instance.post?.toJson(),
      'user': instance.user?.toJson(),
      'comment': instance.comment?.toJson(),
      'id': const ToString().toJson(instance.id),
      'adid': const ToString().toJson(instance.adid),
    };
