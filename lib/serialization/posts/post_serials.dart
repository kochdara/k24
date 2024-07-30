
import 'package:json_annotation/json_annotation.dart';

import '../helper.dart';
import '../try_convert.dart';

part 'post_serials.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class PostSerial {
  PostData data;

  PostSerial({
    required this.data,
  });

  factory PostSerial.fromJson(Map json) => _$PostSerialFromJson(json);
  Map toJson() => _$PostSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToLists()])
class PostData {
  List<PostDataField?>? fields;
  List<PostPrice?>? prices;
  List<PostLocation?>? locations;
  List<PostDelivery?>? deliveries;
  List<PostPhoto?>? photos;
  List<PostDescription?>? descriptions;
  List<PostDescription?>? headlines;
  PostContact? contact;

  PostData({
    this.fields,
    this.prices,
    this.locations,
    this.deliveries,
    this.photos,
    this.descriptions,
    this.headlines,
    this.contact,
  });

  factory PostData.fromJson(Map json) => _$PostDataFromJson(json);
  Map toJson() => _$PostDataToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToLists(), ToString()])
class PostContact {
  String? name;
  String? first_name;
  String? last_name;
  List<String?>? phone;
  String? email;
  String? address;
  MapClass? map;
  PostCommune? province;
  PostCommune? district;
  PostCommune? commune;

  PostContact({
    this.name,
    this.first_name,
    this.last_name,
    this.phone,
    this.email,
    this.address,
    this.map,
    this.province,
    this.district,
    this.commune,
  });

  factory PostContact.fromJson(Map json) => _$PostContactFromJson(json);
  Map toJson() => _$PostContactToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class PostCommune {
  String? id;
  String? slug;
  String? en_name;
  String? km_name;
  String? parent;

  PostCommune({
    this.id,
    this.slug,
    this.en_name,
    this.km_name,
    this.parent,
  });

  factory PostCommune.fromJson(Map json) => _$PostCommuneFromJson(json);
  Map toJson() => _$PostCommuneToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToLists(), ToBool()])
class PostDelivery {
  String? fieldid;
  String? title;
  String? type;
  String? slug;
  PostDescriptionValidation? validation;
  String? fieldname;
  String? chained_field;
  bool? display_icon;
  dynamic display_icon_type;
  PostValueElement? value;
  List<PostValueElement?>? options;

  PostDelivery({
    this.fieldid,
    this.title,
    this.type,
    this.slug,
    this.validation,
    this.fieldname,
    this.chained_field,
    this.display_icon,
    this.display_icon_type,
    this.value,
    this.options,
  });

  factory PostDelivery.fromJson(Map json) => _$PostDeliveryFromJson(json);
  Map toJson() => _$PostDeliveryToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class PostValueElement {
  String? value;
  String? title;

  PostValueElement({
    this.value,
    this.title,
  });

  factory PostValueElement.fromJson(Map json) => _$PostValueElementFromJson(json);
  Map toJson() => _$PostValueElementToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ ToString()])
class PostDescription {
  String? fieldid;
  String? title;
  String? type;
  String? slug;
  PostDescriptionValidation? validation;
  String? fieldname;
  String? chained_field;
  bool? display_icon;
  dynamic display_icon_type;

  PostDescription({
    this.fieldid,
    this.title,
    this.type,
    this.slug,
    this.validation,
    this.fieldname,
    this.chained_field,
    this.display_icon,
    this.display_icon_type,
  });

  factory PostDescription.fromJson(Map json) => _$PostDescriptionFromJson(json);
  Map toJson() => _$PostDescriptionToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ ToString(), ToBool()])
class PostDescriptionValidation {
  bool? required;
  String? min_length;
  String? max_length;
  bool? numeric;
  String? greater_than_equal_to;
  List<String?>? in_list;

  PostDescriptionValidation({
    this.required,
    this.min_length,
    this.max_length,
    this.numeric,
    this.greater_than_equal_to,
    this.in_list,
  });

