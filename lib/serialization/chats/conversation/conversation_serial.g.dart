// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_serial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadTMPSerial _$UploadTMPSerialFromJson(Map<String, dynamic> json) =>
    UploadTMPSerial(
      status: const ToString().fromJson(json['status']),
      message: const ToString().fromJson(json['message']),
      file: const ToString().fromJson(json['file']),
      type: const ToString().fromJson(json['type']),
      file_type: const ToString().fromJson(json['file_type']),
      size: (json['size'] as num?)?.toDouble(),
      thumbnail: const ToString().fromJson(json['thumbnail']),
    );

Map<String, dynamic> _$UploadTMPSerialToJson(UploadTMPSerial instance) =>
    <String, dynamic>{
      'status': const ToString().toJson(instance.status),
      'message': const ToString().toJson(instance.message),
      'file': const ToString().toJson(instance.file),
      'file_type': const ToString().toJson(instance.file_type),
      'type': const ToString().toJson(instance.type),
      'size': instance.size,
      'thumbnail': const ToString().toJson(instance.thumbnail),
    };

ConSerial _$ConSerialFromJson(Map json) => ConSerial(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null ? null : ConData.fromJson(e as Map?))
          .toList(),
      blocked: json['blocked'] == null
          ? null
          : Blocked.fromJson(json['blocked'] as Map?),
    );

Map<String, dynamic> _$ConSerialToJson(ConSerial instance) => <String, dynamic>{
      'data': instance.data?.map((e) => e?.toJson()).toList(),
      'blocked': instance.blocked?.toJson(),
    };

Blocked _$BlockedFromJson(Map json) => Blocked(
      is_block: const ToBool().fromJson(json['is_block']),
    );

Map<String, dynamic> _$BlockedToJson(Blocked instance) => <String, dynamic>{
      'is_block': _$JsonConverterToJson<Object?, bool>(
          instance.is_block, const ToBool().toJson),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

ConData _$ConDataFromJson(Map json) => ConData(
      id: const ToString().fromJson(json['id']),
      topic_id: const ToString().fromJson(json['topic_id']),
      type: const ToString().fromJson(json['type']),
      message: const ToString().fromJson(json['message']),
      send_time: const ToString().fromJson(json['send_time']),
      send_date: const ToDateTime().fromJson(json['send_date']),
      is_read: const ToBool().fromJson(json['is_read']),
      folder: const ToString().fromJson(json['folder']),
      data: json['data'],
      read_time: const ToString().fromJson(json['read_time']),
      read_date: const ToDateTime().fromJson(json['read_date']),
    );

Map<String, dynamic> _$ConDataToJson(ConData instance) => <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'topic_id': const ToString().toJson(instance.topic_id),
      'type': const ToString().toJson(instance.type),
      'message': const ToString().toJson(instance.message),
      'send_time': const ToString().toJson(instance.send_time),
      'send_date': const ToDateTime().toJson(instance.send_date),
      'is_read': _$JsonConverterToJson<Object?, bool>(
          instance.is_read, const ToBool().toJson),
      'folder': const ToString().toJson(instance.folder),
      'data': instance.data,
      'read_time': const ToString().toJson(instance.read_time),
      'read_date': const ToDateTime().toJson(instance.read_date),
    };

DataMore _$DataMoreFromJson(Map json) => DataMore(
      name: const ToString().fromJson(json['name']),
      company: const ToString().fromJson(json['company']),
      phone: (json['phone'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      email: const ToString().fromJson(json['email']),
      location: json['location'] == null
          ? null
          : Location_.fromJson(
              Map<String, dynamic>.from(json['location'] as Map)),
      address: const ToString().fromJson(json['address']),
      map: json['map'],
      phone_white_operator: (json['phone_white_operator'] as List<dynamic>?)
          ?.map(
              (e) => e == null ? null : PhoneWhiteOperator.fromJson(e as Map?))
          .toList(),
    );

Map<String, dynamic> _$DataMoreToJson(DataMore instance) => <String, dynamic>{
      'name': const ToString().toJson(instance.name),
      'company': const ToString().toJson(instance.company),
      'phone': instance.phone?.map(const ToString().toJson).toList(),
      'email': const ToString().toJson(instance.email),
      'location': instance.location?.toJson(),
      'address': const ToString().toJson(instance.address),
      'map': instance.map,
      'phone_white_operator':
          instance.phone_white_operator?.map((e) => e?.toJson()).toList(),
    };

ConImage _$ConImageFromJson(Map json) => ConImage(
      image: const ToString().fromJson(json['image']),
      thumbnail: const ToString().fromJson(json['thumbnail']),
      width: const ToString().fromJson(json['width']),
      height: const ToString().fromJson(json['height']),
      type: const ToString().fromJson(json['type']),
      size: const ToString().fromJson(json['size']),
      name: const ToString().fromJson(json['name']),
      small: json['small'] == null
          ? null
          : SizeOfImage.fromJson(
              Map<String, dynamic>.from(json['small'] as Map)),
      medium: json['medium'] == null
          ? null
          : SizeOfImage.fromJson(
              Map<String, dynamic>.from(json['medium'] as Map)),
      large: json['large'] == null
          ? null
          : SizeOfImage.fromJson(
              Map<String, dynamic>.from(json['large'] as Map)),
    );

Map<String, dynamic> _$ConImageToJson(ConImage instance) => <String, dynamic>{
      'image': const ToString().toJson(instance.image),
      'thumbnail': const ToString().toJson(instance.thumbnail),
      'width': const ToString().toJson(instance.width),
      'height': const ToString().toJson(instance.height),
      'type': const ToString().toJson(instance.type),
      'size': const ToString().toJson(instance.size),
      'name': const ToString().toJson(instance.name),
      'small': instance.small?.toJson(),
      'medium': instance.medium?.toJson(),
      'large': instance.large?.toJson(),
    };

ResumeData _$ResumeDataFromJson(Map json) => ResumeData(
      id: const ToString().fromJson(json['id']),
      userid: const ToString().fromJson(json['userid']),
      name: const ToString().fromJson(json['name']),
      nationality: const ToString().fromJson(json['nationality']),
      photo: json['photo'] == null
          ? null
          : IconSerial.fromJson(
              Map<String, dynamic>.from(json['photo'] as Map)),
      education_level: json['education_level'] == null
          ? null
          : ResumeEduLevel.fromJson(json['education_level'] as Map?),
      position: const ToString().fromJson(json['position']),
      work_experience: const ToString().fromJson(json['work_experience']),
      sender: const ToString().fromJson(json['sender']),
      key: const ToString().fromJson(json['key']),
    );

Map<String, dynamic> _$ResumeDataToJson(ResumeData instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'userid': const ToString().toJson(instance.userid),
      'name': const ToString().toJson(instance.name),
      'nationality': const ToString().toJson(instance.nationality),
      'photo': instance.photo?.toJson(),
      'education_level': instance.education_level?.toJson(),
      'position': const ToString().toJson(instance.position),
      'work_experience': const ToString().toJson(instance.work_experience),
      'sender': const ToString().toJson(instance.sender),
      'key': const ToString().toJson(instance.key),
    };
