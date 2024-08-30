
import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/helper.dart';
import 'package:k24/serialization/jobs/details/details_serial.dart';
import 'package:k24/serialization/notify/nortify_serial.dart';

import '../../try_convert.dart';

part 'my_resume_serial.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true,)
class MyResumeSerial {
  MyResumePoints? points;
  MyResumeData? data;

  MyResumeSerial({
    this.points,
    this.data,
  });

  factory MyResumeSerial.fromJson(Map? json) => _$MyResumeSerialFromJson(json!);
  Map? toJson() => _$MyResumeSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToLists()])
class MyResumeData {
  String? id;
  ResumePersonalDetails? personal_details;
  List<ResumeEducation?>? educations;
  List<ResumeExperience?>? experiences;
  List<ResumeLanguage?>? skills;
  List<ResumeLanguage?>? languages;
  List<ResumeReferences?>? references;
  String? hobbies;
  String? summary;
  MyResumeAttachment? attachment;
  MyResumePreference? preference;

  MyResumeData({
    this.id,
    this.personal_details,
    this.educations,
    this.experiences,
    this.skills,
    this.languages,
    this.references,
    this.hobbies,
    this.summary,
    this.attachment,
    this.preference,
  });

  factory MyResumeData.fromJson(Map? json) => _$MyResumeDataFromJson(json!);
  Map? toJson() => _$MyResumeDataToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToInt()])
class MyResumePoints {
  String? current;
  int? total;
  List<MyResumeSuggestion?>? suggestions;

  MyResumePoints({
    this.current,
    this.total,
    this.suggestions,
  });

  factory MyResumePoints.fromJson(Map? json) => _$MyResumePointsFromJson(json!);
  Map? toJson() => _$MyResumePointsToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class MyResumeSuggestion {
  String? type;
  String? field;
  String? name;

  MyResumeSuggestion({
    this.type,
    this.field,
    this.name,
  });

  factory MyResumeSuggestion.fromJson(Map? json) => _$MyResumeSuggestionFromJson(json!);
  Map? toJson() => _$MyResumeSuggestionToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToInt(), ToDateTime()])
class MyResumeAttachment {
  String? id;
  String? name;
  String? file;
  String? type;
  int? size;
  DateTime? created_at;
  String? url;

  MyResumeAttachment({
    this.id,
    this.name,
    this.file,
    this.type,
    this.size,
    this.created_at,
    this.url,
  });

  factory MyResumeAttachment.fromJson(Map? json) => _$MyResumeAttachmentFromJson(json!);
  Map? toJson() => _$MyResumeAttachmentToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToBool(), ToLists()])
class MyResumePreference {
  bool? open_job;
  String? position;
  List<MyResumeCategory?>? category;
  List<Location_?>? location;
  List<MyResumeJobType?>? job_type;

  MyResumePreference({
    this.open_job,
    this.position,
    this.category,
    this.location,
    this.job_type,
  });

  factory MyResumePreference.fromJson(Map? json) => _$MyResumePreferenceFromJson(json!);
  Map? toJson() => _$MyResumePreferenceToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class MyResumeCategory {
  String? id;
  String? en_name;
  String? km_name;
  String? slug;
  String? parent;
  Location_? parent_data;

  MyResumeCategory({
    this.id,
    this.en_name,
    this.km_name,
    this.slug,
    this.parent,
    this.parent_data,
  });

  factory MyResumeCategory.fromJson(Map? json) => _$MyResumeCategoryFromJson(json!);
  Map? toJson() => _$MyResumeCategoryToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(),])
class MyResumeJobType {
  String? title;
  String? value;

  MyResumeJobType({
    this.title,
    this.value,
  });

  factory MyResumeJobType.fromJson(Map? json) => _$MyResumeJobTypeFromJson(json!);
  Map? toJson() => _$MyResumeJobTypeToJson(this);

}

