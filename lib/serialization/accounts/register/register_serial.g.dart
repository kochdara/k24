// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_serial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterSerial _$RegisterSerialFromJson(Map json) => RegisterSerial(
      next_page: json['next_page'] == null
          ? null
          : RegisterNextPage.fromJson(
              Map<String, dynamic>.from(json['next_page'] as Map)),
      message: const ToString().fromJson(json['message']),
    );

Map<String, dynamic> _$RegisterSerialToJson(RegisterSerial instance) =>
    <String, dynamic>{
      'next_page': instance.next_page?.toJson(),
      'message': const ToString().toJson(instance.message),
    };

RegisterNextPage _$RegisterNextPageFromJson(Map json) => RegisterNextPage(
      page: const ToString().fromJson(json['page']),
      recipient_phone: const ToString().fromJson(json['recipient_phone']),
      phone: const ToString().fromJson(json['phone']),
      code: const ToString().fromJson(json['code']),
      message: const ToString().fromJson(json['message']),
      token: const ToString().fromJson(json['token']),
      data: json['data'] == null
          ? null
          : RegisterData.fromJson(
              Map<String, dynamic>.from(json['data'] as Map)),
    );

Map<String, dynamic> _$RegisterNextPageToJson(RegisterNextPage instance) =>
    <String, dynamic>{
      'page': const ToString().toJson(instance.page),
      'recipient_phone': const ToString().toJson(instance.recipient_phone),
      'phone': const ToString().toJson(instance.phone),
      'code': const ToString().toJson(instance.code),
      'message': const ToString().toJson(instance.message),
      'token': const ToString().toJson(instance.token),
      'data': instance.data?.toJson(),
    };

RegisterData _$RegisterDataFromJson(Map json) => RegisterData(
      verify: json['verify'] == null
          ? null
          : RegisterVerify.fromJson(
              Map<String, dynamic>.from(json['verify'] as Map)),
    );

Map<String, dynamic> _$RegisterDataToJson(RegisterData instance) =>
    <String, dynamic>{
      'verify': instance.verify?.toJson(),
    };

RegisterVerify _$RegisterVerifyFromJson(Map json) => RegisterVerify(
      type: const ToString().fromJson(json['type']),
      value: const ToString().fromJson(json['value']),
    );

Map<String, dynamic> _$RegisterVerifyToJson(RegisterVerify instance) =>
    <String, dynamic>{
      'type': const ToString().toJson(instance.type),
      'value': const ToString().toJson(instance.value),
    };
