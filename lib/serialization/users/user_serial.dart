
import 'package:json_annotation/json_annotation.dart';
import '../helper.dart';
import '../try_convert.dart';

part 'user_serial.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class UserSerial {
  DataUser? data;

  UserSerial({
    this.data,
  });

  factory UserSerial.fromJson(Map<String, dynamic> json) => _$UserSerialFromJson(json);
  Map toJson() => _$UserSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true)
class DataUser {
  UserProfile? user;
  Tokens? tokens;

  DataUser({
    this.user,
    this.tokens,
  });

  factory DataUser.fromJson(Map json) => _$DataUserFromJson(json);
  Map toJson() => _$DataUserToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToInt(), ToLists()])
class Tokens {
  String? access_token;
  int? expires_in;
  List<String?>? scope;
  String? refresh_token;

  Tokens({
    this.access_token,
    this.expires_in,
    this.scope,
    this.refresh_token,
  });

  factory Tokens.fromJson(Map json) => _$TokensFromJson(json);
  Map toJson() => _$TokensToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToBool(), ToDateTime()])
class UserProfile {
  String? id;
  String? username;
  String? first_name;
  String? last_name;
  String? name;
  String? company;
  bool? is_verify;
  AccountVerification? account_verification;
  CoverProfile? photo;
  CoverProfile? cover;
  bool? is_has_password;
  bool? phone_activated;
  bool? email_activated;
  bool? auto_update_profile_picture;
  ContactUser? contact;
  String? last_login;
  bool? is_membership;
  Membership? membership;
  SettingUser? setting;

  UserProfile({
    this.id,
    this.username,
    this.first_name,
    this.last_name,
    this.name,
    this.company,
    this.is_verify,
    this.account_verification,
    this.photo,
    this.cover,
    this.is_has_password,
    this.phone_activated,
    this.email_activated,
    this.auto_update_profile_picture,
    this.contact,
    this.last_login,
    this.is_membership,
    this.membership,
    this.setting,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
  Map toJson() => _$UserProfileToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true)
class AccountVerification {
  PhoneUser? phone;

  AccountVerification({
    this.phone,
  });

  factory AccountVerification.fromJson(Map<String, dynamic> json) => _$AccountVerificationFromJson(json);
  Map toJson() => _$AccountVerificationToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToBool()])
class PhoneUser {
  String? value;
  bool? verify;

  PhoneUser({
    this.value,
    this.verify,
  });

  factory PhoneUser.fromJson(Map<String, dynamic> json) => _$PhoneUserFromJson(json);
  Map toJson() => _$PhoneUserToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToLists()])
class ContactUser {
  MapClass? map;
  CommuneUser? location;
  CommuneUser? commune;
  CommuneUser? district;
  String? address;
  List<String?>? phone;

  ContactUser({
    this.map,
    this.location,
    this.commune,
    this.district,
    this.address,
    this.phone,
  });

  factory ContactUser.fromJson(Map<String, dynamic> json) => _$ContactUserFromJson(json);
  Map toJson() => _$ContactUserToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class CommuneUser {
  String? id;
  String? kmName;
  String? enName;
  String? slug;

  CommuneUser({
    this.id,
    this.kmName,
    this.enName,
    this.slug,
  });

  factory CommuneUser.fromJson(Map<String, dynamic> json) => _$CommuneUserFromJson(json);
  Map toJson() => _$CommuneUserToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class CoverProfile {
  String? url;
  String? width;
  String? height;
  SizeOfImage? small;
  SizeOfImage? medium;
  SizeOfImage? large;
  String? align;
  dynamic offset;

  CoverProfile({
    this.url,
    this.width,
    this.height,
    this.small,
    this.medium,
    this.large,
    this.align,
    this.offset,
  });

  factory CoverProfile.fromJson(Map<String, dynamic>? json) => _$CoverProfileFromJson(json!);
  Map<String, dynamic>? toJson() => _$CoverProfileToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToInt()])
class Membership {
  String? title;
  String? type;
  String? status;
  String? status_title;
  int? num_ads;
  int? renew;
  int? auto_renew;

  Membership({
    this.title,
    this.type,
    this.status,
    this.status_title,
    this.num_ads,
    this.renew,
    this.auto_renew,
  });

  factory Membership.fromJson(Map<String, dynamic> json) => _$MembershipFromJson(json);
  Map toJson() => _$MembershipToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToLists(), ToBool()])
class SettingUser {
  List<String?>? chat;
  List<String?>? comment;
  bool? like;
  bool? save;
  bool? follow;
  List<String?>? job;
  bool? privacy;
  List<String?>? payment;

  SettingUser({
    this.chat,
    this.comment,
    this.like,
    this.save,
    this.follow,
    this.job,
    this.privacy,
    this.payment,
  });

  factory SettingUser.fromJson(Map<String, dynamic> json) => _$SettingUserFromJson(json);
  Map toJson() => _$SettingUserToJson(this);

}






@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class MessageLogin {
  String? message;
  String? type;
  String? code;
  KeyErrors? errors;

  MessageLogin({
    this.message,
    this.type,
    this.code,
    this.errors,
  });

  factory MessageLogin.fromJson(Map<String, dynamic>? json) => _$MessageLoginFromJson(json!);
  Map? toJson() => _$MessageLoginToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class KeyErrors {
  LoginKey? login;
  PasswordKey? password;

  KeyErrors({
    this.password,
    this.login,
  });

  factory KeyErrors.fromJson(Map<String, dynamic>? json) => _$KeyErrorsFromJson(json!);
  Map? toJson() => _$KeyErrorsToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class LoginKey {
  String? message;

  LoginKey({
    this.message,
  });

  factory LoginKey.fromJson(Map<String, dynamic>? json) => _$LoginKeyFromJson(json!);
  Map? toJson() => _$LoginKeyToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class PasswordKey {
  String? message;

  PasswordKey({
    this.message,
  });

  factory PasswordKey.fromJson(Map<String, dynamic>? json) => _$PasswordKeyFromJson(json!);
  Map? toJson() => _$PasswordKeyToJson(this);

}
