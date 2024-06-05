// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switch_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SwitchType _$SwitchTypeFromJson(Map json) => SwitchType(
      fieldid: const ToString().fromJson(json['fieldid']),
      title: const ToString().fromJson(json['title']),
      type: const ToString().fromJson(json['type']),
      slug: const ToString().fromJson(json['slug']),
      validation: json['validation'] == null
          ? null
          : Validation.fromJson(json['validation'] as Map),
      fieldname: const ToString().fromJson(json['fieldname']),
      chained_field: const ToString().fromJson(json['chained_field']),
      display_icon: const ToBool().fromJson(json['display_icon']),
      popular: const ToBool().fromJson(json['popular']),
      display_icon_type: json['display_icon_type'],
      value: json['value'] == null
          ? null
          : ValueSwitch.fromJson(json['value'] as Map),
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => ValueSwitch.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$SwitchTypeToJson(SwitchType instance) =>
    <String, dynamic>{
      'fieldid': const ToString().toJson(instance.fieldid),
      'title': const ToString().toJson(instance.title),
      'type': const ToString().toJson(instance.type),
      'slug': const ToString().toJson(instance.slug),
      'validation': instance.validation?.toJson(),
      'fieldname': const ToString().toJson(instance.fieldname),
      'chained_field': const ToString().toJson(instance.chained_field),
      'display_icon': _$JsonConverterToJson<Object?, bool>(
          instance.display_icon, const ToBool().toJson),
      'popular': _$JsonConverterToJson<Object?, bool>(
          instance.popular, const ToBool().toJson),
      'display_icon_type': instance.display_icon_type,
      'value': instance.value?.toJson(),
      'options': instance.options?.map((e) => e.toJson()).toList(),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

ValueSwitch _$ValueSwitchFromJson(Map json) => ValueSwitch(
      value: const ToString().fromJson(json['value']),
      title: const ToString().fromJson(json['title']),
    );

Map<String, dynamic> _$ValueSwitchToJson(ValueSwitch instance) =>
    <String, dynamic>{
      'value': const ToString().toJson(instance.value),
      'title': const ToString().toJson(instance.title),
    };

Validation _$ValidationFromJson(Map json) => Validation(
      numeric: const ToBool().fromJson(json['numeric']),
    );

Map<String, dynamic> _$ValidationToJson(Validation instance) =>
    <String, dynamic>{
      'numeric': _$JsonConverterToJson<Object?, bool>(
          instance.numeric, const ToBool().toJson),
    };
