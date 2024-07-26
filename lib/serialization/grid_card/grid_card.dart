
import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/try_convert.dart';
import 'package:k24/serialization/users/user_serial.dart';

import '../category/main_category.dart';
import '../helper.dart';

part 'grid_card.g.dart';

@JsonSerializable(anyMap: true, converters: [ ToInt() ])
class HomeSerial {
  int? total;
  int? limit;
  int? offset;
  int? current_result;
  List<GridCard?>? data;

  HomeSerial({
    this.total,
    this.limit,
    this.offset,
    this.current_result,
    this.data,
  });

  factory HomeSerial.fromJson(Map json) => _$HomeSerialFromJson(json);
  Map<String, dynamic> toJson() => _$HomeSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class GridCard {
  @JsonKey(fromJson: ToString.tryConvert)
  String? type;
  Data_? data;
  Setting_? setting;
  List<String?>? actions;

  GridCard({
    this.type,
    this.data,
    this.setting,
    this.actions,
  });

  factory GridCard.fromJson(Map json) => _$GridCardFromJson(json);
  Map toJson() => _$GridCardToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToBool(), ToInt(), ToDouble(), ToDateTime()])
class Data_ {
  @JsonKey(fromJson: ToString.tryConvert)
  String? id;
  String? title;
  bool? is_premium;
  String? description;
  GridDiscount? discount;
  String? photo;
  List<String?>? photos;
  String? thumbnail;
  List<String?>? thumbnails;
  List<String?>? phone;
  List<PhoneWhiteOperator?>? phone_white_operator;
  String? views;
  DateTime? renew_date;
  DateTime? posted_date;
  String? link;
  String? short_link;
  int? total_comment;
  User_? user;
  Store_? store;
  Location_? location;
  MainCategory? category;
  List<HighlightSpec?>? highlight_specs;
  List<Spec_?>? specs;
  String? status;
  Condition_? condition;
  String? type;
  double? price;
  int? total_like;
  bool? is_saved;
  bool? is_like;
  GridShipping? shipping;

  Data_({
    this.id,
    this.title,
    this.is_premium,
    this.description,
    this.discount,
    this.photo,
    this.photos,
    this.thumbnail,
    this.thumbnails,
    this.phone,
    this.phone_white_operator,
    this.views,
    this.renew_date,
    this.posted_date,
    this.link,
    this.short_link,
    this.total_comment,
    this.user,
    this.store,
    this.location,
    this.category,
    this.highlight_specs,
    this.specs,
    this.status,
    this.condition,
    this.type,
    this.price,
    this.total_like,
    this.is_saved,
    this.is_like,
  });

  factory Data_.fromJson(Map json) => _$Data_FromJson(json);
  Map toJson() => _$Data_ToJson(this);

}

@JsonSerializable(explicitToJson: true, converters: [ToString()])
class GridDiscount {
  String? sale_price;
  String? original_price;
  String? amount_saved;
  String? type;
  String? discount;

  GridDiscount({
    this.sale_price,
    this.original_price,
    this.amount_saved,
    this.type,
    this.discount,
  });

  factory GridDiscount.fromJson(Map<String, dynamic> json) => _$GridDiscountFromJson(json);
  Map toJson() => _$GridDiscountToJson(this);

}

@JsonSerializable(explicitToJson: true, converters: [ToString()])
class GridShipping {
  String? type;
  String? title;

  GridShipping({
    this.type,
    this.title,
  });

  factory GridShipping.fromJson(Map<String, dynamic> json) => _$GridShippingFromJson(json);
  Map toJson() => _$GridShippingToJson(this);

}

@JsonSerializable(explicitToJson: true, converters: [ToString()])
class Spec_ {
  String? title;
  String? field;
  String? value;
  String? display_value;
  String? value_slug;

  Spec_({
    this.title,
    this.field,
    this.value,
    this.display_value,
    this.value_slug,
  });

  factory Spec_.fromJson(Map<String, dynamic> json) => _$Spec_FromJson(json);
  Map toJson() => _$Spec_ToJson(this);

}

@JsonSerializable(converters: [ToString()])
class Condition_ {
  String? title;
  String? field;
  String? value;

  Condition_({
    this.title,
    this.field,
    this.value,
  });

  factory Condition_.fromJson(Map<String, dynamic> json) => _$Condition_FromJson(json);
  Map toJson() => _$Condition_ToJson(this);

}

@JsonSerializable(converters: [ToString()])
class HighlightSpec {
  String? title;
  String? field;
  String? value;
  String? display_value;
  String? value_slug;

  HighlightSpec({
    this.title,
    this.field,
    this.value,
    this.display_value,
    this.value_slug,
  });

  factory HighlightSpec.fromJson(Map<String, dynamic> json) => _$HighlightSpecFromJson(json);
  Map toJson() => _$HighlightSpecToJson(this);

}

@JsonSerializable(converters: [ToString(), ToBool()])
class Store_ {
  String? id;
  String? title;
  String? username;
  String? userid;
  CoverProfile? logo;
  CoverProfile? cover;
  bool? is_verify;
  dynamic created_date;
  String? taxed;

  Store_({
    this.id,
    this.title,
    this.username,
    this.userid,
    this.logo,
    this.cover,
    this.is_verify,
    this.created_date,
    this.taxed,
  });

  factory Store_.fromJson(Map<String, dynamic> json) => _$Store_FromJson(json);
  Map toJson() => _$Store_ToJson(this);

}


@JsonSerializable(converters: [ToString(), ToBool(), ToDateTime()])
class User_ {
  String? id;
  String? name;
  String? username;
  CoverProfile? photo;
  OnlineStatusProfile? online_status;
  bool? is_verify;
  DateTime? registered_date;
  String? taxed;
  String? user_type;

  User_({
    this.id,
    this.name,
    this.username,
    this.photo,
    this.online_status,
    this.is_verify,
    this.registered_date,
    this.taxed,
    this.user_type,
  });

  factory User_.fromJson(Map<String, dynamic> json) => _$User_FromJson(json);
  Map toJson() => _$User_ToJson(this);

}

@JsonSerializable(converters: [ToBool()])
class Setting_ {
  bool? show_contact;
  bool? enable_chat;
  bool? enable_like;
  bool? enable_save;
  bool? enable_comment;
  bool? enable_offer;
  bool? enable_buy;
  bool? enable_apply_job;
  bool? enable_shipping;

  Setting_({
    this.show_contact,
    this.enable_chat,
    this.enable_like,
    this.enable_save,
    this.enable_comment,
    this.enable_buy,
    this.enable_offer,
    this.enable_apply_job,
    this.enable_shipping,
  });

  factory Setting_.fromJson(Map<String, dynamic> json) => _$Setting_FromJson(json);
  Map toJson() => _$Setting_ToJson(this);

}
