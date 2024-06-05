
import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/try_convert.dart';

part 'main_category.g.dart';

@JsonSerializable(converters: [ToString(), ToBool()])
class MainCategory {
  String? id;
  String? en_name;
  String? km_name;
  Icon2? icon;
  String? slug;
  String? parent;
  bool? popular;

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

@JsonSerializable(anyMap: true, converters: [ToString()])
class Icon2 {
  String? url;
  String? width;
  String? height;
  Large? small;
  Large? medium;
  Large? large;

  Icon2({
    this.url,
    this.width,
    this.height,
    this.small,
    this.medium,
    this.large,
  });

  factory Icon2.fromJson(Map json) => _$Icon2FromJson(json);
  Map toJson() => _$Icon2ToJson(this);

}

@JsonSerializable(converters: [ToString()])
class Large {
  String? url;
  String? width;
  String? height;

  Large({
    this.url,
    this.width,
    this.height,
  });

  factory Large.fromJson(Map<String, dynamic> json) => _$LargeFromJson(json);
  Map toJson() => _$LargeToJson(this);

}
