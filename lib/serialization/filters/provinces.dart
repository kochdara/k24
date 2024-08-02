
import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/helper.dart';

import '../try_convert.dart';
part 'provinces.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToBool()])
class Province {
  String? id;
  String? type;
  String? en_name;
  String? km_name;
  String? slug;
  String? orders;
  bool? popular;
  IconSerial? icon;
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
