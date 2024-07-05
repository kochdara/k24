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
      icon: json['icon'] == null
          ? null
          : IconSerial.fromJson(json['icon'] as Map),
      map: json['map'] == null
          ? null
          : MapClass.fromJson(Map<String, dynamic>.from(json['map'] as Map)),
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
