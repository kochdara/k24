// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy_serial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivacySerial _$PrivacySerialFromJson(Map json) => PrivacySerial(
      data: json['data'] == null
          ? null
          : PrivacyData.fromJson(
              Map<String, dynamic>.from(json['data'] as Map)),
    );

Map<String, dynamic> _$PrivacySerialToJson(PrivacySerial instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
    };

PrivacyData _$PrivacyDataFromJson(Map json) => PrivacyData(
      gender: const ToString().fromJson(json['gender']),
      dob: const ToString().fromJson(json['dob']),
      phone: const ToString().fromJson(json['phone']),
      email: const ToString().fromJson(json['email']),
      location: const ToString().fromJson(json['location']),
    );

Map<String, dynamic> _$PrivacyDataToJson(PrivacyData instance) =>
    <String, dynamic>{
      'gender': const ToString().toJson(instance.gender),
      'dob': const ToString().toJson(instance.dob),
      'phone': const ToString().toJson(instance.phone),
      'email': const ToString().toJson(instance.email),
      'location': const ToString().toJson(instance.location),
    };
