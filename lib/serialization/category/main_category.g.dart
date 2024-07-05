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
          : IconSerial.fromJson(json['icon'] as Map<String, dynamic>),
      slug: const ToString().fromJson(json['slug']),
      parent: const ToString().fromJson(json['parent']),
      popular: const ToBool().fromJson(json['popular']),
    )..parent_data = json['parent_data'] == null
        ? null
        : ParentData.fromJson(json['parent_data'] as Map<String, dynamic>);

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
      'parent_data': instance.parent_data,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

ParentData _$ParentDataFromJson(Map<String, dynamic> json) => ParentData(
      id: const ToString().fromJson(json['id']),
      en_name: const ToString().fromJson(json['en_name']),
      km_name: const ToString().fromJson(json['km_name']),
      slug: const ToString().fromJson(json['slug']),
    );

Map<String, dynamic> _$ParentDataToJson(ParentData instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'en_name': const ToString().toJson(instance.en_name),
      'km_name': const ToString().toJson(instance.km_name),
      'slug': const ToString().toJson(instance.slug),
    };
