// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_serial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfileSerial _$EditProfileSerialFromJson(Map json) => EditProfileSerial(
      data: EditProfileData.fromJson(
          Map<String, dynamic>.from(json['data'] as Map)),
    );

Map<String, dynamic> _$EditProfileSerialToJson(EditProfileSerial instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

UploadData _$UploadDataFromJson(Map json) => UploadData(
      status: const ToString().fromJson(json['status']),
      message: const ToString().fromJson(json['message']),
      image: const ToString().fromJson(json['image']),
      thumbnail: const ToString().fromJson(json['thumbnail']),
      photo: json['photo'] == null
          ? null
          : IconSerial.fromJson(
              Map<String, dynamic>.from(json['photo'] as Map)),
    );

Map<String, dynamic> _$UploadDataToJson(UploadData instance) =>
    <String, dynamic>{
      'status': const ToString().toJson(instance.status),
      'message': const ToString().toJson(instance.message),
      'image': const ToString().toJson(instance.image),
      'thumbnail': const ToString().toJson(instance.thumbnail),
      'photo': instance.photo?.toJson(),
    };

EditProfileData _$EditProfileDataFromJson(Map json) => EditProfileData(
      id: const ToString().fromJson(json['id']),
      username: const ToString().fromJson(json['username']),
      first_name: const ToString().fromJson(json['first_name']),
      last_name: const ToString().fromJson(json['last_name']),
      name: const ToString().fromJson(json['name']),
      company: const ToString().fromJson(json['company']),
      photo: json['photo'] == null
          ? null
          : IconSerial.fromJson(
              Map<String, dynamic>.from(json['photo'] as Map)),
      cover: json['cover'] == null
          ? null
          : IconSerial.fromJson(
              Map<String, dynamic>.from(json['cover'] as Map)),
      dob: const ToDateTime().fromJson(json['dob']),
      gender: const ToString().fromJson(json['gender']),
      auto_update_profile_picture:
          const ToBool().fromJson(json['auto_update_profile_picture']),
      contact: json['contact'] == null
          ? null
          : EditProfileContact.fromJson(
              Map<String, dynamic>.from(json['contact'] as Map)),
    );

Map<String, dynamic> _$EditProfileDataToJson(EditProfileData instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'username': const ToString().toJson(instance.username),
      'first_name': const ToString().toJson(instance.first_name),
      'last_name': const ToString().toJson(instance.last_name),
      'name': const ToString().toJson(instance.name),
      'company': const ToString().toJson(instance.company),
      'photo': instance.photo?.toJson(),
      'cover': instance.cover?.toJson(),
      'dob': const ToDateTime().toJson(instance.dob),
      'gender': const ToString().toJson(instance.gender),
      'auto_update_profile_picture': _$JsonConverterToJson<Object?, bool>(
          instance.auto_update_profile_picture, const ToBool().toJson),
      'contact': instance.contact?.toJson(),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

EditProfileContact _$EditProfileContactFromJson(Map json) => EditProfileContact(
      phone: (json['phone'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      email: const ToString().fromJson(json['email']),
      map: json['map'] == null
          ? null
          : MapClass.fromJson(Map<String, dynamic>.from(json['map'] as Map)),
      location: json['location'] == null
          ? null
          : CommuneUser.fromJson(
              Map<String, dynamic>.from(json['location'] as Map)),
      commune: json['commune'] == null
          ? null
          : CommuneUser.fromJson(
              Map<String, dynamic>.from(json['commune'] as Map)),
      district: json['district'] == null
          ? null
          : CommuneUser.fromJson(
              Map<String, dynamic>.from(json['district'] as Map)),
      address: const ToString().fromJson(json['address']),
    );

Map<String, dynamic> _$EditProfileContactToJson(EditProfileContact instance) =>
    <String, dynamic>{
      'phone': instance.phone?.map(const ToString().toJson).toList(),
      'email': const ToString().toJson(instance.email),
      'map': instance.map?.toJson(),
      'location': instance.location?.toJson(),
      'commune': instance.commune?.toJson(),
      'district': instance.district?.toJson(),
      'address': const ToString().toJson(instance.address),
    };
