// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_fields.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupFields _$GroupFieldsFromJson(Map json) => GroupFields(
      fieldid: const ToString().fromJson(json['fieldid']),
      title: const ToString().fromJson(json['title']),
      type: const ToString().fromJson(json['type']),
      slug: const ToString().fromJson(json['slug']),
      validation: const ToBool().fromJson(json['validation']),
      fieldname: const ToString().fromJson(json['fieldname']),
      chained_field: const ToString().fromJson(json['chained_field']),
      display_icon: const ToBool().fromJson(json['display_icon']),
      popular: const ToBool().fromJson(json['popular']),
      display_icon_type: json['display_icon_type'],
      fields: (json['fields'] as List<dynamic>?)
          ?.map(
              (e) => RadioSelect.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$GroupFieldsToJson(GroupFields instance) =>
    <String, dynamic>{
      'fieldid': const ToString().toJson(instance.fieldid),
      'title': const ToString().toJson(instance.title),
      'type': const ToString().toJson(instance.type),
      'slug': const ToString().toJson(instance.slug),
      'validation': _$JsonConverterToJson<Object?, bool>(
          instance.validation, const ToBool().toJson),
      'fieldname': const ToString().toJson(instance.fieldname),
      'chained_field': const ToString().toJson(instance.chained_field),
      'display_icon': _$JsonConverterToJson<Object?, bool>(
          instance.display_icon, const ToBool().toJson),
      'popular': _$JsonConverterToJson<Object?, bool>(
          instance.popular, const ToBool().toJson),
      'display_icon_type': instance.display_icon_type,
      'fields': instance.fields?.map((e) => e.toJson()).toList(),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
