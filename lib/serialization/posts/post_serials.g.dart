// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_serials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSerial _$PostSerialFromJson(Map json) => PostSerial(
      data: PostData.fromJson(json['data'] as Map),
    );

Map<String, dynamic> _$PostSerialToJson(PostSerial instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

PostData _$PostDataFromJson(Map json) => PostData(
      fields: (json['fields'] as List<dynamic>?)
          ?.map((e) => e == null ? null : PostDataField.fromJson(e as Map))
          .toList(),
      prices: (json['prices'] as List<dynamic>?)
          ?.map((e) => e == null ? null : PostPrice.fromJson(e as Map))
          .toList(),
      locations: (json['locations'] as List<dynamic>?)
          ?.map((e) => e == null ? null : PostLocation.fromJson(e as Map))
          .toList(),
      deliveries: (json['deliveries'] as List<dynamic>?)
          ?.map((e) => e == null ? null : PostDelivery.fromJson(e as Map))
          .toList(),
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => e == null ? null : PostPhoto.fromJson(e as Map))
          .toList(),
      descriptions: (json['descriptions'] as List<dynamic>?)
          ?.map((e) => e == null ? null : PostDescription.fromJson(e as Map))
          .toList(),
      headlines: (json['headlines'] as List<dynamic>?)
          ?.map((e) => e == null ? null : PostDescription.fromJson(e as Map))
          .toList(),
      contact: json['contact'] == null
          ? null
          : PostContact.fromJson(json['contact'] as Map),
    );

Map<String, dynamic> _$PostDataToJson(PostData instance) => <String, dynamic>{
      'fields': instance.fields?.map((e) => e?.toJson()).toList(),
      'prices': instance.prices?.map((e) => e?.toJson()).toList(),
      'locations': instance.locations?.map((e) => e?.toJson()).toList(),
      'deliveries': instance.deliveries?.map((e) => e?.toJson()).toList(),
      'photos': instance.photos?.map((e) => e?.toJson()).toList(),
      'descriptions': instance.descriptions?.map((e) => e?.toJson()).toList(),
      'headlines': instance.headlines?.map((e) => e?.toJson()).toList(),
      'contact': instance.contact?.toJson(),
    };

