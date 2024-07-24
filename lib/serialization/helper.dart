
import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/try_convert.dart';

part 'helper.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class SizeOfImage {
  String? url;
  String? width;
  String? height;

  SizeOfImage({
    this.url,
    this.width,
    this.height,
  });

  factory SizeOfImage.fromJson(Map<String, dynamic> json) => _$SizeOfImageFromJson(json);
  Map? toJson() => _$SizeOfImageToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToBool(), ToInt(), ToDateTime(),])
class OnlineStatusProfile {
  bool? is_active;
  String? last_active;
  int? time;
  DateTime? date;

  OnlineStatusProfile({
    this.is_active,
    this.last_active,
    this.time,
    this.date,
  });

  factory OnlineStatusProfile.fromJson(Map<String, dynamic>? json) => _$OnlineStatusProfileFromJson(json!);
  Map<String, dynamic>? toJson() => _$OnlineStatusProfileToJson(this);

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

@JsonSerializable(converters: [ToString()])
class Location_ {
  String? id;
  String? en_name;
  String? km_name;
  String? en_name2;
  String? km_name2;
  String? en_name3;
  String? km_name3;
  String? slug;
  String? address;
  String? long_location;

  Location_({
    this.id,
    this.en_name,
    this.km_name,
    this.en_name2,
    this.km_name2,
    this.en_name3,
    this.km_name3,
    this.slug,
    this.address,
    this.long_location,
  });

  factory Location_.fromJson(Map<String, dynamic> json) => _$Location_FromJson(json);
  Map toJson() => _$Location_ToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class IconSerial {
  String? url;
  String? width;
  String? height;
  SizeOfImage? small;
  SizeOfImage? medium;
  SizeOfImage? large;

  IconSerial({
    this.url,
    this.width,
    this.height,
    this.small,
    this.medium,
    this.large,
  });

  factory IconSerial.fromJson(Map<String, dynamic> json) => _$IconSerialFromJson(json);
  Map toJson() => _$IconSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class MapClass {
  String? x;
  String? y;
  String? z;

  MapClass({
    this.x,
    this.y,
    this.z,
  });

  factory MapClass.fromJson(Map<String, dynamic> json) => _$MapClassFromJson(json);
  Map toJson() => _$MapClassToJson(this);

}
