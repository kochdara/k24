// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_serial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSerial _$UserSerialFromJson(Map json) => UserSerial(
      data:
          json['data'] == null ? null : DataUser.fromJson(json['data'] as Map),
      login: json['login'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UserSerialToJson(UserSerial instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'login': instance.login,
      'password': instance.password,
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
      photo: json['photo'] == null
          ? null
          : CoverProfile.fromJson((json['photo'] as Map?)?.map(
              (k, e) => MapEntry(k as String, e),
            )),
      cover: json['cover'] == null
          ? null
          : CoverProfile.fromJson((json['cover'] as Map?)?.map(
              (k, e) => MapEntry(k as String, e),
            )),
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
      'photo': instance.photo?.toJson(),
      'cover': instance.cover?.toJson(),
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
      map: json['map'] == null
          ? null
          : MapClass.fromJson(Map<String, dynamic>.from(json['map'] as Map)),
      location: json['location'] == null
          ? null
          : CommuneUser.fromJson(
              Map<String, dynamic>.from(json['location'] as Map)),
      commune: json['commune'] == null
          ? null
          : CommuneUser.fromJson(
              Map<String, dynamic>.from(json['commune'] as Map)),
      district: json['district'] == null
          ? null
          : CommuneUser.fromJson(
              Map<String, dynamic>.from(json['district'] as Map)),
      address: json['address'] as String?,
      email: json['email'] as String?,
      phone:
          (json['phone'] as List<dynamic>?)?.map((e) => e as String?).toList(),
    );

Map<String, dynamic> _$ContactUserToJson(ContactUser instance) =>
    <String, dynamic>{
      'map': instance.map?.toJson(),
      'location': instance.location?.toJson(),
      'commune': instance.commune?.toJson(),
      'district': instance.district?.toJson(),
      'address': instance.address,
      'email': instance.email,
      'phone': instance.phone,
    };

CommuneUser _$CommuneUserFromJson(Map json) => CommuneUser(
      id: const ToString().fromJson(json['id']),
      km_name: const ToString().fromJson(json['km_name']),
      en_name: const ToString().fromJson(json['en_name']),
      slug: const ToString().fromJson(json['slug']),
    );

Map<String, dynamic> _$CommuneUserToJson(CommuneUser instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'km_name': const ToString().toJson(instance.km_name),
      'en_name': const ToString().toJson(instance.en_name),
      'slug': const ToString().toJson(instance.slug),
    };

CoverProfile _$CoverProfileFromJson(Map json) => CoverProfile(
      url: const ToString().fromJson(json['url']),
      width: const ToString().fromJson(json['width']),
      height: const ToString().fromJson(json['height']),
      small: json['small'] == null
          ? null
          : SizeOfImage.fromJson(
              Map<String, dynamic>.from(json['small'] as Map)),
      medium: json['medium'] == null
          ? null
          : SizeOfImage.fromJson(
              Map<String, dynamic>.from(json['medium'] as Map)),
      large: json['large'] == null
          ? null
          : SizeOfImage.fromJson(
              Map<String, dynamic>.from(json['large'] as Map)),
      align: const ToString().fromJson(json['align']),
      offset: json['offset'],
    );

Map<String, dynamic> _$CoverProfileToJson(CoverProfile instance) =>
    <String, dynamic>{
      'url': const ToString().toJson(instance.url),
      'width': const ToString().toJson(instance.width),
      'height': const ToString().toJson(instance.height),
      'small': instance.small?.toJson(),
      'medium': instance.medium?.toJson(),
      'large': instance.large?.toJson(),
      'align': const ToString().toJson(instance.align),
      'offset': instance.offset,
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
      availability: const ToBool().fromJson(json['availability']),
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
      'availability': _$JsonConverterToJson<Object?, bool>(
          instance.availability, const ToBool().toJson),
      'payment': instance.payment?.map(const ToString().toJson).toList(),
    };

MessageLogin _$MessageLoginFromJson(Map json) => MessageLogin(
      message: const ToString().fromJson(json['message']),
      status: const ToString().fromJson(json['status']),
      type: const ToString().fromJson(json['type']),
      code: const ToString().fromJson(json['code']),
      errors: json['errors'] == null
          ? null
          : KeyErrors.fromJson((json['errors'] as Map?)?.map(
              (k, e) => MapEntry(k as String, e),
            )),
      data: json['data'],
      next_page: json['next_page'] == null
          ? null
          : NextPage.fromJson((json['next_page'] as Map?)?.map(
              (k, e) => MapEntry(k as String, e),
            )),
    );

Map<String, dynamic> _$MessageLoginToJson(MessageLogin instance) =>
    <String, dynamic>{
      'message': const ToString().toJson(instance.message),
      'status': const ToString().toJson(instance.status),
      'type': const ToString().toJson(instance.type),
      'code': const ToString().toJson(instance.code),
      'errors': instance.errors?.toJson(),
      'data': instance.data,
      'next_page': instance.next_page?.toJson(),
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

NextPage _$NextPageFromJson(Map json) => NextPage(
      page: const ToString().fromJson(json['page']),
      data: json['data'] == null
          ? null
          : NextPageData.fromJson((json['data'] as Map?)?.map(
              (k, e) => MapEntry(k as String, e),
            )),
    );

Map<String, dynamic> _$NextPageToJson(NextPage instance) => <String, dynamic>{
      'page': const ToString().toJson(instance.page),
      'data': instance.data?.toJson(),
    };

NextPageData _$NextPageDataFromJson(Map json) => NextPageData(
      verify: json['verify'] == null
          ? null
          : Verify.fromJson(json['verify'] as Map),
    );

Map<String, dynamic> _$NextPageDataToJson(NextPageData instance) =>
    <String, dynamic>{
      'verify': instance.verify?.toJson(),
    };

Verify _$VerifyFromJson(Map json) => Verify(
      type: const ToString().fromJson(json['type']),
      value: const ToString().fromJson(json['value']),
    );

Map<String, dynamic> _$VerifyToJson(Verify instance) => <String, dynamic>{
      'type': const ToString().toJson(instance.type),
      'value': const ToString().toJson(instance.value),
    };
