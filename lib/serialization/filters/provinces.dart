
import 'package:json_annotation/json_annotation.dart';

import '../try_convert.dart';
part 'provinces.g.dart';

@JsonSerializable(anyMap: true, converters: [ToString(), ToBool()])
class Province {
  String? id;
  String? type;
  String? en_name;
  String? km_name;
  String? slug;
  String? orders;
  bool? popular;
  Icon_? icon;
  MapClass? map;

  Province({
    this.id,
    this.type,
    this.en_name,
    this.km_name,
    this.slug,
    this.orders,
    this.popular,
    this.icon,
    this.map,
  });

  factory Province.fromJson(Map json) => _$ProvinceFromJson(json);
  Map toJson() => _$ProvinceToJson(this);

}

@JsonSerializable(anyMap: true, converters: [ToString()])
class Icon_ {
  String? url;
  String? width;
  String? height;
  Large? small;
  Large? medium;
  Large? large;

  Icon_({
    this.url,
    this.width,
    this.height,
    this.small,
    this.medium,
    this.large,
  });

  factory Icon_.fromJson(Map json) => _$Icon_FromJson(json);
  Map toJson() => _$Icon_ToJson(this);

}

@JsonSerializable(anyMap: true, converters: [ToString()])
class Large {
  String? url;
  String? width;
  String? height;

  Large({
    this.url,
    this.width,
    this.height,
  });

  factory Large.fromJson(Map json) => _$LargeFromJson(json);
  Map toJson() => _$LargeToJson(this);

}

@JsonSerializable(anyMap: true, converters: [ToDouble(), ToInt()])
class MapClass {
  double? x;
  double? y;
  int? z;

  MapClass({
    this.x,
    this.y,
    this.z,
  });

  factory MapClass.fromJson(Map json) => _$MapClassFromJson(json);
  Map toJson() => _$MapClassToJson(this);

}
