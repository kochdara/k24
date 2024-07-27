// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_serial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResumeDetailSerial _$ResumeDetailSerialFromJson(Map json) => ResumeDetailSerial(
      data: ResumeData.fromJson(json['data'] as Map?),
    );

Map<String, dynamic> _$ResumeDetailSerialToJson(ResumeDetailSerial instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

ResumeData _$ResumeDataFromJson(Map json) => ResumeData(
      id: const ToString().fromJson(json['id']),
      userid: const ToString().fromJson(json['userid']),
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
      hobbies: const ToString().fromJson(json['hobbies']),
      summary: const ToString().fromJson(json['summary']),
      preference: json['preference'] == null
          ? null
          : ResumePreference.fromJson(json['preference'] as Map?),
      saved: const ToBool().fromJson(json['saved']),
    );

Map<String, dynamic> _$ResumeDataToJson(ResumeData instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'userid': const ToString().toJson(instance.userid),
      'personal_details': instance.personal_details?.toJson(),
      'educations': instance.educations?.map((e) => e?.toJson()).toList(),
      'experiences': instance.experiences?.map((e) => e?.toJson()).toList(),
      'skills': instance.skills?.map((e) => e?.toJson()).toList(),
      'languages': instance.languages?.map((e) => e?.toJson()).toList(),
      'hobbies': const ToString().toJson(instance.hobbies),
      'summary': const ToString().toJson(instance.summary),
      'preference': instance.preference?.toJson(),
      'saved': _$JsonConverterToJson<Object?, bool>(
          instance.saved, const ToBool().toJson),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

ResumeEducation _$ResumeEducationFromJson(Map json) => ResumeEducation(
      id: const ToString().fromJson(json['id']),
      school: const ToString().fromJson(json['school']),
      degree: json['degree'] == null
          ? null
          : ResumeEduLevel.fromJson(json['degree'] as Map?),
      major: const ToString().fromJson(json['major']),
      description: json['description'],
      start_date: const ToDateTime().fromJson(json['start_date']),
      end_date: const ToDateTime().fromJson(json['end_date']),
    );

Map<String, dynamic> _$ResumeEducationToJson(ResumeEducation instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'school': const ToString().toJson(instance.school),
      'degree': instance.degree?.toJson(),
      'major': const ToString().toJson(instance.major),
      'description': instance.description,
      'start_date': const ToDateTime().toJson(instance.start_date),
      'end_date': const ToDateTime().toJson(instance.end_date),
    };

ResumeEduLevel _$ResumeEduLevelFromJson(Map json) => ResumeEduLevel(
      value: const ToString().fromJson(json['value']),
      title: const ToString().fromJson(json['title']),
    );

Map<String, dynamic> _$ResumeEduLevelToJson(ResumeEduLevel instance) =>
    <String, dynamic>{
      'value': const ToString().toJson(instance.value),
      'title': const ToString().toJson(instance.title),
    };

ResumeExperience _$ResumeExperienceFromJson(Map json) => ResumeExperience(
      id: const ToString().fromJson(json['id']),
      company: const ToString().fromJson(json['company']),
      position: const ToString().fromJson(json['position']),
      description: json['description'],
      start_date: const ToDateTime().fromJson(json['start_date']),
      end_date: const ToDateTime().fromJson(json['end_date']),
      location: json['location'] == null
          ? null
          : Location_.fromJson(
              Map<String, dynamic>.from(json['location'] as Map)),
    );

Map<String, dynamic> _$ResumeExperienceToJson(ResumeExperience instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'company': const ToString().toJson(instance.company),
      'position': const ToString().toJson(instance.position),
      'description': instance.description,
      'start_date': const ToDateTime().toJson(instance.start_date),
      'end_date': const ToDateTime().toJson(instance.end_date),
      'location': instance.location?.toJson(),
    };

ResumeLanguage _$ResumeLanguageFromJson(Map json) => ResumeLanguage(
      id: const ToString().fromJson(json['id']),
      title: const ToString().fromJson(json['title']),
      level: json['level'] == null
          ? null
          : ResumeEduLevel.fromJson(json['level'] as Map?),
    );

Map<String, dynamic> _$ResumeLanguageToJson(ResumeLanguage instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'title': const ToString().toJson(instance.title),
      'level': instance.level?.toJson(),
    };

ResumePersonalDetails _$ResumePersonalDetailsFromJson(Map json) =>
    ResumePersonalDetails(
      first_name: const ToString().fromJson(json['first_name']),
      last_name: const ToString().fromJson(json['last_name']),
      name: const ToString().fromJson(json['name']),
      gender: json['gender'] == null
          ? null
          : ResumeEduLevel.fromJson(json['gender'] as Map?),
      marital_status: json['marital_status'] == null
          ? null
          : ResumeEduLevel.fromJson(json['marital_status'] as Map?),
      location: json['location'] == null
          ? null
          : Location_.fromJson(
              Map<String, dynamic>.from(json['location'] as Map)),
      education_level: json['education_level'] == null
          ? null
          : ResumeEduLevel.fromJson(json['education_level'] as Map?),
      nationality: const ToString().fromJson(json['nationality']),
      eduction_level: json['eduction_level'] == null
          ? null
          : ResumeEduLevel.fromJson(json['eduction_level'] as Map?),
      dob: const ToString().fromJson(json['dob']),
      phone: (json['phone'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      position: const ToString().fromJson(json['position']),
      email: const ToString().fromJson(json['email']),
      address: const ToString().fromJson(json['address']),
      work_experience: const ToString().fromJson(json['work_experience']),
      photo: json['photo'] == null
          ? null
          : IconSerial.fromJson(
              Map<String, dynamic>.from(json['photo'] as Map)),
    );

Map<String, dynamic> _$ResumePersonalDetailsToJson(
        ResumePersonalDetails instance) =>
    <String, dynamic>{
      'first_name': const ToString().toJson(instance.first_name),
      'last_name': const ToString().toJson(instance.last_name),
      'name': const ToString().toJson(instance.name),
      'gender': instance.gender?.toJson(),
      'marital_status': instance.marital_status?.toJson(),
      'location': instance.location?.toJson(),
      'education_level': instance.education_level?.toJson(),
      'nationality': const ToString().toJson(instance.nationality),
      'eduction_level': instance.eduction_level?.toJson(),
      'dob': const ToString().toJson(instance.dob),
      'phone': instance.phone?.map(const ToString().toJson).toList(),
      'email': const ToString().toJson(instance.email),
      'address': const ToString().toJson(instance.address),
      'position': const ToString().toJson(instance.position),
      'work_experience': const ToString().toJson(instance.work_experience),
      'photo': instance.photo?.toJson(),
    };

ResumePreference _$ResumePreferenceFromJson(Map json) => ResumePreference(
      open_job: json['open_job'] as bool?,
      position: const ToString().fromJson(json['position']),
      category: json['category'],
      location: (json['location'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : Location_.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      job_type: json['job_type'],
    );

Map<String, dynamic> _$ResumePreferenceToJson(ResumePreference instance) =>
    <String, dynamic>{
      'open_job': instance.open_job,
      'position': const ToString().toJson(instance.position),
      'category': instance.category,
      'location': instance.location?.map((e) => e?.toJson()).toList(),
      'job_type': instance.job_type,
    };
