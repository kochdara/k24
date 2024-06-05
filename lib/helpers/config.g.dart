// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigState _$ConfigStateFromJson(Map json) => ConfigState(
      status: const ToInt().fromJson(json['status']),
      message: const ToString().fromJson(json['message']),
      result: json['result'],
      data: json['data'],
      code: const ToInt().fromJson(json['code']),
    );

Map<String, dynamic> _$ConfigStateToJson(ConfigState instance) =>
    <String, dynamic>{
      'status': _$JsonConverterToJson<Object?, int>(
          instance.status, const ToInt().toJson),
      'message': const ToString().toJson(instance.message),
      'result': instance.result,
      'data': instance.data,
      'code': _$JsonConverterToJson<Object?, int>(
          instance.code, const ToInt().toJson),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
