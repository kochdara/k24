// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'min_max.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinMax _$MinMaxFromJson(Map json) => MinMax(
      fieldid: const ToString().fromJson(json['fieldid']),
      title: const ToString().fromJson(json['title']),
      type: const ToString().fromJson(json['type']),
      slug: const ToString().fromJson(json['slug']),
      min_field: json['min_field'] == null
          ? null
          : Field_.fromJson(json['min_field'] as Map),
      max_field: json['max_field'] == null
          ? null
          : Field_.fromJson(json['max_field'] as Map),
      min_controller: json['min_controller'],
      max_controller: json['max_controller'],
    );

Map<String, dynamic> _$MinMaxToJson(MinMax instance) => <String, dynamic>{
      'fieldid': const ToString().toJson(instance.fieldid),
      'title': const ToString().toJson(instance.title),
      'type': const ToString().toJson(instance.type),
      'slug': const ToString().toJson(instance.slug),
      'min_field': instance.min_field?.toJson(),
      'max_field': instance.max_field?.toJson(),
      'min_controller': instance.min_controller,
      'max_controller': instance.max_controller,
    };

Field_ _$Field_FromJson(Map json) => Field_(
      fieldid: const ToString().fromJson(json['fieldid']),
      title: const ToString().fromJson(json['title']),
      type: const ToString().fromJson(json['type']),
      slug: const ToString().fromJson(json['slug']),
      validation: json['validation'] as Map?,
      fieldname: const ToString().fromJson(json['fieldname']),
      chained_field: const ToString().fromJson(json['chained_field']),
      display_icon: const ToBool().fromJson(json['display_icon']),
      popular: const ToBool().fromJson(json['popular']),
      display_icon_type: json['display_icon_type'],
      prefix: json['prefix'] as Map?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : OptionM.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$Field_ToJson(Field_ instance) => <String, dynamic>{
      'fieldid': const ToString().toJson(instance.fieldid),
      'title': const ToString().toJson(instance.title),
      'type': const ToString().toJson(instance.type),
      'slug': const ToString().toJson(instance.slug),
      'validation': instance.validation,
      'fieldname': const ToString().toJson(instance.fieldname),
      'chained_field': const ToString().toJson(instance.chained_field),
      'display_icon': _$JsonConverterToJson<Object?, bool>(
          instance.display_icon, const ToBool().toJson),
      'popular': _$JsonConverterToJson<Object?, bool>(
          instance.popular, const ToBool().toJson),
      'display_icon_type': instance.display_icon_type,
      'prefix': instance.prefix,
      'options': instance.options?.map((e) => e?.toJson()).toList(),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

Prefix_ _$Prefix_FromJson(Map json) => Prefix_(
      type: const ToString().fromJson(json['type']),
      text: const ToString().fromJson(json['text']),
    );

Map<String, dynamic> _$Prefix_ToJson(Prefix_ instance) => <String, dynamic>{
      'type': const ToString().toJson(instance.type),
      'text': const ToString().toJson(instance.text),
    };

Validation_ _$Validation_FromJson(Map json) => Validation_(
      numeric: const ToBool().fromJson(json['numeric']),
      greater_than: const ToString().fromJson(json['greater_than']),
    );

Map<String, dynamic> _$Validation_ToJson(Validation_ instance) =>
    <String, dynamic>{
      'numeric': _$JsonConverterToJson<Object?, bool>(
          instance.numeric, const ToBool().toJson),
      'greater_than': const ToString().toJson(instance.greater_than),
    };

OptionM _$OptionMFromJson(Map json) => OptionM(
      fieldid: const ToString().fromJson(json['fieldid']),
      fieldtitle: const ToInt().fromJson(json['fieldtitle']),
      fieldvalue: const ToInt().fromJson(json['fieldvalue']),
      popular: const ToBool().fromJson(json['popular']),
    );

Map<String, dynamic> _$OptionMToJson(OptionM instance) => <String, dynamic>{
      'fieldid': const ToString().toJson(instance.fieldid),
      'fieldtitle': _$JsonConverterToJson<Object?, int>(
          instance.fieldtitle, const ToInt().toJson),
      'fieldvalue': _$JsonConverterToJson<Object?, int>(
          instance.fieldvalue, const ToInt().toJson),
      'popular': _$JsonConverterToJson<Object?, bool>(
          instance.popular, const ToBool().toJson),
    };
