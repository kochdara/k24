// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadioSelect _$RadioSelectFromJson(Map<String, dynamic> json) => RadioSelect(
      fieldid:
          json['fieldid'] == null ? '' : ToString.tryConvert(json['fieldid']),
      fieldname: const ToString().fromJson(json['fieldname']),
      title: const ToString().fromJson(json['title']),
      type: const ToString().fromJson(json['type']),
      validation: json['validation'],
      chained_field: const ToString().fromJson(json['chained_field']),
      slug: const ToString().fromJson(json['slug']),
      display_icon: const ToBool().fromJson(json['display_icon']),
      display_icon_type: json['display_icon_type'],
      popular: const ToBool().fromJson(json['popular']),
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ValueSelect.fromJson(e as Map<String, dynamic>))
          .toList(),
      value: json['value'] == null
          ? null
          : ValueSelect.fromJson(json['value'] as Map<String, dynamic>),
      controller: json['controller'],
      fields: (json['fields'] as List<dynamic>?)
          ?.map((e) => RadioSelect.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RadioSelectToJson(RadioSelect instance) =>
    <String, dynamic>{
      'fieldid': const ToString().toJson(instance.fieldid),
      'fieldname': const ToString().toJson(instance.fieldname),
      'title': const ToString().toJson(instance.title),
      'type': const ToString().toJson(instance.type),
      'validation': instance.validation,
      'chained_field': const ToString().toJson(instance.chained_field),
      'slug': const ToString().toJson(instance.slug),
      'display_icon': _$JsonConverterToJson<Object?, bool>(
          instance.display_icon, const ToBool().toJson),
      'display_icon_type': instance.display_icon_type,
      'popular': _$JsonConverterToJson<Object?, bool>(
          instance.popular, const ToBool().toJson),
      'options': instance.options?.map((e) => e?.toJson()).toList(),
      'value': instance.value?.toJson(),
      'controller': instance.controller,
      'fields': instance.fields?.map((e) => e.toJson()).toList(),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

ValueSelect _$ValueSelectFromJson(Map<String, dynamic> json) => ValueSelect(
      fieldtitle: ToString.tryConvert(json['fieldtitle']),
      fieldvalue: const ToString().fromJson(json['fieldvalue']),
      popular: const ToBool().fromJson(json['popular']),
      fieldid: const ToString().fromJson(json['fieldid']),
      fieldparentvalue: const ToString().fromJson(json['fieldparentvalue']),
      icon: json['icon'] == null
          ? null
          : IconSerial.fromJson(json['icon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ValueSelectToJson(ValueSelect instance) =>
    <String, dynamic>{
      'fieldtitle': const ToString().toJson(instance.fieldtitle),
      'fieldvalue': const ToString().toJson(instance.fieldvalue),
      'popular': _$JsonConverterToJson<Object?, bool>(
          instance.popular, const ToBool().toJson),
      'fieldid': const ToString().toJson(instance.fieldid),
      'fieldparentvalue': const ToString().toJson(instance.fieldparentvalue),
      'icon': instance.icon?.toJson(),
    };
