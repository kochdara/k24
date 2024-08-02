// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SizeOfImage _$SizeOfImageFromJson(Map json) => SizeOfImage(
      url: const ToString().fromJson(json['url']),
      width: const ToString().fromJson(json['width']),
      height: const ToString().fromJson(json['height']),
    );

Map<String, dynamic> _$SizeOfImageToJson(SizeOfImage instance) =>
    <String, dynamic>{
      'url': const ToString().toJson(instance.url),
      'width': const ToString().toJson(instance.width),
      'height': const ToString().toJson(instance.height),
    };

OnlineStatusProfile _$OnlineStatusProfileFromJson(Map json) =>
    OnlineStatusProfile(
      is_active: const ToBool().fromJson(json['is_active']),
      last_active: const ToString().fromJson(json['last_active']),
      time: const ToInt().fromJson(json['time']),
      date: const ToDateTime().fromJson(json['date']),
    );

Map<String, dynamic> _$OnlineStatusProfileToJson(
        OnlineStatusProfile instance) =>
    <String, dynamic>{
      'is_active': _$JsonConverterToJson<Object?, bool>(
          instance.is_active, const ToBool().toJson),
      'last_active': const ToString().toJson(instance.last_active),
      'time': _$JsonConverterToJson<Object?, int>(
          instance.time, const ToInt().toJson),
      'date': const ToDateTime().toJson(instance.date),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

PhoneWhiteOperator _$PhoneWhiteOperatorFromJson(Map json) => PhoneWhiteOperator(
      title: const ToString().fromJson(json['title']),
      phone: const ToString().fromJson(json['phone']),
      slug: const ToString().fromJson(json['slug']),
      icon: const ToString().fromJson(json['icon']),
    );

Map<String, dynamic> _$PhoneWhiteOperatorToJson(PhoneWhiteOperator instance) =>
    <String, dynamic>{
      'title': const ToString().toJson(instance.title),
      'phone': const ToString().toJson(instance.phone),
      'slug': const ToString().toJson(instance.slug),
      'icon': const ToString().toJson(instance.icon),
    };

Location_ _$Location_FromJson(Map<String, dynamic> json) => Location_(
      id: const ToString().fromJson(json['id']),
      type: const ToString().fromJson(json['type']),
      en_name: const ToString().fromJson(json['en_name']),
      km_name: const ToString().fromJson(json['km_name']),
      en_name2: const ToString().fromJson(json['en_name2']),
      km_name2: const ToString().fromJson(json['km_name2']),
      en_name3: const ToString().fromJson(json['en_name3']),
      km_name3: const ToString().fromJson(json['km_name3']),
      slug: const ToString().fromJson(json['slug']),
      address: const ToString().fromJson(json['address']),
      long_location: const ToString().fromJson(json['long_location']),
      province: json['province'] == null
          ? null
          : Location_.fromJson(json['province'] as Map<String, dynamic>),
      district: json['district'] == null
          ? null
          : Location_.fromJson(json['district'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$Location_ToJson(Location_ instance) => <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'type': const ToString().toJson(instance.type),
      'en_name': const ToString().toJson(instance.en_name),
      'km_name': const ToString().toJson(instance.km_name),
      'en_name2': const ToString().toJson(instance.en_name2),
      'km_name2': const ToString().toJson(instance.km_name2),
      'en_name3': const ToString().toJson(instance.en_name3),
      'km_name3': const ToString().toJson(instance.km_name3),
      'slug': const ToString().toJson(instance.slug),
      'address': const ToString().toJson(instance.address),
      'long_location': const ToString().toJson(instance.long_location),
      'province': instance.province,
      'district': instance.district,
    };

IconSerial _$IconSerialFromJson(Map json) => IconSerial(
      url: const ToString().fromJson(json['url']),
      width: const ToString().fromJson(json['width']),
      height: const ToString().fromJson(json['height']),
      small: json['small'] == null
          ? null
          : SizeOfImage.fromJson(
              Map<String, dynamic>.from(json['small'] as Map)),
      file: const ToString().fromJson(json['file']),
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

Map<String, dynamic> _$IconSerialToJson(IconSerial instance) =>
    <String, dynamic>{
      'url': const ToString().toJson(instance.url),
      'width': const ToString().toJson(instance.width),
      'height': const ToString().toJson(instance.height),
      'file': const ToString().toJson(instance.file),
      'small': instance.small?.toJson(),
      'medium': instance.medium?.toJson(),
      'large': instance.large?.toJson(),
      'align': const ToString().toJson(instance.align),
      'offset': instance.offset,
    };

MapClass _$MapClassFromJson(Map json) => MapClass(
      x: const ToString().fromJson(json['x']),
      y: const ToString().fromJson(json['y']),
      z: const ToString().fromJson(json['z']),
    );

Map<String, dynamic> _$MapClassToJson(MapClass instance) => <String, dynamic>{
      'x': const ToString().toJson(instance.x),
      'y': const ToString().toJson(instance.y),
      'z': const ToString().toJson(instance.z),
    };
