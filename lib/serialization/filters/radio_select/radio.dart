
import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/helper.dart';
import 'package:k24/serialization/try_convert.dart';
part 'radio.g.dart';

@JsonSerializable(explicitToJson: true, converters: [ToString(), ToBool()])
class RadioSelect {
  @JsonKey(fromJson: ToString.tryConvert)
  String? fieldid;
  String? fieldname;
  String? title;
  String? type;
  dynamic validation;
  String? chained_field;
  String? slug;
  bool? display_icon;
  dynamic display_icon_type;
  bool? popular;
  List<ValueSelect?>? options;
  ValueSelect? value;
  dynamic controller;
  List<RadioSelect>? fields;

  RadioSelect({
    this.fieldid = '',
    this.fieldname,
    this.title,
    this.type,
    this.validation,
    this.chained_field,
    this.slug,
    this.display_icon,
    this.display_icon_type,
    this.popular,
    this.options,
    this.value,
    this.controller,
    this.fields,
  });

  factory RadioSelect.fromJson(Map<String, dynamic> json) => _$RadioSelectFromJson(json);
  Map toJson() => _$RadioSelectToJson(this);

}

@JsonSerializable(explicitToJson: true, converters: [ToString(), ToBool()])
class ValueSelect {
  @JsonKey(fromJson: ToString.tryConvert)
  String? fieldtitle;
  String? fieldvalue;
  bool? popular;
  String? fieldid;
  String? fieldparentvalue;
  IconSerial? icon;

  ValueSelect({
    this.fieldtitle,
    this.fieldvalue,
    this.popular,
    this.fieldid,
    this.fieldparentvalue,
    this.icon,
  });

  factory ValueSelect.fromJson(Map<String, dynamic> json) => _$ValueSelectFromJson(json);
  Map toJson() => _$ValueSelectToJson(this);

}
