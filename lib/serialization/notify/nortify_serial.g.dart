// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nortify_serial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotifySerial _$NotifySerialFromJson(Map json) => NotifySerial(
      data: (json['data'] as List<dynamic>)
          .map((e) => NotifyDatum.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      limit: const ToInt().fromJson(json['limit']),
    );

Map<String, dynamic> _$NotifySerialToJson(NotifySerial instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'limit': const ToInt().toJson(instance.limit),
    };

NotifyBadges _$NotifyBadgesFromJson(Map json) => NotifyBadges(
      notification: const ToString().fromJson(json['notification']),
      chat: const ToString().fromJson(json['chat']),
      comment: const ToString().fromJson(json['comment']),
    );

Map<String, dynamic> _$NotifyBadgesToJson(NotifyBadges instance) =>
    <String, dynamic>{
      'notification': const ToString().toJson(instance.notification),
      'chat': const ToString().toJson(instance.chat),
      'comment': const ToString().toJson(instance.comment),
    };

NotifyDatum _$NotifyDatumFromJson(Map json) => NotifyDatum(
      notid: const ToString().fromJson(json['notid']),
      title: const ToString().fromJson(json['title']),
      message: const ToString().fromJson(json['message']),
      is_open: const ToBool().fromJson(json['is_open']),
      open_date: const ToDateTime().fromJson(json['open_date']),
      send_date: const ToDateTime().fromJson(json['send_date']),
      id: const ToString().fromJson(json['id']),
      id_type: json['id_type'],
      type: const ToString().fromJson(json['type']),
      data: json['data'] == null
          ? null
          : NotifyData.fromJson(Map<String, dynamic>.from(json['data'] as Map)),
    );

