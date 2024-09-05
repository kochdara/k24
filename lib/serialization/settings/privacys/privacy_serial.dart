
import 'package:json_annotation/json_annotation.dart';

import '../../try_convert.dart';

part 'privacy_serial.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class PrivacySerial {
  PrivacyData? data;

  PrivacySerial({
    this.data,
  });

  factory PrivacySerial.fromJson(Map<String, dynamic> json) => _$PrivacySerialFromJson(json);
  Map? toJson() => _$PrivacySerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class PrivacyData {
  String? gender;
  String? dob;
  String? phone;
  String? email;
  String? location;

  PrivacyData({
    this.gender,
    this.dob,
    this.phone,
    this.email,
    this.location,
  });

  factory PrivacyData.fromJson(Map<String, dynamic> json) => _$PrivacyDataFromJson(json);
  Map? toJson() => _$PrivacyDataToJson(this);

}

