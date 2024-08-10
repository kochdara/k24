
import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/serialization/jobs/details/details_serial.dart';
import 'package:k24/serialization/try_convert.dart';

import '../../helper.dart';
import '../../notify/nortify_serial.dart';

part 'jobapplications_serial.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToInt(), ToLists()])
class JobAppSerial {
  int? limit;
  List<JobAppData>? data;

  JobAppSerial({
    this.limit,
    this.data,
  });

  factory JobAppSerial.fromJson(Map? json) => _$JobAppSerialFromJson(json!);
  Map? toJson() => _$JobAppSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true,)
class GetBadgesSerial {
  GetBadgesData? data;

  GetBadgesSerial({
    this.data,
  });

  factory GetBadgesSerial.fromJson(Map? json) => _$GetBadgesSerialFromJson(json!);
  Map? toJson() => _$GetBadgesSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true)
class GetBadgesData {
  String? total;
  String? newCount; // Renamed from 'new' to 'newCount'

  GetBadgesData({
    this.total,
    this.newCount,
  });

  factory GetBadgesData.fromJson(Map<String, dynamic> json) => _$GetBadgesDataFromJson(json);
  Map<String, dynamic> toJson() => _$GetBadgesDataToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToLists(), ToDateTime()])
class JobAppData {
  String? id;
  DateTime? apply_date;
  ResumeEduLevel? status;
  String? application_type;
  Data_? post;
  JobAppApplication? application;

  JobAppData({
    this.id,
    this.apply_date,
    this.status,
    this.application_type,
    this.post,
    this.application,
  });

  factory JobAppData.fromJson(Map? json) => _$JobAppDataFromJson(json!);
  Map? toJson() => _$JobAppDataToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToLists(),])
class JobAppApplication {
  String? name;
  List<String?>? phone;
  List<PhoneWhiteOperator?>? phone_white_operator;
  String? email;
  String? userid;
  String? file;
  String? cv;
  ResumePersonalDetails? personal_details;
  String? summary;
  List<ResumeEducation?>? educations;
  List<ResumeExperience?>? experiences;
  List<ResumeLanguage?>? skills;
  List<ResumeLanguage?>? languages;
  String? hobbies;
  List<ResumeReferences?>? references;

  JobAppApplication({
    this.name,
    this.phone,
    this.phone_white_operator,
    this.email,
    this.userid,
    this.file,
    this.cv,
    this.personal_details,
    this.summary,
    this.educations,
    this.experiences,
    this.skills,
    this.languages,
    this.hobbies,
    this.references,
  });

  factory JobAppApplication.fromJson(Map? json) => _$JobAppApplicationFromJson(json!);
  Map? toJson() => _$JobAppApplicationToJson(this);

}
