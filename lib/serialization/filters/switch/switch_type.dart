

import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/try_convert.dart';
part 'switch_type.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToBool()])
class SwitchType {
  String? fieldid;
  String? title;
  String? type;
  String? slug;
  Validation? validation;
  String? fieldname;
  String? chained_field;
  bool? display_icon;
  bool? popular;
  dynamic display_icon_type;
  ValueSwitch? value;
  List<ValueSwitch>? options;

  SwitchType({
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
    this.value,
    this.options,
  });

  factory SwitchType.fromJson(Map json) => _$SwitchTypeFromJson(json);
  Map toJson() => _$SwitchTypeToJson(this);

}

@JsonSerializable(anyMap: true, converters: [ToString()])
class ValueSwitch {
  String? value;
  String? title;

  ValueSwitch({
    this.value,
    this.title,
  });

  factory ValueSwitch.fromJson(Map json) => _$ValueSwitchFromJson(json);
  Map toJson() => _$ValueSwitchToJson(this);

}

@JsonSerializable(anyMap: true, converters: [ToBool()])
class Validation {
  bool? numeric;

  Validation({
    this.numeric,
  });

  factory Validation.fromJson(Map json) => _$ValidationFromJson(json);
  Map toJson() => _$ValidationToJson(this);

}
