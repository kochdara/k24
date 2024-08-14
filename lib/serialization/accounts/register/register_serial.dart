
import 'package:json_annotation/json_annotation.dart';

import '../../try_convert.dart';

part 'register_serial.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class RegisterSerial {
  RegisterNextPage? next_page;
  String? message;

  RegisterSerial({
    this.next_page,
    this.message,
  });

  factory RegisterSerial.fromJson(Map<String, dynamic> json) => _$RegisterSerialFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class RegisterNextPage {
  String? page;
  String? recipient_phone;
  String? phone;
  String? code;
  String? message;
  String? token;
  RegisterData? data;

  RegisterNextPage({
    this.page,
    this.recipient_phone,
    this.phone,
    this.code,
    this.message,
    this.token,
    this.data,
  });

  factory RegisterNextPage.fromJson(Map<String, dynamic> json) => _$RegisterNextPageFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterNextPageToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true,)
class RegisterData {
  RegisterVerify? verify;

  RegisterData({
    this.verify,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) => _$RegisterDataFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterDataToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class RegisterVerify {
  String? type;
  String? value;

  RegisterVerify({
    this.type,
    this.value,
  });

  factory RegisterVerify.fromJson(Map<String, dynamic> json) => _$RegisterVerifyFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterVerifyToJson(this);

}

