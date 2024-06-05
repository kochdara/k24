// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainCategory _$MainCategoryFromJson(Map<String, dynamic> json) => MainCategory(
      id: const ToString().fromJson(json['id']),
      en_name: const ToString().fromJson(json['en_name']),
      km_name: const ToString().fromJson(json['km_name']),
      icon: json['icon'] == null
          ? null
          : Icon2.fromJson(json['icon'] as Map<String, dynamic>),
      slug: const ToString().fromJson(json['slug']),
      parent: const ToString().fromJson(json['parent']),
      popular: const ToBool().fromJson(json['popular']),
    );

Map<String, dynamic> _$MainCategoryToJson(MainCategory instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'en_name': const ToString().toJson(instance.en_name),
      'km_name': const ToString().toJson(instance.km_name),
      'icon': instance.icon,
      'slug': const ToString().toJson(instance.slug),
      'parent': const ToString().toJson(instance.parent),
      'popular': _$JsonConverterToJson<Object?, bool>(
          instance.popular, const ToBool().toJson),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

Icon2 _$Icon2FromJson(Map json) => Icon2(
      url: const ToString().fromJson(json['url']),
      width: const ToString().fromJson(json['width']),
      height: const ToString().fromJson(json['height']),
      small: json['small'] == null
          ? null
          : Large.fromJson(Map<String, dynamic>.from(json['small'] as Map)),
      medium: json['medium'] == null
          ? null
          : Large.fromJson(Map<String, dynamic>.from(json['medium'] as Map)),
      large: json['large'] == null
          ? null
          : Large.fromJson(Map<String, dynamic>.from(json['large'] as Map)),
    );

Map<String, dynamic> _$Icon2ToJson(Icon2 instance) => <String, dynamic>{
      'url': const ToString().toJson(instance.url),
      'width': const ToString().toJson(instance.width),
      'height': const ToString().toJson(instance.height),
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
    };

Large _$LargeFromJson(Map<String, dynamic> json) => Large(
      url: const ToString().fromJson(json['url']),
      width: const ToString().fromJson(json['width']),
      height: const ToString().fromJson(json['height']),
    );

Map<String, dynamic> _$LargeToJson(Large instance) => <String, dynamic>{
      'url': const ToString().toJson(instance.url),
      'width': const ToString().toJson(instance.width),
      'height': const ToString().toJson(instance.height),
    };