  factory PostDescriptionValidation.fromJson(Map json) => _$PostDescriptionValidationFromJson(json);
  Map toJson() => _$PostDescriptionValidationToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ ToString(), ToBool(), ToLists()])
class PostDataField {
  String? fieldid;
  String? title;
  String? type;
  String? slug;
  bool? display_icon;
  String? display_icon_type;
  List<PostFieldField?>? fields;
  PostDescriptionValidation? validation;
  String? fieldname;
  String? chained_field;
  List<PostFluffyOption?>? options;
  List<PostFluffyOption?>? popular_options;
  dynamic value;

  PostDataField({
    this.fieldid,
    this.title,
    this.type,
    this.slug,
    this.display_icon,
    this.display_icon_type,
    this.fields,
    this.validation,
    this.fieldname,
    this.chained_field,
    this.options,
    this.value,
    this.popular_options,
  });

  factory PostDataField.fromJson(Map json) => _$PostDataFieldFromJson(json);
  Map toJson() => _$PostDataFieldToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ ToString(), ToBool(), ToLists()])
class PostFieldField {
  String? fieldid;
  String? title;
  String? type;
  String? slug;
  PostDescriptionValidation? validation;
  String? fieldname;
  String? chained_field;
  bool? display_icon;
  String? display_icon_type;
  List<PostPurpleOption?>? options;
  List<PostPopularOption?>? popularOptions;

  PostFieldField({
    this.fieldid,
    this.title,
    this.type,
    this.slug,
    this.validation,
    this.fieldname,
    this.chained_field,
    this.display_icon,
    this.display_icon_type,
    this.options,
    this.popularOptions,
  });

  factory PostFieldField.fromJson(Map json) => _$PostFieldFieldFromJson(json);
  Map toJson() => _$PostFieldFieldToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ ToString(), ToBool()])
class PostPurpleOption {
  dynamic fieldtitle;
  dynamic fieldvalue;
  String? fieldid;
  String? fieldparentvalue;
  bool? popular;
  IconSerial? icon;

  PostPurpleOption({
    this.fieldtitle,
    this.fieldvalue,
    this.fieldid,
    this.fieldparentvalue,
    this.popular,
    this.icon,
  });

  factory PostPurpleOption.fromJson(Map json) => _$PostPurpleOptionFromJson(json);
  Map toJson() => _$PostPurpleOptionToJson(this);


}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ ToString(), ToBool()])
class PostPopularOption {
  String? fieldtitle;
  String? fieldvalue;
  String? fieldid;
  String? fieldparentvalue;
  bool? popular;

  PostPopularOption({
    this.fieldtitle,
    this.fieldvalue,
    this.fieldid,
    this.fieldparentvalue,
    this.popular,
  });

  factory PostPopularOption.fromJson(Map json) => _$PostPopularOptionFromJson(json);
  Map toJson() => _$PostPopularOptionToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ ToString(), ToBool()])
class PostFluffyOption {
  String? fieldtitle;
  String? fieldvalue;
  String? fieldid;
  String? fieldparentvalue;
  bool? popular;
  IconSerial? icon;
  String? value;
  String? title;

  PostFluffyOption({
    this.fieldtitle,
    this.fieldvalue,
    this.fieldid,
    this.fieldparentvalue,
    this.popular,
    this.icon,
    this.value,
    this.title,
  });

  factory PostFluffyOption.fromJson(Map json) => _$PostFluffyOptionFromJson(json);
  Map toJson() => _$PostFluffyOptionToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ ToString(), ToLists()])
class PostLocation {
  String? fieldid;
  String? title;
  String? type;
  String? slug;
  bool? display_icon;
  dynamic display_icon_type;
  dynamic value;
  List<PostLocationField?>? fields;
  PostDescriptionValidation? validation;
  String? fieldname;
  String? chained_field;

  PostLocation({
    this.fieldid,
    this.title,
    this.type,
    this.slug,
    this.display_icon,
    this.display_icon_type,
    this.value,
    this.fields,
    this.validation,
    this.fieldname,
    this.chained_field,
  });

  factory PostLocation.fromJson(Map json) => _$PostLocationFromJson(json);
  Map toJson() => _$PostLocationToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ ToString(), ToLists()])
