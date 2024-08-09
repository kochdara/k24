// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'likes_serial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeSerial _$LikeSerialFromJson(Map json) => LikeSerial(
      limit: const ToInt().fromJson(json['limit']),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : LikesDatum.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$LikeSerialToJson(LikeSerial instance) =>
    <String, dynamic>{
      'limit': _$JsonConverterToJson<Object?, int>(
          instance.limit, const ToInt().toJson),
      'data': instance.data?.map((e) => e?.toJson()).toList(),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

LikesDatum _$LikesDatumFromJson(Map json) => LikesDatum(
      id: const ToString().fromJson(json['id']),
      type: const ToString().fromJson(json['type']),
      data: json['data'],
      date: const ToDateTime().fromJson(json['date']),
    );

Map<String, dynamic> _$LikesDatumToJson(LikesDatum instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'type': const ToString().toJson(instance.type),
      'data': instance.data,
      'date': const ToDateTime().toJson(instance.date),
    };

LikesData _$LikesDataFromJson(Map json) => LikesData(
      id: const ToString().fromJson(json['id']),
      title: const ToString().fromJson(json['title']),
      price: const ToString().fromJson(json['price']),
      userid: const ToString().fromJson(json['userid']),
      contact: json['contact'] == null
          ? null
          : LikesContact.fromJson(
              Map<String, dynamic>.from(json['contact'] as Map)),
      link: const ToString().fromJson(json['link']),
      photo: const ToString().fromJson(json['photo']),
      photos: (json['photos'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      thumbnail: const ToString().fromJson(json['thumbnail']),
      thumbnails: (json['thumbnails'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
    );

Map<String, dynamic> _$LikesDataToJson(LikesData instance) => <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'title': const ToString().toJson(instance.title),
      'price': const ToString().toJson(instance.price),
      'userid': const ToString().toJson(instance.userid),
      'contact': instance.contact?.toJson(),
      'link': const ToString().toJson(instance.link),
      'photo': const ToString().toJson(instance.photo),
      'photos': instance.photos?.map(const ToString().toJson).toList(),
      'thumbnail': const ToString().toJson(instance.thumbnail),
      'thumbnails': instance.thumbnails?.map(const ToString().toJson).toList(),
    };

LikesContact _$LikesContactFromJson(Map json) => LikesContact(
      name: const ToString().fromJson(json['name']),
      location: json['location'] == null
          ? null
          : Location_.fromJson(
              Map<String, dynamic>.from(json['location'] as Map)),
      phone: (json['phone'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
    );

Map<String, dynamic> _$LikesContactToJson(LikesContact instance) =>
    <String, dynamic>{
      'name': const ToString().toJson(instance.name),
      'location': instance.location?.toJson(),
      'phone': instance.phone?.map(const ToString().toJson).toList(),
    };
