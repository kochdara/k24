// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provinces.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Province _$ProvinceFromJson(Map json) => Province(
      id: const ToString().fromJson(json['id']),
      type: const ToString().fromJson(json['type']),
      en_name: const ToString().fromJson(json['en_name']),
      km_name: const ToString().fromJson(json['km_name']),
      slug: const ToString().fromJson(json['slug']),
      orders: const ToString().fromJson(json['orders']),
      popular: const ToBool().fromJson(json['popular']),
      icon: json['icon'] == null ? null : Icon_.fromJson(json['icon'] as Map),
      map: json['map'] == null ? null : MapClass.fromJson(json['map'] as Map),
    );

Map<String, dynamic> _$ProvinceToJson(Province instance) => <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'type': const ToString().toJson(instance.type),
      'en_name': const ToString().toJson(instance.en_name),
      'km_name': const ToString().toJson(instance.km_name),
      'slug': const ToString().toJson(instance.slug),
      'orders': const ToString().toJson(instance.orders),
      'popular': _$JsonConverterToJson<Object?, bool>(
          instance.popular, const ToBool().toJson),
      'icon': instance.icon,
      'map': instance.map,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

Icon_ _$Icon_FromJson(Map json) => Icon_(
      url: const ToString().fromJson(json['url']),
      width: const ToString().fromJson(json['width']),
      height: const ToString().fromJson(json['height']),
      small:
          json['small'] == null ? null : Large.fromJson(json['small'] as Map),
      medium:
          json['medium'] == null ? null : Large.fromJson(json['medium'] as Map),
      large:
          json['large'] == null ? null : Large.fromJson(json['large'] as Map),
    );

Map<String, dynamic> _$Icon_ToJson(Icon_ instance) => <String, dynamic>{
      'url': const ToString().toJson(instance.url),
      'width': const ToString().toJson(instance.width),
      'height': const ToString().toJson(instance.height),
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
    };

Large _$LargeFromJson(Map json) => Large(
      url: const ToString().fromJson(json['url']),
      width: const ToString().fromJson(json['width']),
      height: const ToString().fromJson(json['height']),
    );

Map<String, dynamic> _$LargeToJson(Large instance) => <String, dynamic>{
      'url': const ToString().toJson(instance.url),
      'width': const ToString().toJson(instance.width),
      'height': const ToString().toJson(instance.height),
    };

MapClass _$MapClassFromJson(Map json) => MapClass(
      x: const ToDouble().fromJson(json['x']),
      y: const ToDouble().fromJson(json['y']),
      z: const ToInt().fromJson(json['z']),
    );

Map<String, dynamic> _$MapClassToJson(MapClass instance) => <String, dynamic>{
      'x': _$JsonConverterToJson<Object?, double>(
          instance.x, const ToDouble().toJson),
      'y': _$JsonConverterToJson<Object?, double>(
          instance.y, const ToDouble().toJson),
      'z':
          _$JsonConverterToJson<Object?, int>(instance.z, const ToInt().toJson),
    };
