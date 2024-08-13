
import 'package:json_annotation/json_annotation.dart';
import '../../try_convert.dart';

part 'profiles_own.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class OwnTotalPost {
  OwnDataTotalPost data;

  OwnTotalPost({
    required this.data,
  });

  factory OwnTotalPost.fromJson(Map<String, dynamic> json) => _$OwnTotalPostFromJson(json);
  Map toJson() => _$OwnTotalPostToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class OwnDataTotalPost {
  String? paid;
  String? active;
  String? expired;
  String? total;
  String? saved;

  OwnDataTotalPost({
    this.paid,
    this.active,
    this.expired,
    this.total,
    this.saved,
  });

  factory OwnDataTotalPost.fromJson(Map<String, dynamic> json) => _$OwnDataTotalPostFromJson(json);
  Map toJson() => _$OwnDataTotalPostToJson(this);

}


@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToLists(), ToInt()])
class OwnProfileSerial {
  List<DatumProfile?>? data;
  int? limit;
  dynamic available_paid_ads;

  OwnProfileSerial({
    this.data,
    this.limit,
    this.available_paid_ads,
  });

  factory OwnProfileSerial.fromJson(Map<String, dynamic> json) => _$OwnProfileSerialFromJson(json);
  Map toJson() => _$OwnProfileSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToLists(), ToDateTime(), ToBool(), ToString()])
class DatumProfile {
  String? id;
  dynamic storeid;
  String? title;
  dynamic price;
  DiscountProfile? discount;
  String? photo;
  String? thumbnail;
  String? status;
  bool? is_premium;
  String? views;
  DateTime? posted_date;
  DateTime? last_update;
  DateTime? renew_date;
  String? link;
  String? short_link;
  InsightsProfile? insights;
  CategoryTypeProfile? category_type;
  List<String>? actions;

  DatumProfile({
    this.id,
    this.storeid,
    this.title,
    this.price,
    this.discount,
    this.photo,
    this.thumbnail,
    this.status,
    this.is_premium,
    this.views,
    this.posted_date,
    this.last_update,
    this.renew_date,
    this.link,
    this.short_link,
    this.insights,
    this.category_type,
    this.actions,
  });

  factory DatumProfile.fromJson(Map<String, dynamic> json) => _$DatumProfileFromJson(json);
  Map toJson() => _$DatumProfileToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class CategoryTypeProfile {
  String? title;
  String? category_type_slug;
  String? slug;

  CategoryTypeProfile({
    this.title,
    this.category_type_slug,
    this.slug,
  });

  factory CategoryTypeProfile.fromJson(Map<String, dynamic> json) => _$CategoryTypeProfileFromJson(json);
  Map toJson() => _$CategoryTypeProfileToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToInt()])
class DiscountProfile {
  int? sale_price;
  String? original_price;
  int? amount_saved;
  String? type;
  String? discount;

  DiscountProfile({
    this.sale_price,
    this.original_price,
    this.amount_saved,
    this.type,
    this.discount,
  });

  factory DiscountProfile.fromJson(Map<String, dynamic> json) => _$DiscountProfileFromJson(json);
  Map toJson() => _$DiscountProfileToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToInt()])
class InsightsProfile {
  int? reach;
  int? engagement;
  int? impression;

  InsightsProfile({
    this.reach,
    this.engagement,
    this.impression,
  });

  factory InsightsProfile.fromJson(Map<String, dynamic> json) => _$InsightsProfileFromJson(json);
  Map toJson() => _$InsightsProfileToJson(this);

}










@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToLists()])
class DeleteReasonSerial {
  List<DeleteReasonDatum?>? data;

  DeleteReasonSerial({
    this.data,
  });

  factory DeleteReasonSerial.fromJson(Map<String, dynamic> json) => _$DeleteReasonSerialFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteReasonSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class DeleteReasonDatum {
  String? value;
  String? km;
  String? en;

  DeleteReasonDatum({
    this.value,
    this.km,
    this.en,
  });

  factory DeleteReasonDatum.fromJson(Map<String, dynamic> json) => _$DeleteReasonDatumFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteReasonDatumToJson(this);

}