class PostLocationField {
  String? fieldid;
  String? title;
  String? type;
  String? slug;
  PostDescriptionValidation? validation;
  String? fieldname;
  String? chained_field;
  bool? display_icon;
  dynamic display_icon_type;
  PostCommune? value;

  PostLocationField({
    this.fieldid,
    this.title,
    this.type,
    this.slug,
    this.validation,
    this.fieldname,
    this.chained_field,
    this.display_icon,
    this.display_icon_type,
    this.value,
  });

  factory PostLocationField.fromJson(Map json) => _$PostLocationFieldFromJson(json);
  Map toJson() => _$PostLocationFieldToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ ToString(), ToBool()])
class PostPhoto {
  String? fieldid;
  String? title;
  String? type;
  String? slug;
  PostDescriptionValidation? validation;
  String? fieldname;
  String? chained_field;
  bool? display_icon;
  dynamic display_icon_type;

  PostPhoto({
    this.fieldid,
    this.title,
    this.type,
    this.slug,
    this.validation,
    this.fieldname,
    this.chained_field,
    this.display_icon,
    this.display_icon_type,
  });

  factory PostPhoto.fromJson(Map json) => _$PostPhotoFromJson(json);
  Map toJson() => _$PostPhotoToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ ToString(), ToBool()])
class PostPrice {
  String? title;
  String? fieldname;
  String? type;
  PostDescriptionValidation? validation;
  String? value;
  PostSubFix? subfix;
  String? fieldid;
  String? slug;
  String? chained_field;
  bool? display_icon;
  dynamic display_icon_type;
  PostPrefix? prefix;

  PostPrice({
    this.title,
    this.fieldname,
    this.type,
    this.validation,
    this.value,
    this.subfix,
    this.fieldid,
    this.slug,
    this.chained_field,
    this.display_icon,
    this.display_icon_type,
    this.prefix,
  });

  factory PostPrice.fromJson(Map json) => _$PostPriceFromJson(json);
  Map toJson() => _$PostPriceToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ ToString()])
class PostPrefix {
  String? type;
  String? text;

  PostPrefix({
    this.type,
    this.text,
  });

  factory PostPrefix.fromJson(Map json) => _$PostPrefixFromJson(json);
  Map toJson() => _$PostPrefixToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ ToString(), ToLists()])
class PostSubFix {
  String? type;
  String? fieldname;
  PostDescriptionValidation? validation;
  PostValueElement? value;
  List<PostValueElement?>? options;

  PostSubFix({
    this.type,
    this.fieldname,
    this.validation,
    this.value,
    this.options,
  });

  factory PostSubFix.fromJson(Map json) => _$PostSubFixFromJson(json);
  Map toJson() => _$PostSubFixToJson(this);

}





@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ ToString()])
class ResponseMessagePost {
  String? status;
  String? message;
  MessageResData? data;

  ResponseMessagePost({
    this.status,
    this.message,
    this.data,
  });

  factory ResponseMessagePost.fromJson(Map json) => _$ResponseMessagePostFromJson(json);
  Map toJson() => _$ResponseMessagePostToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ ToString(), ToInt(), ToLists()])
class MessageResData {
  int? id;
  String? title;
  int? price;
  String? thumbnail;
  List<MessageResPhoto?>? photo;
  String? link;
  String? short_link;
  dynamic storeid;
  List<String?>? actions;

  MessageResData({
    this.id,
    this.title,
    this.price,
    this.thumbnail,
    this.photo,
    this.link,
    this.short_link,
    this.storeid,
    this.actions,
  });

  factory MessageResData.fromJson(Map json) => _$MessageResDataFromJson(json);
  Map toJson() => _$MessageResDataToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ ToString()])
class MessageResPhoto {
  String? image_url;
  String? image_name;

  MessageResPhoto({
    this.image_url,
    this.image_name,
  });

  factory MessageResPhoto.fromJson(Map json) => _$MessageResPhotoFromJson(json);
  Map toJson() => _$MessageResPhotoToJson(this);

}


