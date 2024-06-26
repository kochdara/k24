
import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/try_convert.dart';

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
  String? photo;
  List<String?>? photos;
  String? thumbnail;
  List<String?>? thumbnails;
  List<String?>? phone;
  List<PhoneWhiteOperator_?>? phone_white_operator;
  String? views;
  DateTime? renew_date;
  DateTime? posted_date;
  String? link;
  String? short_link;
  int? total_comment;
  User_? user;
  Store_? store;
  Location_? location;
  Category_? category;
  List<HighlightSpec?>? highlight_specs;
  List<Spec_?>? specs;
  String? status;
  Condition_? condition;
  String? type;
  double? price;
  int? total_like;

  Data_({
    this.id,
    this.title,
    this.is_premium,
    this.description,
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
  });

  factory Data_.fromJson(Map json) => _$Data_FromJson(json);
  Map toJson() => _$Data_ToJson(this);

}

@JsonSerializable(converters: [ToString()])
class Category_ {
  String? id;
  String? en_name;
  String? km_name;
  String? slug;
  String? parent;
  ParentData? parent_data;

  Category_({
    this.id,
    this.en_name,
    this.km_name,
    this.slug,
    this.parent,
    this.parent_data,
  });

  factory Category_.fromJson(Map<String, dynamic> json) => _$Category_FromJson(json);
  Map toJson() => _$Category_ToJson(this);

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

@JsonSerializable(converters: [ToString()])
class PhoneWhiteOperator_ {
  String? title;
  String? slug;
  String? icon;
  String? phone;

  PhoneWhiteOperator_({
    this.title,
    this.slug,
    this.icon,
    this.phone,
  });

  factory PhoneWhiteOperator_.fromJson(Map<String, dynamic> json) => _$PhoneWhiteOperator_FromJson(json);
  Map toJson() => _$PhoneWhiteOperator_ToJson(this);

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

@JsonSerializable(converters: [ToString()])
class Location_ {
  String? id;
  String? en_name;
  String? km_name;
  String? en_name2;
  String? km_name2;
  String? en_name3;
  String? km_name3;
  String? slug;
  String? address;
  String? long_location;

  Location_({
    this.id,
    this.en_name,
    this.km_name,
    this.en_name2,
    this.km_name2,
    this.en_name3,
    this.km_name3,
    this.slug,
    this.address,
    this.long_location,
  });

  factory Location_.fromJson(Map<String, dynamic> json) => _$Location_FromJson(json);
  Map toJson() => _$Location_ToJson(this);

}

@JsonSerializable(converters: [ToString(), ToBool()])
class Store_ {
  String? id;
  String? title;
  String? username;
  String? userid;
  Photo_? logo;
  Cover? cover;
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
  Photo_? photo;
  OnlineStatus? online_status;
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

@JsonSerializable(converters: [ToString(), ToBool(), ToDouble(), ToDateTime()])
class OnlineStatus {
  bool? is_active;
  String? last_active;
  dynamic time;
  DateTime? date;

  OnlineStatus({
    this.is_active,
    this.last_active,
    this.time,
    this.date,
  });

  factory OnlineStatus.fromJson(Map<String, dynamic> json) => _$OnlineStatusFromJson(json);
  Map toJson() => _$OnlineStatusToJson(this);

}

@JsonSerializable(converters: [ToString()])
class Cover {
  String? url;
  CoverLarge? small;
  CoverLarge? medium;
  CoverLarge? large;

  Cover({
    this.url,
    this.small,
    this.medium,
    this.large,
  });

  factory Cover.fromJson(Map<String, dynamic> json) => _$CoverFromJson(json);
  Map toJson() => _$CoverToJson(this);

}

@JsonSerializable(converters: [ToString()])
class CoverLarge {
  String? url;

  CoverLarge({
    this.url,
  });

  factory CoverLarge.fromJson(Map<String, dynamic> json) => _$CoverLargeFromJson(json);
  Map toJson() => _$CoverLargeToJson(this);

}

@JsonSerializable(converters: [ToString()])
class Photo_ {
  String? url;
  String? width;
  String? height;
  Large? small;
  Large? medium;
  Large? large;

  Photo_({
    this.url,
    this.width,
    this.height,
    this.small,
    this.medium,
    this.large,
  });

  factory Photo_.fromJson(Map<String, dynamic> json) => _$Photo_FromJson(json);
  Map toJson() => _$Photo_ToJson(this);

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

@JsonSerializable(converters: [ToBool(), ToDateTime()])
class Meta {
  String? site_name;
  String? title;
  String? price;
  String? currency;
  String? description;
  String? keyword;
  String? author;
  Fb? fb;
  String? image;
  String? url;
  String? deeplink;
  DateTime? date;

  Meta({
    this.site_name,
    this.title,
    this.price,
    this.currency,
    this.description,
    this.keyword,
    this.author,
    this.fb,
    this.image,
    this.url,
    this.deeplink,
    this.date,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map toJson() => _$MetaToJson(this);

}

@JsonSerializable(converters: [ToBool()])
class Fb {
  String? id;
  String? type;

  Fb({
    this.id,
    this.type,
  });

  factory Fb.fromJson(Map<String, dynamic> json) => _$FbFromJson(json);
  Map toJson() => _$FbToJson(this);

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
