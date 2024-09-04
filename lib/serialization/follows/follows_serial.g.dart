// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follows_serial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowsSerial _$FollowsSerialFromJson(Map json) => FollowsSerial(
      total: const ToString().fromJson(json['total']),
      limit: const ToInt().fromJson(json['limit']),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null ? null : FollowsDatum.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$FollowsSerialToJson(FollowsSerial instance) =>
    <String, dynamic>{
      'total': const ToString().toJson(instance.total),
      'limit': _$JsonConverterToJson<Object?, int>(
          instance.limit, const ToInt().toJson),
      'data': instance.data?.map((e) => e?.toJson()).toList(),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

FollowsDatum _$FollowsDatumFromJson(Map json) => FollowsDatum(
      id: const ToString().fromJson(json['id']),
      name: const ToString().fromJson(json['name']),
      username: const ToString().fromJson(json['username']),
      photo: json['photo'] == null
          ? null
          : IconSerial.fromJson(
              Map<String, dynamic>.from(json['photo'] as Map)),
      type: const ToString().fromJson(json['type']),
    );

Map<String, dynamic> _$FollowsDatumToJson(FollowsDatum instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'name': const ToString().toJson(instance.name),
      'username': const ToString().toJson(instance.username),
      'photo': instance.photo?.toJson(),
      'type': const ToString().toJson(instance.type),
    };