Map<String, dynamic> _$NotifyDatumToJson(NotifyDatum instance) =>
    <String, dynamic>{
      'notid': const ToString().toJson(instance.notid),
      'title': const ToString().toJson(instance.title),
      'message': const ToString().toJson(instance.message),
      'is_open': _$JsonConverterToJson<Object?, bool>(
          instance.is_open, const ToBool().toJson),
      'open_date': const ToDateTime().toJson(instance.open_date),
      'send_date': const ToDateTime().toJson(instance.send_date),
      'id': const ToString().toJson(instance.id),
      'id_type': instance.id_type,
      'type': const ToString().toJson(instance.type),
      'data': instance.data?.toJson(),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

NotifyData _$NotifyDataFromJson(Map json) => NotifyData(
      type: const ToString().fromJson(json['type']),
      post: json['post'] == null ? null : Data_.fromJson(json['post'] as Map),
      user: json['user'] == null
          ? null
          : User_.fromJson(Map<String, dynamic>.from(json['user'] as Map)),
      comment: json['comment'] == null
          ? null
          : CommentDatum.fromJson(
              Map<String, dynamic>.from(json['comment'] as Map)),
      id: const ToString().fromJson(json['id']),
      adid: const ToString().fromJson(json['adid']),
      application_type: const ToString().fromJson(json['application_type']),
      apply_date: json['apply_date'] == null
          ? null
          : DateTime.parse(json['apply_date'] as String),
      cv: json['cv'] == null
          ? null
          : ResumeData.fromJson(Map<String, dynamic>.from(json['cv'] as Map)),
    );

Map<String, dynamic> _$NotifyDataToJson(NotifyData instance) =>
    <String, dynamic>{
      'type': const ToString().toJson(instance.type),
      'post': instance.post?.toJson(),
      'user': instance.user?.toJson(),
      'comment': instance.comment?.toJson(),
      'id': const ToString().toJson(instance.id),
      'adid': const ToString().toJson(instance.adid),
      'application_type': const ToString().toJson(instance.application_type),
      'apply_date': instance.apply_date?.toIso8601String(),
      'cv': instance.cv?.toJson(),
    };

ResumeData _$ResumeDataFromJson(Map json) => ResumeData(
      id: const ToString().fromJson(json['id']),
      name: const ToString().fromJson(json['name']),
      email: const ToString().fromJson(json['email']),
      phone: (json['phone'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      cv: const ToString().fromJson(json['cv']),
      file: const ToString().fromJson(json['file']),
      phone_white_operator: (json['phone_white_operator'] as List<dynamic>?)
          ?.map(
              (e) => e == null ? null : PhoneWhiteOperator.fromJson(e as Map?))
          .toList(),
    );

Map<String, dynamic> _$ResumeDataToJson(ResumeData instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'name': const ToString().toJson(instance.name),
      'email': const ToString().toJson(instance.email),
      'phone': instance.phone?.map(const ToString().toJson).toList(),
      'cv': const ToString().toJson(instance.cv),
      'file': const ToString().toJson(instance.file),
      'phone_white_operator':
          instance.phone_white_operator?.map((e) => e?.toJson()).toList(),
    };

NotifyResume _$NotifyResumeFromJson(Map json) => NotifyResume(
      data: NotifyResumeData.fromJson(
          Map<String, dynamic>.from(json['data'] as Map)),
    );

Map<String, dynamic> _$NotifyResumeToJson(NotifyResume instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

NotifyResumeData _$NotifyResumeDataFromJson(Map json) => NotifyResumeData(
      id: const ToString().fromJson(json['id']),
      apply_date: const ToDateTime().fromJson(json['apply_date']),
      status: json['status'] == null
          ? null
          : ResumeEduLevel.fromJson(json['status'] as Map?),
      application_type: const ToString().fromJson(json['application_type']),
      post: json['post'] == null ? null : Data_.fromJson(json['post'] as Map),
      application: json['application'] == null
          ? null
          : NotifyResumeApplication.fromJson(
              Map<String, dynamic>.from(json['application'] as Map)),
    );

Map<String, dynamic> _$NotifyResumeDataToJson(NotifyResumeData instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'apply_date': const ToDateTime().toJson(instance.apply_date),
      'status': instance.status?.toJson(),
      'application_type': const ToString().toJson(instance.application_type),
      'post': instance.post?.toJson(),
      'application': instance.application?.toJson(),
    };

NotifyResumeApplication _$NotifyResumeApplicationFromJson(Map json) =>
    NotifyResumeApplication(
      name: const ToString().fromJson(json['name']),
      phone: (json['phone'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      phone_white_operator: (json['phone_white_operator'] as List<dynamic>?)
          ?.map(
              (e) => e == null ? null : PhoneWhiteOperator.fromJson(e as Map?))
          .toList(),
      email: const ToString().fromJson(json['email']),
      id: const ToString().fromJson(json['id']),
      userid: const ToString().fromJson(json['userid']),
      file: const ToString().fromJson(json['file']),
      cv: const ToString().fromJson(json['cv']),
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
    )..references = (json['references'] as List<dynamic>?)
        ?.map((e) => e == null
            ? null
            : ResumeReferences.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();

Map<String, dynamic> _$NotifyResumeApplicationToJson(
        NotifyResumeApplication instance) =>
    <String, dynamic>{
      'name': const ToString().toJson(instance.name),
      'phone': instance.phone?.map(const ToString().toJson).toList(),
      'phone_white_operator':
          instance.phone_white_operator?.map((e) => e?.toJson()).toList(),
      'email': const ToString().toJson(instance.email),
      'id': const ToString().toJson(instance.id),
      'userid': const ToString().toJson(instance.userid),
      'file': const ToString().toJson(instance.file),
      'cv': const ToString().toJson(instance.cv),
      'personal_details': instance.personal_details?.toJson(),
      'educations': instance.educations?.map((e) => e?.toJson()).toList(),
      'experiences': instance.experiences?.map((e) => e?.toJson()).toList(),
      'skills': instance.skills?.map((e) => e?.toJson()).toList(),
      'languages': instance.languages?.map((e) => e?.toJson()).toList(),
      'hobbies': const ToString().toJson(instance.hobbies),
      'summary': const ToString().toJson(instance.summary),
      'preference': instance.preference?.toJson(),
      'references': instance.references?.map((e) => e?.toJson()).toList(),
      'saved': _$JsonConverterToJson<Object?, bool>(
          instance.saved, const ToBool().toJson),
    };

ResumeReferences _$ResumeReferencesFromJson(Map json) => ResumeReferences(
      id: const ToString().fromJson(json['id']),
      company: const ToString().fromJson(json['company']),
      name: const ToString().fromJson(json['name']),
      position: const ToString().fromJson(json['position']),
      phone: (json['phone'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      email: const ToString().fromJson(json['email']),
    );

Map<String, dynamic> _$ResumeReferencesToJson(ResumeReferences instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'company': const ToString().toJson(instance.company),
      'name': const ToString().toJson(instance.name),
      'position': const ToString().toJson(instance.position),
      'phone': instance.phone?.map(const ToString().toJson).toList(),
      'email': const ToString().toJson(instance.email),
    };
