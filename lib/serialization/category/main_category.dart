
import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/helper.dart';
import 'package:k24/serialization/helper.dart';
import 'package:k24/serialization/helper.dart';
import 'package:k24/serialization/try_convert.dart';

part 'main_category.g.dart';

@JsonSerializable(converters: [ToString(), ToBool()])
class MainCategory {
  String? id;
  String? en_name;
  String? km_name;
  IconSerial? icon;
  String? slug;
  String? parent;
  bool? popular;
  ParentData? parent_data;

  MainCategory({
    this.id,
    this.en_name,
    this.km_name,
    this.icon,
    this.slug,
    this.parent,
    this.popular,
  });

  factory MainCategory.fromJson(Map<String, dynamic> json) => _$MainCategoryFromJson(json);
  Map toJson() => _$MainCategoryToJson(this);

}

@JsonSerializable(converters: [ToString()])
class ParentData {
  String? id;
  String? en_name;
  String? km_name;
  String? slug;

  ParentData({
    this.id,
    this.en_name,
    this.km_name,
    this.slug,
  });

  factory ParentData.fromJson(Map<String, dynamic> json) => _$ParentDataFromJson(json);
  Map toJson() => _$ParentDataToJson(this);

}
