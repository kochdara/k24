

import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/helper.dart';
import 'package:k24/serialization/try_convert.dart';

part 'apply_job_serial.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToInt(), ToDateTime()])
class ApplyJobSerial {
  List<ApplyJobDatum?>? data;
  int? limit;

  ApplyJobSerial({
    this.data,
    this.limit,
  });

  factory ApplyJobSerial.fromJson(Map? json) => _$ApplyJobSerialFromJson(json!);
  Map? toJson() => _$ApplyJobSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToDateTime()])
class ApplyJobDatum {
  String? id;
  DateTime? apply_date;
  ApplyJobStatus? status;
  ApplyJobPost? post;

  ApplyJobDatum({
    this.id,
    this.apply_date,
    this.status,
    this.post,
  });

  factory ApplyJobDatum.fromJson(Map? json) => _$ApplyJobDatumFromJson(json!);
  Map? toJson() => _$ApplyJobDatumToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(),])
class ApplyJobPost {
  String? id;
  String? title;
  String? company;
  String? logo;
  String? type;
  String? salary;
  String? status;
  String? status_message;
  Location_? location;

  ApplyJobPost({
    this.id,
    this.title,
    this.company,
    this.logo,
    this.type,
    this.salary,
    this.status,
    this.status_message,
    this.location,
  });

  factory ApplyJobPost.fromJson(Map? json) => _$ApplyJobPostFromJson(json!);
  Map? toJson() => _$ApplyJobPostToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(),])
class ApplyJobStatus {
  String? value;
  String? title;

  ApplyJobStatus({
    this.value,
    this.title,
  });

  factory ApplyJobStatus.fromJson(Map? json) => _$ApplyJobStatusFromJson(json!);
  Map? toJson() => _$ApplyJobStatusToJson(this);

}

