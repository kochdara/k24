// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_serial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSerial _$UserSerialFromJson(Map json) => UserSerial(
      data:
          json['data'] == null ? null : DataUser.fromJson(json['data'] as Map),
    );

Map<String, dynamic> _$UserSerialToJson(UserSerial instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
    };

DataUser _$DataUserFromJson(Map json) => DataUser(
      user: json['user'] == null
          ? null
          : UserProfile.fromJson(
              Map<String, dynamic>.from(json['user'] as Map)),
      tokens: json['tokens'] == null
          ? null
          : Tokens.fromJson(json['tokens'] as Map),
    );

Map<String, dynamic> _$DataUserToJson(DataUser instance) => <String, dynamic>{
      'user': instance.user?.toJson(),
      'tokens': instance.tokens?.toJson(),
    };

Tokens _$TokensFromJson(Map json) => Tokens(
      access_token: const ToString().fromJson(json['access_token']),
      expires_in: const ToInt().fromJson(json['expires_in']),
      scope: (json['scope'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      refresh_token: const ToString().fromJson(json['refresh_token']),
    );

Map<String, dynamic> _$TokensToJson(Tokens instance) => <String, dynamic>{
      'access_token': const ToString().toJson(instance.access_token),
      'expires_in': _$JsonConverterToJson<Object?, int>(
          instance.expires_in, const ToInt().toJson),
      'scope': instance.scope?.map(const ToString().toJson).toList(),
      'refresh_token': const ToString().toJson(instance.refresh_token),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

UserProfile _$UserProfileFromJson(Map json) => UserProfile(
      id: const ToString().fromJson(json['id']),
      username: const ToString().fromJson(json['username']),
      first_name: const ToString().fromJson(json['first_name']),
      last_name: const ToString().fromJson(json['last_name']),
      name: const ToString().fromJson(json['name']),
      company: const ToString().fromJson(json['company']),
      is_verify: const ToBool().fromJson(json['is_verify']),
      account_verification: json['account_verification'] == null
          ? null
          : AccountVerification.fromJson(
              Map<String, dynamic>.from(json['account_verification'] as Map)),
      is_has_password: const ToBool().fromJson(json['is_has_password']),
      phone_activated: const ToBool().fromJson(json['phone_activated']),
      email_activated: const ToBool().fromJson(json['email_activated']),
      auto_update_profile_picture:
          const ToBool().fromJson(json['auto_update_profile_picture']),
      contact: json['contact'] == null
          ? null
          : ContactUser.fromJson(
              Map<String, dynamic>.from(json['contact'] as Map)),
      last_login: const ToString().fromJson(json['last_login']),
      is_membership: const ToBool().fromJson(json['is_membership']),
      membership: json['membership'] == null
          ? null
          : Membership.fromJson(
              Map<String, dynamic>.from(json['membership'] as Map)),
      setting: json['setting'] == null
          ? null
          : SettingUser.fromJson(
              Map<String, dynamic>.from(json['setting'] as Map)),
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'username': const ToString().toJson(instance.username),
      'first_name': const ToString().toJson(instance.first_name),
      'last_name': const ToString().toJson(instance.last_name),
      'name': const ToString().toJson(instance.name),
      'company': const ToString().toJson(instance.company),
      'is_verify': _$JsonConverterToJson<Object?, bool>(
          instance.is_verify, const ToBool().toJson),
      'account_verification': instance.account_verification?.toJson(),
      'is_has_password': _$JsonConverterToJson<Object?, bool>(
          instance.is_has_password, const ToBool().toJson),
      'phone_activated': _$JsonConverterToJson<Object?, bool>(
          instance.phone_activated, const ToBool().toJson),
      'email_activated': _$JsonConverterToJson<Object?, bool>(
          instance.email_activated, const ToBool().toJson),
      'auto_update_profile_picture': _$JsonConverterToJson<Object?, bool>(
          instance.auto_update_profile_picture, const ToBool().toJson),
      'contact': instance.contact?.toJson(),
      'last_login': const ToString().toJson(instance.last_login),
      'is_membership': _$JsonConverterToJson<Object?, bool>(
          instance.is_membership, const ToBool().toJson),
      'membership': instance.membership?.toJson(),
      'setting': instance.setting?.toJson(),
    };

AccountVerification _$AccountVerificationFromJson(Map json) =>
    AccountVerification(
      phone: json['phone'] == null
          ? null
          : PhoneUser.fromJson(Map<String, dynamic>.from(json['phone'] as Map)),
    );

Map<String, dynamic> _$AccountVerificationToJson(
        AccountVerification instance) =>
    <String, dynamic>{
      'phone': instance.phone?.toJson(),
    };

PhoneUser _$PhoneUserFromJson(Map json) => PhoneUser(
      value: const ToString().fromJson(json['value']),
      verify: const ToBool().fromJson(json['verify']),
    );

Map<String, dynamic> _$PhoneUserToJson(PhoneUser instance) => <String, dynamic>{
      'value': const ToString().toJson(instance.value),
      'verify': _$JsonConverterToJson<Object?, bool>(
          instance.verify, const ToBool().toJson),
    };

ContactUser _$ContactUserFromJson(Map json) => ContactUser(
      phone:
          (json['phone'] as List<dynamic>?)?.map((e) => e as String?).toList(),
    );

Map<String, dynamic> _$ContactUserToJson(ContactUser instance) =>
    <String, dynamic>{
      'phone': instance.phone,
    };

Membership _$MembershipFromJson(Map json) => Membership(
      title: const ToString().fromJson(json['title']),
      type: const ToString().fromJson(json['type']),
      status: const ToString().fromJson(json['status']),
      status_title: const ToString().fromJson(json['status_title']),
      num_ads: const ToInt().fromJson(json['num_ads']),
      renew: const ToInt().fromJson(json['renew']),
      auto_renew: const ToInt().fromJson(json['auto_renew']),
    );

Map<String, dynamic> _$MembershipToJson(Membership instance) =>
    <String, dynamic>{
      'title': const ToString().toJson(instance.title),
      'type': const ToString().toJson(instance.type),
      'status': const ToString().toJson(instance.status),
      'status_title': const ToString().toJson(instance.status_title),
      'num_ads': _$JsonConverterToJson<Object?, int>(
          instance.num_ads, const ToInt().toJson),
      'renew': _$JsonConverterToJson<Object?, int>(
          instance.renew, const ToInt().toJson),
      'auto_renew': _$JsonConverterToJson<Object?, int>(
          instance.auto_renew, const ToInt().toJson),
    };

SettingUser _$SettingUserFromJson(Map json) => SettingUser(
      chat: (json['chat'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      comment: (json['comment'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      like: const ToBool().fromJson(json['like']),
      save: const ToBool().fromJson(json['save']),
      follow: const ToBool().fromJson(json['follow']),
      job: (json['job'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      privacy: const ToBool().fromJson(json['privacy']),
      payment: (json['payment'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
    );

Map<String, dynamic> _$SettingUserToJson(SettingUser instance) =>
    <String, dynamic>{
      'chat': instance.chat?.map(const ToString().toJson).toList(),
      'comment': instance.comment?.map(const ToString().toJson).toList(),
      'like': _$JsonConverterToJson<Object?, bool>(
          instance.like, const ToBool().toJson),
      'save': _$JsonConverterToJson<Object?, bool>(
          instance.save, const ToBool().toJson),
      'follow': _$JsonConverterToJson<Object?, bool>(
          instance.follow, const ToBool().toJson),
      'job': instance.job?.map(const ToString().toJson).toList(),
      'privacy': _$JsonConverterToJson<Object?, bool>(
          instance.privacy, const ToBool().toJson),
      'payment': instance.payment?.map(const ToString().toJson).toList(),
    };

MessageLogin _$MessageLoginFromJson(Map json) => MessageLogin(
      message: const ToString().fromJson(json['message']),
      type: const ToString().fromJson(json['type']),
      code: const ToString().fromJson(json['code']),
      errors: json['errors'] == null
          ? null
          : KeyErrors.fromJson((json['errors'] as Map?)?.map(
              (k, e) => MapEntry(k as String, e),
            )),
    );

Map<String, dynamic> _$MessageLoginToJson(MessageLogin instance) =>
    <String, dynamic>{
      'message': const ToString().toJson(instance.message),
      'type': const ToString().toJson(instance.type),
      'code': const ToString().toJson(instance.code),
      'errors': instance.errors?.toJson(),
    };

KeyErrors _$KeyErrorsFromJson(Map json) => KeyErrors(
      password: json['password'] == null
          ? null
          : PasswordKey.fromJson((json['password'] as Map?)?.map(
              (k, e) => MapEntry(k as String, e),
            )),
      login: json['login'] == null
          ? null
          : LoginKey.fromJson((json['login'] as Map?)?.map(
              (k, e) => MapEntry(k as String, e),
            )),
    );

Map<String, dynamic> _$KeyErrorsToJson(KeyErrors instance) => <String, dynamic>{
      'login': instance.login?.toJson(),
      'password': instance.password?.toJson(),
    };

LoginKey _$LoginKeyFromJson(Map json) => LoginKey(
      message: const ToString().fromJson(json['message']),
    );

Map<String, dynamic> _$LoginKeyToJson(LoginKey instance) => <String, dynamic>{
      'message': const ToString().toJson(instance.message),
    };

PasswordKey _$PasswordKeyFromJson(Map json) => PasswordKey(
      message: const ToString().fromJson(json['message']),
    );

Map<String, dynamic> _$PasswordKeyToJson(PasswordKey instance) =>
    <String, dynamic>{
      'message': const ToString().toJson(instance.message),
    };
