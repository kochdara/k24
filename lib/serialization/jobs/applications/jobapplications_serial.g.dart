// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobapplications_serial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobAppSerial _$JobAppSerialFromJson(Map json) => JobAppSerial(
      limit: const ToInt().fromJson(json['limit']),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => JobAppData.fromJson(e as Map?))
          .toList(),
    );

Map<String, dynamic> _$JobAppSerialToJson(JobAppSerial instance) =>
    <String, dynamic>{
      'limit': _$JsonConverterToJson<Object?, int>(
          instance.limit, const ToInt().toJson),
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

GetBadgesSerial _$GetBadgesSerialFromJson(Map json) => GetBadgesSerial(
      data: json['data'] == null
          ? null
          : GetBadgesData.fromJson(
              Map<String, dynamic>.from(json['data'] as Map)),
    );

Map<String, dynamic> _$GetBadgesSerialToJson(GetBadgesSerial instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
    };

GetBadgesData _$GetBadgesDataFromJson(Map json) => GetBadgesData(
      total: json['total'] as String?,
      newCount: json['newCount'] as String?,
    );

Map<String, dynamic> _$GetBadgesDataToJson(GetBadgesData instance) =>
    <String, dynamic>{
      'total': instance.total,
      'newCount': instance.newCount,
    };

JobAppData _$JobAppDataFromJson(Map json) => JobAppData(
      id: const ToString().fromJson(json['id']),
      apply_date: const ToDateTime().fromJson(json['apply_date']),
      status: json['status'] == null
          ? null
          : ResumeEduLevel.fromJson(json['status'] as Map?),
      application_type: const ToString().fromJson(json['application_type']),
      post: json['post'] == null ? null : Data_.fromJson(json['post'] as Map),
      application: json['application'] == null
          ? null
          : JobAppApplication.fromJson(json['application'] as Map?),
    );

Map<String, dynamic> _$JobAppDataToJson(JobAppData instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'apply_date': const ToDateTime().toJson(instance.apply_date),
      'status': instance.status?.toJson(),
      'application_type': const ToString().toJson(instance.application_type),
      'post': instance.post?.toJson(),
      'application': instance.application?.toJson(),
    };

JobAppApplication _$JobAppApplicationFromJson(Map json) => JobAppApplication(
      name: const ToString().fromJson(json['name']),
      phone: (json['phone'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      phone_white_operator: (json['phone_white_operator'] as List<dynamic>?)
          ?.map(
              (e) => e == null ? null : PhoneWhiteOperator.fromJson(e as Map?))
          .toList(),
      email: const ToString().fromJson(json['email']),
      userid: const ToString().fromJson(json['userid']),
      file: const ToString().fromJson(json['file']),
      cv: const ToString().fromJson(json['cv']),
      personal_details: json['personal_details'] == null
          ? null
          : ResumePersonalDetails.fromJson(json['personal_details'] as Map?),
      summary: const ToString().fromJson(json['summary']),
      educations: (json['educations'] as List<dynamic>?)
          ?.map((e) => e == null ? null : ResumeEducation.fromJson(e as Map?))
          .toList(),
      experiences: (json['experiences'] as List<dynamic>?)
          ?.map((e) => e == null ? null : ResumeExperience.fromJson(e as Map?))
          .toList(),
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => e == null ? null : ResumeLanguage.fromJson(e as Map?))
          .toList(),
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e == null ? null : ResumeLanguage.fromJson(e as Map?))
          .toList(),
      hobbies: const ToString().fromJson(json['hobbies']),
      references: (json['references'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ResumeReferences.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$JobAppApplicationToJson(JobAppApplication instance) =>
    <String, dynamic>{
      'name': const ToString().toJson(instance.name),
      'phone': instance.phone?.map(const ToString().toJson).toList(),
      'phone_white_operator':
          instance.phone_white_operator?.map((e) => e?.toJson()).toList(),
      'email': const ToString().toJson(instance.email),
      'userid': const ToString().toJson(instance.userid),
      'file': const ToString().toJson(instance.file),
      'cv': const ToString().toJson(instance.cv),
      'personal_details': instance.personal_details?.toJson(),
      'summary': const ToString().toJson(instance.summary),
      'educations': instance.educations?.map((e) => e?.toJson()).toList(),
      'experiences': instance.experiences?.map((e) => e?.toJson()).toList(),
      'skills': instance.skills?.map((e) => e?.toJson()).toList(),
      'languages': instance.languages?.map((e) => e?.toJson()).toList(),
      'hobbies': const ToString().toJson(instance.hobbies),
      'references': instance.references?.map((e) => e?.toJson()).toList(),
    };
