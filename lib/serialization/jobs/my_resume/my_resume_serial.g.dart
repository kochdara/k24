// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_resume_serial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalSerial _$PersonalSerialFromJson(Map json) => PersonalSerial(
      status: const ToString().fromJson(json['status']),
      message: const ToString().fromJson(json['message']),
      data: json['data'],
    );

Map<String, dynamic> _$PersonalSerialToJson(PersonalSerial instance) =>
    <String, dynamic>{
      'status': const ToString().toJson(instance.status),
      'message': const ToString().toJson(instance.message),
      'data': instance.data,
    };

MyResumeSerial _$MyResumeSerialFromJson(Map json) => MyResumeSerial(
      points: json['points'] == null
          ? null
          : MyResumePoints.fromJson(json['points'] as Map?),
      data: json['data'] == null
          ? null
          : MyResumeData.fromJson(json['data'] as Map?),
    );

Map<String, dynamic> _$MyResumeSerialToJson(MyResumeSerial instance) =>
    <String, dynamic>{
      'points': instance.points?.toJson(),
      'data': instance.data?.toJson(),
    };

MyResumeData _$MyResumeDataFromJson(Map json) => MyResumeData(
      id: const ToString().fromJson(json['id']),
      personal_details: json['personal_details'] == null
          ? null
          : ResumePersonalDetails.fromJson(json['personal_details'] as Map?),
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
      references: (json['references'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ResumeReferences.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      hobbies: const ToString().fromJson(json['hobbies']),
      summary: const ToString().fromJson(json['summary']),
      attachment: json['attachment'] == null
          ? null
          : MyResumeAttachment.fromJson(json['attachment'] as Map?),
      preference: json['preference'] == null
          ? null
          : MyResumePreference.fromJson(json['preference'] as Map?),
    );

Map<String, dynamic> _$MyResumeDataToJson(MyResumeData instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'personal_details': instance.personal_details?.toJson(),
      'educations': instance.educations?.map((e) => e?.toJson()).toList(),
      'experiences': instance.experiences?.map((e) => e?.toJson()).toList(),
      'skills': instance.skills?.map((e) => e?.toJson()).toList(),
      'languages': instance.languages?.map((e) => e?.toJson()).toList(),
      'references': instance.references?.map((e) => e?.toJson()).toList(),
      'hobbies': const ToString().toJson(instance.hobbies),
      'summary': const ToString().toJson(instance.summary),
      'attachment': instance.attachment?.toJson(),
      'preference': instance.preference?.toJson(),
    };

MyResumePoints _$MyResumePointsFromJson(Map json) => MyResumePoints(
      current: const ToString().fromJson(json['current']),
      total: const ToInt().fromJson(json['total']),
      suggestions: (json['suggestions'] as List<dynamic>?)
          ?.map(
              (e) => e == null ? null : MyResumeSuggestion.fromJson(e as Map?))
          .toList(),
    );

Map<String, dynamic> _$MyResumePointsToJson(MyResumePoints instance) =>
    <String, dynamic>{
      'current': const ToString().toJson(instance.current),
      'total': _$JsonConverterToJson<Object?, int>(
          instance.total, const ToInt().toJson),
      'suggestions': instance.suggestions?.map((e) => e?.toJson()).toList(),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

MyResumeSuggestion _$MyResumeSuggestionFromJson(Map json) => MyResumeSuggestion(
      type: const ToString().fromJson(json['type']),
      field: const ToString().fromJson(json['field']),
      name: const ToString().fromJson(json['name']),
    );

Map<String, dynamic> _$MyResumeSuggestionToJson(MyResumeSuggestion instance) =>
    <String, dynamic>{
      'type': const ToString().toJson(instance.type),
      'field': const ToString().toJson(instance.field),
      'name': const ToString().toJson(instance.name),
    };

MyResumeAttachment _$MyResumeAttachmentFromJson(Map json) => MyResumeAttachment(
      id: const ToString().fromJson(json['id']),
      name: const ToString().fromJson(json['name']),
      file: const ToString().fromJson(json['file']),
      type: const ToString().fromJson(json['type']),
      size: const ToInt().fromJson(json['size']),
      created_at: const ToDateTime().fromJson(json['created_at']),
      url: const ToString().fromJson(json['url']),
    );

Map<String, dynamic> _$MyResumeAttachmentToJson(MyResumeAttachment instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'name': const ToString().toJson(instance.name),
      'file': const ToString().toJson(instance.file),
      'type': const ToString().toJson(instance.type),
      'size': _$JsonConverterToJson<Object?, int>(
          instance.size, const ToInt().toJson),
      'created_at': const ToDateTime().toJson(instance.created_at),
      'url': const ToString().toJson(instance.url),
    };

MyResumePreference _$MyResumePreferenceFromJson(Map json) => MyResumePreference(
      open_job: const ToBool().fromJson(json['open_job']),
      position: const ToString().fromJson(json['position']),
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => e == null ? null : MyResumeCategory.fromJson(e as Map?))
          .toList(),
      location: (json['location'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : Location_.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      job_type: (json['job_type'] as List<dynamic>?)
          ?.map((e) => e == null ? null : MyResumeJobType.fromJson(e as Map?))
          .toList(),
    );

Map<String, dynamic> _$MyResumePreferenceToJson(MyResumePreference instance) =>
    <String, dynamic>{
      'open_job': _$JsonConverterToJson<Object?, bool>(
          instance.open_job, const ToBool().toJson),
      'position': const ToString().toJson(instance.position),
      'category': instance.category?.map((e) => e?.toJson()).toList(),
      'location': instance.location?.map((e) => e?.toJson()).toList(),
      'job_type': instance.job_type?.map((e) => e?.toJson()).toList(),
    };

MyResumeCategory _$MyResumeCategoryFromJson(Map json) => MyResumeCategory(
      id: const ToString().fromJson(json['id']),
      en_name: const ToString().fromJson(json['en_name']),
      km_name: const ToString().fromJson(json['km_name']),
      slug: const ToString().fromJson(json['slug']),
      parent: const ToString().fromJson(json['parent']),
      parent_data: json['parent_data'] == null
          ? null
          : Location_.fromJson(
              Map<String, dynamic>.from(json['parent_data'] as Map)),
    );

Map<String, dynamic> _$MyResumeCategoryToJson(MyResumeCategory instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'en_name': const ToString().toJson(instance.en_name),
      'km_name': const ToString().toJson(instance.km_name),
      'slug': const ToString().toJson(instance.slug),
      'parent': const ToString().toJson(instance.parent),
      'parent_data': instance.parent_data?.toJson(),
    };

MyResumeJobType _$MyResumeJobTypeFromJson(Map json) => MyResumeJobType(
      title: const ToString().fromJson(json['title']),
      value: const ToString().fromJson(json['value']),
    );

Map<String, dynamic> _$MyResumeJobTypeToJson(MyResumeJobType instance) =>
    <String, dynamic>{
      'title': const ToString().toJson(instance.title),
      'value': const ToString().toJson(instance.value),
    };
