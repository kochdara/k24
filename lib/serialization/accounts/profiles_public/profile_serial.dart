
import 'package:json_annotation/json_annotation.dart';

import '../../helper.dart';
import '../../try_convert.dart';
import '../../users/user_serial.dart';

part 'profile_serial.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ProfileSerial {
  DataProfile data;
  MetaProfile? meta;

  ProfileSerial({
    required this.data,
    this.meta,
  });

  factory ProfileSerial.fromJson(Map<String, dynamic>? json) => _$ProfileSerialFromJson(json!);
  Map<String, dynamic>? toJson() => _$ProfileSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToDateTime(), ToBool(), ToLists()])
class DataProfile {
  String? id;
  String? username;
  String? name;
  CoverProfile? photo;
  CoverProfile? logo;
  CoverProfile? cover;
  DateTime? registered_date;
  OnlineStatusProfile? online_status;
  ContactProfile? contact;
  String? type;
  bool? is_verify;
  List<String?>? verified;
  String? link;
  List<String>? menu;
  bool? is_saved;
  String? following;
  String? followers;
  bool? is_follow;
  SettingProfile? setting;

  DataProfile({
    this.id,
    this.username,
    this.name,
    this.photo,
    this.logo,
    this.cover,
    this.registered_date,
    this.online_status,
    this.contact,
    this.type,
    this.is_verify,
    this.verified,
    this.link,
    this.menu,
    this.is_saved,
    this.following,
    this.followers,
    this.is_follow,
    this.setting,
  });

  factory DataProfile.fromJson(Map<String, dynamic>? json) => _$DataProfileFromJson(json!);
  Map<String, dynamic>? toJson() => _$DataProfileToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToLists()])
class ContactProfile {
  String? name;
  dynamic email;
  MapClass? map;
  String? address;
  List<String?>? phone;
  Location_? location;
  Location_? commune;
  Location_? district;
  String? long_location;
  List<PhoneWhiteOperator?>? phone_white_operator;

  ContactProfile({
    this.name,
    this.email,
    this.map,
    this.address,
    this.phone,
    this.location,
    this.commune,
    this.district,
    this.long_location,
    this.phone_white_operator,
  });

  factory ContactProfile.fromJson(Map<String, dynamic>? json) => _$ContactProfileFromJson(json!);
  Map<String, dynamic>? toJson() => _$ContactProfileToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToBool()])
class SettingProfile {
  bool? enable_save;
  bool? enable_follow;
  bool? enable_chat;

  SettingProfile({
    this.enable_save,
    this.enable_follow,
    this.enable_chat,
  });

  factory SettingProfile.fromJson(Map<String, dynamic>? json) => _$SettingProfileFromJson(json!);
  Map<String, dynamic>? toJson() => _$SettingProfileToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToDateTime(),])
class MetaProfile {
  String? site_ame;
  String? title;
  String? description;
  String? keyword;
  String? author;
  String? username;
  FbProfile? fb;
  String? image;
  String? url;
  String? deeplink;
  DateTime? date;

  MetaProfile({
    this.site_ame,
    this.title,
    this.description,
    this.keyword,
    this.author,
    this.username,
    this.fb,
    this.image,
    this.url,
    this.deeplink,
    this.date,
  });

  factory MetaProfile.fromJson(Map<String, dynamic>? json) => _$MetaProfileFromJson(json!);
  Map<String, dynamic>? toJson() => _$MetaProfileToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(),])
class FbProfile {
  String? id;
  String? type;

  FbProfile({
    this.id,
    this.type,
  });

  factory FbProfile.fromJson(Map<String, dynamic>? json) => _$FbProfileFromJson(json!);
  Map<String, dynamic>? toJson() => _$FbProfileToJson(this);

}