PostContact _$PostContactFromJson(Map json) => PostContact(
      name: const ToString().fromJson(json['name']),
      first_name: const ToString().fromJson(json['first_name']),
      last_name: const ToString().fromJson(json['last_name']),
      phone: (json['phone'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      email: const ToString().fromJson(json['email']),
      address: const ToString().fromJson(json['address']),
      map: json['map'] == null
          ? null
          : MapClass.fromJson(Map<String, dynamic>.from(json['map'] as Map)),
      province: json['province'] == null
          ? null
          : PostCommune.fromJson(json['province'] as Map),
      district: json['district'] == null
          ? null
          : PostCommune.fromJson(json['district'] as Map),
      commune: json['commune'] == null
          ? null
          : PostCommune.fromJson(json['commune'] as Map),
    );

Map<String, dynamic> _$PostContactToJson(PostContact instance) =>
    <String, dynamic>{
      'name': const ToString().toJson(instance.name),
      'first_name': const ToString().toJson(instance.first_name),
      'last_name': const ToString().toJson(instance.last_name),
      'phone': instance.phone?.map(const ToString().toJson).toList(),
      'email': const ToString().toJson(instance.email),
      'address': const ToString().toJson(instance.address),
      'map': instance.map?.toJson(),
      'province': instance.province?.toJson(),
      'district': instance.district?.toJson(),
      'commune': instance.commune?.toJson(),
    };

PostCommune _$PostCommuneFromJson(Map json) => PostCommune(
      id: const ToString().fromJson(json['id']),
      slug: const ToString().fromJson(json['slug']),
      en_name: const ToString().fromJson(json['en_name']),
      km_name: const ToString().fromJson(json['km_name']),
      parent: const ToString().fromJson(json['parent']),
    );

Map<String, dynamic> _$PostCommuneToJson(PostCommune instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'slug': const ToString().toJson(instance.slug),
      'en_name': const ToString().toJson(instance.en_name),
      'km_name': const ToString().toJson(instance.km_name),
      'parent': const ToString().toJson(instance.parent),
    };

PostDelivery _$PostDeliveryFromJson(Map json) => PostDelivery(
      fieldid: const ToString().fromJson(json['fieldid']),
      title: const ToString().fromJson(json['title']),
      type: const ToString().fromJson(json['type']),
      slug: const ToString().fromJson(json['slug']),
      validation: json['validation'] == null
          ? null
          : PostDescriptionValidation.fromJson(json['validation'] as Map),
      fieldname: const ToString().fromJson(json['fieldname']),
      chained_field: const ToString().fromJson(json['chained_field']),
      display_icon: const ToBool().fromJson(json['display_icon']),
      display_icon_type: json['display_icon_type'],
      value: json['value'] == null
          ? null
          : PostValueElement.fromJson(json['value'] as Map),
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => e == null ? null : PostValueElement.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$PostDeliveryToJson(PostDelivery instance) =>
    <String, dynamic>{
      'fieldid': const ToString().toJson(instance.fieldid),
      'title': const ToString().toJson(instance.title),
      'type': const ToString().toJson(instance.type),
      'slug': const ToString().toJson(instance.slug),
      'validation': instance.validation?.toJson(),
      'fieldname': const ToString().toJson(instance.fieldname),
      'chained_field': const ToString().toJson(instance.chained_field),
      'display_icon': _$JsonConverterToJson<Object?, bool>(
          instance.display_icon, const ToBool().toJson),
      'display_icon_type': instance.display_icon_type,
      'value': instance.value?.toJson(),
      'options': instance.options?.map((e) => e?.toJson()).toList(),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

PostValueElement _$PostValueElementFromJson(Map json) => PostValueElement(
      value: const ToString().fromJson(json['value']),
      title: const ToString().fromJson(json['title']),
    );

Map<String, dynamic> _$PostValueElementToJson(PostValueElement instance) =>
    <String, dynamic>{
      'value': const ToString().toJson(instance.value),
      'title': const ToString().toJson(instance.title),
    };

PostDescription _$PostDescriptionFromJson(Map json) => PostDescription(
      fieldid: const ToString().fromJson(json['fieldid']),
      title: const ToString().fromJson(json['title']),
      type: const ToString().fromJson(json['type']),
      slug: const ToString().fromJson(json['slug']),
      validation: json['validation'] == null
          ? null
          : PostDescriptionValidation.fromJson(json['validation'] as Map),
      fieldname: const ToString().fromJson(json['fieldname']),
      chained_field: const ToString().fromJson(json['chained_field']),
      display_icon: json['display_icon'] as bool?,
      display_icon_type: json['display_icon_type'],
    );

Map<String, dynamic> _$PostDescriptionToJson(PostDescription instance) =>
    <String, dynamic>{
      'fieldid': const ToString().toJson(instance.fieldid),
      'title': const ToString().toJson(instance.title),
      'type': const ToString().toJson(instance.type),
      'slug': const ToString().toJson(instance.slug),
      'validation': instance.validation?.toJson(),
      'fieldname': const ToString().toJson(instance.fieldname),
      'chained_field': const ToString().toJson(instance.chained_field),
      'display_icon': instance.display_icon,
      'display_icon_type': instance.display_icon_type,
    };

PostDescriptionValidation _$PostDescriptionValidationFromJson(Map json) =>
    PostDescriptionValidation(
      required: const ToBool().fromJson(json['required']),
      min_length: const ToString().fromJson(json['min_length']),
      max_length: const ToString().fromJson(json['max_length']),
      numeric: const ToBool().fromJson(json['numeric']),
      greater_than_equal_to:
          const ToString().fromJson(json['greater_than_equal_to']),
      in_list: (json['in_list'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
    );

Map<String, dynamic> _$PostDescriptionValidationToJson(
        PostDescriptionValidation instance) =>
    <String, dynamic>{
      'required': _$JsonConverterToJson<Object?, bool>(
          instance.required, const ToBool().toJson),
      'min_length': const ToString().toJson(instance.min_length),
      'max_length': const ToString().toJson(instance.max_length),
      'numeric': _$JsonConverterToJson<Object?, bool>(
          instance.numeric, const ToBool().toJson),
      'greater_than_equal_to':
          const ToString().toJson(instance.greater_than_equal_to),
      'in_list': instance.in_list?.map(const ToString().toJson).toList(),
    };

PostDataField _$PostDataFieldFromJson(Map json) => PostDataField(
      fieldid: const ToString().fromJson(json['fieldid']),
      title: const ToString().fromJson(json['title']),
      type: const ToString().fromJson(json['type']),
      slug: const ToString().fromJson(json['slug']),
      display_icon: const ToBool().fromJson(json['display_icon']),
      display_icon_type: const ToString().fromJson(json['display_icon_type']),
      fields: (json['fields'] as List<dynamic>?)
          ?.map((e) => e == null ? null : PostFieldField.fromJson(e as Map))
          .toList(),
      validation: json['validation'] == null
          ? null
          : PostDescriptionValidation.fromJson(json['validation'] as Map),
      fieldname: const ToString().fromJson(json['fieldname']),
      chained_field: const ToString().fromJson(json['chained_field']),
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => e == null ? null : PostFluffyOption.fromJson(e as Map))
          .toList(),
      value: json['value'],
      popular_options: (json['popular_options'] as List<dynamic>?)
          ?.map((e) => e == null ? null : PostFluffyOption.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$PostDataFieldToJson(PostDataField instance) =>
    <String, dynamic>{
      'fieldid': const ToString().toJson(instance.fieldid),
      'title': const ToString().toJson(instance.title),
      'type': const ToString().toJson(instance.type),
      'slug': const ToString().toJson(instance.slug),
      'display_icon': _$JsonConverterToJson<Object?, bool>(
          instance.display_icon, const ToBool().toJson),
      'display_icon_type': const ToString().toJson(instance.display_icon_type),
      'fields': instance.fields?.map((e) => e?.toJson()).toList(),
      'validation': instance.validation?.toJson(),
      'fieldname': const ToString().toJson(instance.fieldname),
      'chained_field': const ToString().toJson(instance.chained_field),
      'options': instance.options?.map((e) => e?.toJson()).toList(),
      'popular_options':
          instance.popular_options?.map((e) => e?.toJson()).toList(),
      'value': instance.value,
    };

PostFieldField _$PostFieldFieldFromJson(Map json) => PostFieldField(
      fieldid: const ToString().fromJson(json['fieldid']),
      title: const ToString().fromJson(json['title']),
      type: const ToString().fromJson(json['type']),
      slug: const ToString().fromJson(json['slug']),
      validation: json['validation'] == null
          ? null
          : PostDescriptionValidation.fromJson(json['validation'] as Map),
      fieldname: const ToString().fromJson(json['fieldname']),
      chained_field: const ToString().fromJson(json['chained_field']),
      display_icon: const ToBool().fromJson(json['display_icon']),
      display_icon_type: const ToString().fromJson(json['display_icon_type']),
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => e == null ? null : PostPurpleOption.fromJson(e as Map))
          .toList(),
      popularOptions: (json['popularOptions'] as List<dynamic>?)
          ?.map((e) => e == null ? null : PostPopularOption.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$PostFieldFieldToJson(PostFieldField instance) =>
    <String, dynamic>{
      'fieldid': const ToString().toJson(instance.fieldid),
      'title': const ToString().toJson(instance.title),
      'type': const ToString().toJson(instance.type),
      'slug': const ToString().toJson(instance.slug),
      'validation': instance.validation?.toJson(),
      'fieldname': const ToString().toJson(instance.fieldname),
      'chained_field': const ToString().toJson(instance.chained_field),
      'display_icon': _$JsonConverterToJson<Object?, bool>(
          instance.display_icon, const ToBool().toJson),
      'display_icon_type': const ToString().toJson(instance.display_icon_type),
      'options': instance.options?.map((e) => e?.toJson()).toList(),
      'popularOptions':
          instance.popularOptions?.map((e) => e?.toJson()).toList(),
    };

PostPurpleOption _$PostPurpleOptionFromJson(Map json) => PostPurpleOption(
      fieldtitle: json['fieldtitle'],
      fieldvalue: json['fieldvalue'],
      fieldid: const ToString().fromJson(json['fieldid']),
      fieldparentvalue: const ToString().fromJson(json['fieldparentvalue']),
      popular: const ToBool().fromJson(json['popular']),
      icon: json['icon'] == null
          ? null
          : IconSerial.fromJson(Map<String, dynamic>.from(json['icon'] as Map)),
    );

Map<String, dynamic> _$PostPurpleOptionToJson(PostPurpleOption instance) =>
    <String, dynamic>{
      'fieldtitle': instance.fieldtitle,
      'fieldvalue': instance.fieldvalue,
      'fieldid': const ToString().toJson(instance.fieldid),
      'fieldparentvalue': const ToString().toJson(instance.fieldparentvalue),
      'popular': _$JsonConverterToJson<Object?, bool>(
          instance.popular, const ToBool().toJson),
      'icon': instance.icon?.toJson(),
    };

PostPopularOption _$PostPopularOptionFromJson(Map json) => PostPopularOption(
      fieldtitle: const ToString().fromJson(json['fieldtitle']),
      fieldvalue: const ToString().fromJson(json['fieldvalue']),
      fieldid: const ToString().fromJson(json['fieldid']),
      fieldparentvalue: const ToString().fromJson(json['fieldparentvalue']),
      popular: const ToBool().fromJson(json['popular']),
    );

Map<String, dynamic> _$PostPopularOptionToJson(PostPopularOption instance) =>
    <String, dynamic>{
      'fieldtitle': const ToString().toJson(instance.fieldtitle),
      'fieldvalue': const ToString().toJson(instance.fieldvalue),
      'fieldid': const ToString().toJson(instance.fieldid),
      'fieldparentvalue': const ToString().toJson(instance.fieldparentvalue),
      'popular': _$JsonConverterToJson<Object?, bool>(
          instance.popular, const ToBool().toJson),
    };

PostFluffyOption _$PostFluffyOptionFromJson(Map json) => PostFluffyOption(
      fieldtitle: const ToString().fromJson(json['fieldtitle']),
      fieldvalue: const ToString().fromJson(json['fieldvalue']),
      fieldid: const ToString().fromJson(json['fieldid']),
      fieldparentvalue: const ToString().fromJson(json['fieldparentvalue']),
      popular: const ToBool().fromJson(json['popular']),
      icon: json['icon'] == null
          ? null
          : IconSerial.fromJson(Map<String, dynamic>.from(json['icon'] as Map)),
      value: const ToString().fromJson(json['value']),
      title: const ToString().fromJson(json['title']),
    );

Map<String, dynamic> _$PostFluffyOptionToJson(PostFluffyOption instance) =>
    <String, dynamic>{
      'fieldtitle': const ToString().toJson(instance.fieldtitle),
      'fieldvalue': const ToString().toJson(instance.fieldvalue),
      'fieldid': const ToString().toJson(instance.fieldid),
      'fieldparentvalue': const ToString().toJson(instance.fieldparentvalue),
      'popular': _$JsonConverterToJson<Object?, bool>(
          instance.popular, const ToBool().toJson),
      'icon': instance.icon?.toJson(),
      'value': const ToString().toJson(instance.value),
      'title': const ToString().toJson(instance.title),
    };

PostLocation _$PostLocationFromJson(Map json) => PostLocation(
      fieldid: const ToString().fromJson(json['fieldid']),
      title: const ToString().fromJson(json['title']),
      type: const ToString().fromJson(json['type']),
      slug: const ToString().fromJson(json['slug']),
      display_icon: json['display_icon'] as bool?,
      display_icon_type: json['display_icon_type'],
      value: json['value'],
      fields: (json['fields'] as List<dynamic>?)
          ?.map((e) => e == null ? null : PostLocationField.fromJson(e as Map))
          .toList(),
      validation: json['validation'] == null
          ? null
          : PostDescriptionValidation.fromJson(json['validation'] as Map),
      fieldname: const ToString().fromJson(json['fieldname']),
      chained_field: const ToString().fromJson(json['chained_field']),
    );

Map<String, dynamic> _$PostLocationToJson(PostLocation instance) =>
    <String, dynamic>{
      'fieldid': const ToString().toJson(instance.fieldid),
      'title': const ToString().toJson(instance.title),
      'type': const ToString().toJson(instance.type),
      'slug': const ToString().toJson(instance.slug),
      'display_icon': instance.display_icon,
      'display_icon_type': instance.display_icon_type,
      'value': instance.value,
      'fields': instance.fields?.map((e) => e?.toJson()).toList(),
      'validation': instance.validation?.toJson(),
      'fieldname': const ToString().toJson(instance.fieldname),
      'chained_field': const ToString().toJson(instance.chained_field),
    };

PostLocationField _$PostLocationFieldFromJson(Map json) => PostLocationField(
      fieldid: const ToString().fromJson(json['fieldid']),
      title: const ToString().fromJson(json['title']),
      type: const ToString().fromJson(json['type']),
      slug: const ToString().fromJson(json['slug']),
      validation: json['validation'] == null
          ? null
          : PostDescriptionValidation.fromJson(json['validation'] as Map),
      fieldname: const ToString().fromJson(json['fieldname']),
      chained_field: const ToString().fromJson(json['chained_field']),
      display_icon: json['display_icon'] as bool?,
      display_icon_type: json['display_icon_type'],
      value: json['value'] == null
          ? null
          : PostCommune.fromJson(json['value'] as Map),
    );

Map<String, dynamic> _$PostLocationFieldToJson(PostLocationField instance) =>
    <String, dynamic>{
      'fieldid': const ToString().toJson(instance.fieldid),
      'title': const ToString().toJson(instance.title),
      'type': const ToString().toJson(instance.type),
      'slug': const ToString().toJson(instance.slug),
      'validation': instance.validation?.toJson(),
      'fieldname': const ToString().toJson(instance.fieldname),
      'chained_field': const ToString().toJson(instance.chained_field),
      'display_icon': instance.display_icon,
      'display_icon_type': instance.display_icon_type,
      'value': instance.value?.toJson(),
    };

PostPhoto _$PostPhotoFromJson(Map json) => PostPhoto(
      fieldid: const ToString().fromJson(json['fieldid']),
      title: const ToString().fromJson(json['title']),
      type: const ToString().fromJson(json['type']),
      slug: const ToString().fromJson(json['slug']),
      validation: json['validation'] == null
          ? null
          : PostDescriptionValidation.fromJson(json['validation'] as Map),
      fieldname: const ToString().fromJson(json['fieldname']),
      chained_field: const ToString().fromJson(json['chained_field']),
      display_icon: const ToBool().fromJson(json['display_icon']),
      display_icon_type: json['display_icon_type'],
    );

Map<String, dynamic> _$PostPhotoToJson(PostPhoto instance) => <String, dynamic>{
      'fieldid': const ToString().toJson(instance.fieldid),
      'title': const ToString().toJson(instance.title),
      'type': const ToString().toJson(instance.type),
      'slug': const ToString().toJson(instance.slug),
      'validation': instance.validation?.toJson(),
      'fieldname': const ToString().toJson(instance.fieldname),
      'chained_field': const ToString().toJson(instance.chained_field),
      'display_icon': _$JsonConverterToJson<Object?, bool>(
          instance.display_icon, const ToBool().toJson),
      'display_icon_type': instance.display_icon_type,
    };

PostPrice _$PostPriceFromJson(Map json) => PostPrice(
      title: const ToString().fromJson(json['title']),
      fieldname: const ToString().fromJson(json['fieldname']),
      type: const ToString().fromJson(json['type']),
      validation: json['validation'] == null
          ? null
          : PostDescriptionValidation.fromJson(json['validation'] as Map),
      value: const ToString().fromJson(json['value']),
      subfix: json['subfix'] == null
          ? null
          : PostSubFix.fromJson(json['subfix'] as Map),
      fieldid: const ToString().fromJson(json['fieldid']),
      slug: const ToString().fromJson(json['slug']),
      chained_field: const ToString().fromJson(json['chained_field']),
      display_icon: const ToBool().fromJson(json['display_icon']),
      display_icon_type: json['display_icon_type'],
      prefix: json['prefix'] == null
          ? null
          : PostPrefix.fromJson(json['prefix'] as Map),
    );

Map<String, dynamic> _$PostPriceToJson(PostPrice instance) => <String, dynamic>{
      'title': const ToString().toJson(instance.title),
      'fieldname': const ToString().toJson(instance.fieldname),
      'type': const ToString().toJson(instance.type),
      'validation': instance.validation?.toJson(),
      'value': const ToString().toJson(instance.value),
      'subfix': instance.subfix?.toJson(),
      'fieldid': const ToString().toJson(instance.fieldid),
      'slug': const ToString().toJson(instance.slug),
      'chained_field': const ToString().toJson(instance.chained_field),
      'display_icon': _$JsonConverterToJson<Object?, bool>(
          instance.display_icon, const ToBool().toJson),
      'display_icon_type': instance.display_icon_type,
      'prefix': instance.prefix?.toJson(),
    };

PostPrefix _$PostPrefixFromJson(Map json) => PostPrefix(
      type: const ToString().fromJson(json['type']),
      text: const ToString().fromJson(json['text']),
    );

Map<String, dynamic> _$PostPrefixToJson(PostPrefix instance) =>
    <String, dynamic>{
      'type': const ToString().toJson(instance.type),
      'text': const ToString().toJson(instance.text),
    };

PostSubFix _$PostSubFixFromJson(Map json) => PostSubFix(
      type: const ToString().fromJson(json['type']),
      fieldname: const ToString().fromJson(json['fieldname']),
      validation: json['validation'] == null
          ? null
          : PostDescriptionValidation.fromJson(json['validation'] as Map),
      value: json['value'] == null
          ? null
          : PostValueElement.fromJson(json['value'] as Map),
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => e == null ? null : PostValueElement.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$PostSubFixToJson(PostSubFix instance) =>
    <String, dynamic>{
      'type': const ToString().toJson(instance.type),
      'fieldname': const ToString().toJson(instance.fieldname),
      'validation': instance.validation?.toJson(),
      'value': instance.value?.toJson(),
      'options': instance.options?.map((e) => e?.toJson()).toList(),
    };

ResponseMessagePost _$ResponseMessagePostFromJson(Map json) =>
    ResponseMessagePost(
      status: const ToString().fromJson(json['status']),
      message: const ToString().fromJson(json['message']),
      data: json['data'] == null
          ? null
          : MessageResData.fromJson(json['data'] as Map),
    );

Map<String, dynamic> _$ResponseMessagePostToJson(
        ResponseMessagePost instance) =>
    <String, dynamic>{
      'status': const ToString().toJson(instance.status),
      'message': const ToString().toJson(instance.message),
      'data': instance.data?.toJson(),
    };

MessageResData _$MessageResDataFromJson(Map json) => MessageResData(
      id: const ToInt().fromJson(json['id']),
      title: const ToString().fromJson(json['title']),
      price: const ToInt().fromJson(json['price']),
      thumbnail: const ToString().fromJson(json['thumbnail']),
      photo: (json['photo'] as List<dynamic>?)
          ?.map((e) => e == null ? null : MessageResPhoto.fromJson(e as Map))
          .toList(),
      link: const ToString().fromJson(json['link']),
      short_link: const ToString().fromJson(json['short_link']),
      storeid: json['storeid'],
      actions: (json['actions'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      discount: json['discount'] == null
          ? null
          : GridDiscount.fromJson(
              Map<String, dynamic>.from(json['discount'] as Map)),
    );

Map<String, dynamic> _$MessageResDataToJson(MessageResData instance) =>
    <String, dynamic>{
      'id': _$JsonConverterToJson<Object?, int>(
          instance.id, const ToInt().toJson),
      'title': const ToString().toJson(instance.title),
      'price': _$JsonConverterToJson<Object?, int>(
          instance.price, const ToInt().toJson),
      'thumbnail': const ToString().toJson(instance.thumbnail),
      'photo': instance.photo?.map((e) => e?.toJson()).toList(),
      'link': const ToString().toJson(instance.link),
      'short_link': const ToString().toJson(instance.short_link),
      'storeid': instance.storeid,
      'actions': instance.actions?.map(const ToString().toJson).toList(),
      'discount': instance.discount?.toJson(),
    };

MessageResPhoto _$MessageResPhotoFromJson(Map json) => MessageResPhoto(
      image_url: const ToString().fromJson(json['image_url']),
      image_name: const ToString().fromJson(json['image_name']),
    );

Map<String, dynamic> _$MessageResPhotoToJson(MessageResPhoto instance) =>
    <String, dynamic>{
      'image_url': const ToString().toJson(instance.image_url),
      'image_name': const ToString().toJson(instance.image_name),
    };
