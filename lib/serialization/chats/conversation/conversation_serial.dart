
import 'package:json_annotation/json_annotation.dart';

import '../../try_convert.dart';
import '../chat_serial.dart';

part 'conversation_serial.g.dart';

@JsonSerializable(converters: [ToString()])
class UploadTMPSerial {
  String? status;
  String? message;
  String? file;
  String? type;

  UploadTMPSerial({
    this.status,
    this.message,
    this.file,
    this.type,
  });

  factory UploadTMPSerial.fromJson(Map<String, dynamic> json) => _$UploadTMPSerialFromJson(json);
  Map<String, dynamic> toJson() => _$UploadTMPSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToLists()])
class ConSerial {
  List<ConData?>? data;
  Blocked? blocked;

  ConSerial({
    this.data,
    this.blocked,
  });

  factory ConSerial.fromJson(Map? json) => _$ConSerialFromJson(json!);
  Map? toJson() => _$ConSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToBool()])
class Blocked {
  bool? is_block;

  Blocked({
    this.is_block,
  });

  factory Blocked.fromJson(Map? json) => _$BlockedFromJson(json!);
  Map? toJson() => _$BlockedToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToDateTime(), ToBool()])
class ConData {
  String? id;
  String? topic_id;
  String? type;
  String? message;
  String? send_time;
  DateTime? send_date;
  bool? is_read;
  String? folder;
  dynamic data;
  String? read_time;
  DateTime? read_date;

  ConData({
    this.id,
    this.topic_id,
    this.type,
    this.message,
    this.send_time,
    this.send_date,
    this.is_read,
    this.folder,
    this.data,
    this.read_time,
    this.read_date,
  });

  factory ConData.fromJson(Map? json) => _$ConDataFromJson(json!);
  Map? toJson() => _$ConDataToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToLists()])
class DataMore {
  String? name;
  String? company;
  List<String?>? phone;
  String? email;
  ConLocation? location;
  String? address;
  dynamic map;
  List<PhoneWhiteOperator?>? phone_white_operator;

  DataMore({
    this.name,
    this.company,
    this.phone,
    this.email,
    this.location,
    this.address,
    this.map,
    this.phone_white_operator,
  });

  factory DataMore.fromJson(Map? json) => _$DataMoreFromJson(json!);
  Map? toJson() => _$DataMoreToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class ConLocation {
  String? en_name;
  String? km_name;
  String? en_name2;
  String? en_name3;
  String? km_name2;
  String? km_name3;
  String? long_location;

  ConLocation({
    this.en_name,
    this.km_name,
    this.en_name2,
    this.en_name3,
    this.km_name2,
    this.km_name3,
    this.long_location,
  });

  factory ConLocation.fromJson(Map? json) => _$ConLocationFromJson(json!);
  Map? toJson() => _$ConLocationToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class PhoneWhiteOperator {
  String? title;
  String? phone;
  String? slug;
  String? icon;

  PhoneWhiteOperator({
    this.title,
    this.phone,
    this.slug,
    this.icon,
  });

  factory PhoneWhiteOperator.fromJson(Map? json) => _$PhoneWhiteOperatorFromJson(json!);
  Map? toJson() => _$PhoneWhiteOperatorToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class ConImage {
  String? image;
  String? thumbnail;
  String? width;
  String? height;
  String? type;
  String? size;
  String? name;
  ChatLarge? small;
  ChatLarge? medium;
  ChatLarge? large;

  ConImage({
    this.image,
    this.thumbnail,
    this.width,
    this.height,
    this.type,
    this.size,
    this.name,
    this.small,
    this.medium,
    this.large,
  });

  factory ConImage.fromJson(Map? json) => _$ConImageFromJson(json!);
  Map? toJson() => _$ConImageToJson(this);

}

