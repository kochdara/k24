// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_job_serial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplyJobSerial _$ApplyJobSerialFromJson(Map json) => ApplyJobSerial(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null ? null : ApplyJobDatum.fromJson(e as Map?))
          .toList(),
      limit: const ToInt().fromJson(json['limit']),
    );

Map<String, dynamic> _$ApplyJobSerialToJson(ApplyJobSerial instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e?.toJson()).toList(),
      'limit': _$JsonConverterToJson<Object?, int>(
          instance.limit, const ToInt().toJson),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

ApplyJobDatum _$ApplyJobDatumFromJson(Map json) => ApplyJobDatum(
      id: const ToString().fromJson(json['id']),
      apply_date: const ToDateTime().fromJson(json['apply_date']),
      status: json['status'] == null
          ? null
          : ApplyJobStatus.fromJson(json['status'] as Map?),
      post: json['post'] == null
          ? null
          : ApplyJobPost.fromJson(json['post'] as Map?),
    );

Map<String, dynamic> _$ApplyJobDatumToJson(ApplyJobDatum instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'apply_date': const ToDateTime().toJson(instance.apply_date),
      'status': instance.status?.toJson(),
      'post': instance.post?.toJson(),
    };

ApplyJobPost _$ApplyJobPostFromJson(Map json) => ApplyJobPost(
      id: const ToString().fromJson(json['id']),
      title: const ToString().fromJson(json['title']),
      company: const ToString().fromJson(json['company']),
      logo: const ToString().fromJson(json['logo']),
      type: const ToString().fromJson(json['type']),
      salary: const ToString().fromJson(json['salary']),
      status: const ToString().fromJson(json['status']),
      status_message: const ToString().fromJson(json['status_message']),
      location: json['location'] == null
          ? null
          : Location_.fromJson(
              Map<String, dynamic>.from(json['location'] as Map)),
    );

Map<String, dynamic> _$ApplyJobPostToJson(ApplyJobPost instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'title': const ToString().toJson(instance.title),
      'company': const ToString().toJson(instance.company),
      'logo': const ToString().toJson(instance.logo),
      'type': const ToString().toJson(instance.type),
      'salary': const ToString().toJson(instance.salary),
      'status': const ToString().toJson(instance.status),
      'status_message': const ToString().toJson(instance.status_message),
      'location': instance.location?.toJson(),
    };

ApplyJobStatus _$ApplyJobStatusFromJson(Map json) => ApplyJobStatus(
      value: const ToString().fromJson(json['value']),
      title: const ToString().fromJson(json['title']),
    );

Map<String, dynamic> _$ApplyJobStatusToJson(ApplyJobStatus instance) =>
    <String, dynamic>{
      'value': const ToString().toJson(instance.value),
      'title': const ToString().toJson(instance.title),
    };
