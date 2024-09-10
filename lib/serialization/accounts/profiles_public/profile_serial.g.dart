// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_serial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileSerial _$ProfileSerialFromJson(Map json) => ProfileSerial(
      data: DataProfile.fromJson((json['data'] as Map?)?.map(
        (k, e) => MapEntry(k as String, e),
      )),
      meta: json['meta'] == null
          ? null
          : MetaProfile.fromJson((json['meta'] as Map?)?.map(
              (k, e) => MapEntry(k as String, e),
            )),
    );

Map<String, dynamic> _$ProfileSerialToJson(ProfileSerial instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
      'meta': instance.meta?.toJson(),
    };

DataProfile _$DataProfileFromJson(Map json) => DataProfile(
      id: const ToString().fromJson(json['id']),
      username: const ToString().fromJson(json['username']),
      name: const ToString().fromJson(json['name']),
      photo: json['photo'] == null
          ? null
          : CoverProfile.fromJson((json['photo'] as Map?)?.map(
              (k, e) => MapEntry(k as String, e),
            )),
      logo: json['logo'] == null
          ? null
          : CoverProfile.fromJson((json['logo'] as Map?)?.map(
              (k, e) => MapEntry(k as String, e),
            )),
      cover: json['cover'] == null
          ? null
          : CoverProfile.fromJson((json['cover'] as Map?)?.map(
              (k, e) => MapEntry(k as String, e),
            )),
      registered_date: const ToDateTime().fromJson(json['registered_date']),
      online_status: json['online_status'] == null
          ? null
          : OnlineStatusProfile.fromJson((json['online_status'] as Map?)?.map(
              (k, e) => MapEntry(k as String, e),
            )),
      contact: json['contact'] == null
          ? null
          : ContactProfile.fromJson((json['contact'] as Map?)?.map(
              (k, e) => MapEntry(k as String, e),
            )),
      type: const ToString().fromJson(json['type']),
      is_verify: const ToBool().fromJson(json['is_verify']),
      verified: (json['verified'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      link: const ToString().fromJson(json['link']),
      menu: (json['menu'] as List<dynamic>?)?.map((e) => e as String).toList(),
      is_saved: const ToBool().fromJson(json['is_saved']),
      following: const ToString().fromJson(json['following']),
      followers: const ToString().fromJson(json['followers']),
      is_follow: const ToBool().fromJson(json['is_follow']),
      setting: json['setting'] == null
          ? null
          : SettingProfile.fromJson((json['setting'] as Map?)?.map(
              (k, e) => MapEntry(k as String, e),
            )),
    );

Map<String, dynamic> _$DataProfileToJson(DataProfile instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'username': const ToString().toJson(instance.username),
      'name': const ToString().toJson(instance.name),
      'photo': instance.photo?.toJson(),
      'logo': instance.logo?.toJson(),
      'cover': instance.cover?.toJson(),
      'registered_date': const ToDateTime().toJson(instance.registered_date),
      'online_status': instance.online_status?.toJson(),
      'contact': instance.contact?.toJson(),
      'type': const ToString().toJson(instance.type),
      'is_verify': _$JsonConverterToJson<Object?, bool>(
          instance.is_verify, const ToBool().toJson),
      'verified': instance.verified?.map(const ToString().toJson).toList(),
      'link': const ToString().toJson(instance.link),
      'menu': instance.menu,
      'is_saved': _$JsonConverterToJson<Object?, bool>(
          instance.is_saved, const ToBool().toJson),
      'following': const ToString().toJson(instance.following),
      'followers': const ToString().toJson(instance.followers),
      'is_follow': _$JsonConverterToJson<Object?, bool>(
          instance.is_follow, const ToBool().toJson),
      'setting': instance.setting?.toJson(),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

ContactProfile _$ContactProfileFromJson(Map json) => ContactProfile(
      name: const ToString().fromJson(json['name']),
      email: json['email'],
      map: json['map'],
      address: json['address'],
      phone: const ToString().fromJson(json['phone']),
      phone_white_operator: (json['phone_white_operator'] as List<dynamic>?)
          ?.map(
              (e) => e == null ? null : PhoneWhiteOperator.fromJson(e as Map?))
          .toList(),
    );

Map<String, dynamic> _$ContactProfileToJson(ContactProfile instance) =>
    <String, dynamic>{
      'name': const ToString().toJson(instance.name),
      'email': instance.email,
      'map': instance.map,
      'address': instance.address,
      'phone': const ToString().toJson(instance.phone),
      'phone_white_operator':
          instance.phone_white_operator?.map((e) => e?.toJson()).toList(),
    };

SettingProfile _$SettingProfileFromJson(Map json) => SettingProfile(
      enable_save: const ToBool().fromJson(json['enable_save']),
      enable_follow: const ToBool().fromJson(json['enable_follow']),
      enable_chat: const ToBool().fromJson(json['enable_chat']),
    );

Map<String, dynamic> _$SettingProfileToJson(SettingProfile instance) =>
    <String, dynamic>{
      'enable_save': _$JsonConverterToJson<Object?, bool>(
          instance.enable_save, const ToBool().toJson),
      'enable_follow': _$JsonConverterToJson<Object?, bool>(
          instance.enable_follow, const ToBool().toJson),
      'enable_chat': _$JsonConverterToJson<Object?, bool>(
          instance.enable_chat, const ToBool().toJson),
    };

MetaProfile _$MetaProfileFromJson(Map json) => MetaProfile(
      site_ame: const ToString().fromJson(json['site_ame']),
      title: const ToString().fromJson(json['title']),
      description: const ToString().fromJson(json['description']),
      keyword: const ToString().fromJson(json['keyword']),
      author: const ToString().fromJson(json['author']),
      username: const ToString().fromJson(json['username']),
      fb: json['fb'] == null
          ? null
          : FbProfile.fromJson((json['fb'] as Map?)?.map(
              (k, e) => MapEntry(k as String, e),
            )),
      image: const ToString().fromJson(json['image']),
      url: const ToString().fromJson(json['url']),
      deeplink: const ToString().fromJson(json['deeplink']),
      date: const ToDateTime().fromJson(json['date']),
    );

Map<String, dynamic> _$MetaProfileToJson(MetaProfile instance) =>
    <String, dynamic>{
      'site_ame': const ToString().toJson(instance.site_ame),
      'title': const ToString().toJson(instance.title),
      'description': const ToString().toJson(instance.description),
      'keyword': const ToString().toJson(instance.keyword),
      'author': const ToString().toJson(instance.author),
      'username': const ToString().toJson(instance.username),
      'fb': instance.fb?.toJson(),
      'image': const ToString().toJson(instance.image),
      'url': const ToString().toJson(instance.url),
      'deeplink': const ToString().toJson(instance.deeplink),
      'date': const ToDateTime().toJson(instance.date),
    };

FbProfile _$FbProfileFromJson(Map json) => FbProfile(
      id: const ToString().fromJson(json['id']),
      type: const ToString().fromJson(json['type']),
    );

Map<String, dynamic> _$FbProfileToJson(FbProfile instance) => <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'type': const ToString().toJson(instance.type),
    };
