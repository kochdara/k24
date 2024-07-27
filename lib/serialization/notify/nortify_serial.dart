

import 'package:json_annotation/json_annotation.dart';

import '../chats/comments/comments_serial.dart';
import '../grid_card/grid_card.dart';
import '../helper.dart';
import '../jobs/details/details_serial.dart';
import '../try_convert.dart';

part 'nortify_serial.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToInt()])
class NotifySerial {
  List<NotifyDatum> data;
  int limit;

  NotifySerial({
    required this.data,
    required this.limit,
  });

  factory NotifySerial.fromJson(Map<String, dynamic> json) => _$NotifySerialFromJson(json);
  Map? toJson() => _$NotifySerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class NotifyBadges {
  String? notification;
  String? chat;
  String? comment;

  NotifyBadges({
    this.notification,
    this.chat,
    this.comment,
  });

  factory NotifyBadges.fromJson(Map<String, dynamic> json) => _$NotifyBadgesFromJson(json);
  Map? toJson() => _$NotifyBadgesToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToInt(), ToString(), ToDateTime(), ToBool()])
class NotifyDatum {
  NotifyDatum({
    this.notid,
    this.title,
    this.message,
    this.is_open,
    this.open_date,
    this.send_date,
    this.id,
    this.id_type,
    this.type,
    this.data,
  });

  final String? notid;
  final String? title;
  final String? message;
  final bool? is_open;
  final DateTime? open_date;
  final DateTime? send_date;
  final String? id;
  final dynamic id_type;
  final String? type;
  final NotifyData? data;

  factory NotifyDatum.fromJson(Map<String, dynamic> json) => _$NotifyDatumFromJson(json);
  Map? toJson() => _$NotifyDatumToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class NotifyData {
  NotifyData({
    this.type,
    this.post,
    this.user,
    this.comment,
    this.id,
    this.adid,
    this.application_type,
    this.apply_date,
    this.cv,
  });

  final String? type;
  final Data_? post;
  final User_? user;
  final CommentDatum? comment;
  final String? id;
  final String? adid;
  final String? application_type;
  final DateTime? apply_date;
  final ResumeData? cv;

  factory NotifyData.fromJson(Map<String, dynamic> json) => _$NotifyDataFromJson(json);
  Map? toJson() => _$NotifyDataToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class ResumeData {
  ResumeData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.cv,
    this.file,
    this.phone_white_operator,
  });

  final String? id;
  final String? name;
  final String? email;
  final List<String?>? phone;
  final String? cv;
  final String? file;
  final List<PhoneWhiteOperator?>? phone_white_operator;

  factory ResumeData.fromJson(Map<String, dynamic> json) => _$ResumeDataFromJson(json);
  Map? toJson() => _$ResumeDataToJson(this);

}







@JsonSerializable(anyMap: true, explicitToJson: true,)
class NotifyResume {
  NotifyResumeData data;

  NotifyResume({
    required this.data,
  });

  factory NotifyResume.fromJson(Map<String, dynamic> json) => _$NotifyResumeFromJson(json);
  Map? toJson() => _$NotifyResumeToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToDateTime(),])
class NotifyResumeData {
  String? id;
  DateTime? apply_date;
  ResumeEduLevel? status;
  String? application_type;
  Data_? post;
  NotifyResumeApplication? application;

  NotifyResumeData({
    this.id,
    this.apply_date,
    this.status,
    this.application_type,
    this.post,
    this.application,
  });

  factory NotifyResumeData.fromJson(Map<String, dynamic> json) => _$NotifyResumeDataFromJson(json);
  Map? toJson() => _$NotifyResumeDataToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToLists(), ToBool()])
class NotifyResumeApplication {
  String? name;
  List<String?>? phone;
  List<PhoneWhiteOperator?>? phone_white_operator;
  String? email;
  String? id;
  String? userid;
  String? file;
  String? cv;
  ResumePersonalDetails? personal_details;
  List<ResumeEducation?>? educations;
  List<ResumeExperience?>? experiences;
  List<ResumeLanguage?>? skills;
  List<ResumeLanguage?>? languages;
  String? hobbies;
  String? summary;
  ResumePreference? preference;
  bool? saved;

  NotifyResumeApplication({
    this.name,
    this.phone,
    this.phone_white_operator,
    this.email,
    this.id,
    this.userid,
    this.file,
    this.cv,
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

  factory NotifyResumeApplication.fromJson(Map<String, dynamic> json) => _$NotifyResumeApplicationFromJson(json);
  Map? toJson() => _$NotifyResumeApplicationToJson(this);

}







