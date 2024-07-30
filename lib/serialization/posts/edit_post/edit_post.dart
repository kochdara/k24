
import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/try_convert.dart';

import '../post_serials.dart';

part 'edit_post.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class EditPostSerial {
  EditPostData? data;

  EditPostSerial({
    this.data,
  });

  factory EditPostSerial.fromJson(Map json) => _$EditPostSerialFromJson(json);
  Map toJson() => _$EditPostSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class EditPostData {
  String? type;
  EditFields? fields;
  EditPost? post;
  EditPostPrices? prices;
  EditPostLocations? locations;
  EditPostDeliveries? deliveries;
  EditPostPhotos? photos;
  EditPostDescriptions? descriptions;
  EditHeadlines? headlines;
  PostContact? contact;

  EditPostData({
    this.type,
    this.fields,
    this.post,
    this.prices,
    this.locations,
    this.deliveries,
    this.photos,
    this.descriptions,
    this.headlines,
    this.contact,
  });

  factory EditPostData.fromJson(Map json) => _$EditPostDataFromJson(json);
  Map toJson() => _$EditPostDataToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true)
class EditPostDeliveries {
  PostDelivery? shipping;

  EditPostDeliveries({
    this.shipping,
  });

  factory EditPostDeliveries.fromJson(Map json) => _$EditPostDeliveriesFromJson(json);
  Map toJson() => _$EditPostDeliveriesToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true)
class EditPostDescriptions {
  PostDataField? ad_text;

  EditPostDescriptions({
    this.ad_text,
  });

  factory EditPostDescriptions.fromJson(Map json) => _$EditPostDescriptionsFromJson(json);
  Map toJson() => _$EditPostDescriptionsToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true)
class EditFields {
  PostDataField? ad_field;
  PostDataField? ad_model;
  PostDataField? ad_year;
  PostDataField? ad_auto_condition;
  PostDataField? ad_condition;
  PostDataField? ad_color;
  PostDataField? ad_transmission;
  PostDataField? ad_fuel;
  PostDataField? ad_type;
  PostDataField? available;

  EditFields({
    this.ad_field,
    this.ad_model,
    this.ad_year,
    this.ad_auto_condition,
    this.ad_condition,
    this.ad_color,
    this.ad_transmission,
    this.ad_fuel,
    this.ad_type,
    this.available,
  });

  factory EditFields.fromJson(Map json) => _$EditFieldsFromJson(json);
  Map toJson() => _$EditFieldsToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true)
class EditHeadlines {
  PostDataField? ad_headline;

  EditHeadlines({
    this.ad_headline,
  });

  factory EditHeadlines.fromJson(Map json) => _$EditHeadlinesFromJson(json);
  Map toJson() => _$EditHeadlinesToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true)
class EditPostLocations {
  PostLocation? province;
  PostLocation? district;
  PostLocation? commune;
  PostLocation? address;
  PostLocation? map;

  EditPostLocations({
    this.province,
    this.district,
    this.commune,
    this.address,
    this.map,
  });

  factory EditPostLocations.fromJson(Map json) => _$EditPostLocationsFromJson(json);
  Map toJson() => _$EditPostLocationsToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true)
class EditPostPhotos {
  PostLocation? ad_photo;

  EditPostPhotos({
    this.ad_photo,
  });

  factory EditPostPhotos.fromJson(Map json) => _$EditPostPhotosFromJson(json);
  Map toJson() => _$EditPostPhotosToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToLists()])
class EditPost {
  List<MessageResPhoto?>? photo;
  String? title;
  String? cateid;
  PostCommune? category;
  String? description;

  EditPost({
    this.photo,
    this.title,
    this.cateid,
    this.category,
    this.description,
  });

  factory EditPost.fromJson(Map json) => _$EditPostFromJson(json);
  Map toJson() => _$EditPostToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true)
class EditPostPrices {
  PostPrice? discount;
  PostPrice? ad_price;

  EditPostPrices({
    this.discount,
    this.ad_price,
  });

  factory EditPostPrices.fromJson(Map json) => _$EditPostPricesFromJson(json);
  Map toJson() => _$EditPostPricesToJson(this);

}

