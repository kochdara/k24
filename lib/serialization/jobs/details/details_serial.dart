
import 'package:json_annotation/json_annotation.dart';

import '../../helper.dart';
import '../../notify/nortify_serial.dart';
import '../../try_convert.dart';

part 'details_serial.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class ResumeDetailSerial {
  ResumeData data;

  ResumeDetailSerial({
    required this.data,
  });

  factory ResumeDetailSerial.fromJson(Map? json) => _$ResumeDetailSerialFromJson(json!);
  Map? toJson() => _$ResumeDetailSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToLists(), ToBool()])
class ResumeData {
  String? id;
  String? userid;
  ResumePersonalDetails? personal_details;
  List<ResumeEducation?>? educations;
  List<ResumeExperience?>? experiences;
  List<ResumeLanguage?>? skills;
  List<ResumeLanguage?>? languages;
  String? hobbies;
  String? summary;
  ResumePreference? preference;
  List<ResumeReferences?>? references;
  bool? saved;

  ResumeData({
    this.id,
    this.userid,
    this.personal_details,
    this.educations,
    this.experiences,
    this.skills,
    this.languages,
    this.hobbies,
    this.summary,
    this.preference,
    this.saved,
  });

  factory ResumeData.fromJson(Map? json) => _$ResumeDataFromJson(json!);
  Map? toJson() => _$ResumeDataToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToDateTime()])
class ResumeEducation {
  String? id;
  String? school;
  ResumeEduLevel? degree;
  String? major;
  dynamic description;
  DateTime? start_date;
  DateTime? end_date;

  ResumeEducation({
    this.id,
    this.school,
    this.degree,
    this.major,
    this.description,
    this.start_date,
    this.end_date,
  });

  factory ResumeEducation.fromJson(Map? json) => _$ResumeEducationFromJson(json!);
  Map? toJson() => _$ResumeEducationToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(),])
class ResumeEduLevel {
  String? value;
  String? title;

  ResumeEduLevel({
    this.value,
    this.title,
  });

  factory ResumeEduLevel.fromJson(Map? json) => _$ResumeEduLevelFromJson(json!);
  Map? toJson() => _$ResumeEduLevelToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToDateTime()])
class ResumeExperience {
  String? id;
  String? company;
  String? position;
  dynamic description;
  DateTime? start_date;
  DateTime? end_date;
  Location_? location;

  ResumeExperience({
    this.id,
    this.company,
    this.position,
    this.description,
    this.start_date,
    this.end_date,
    this.location,
  });

  factory ResumeExperience.fromJson(Map? json) => _$ResumeExperienceFromJson(json!);
  Map? toJson() => _$ResumeExperienceToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class ResumeLanguage {
  String? id;
  String? title;
  ResumeEduLevel? level;

  ResumeLanguage({
    this.id,
    this.title,
    this.level,
  });

  factory ResumeLanguage.fromJson(Map? json) => _$ResumeLanguageFromJson(json!);
  Map? toJson() => _$ResumeLanguageToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class ResumePersonalDetails {
  String? first_name;
  String? last_name;
  String? name;
  ResumeEduLevel? gender;
  ResumeEduLevel? marital_status;
  Location_? location;
  ResumeEduLevel? education_level;
  String? nationality;
  ResumeEduLevel? eduction_level;
  String? dob;
  List<String?>? phone;
  String? email;
  String? address;
  String? position;
  String? work_experience;
  IconSerial? photo;

  ResumePersonalDetails({
    this.first_name,
    this.last_name,
    this.name,
    this.gender,
    this.marital_status,
    this.location,
    this.education_level,
    this.nationality,
    this.eduction_level,
    this.dob,
    this.phone,
    this.position,
    this.email,
    this.address,
    this.work_experience,
    this.photo,
  });

  factory ResumePersonalDetails.fromJson(Map? json) => _$ResumePersonalDetailsFromJson(json!);
  Map? toJson() => _$ResumePersonalDetailsToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class ResumePreference {
  bool? open_job;
  String? position;
  dynamic category;
  List<Location_?>? location;
  dynamic job_type;

  ResumePreference({
    this.open_job,
    this.position,
    this.category,
    this.location,
    this.job_type,
  });

  factory ResumePreference.fromJson(Map? json) => _$ResumePreferenceFromJson(json!);
  Map? toJson() => _$ResumePreferenceToJson(this);

}

