
import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/try_convert.dart';
part 'min_max.g.dart';

@JsonSerializable(anyMap: true, converters: [ToString()])
class MinMax {
  String? fieldid;
  String? title;
  String? type;
  String? slug;
  Field_? min_field;
  Field_? max_field;
  dynamic min_controller;
  dynamic max_controller;

  MinMax({
    this.fieldid,
    this.title,
    this.type,
    this.slug,
    this.min_field,
    this.max_field,
    this.min_controller,
    this.max_controller
  });

  factory MinMax.fromJson(Map json) => _$MinMaxFromJson(json);
  Map toJson() => _$MinMaxToJson(this);

}

@JsonSerializable(anyMap: true, converters: [ToString(), ToBool()])
class Field_ {
  String? fieldid;
  String? title;
  String? type;
  String? slug;
  Map? validation;
  String? fieldname;
  String? chained_field;
  bool? display_icon;
  bool? popular;
  dynamic display_icon_type;
  Map? prefix;
  List<OptionM?>? options;

  Field_({
    this.fieldid,
    this.title,
    this.type,
    this.slug,
    this.validation,
    this.fieldname,
    this.chained_field,
    this.display_icon,
    this.popular,
    this.display_icon_type,
    this.prefix,
    this.options,
  });

  factory Field_.fromJson(Map json) => _$Field_FromJson(json);
  Map toJson() => _$Field_ToJson(this);

}

@JsonSerializable(anyMap: true, converters: [ToString()])
class Prefix_ {
  String? type;
  String? text;

  Prefix_({
    this.type,
    this.text,
  });

  factory Prefix_.fromJson(Map json) => _$Prefix_FromJson(json);
  Map toJson() => _$Prefix_ToJson(this);

}

@JsonSerializable(anyMap: true, converters: [ToBool(), ToString()])
class Validation_ {
  bool? numeric;
  String? greater_than;

  Validation_({
    this.numeric,
    this.greater_than,
  });

  factory Validation_.fromJson(Map json) => _$Validation_FromJson(json);
  Map toJson() => _$Validation_ToJson(this);

}

@JsonSerializable(anyMap: true, converters: [ToString(), ToInt(), ToBool()])
class OptionM {
  String? fieldid;
  int? fieldtitle;
  int? fieldvalue;
  bool? popular;

  OptionM({
    this.fieldid,
    this.fieldtitle,
    this.fieldvalue,
    this.popular,
  });

  factory OptionM.fromJson(Map json) => _$OptionMFromJson(json);
  Map toJson() => _$OptionMToJson(this);

}
