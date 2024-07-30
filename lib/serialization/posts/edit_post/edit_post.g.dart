// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditPostSerial _$EditPostSerialFromJson(Map json) => EditPostSerial(
      data: json['data'] == null
          ? null
          : EditPostData.fromJson(json['data'] as Map),
    );

Map<String, dynamic> _$EditPostSerialToJson(EditPostSerial instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
    };

EditPostData _$EditPostDataFromJson(Map json) => EditPostData(
      type: const ToString().fromJson(json['type']),
      fields: json['fields'] == null
          ? null
          : EditFields.fromJson(json['fields'] as Map),
      post:
          json['post'] == null ? null : EditPost.fromJson(json['post'] as Map),
      prices: json['prices'] == null
          ? null
          : EditPostPrices.fromJson(json['prices'] as Map),
      locations: json['locations'] == null
          ? null
          : EditPostLocations.fromJson(json['locations'] as Map),
      deliveries: json['deliveries'] == null
          ? null
          : EditPostDeliveries.fromJson(json['deliveries'] as Map),
      photos: json['photos'] == null
          ? null
          : EditPostPhotos.fromJson(json['photos'] as Map),
      descriptions: json['descriptions'] == null
          ? null
          : EditPostDescriptions.fromJson(json['descriptions'] as Map),
      headlines: json['headlines'] == null
          ? null
          : EditHeadlines.fromJson(json['headlines'] as Map),
      contact: json['contact'] == null
          ? null
          : PostContact.fromJson(json['contact'] as Map),
    );

Map<String, dynamic> _$EditPostDataToJson(EditPostData instance) =>
    <String, dynamic>{
      'type': const ToString().toJson(instance.type),
      'fields': instance.fields?.toJson(),
      'post': instance.post?.toJson(),
      'prices': instance.prices?.toJson(),
      'locations': instance.locations?.toJson(),
      'deliveries': instance.deliveries?.toJson(),
      'photos': instance.photos?.toJson(),
      'descriptions': instance.descriptions?.toJson(),
      'headlines': instance.headlines?.toJson(),
      'contact': instance.contact?.toJson(),
    };

EditPostDeliveries _$EditPostDeliveriesFromJson(Map json) => EditPostDeliveries(
      shipping: json['shipping'] == null
          ? null
          : PostDelivery.fromJson(json['shipping'] as Map),
    );

Map<String, dynamic> _$EditPostDeliveriesToJson(EditPostDeliveries instance) =>
    <String, dynamic>{
      'shipping': instance.shipping?.toJson(),
    };

EditPostDescriptions _$EditPostDescriptionsFromJson(Map json) =>
    EditPostDescriptions(
      ad_text: json['ad_text'] == null
          ? null
          : PostDataField.fromJson(json['ad_text'] as Map),
    );

Map<String, dynamic> _$EditPostDescriptionsToJson(
        EditPostDescriptions instance) =>
    <String, dynamic>{
      'ad_text': instance.ad_text?.toJson(),
    };

EditFields _$EditFieldsFromJson(Map json) => EditFields(
      ad_field: json['ad_field'] == null
          ? null
          : PostDataField.fromJson(json['ad_field'] as Map),
      ad_model: json['ad_model'] == null
          ? null
          : PostDataField.fromJson(json['ad_model'] as Map),
      ad_year: json['ad_year'] == null
          ? null
          : PostDataField.fromJson(json['ad_year'] as Map),
      ad_auto_condition: json['ad_auto_condition'] == null
          ? null
          : PostDataField.fromJson(json['ad_auto_condition'] as Map),
      ad_condition: json['ad_condition'] == null
          ? null
          : PostDataField.fromJson(json['ad_condition'] as Map),
      ad_color: json['ad_color'] == null
          ? null
          : PostDataField.fromJson(json['ad_color'] as Map),
      ad_transmission: json['ad_transmission'] == null
          ? null
          : PostDataField.fromJson(json['ad_transmission'] as Map),
      ad_fuel: json['ad_fuel'] == null
          ? null
          : PostDataField.fromJson(json['ad_fuel'] as Map),
      ad_type: json['ad_type'] == null
          ? null
          : PostDataField.fromJson(json['ad_type'] as Map),
      available: json['available'] == null
          ? null
          : PostDataField.fromJson(json['available'] as Map),
    );

Map<String, dynamic> _$EditFieldsToJson(EditFields instance) =>
    <String, dynamic>{
      'ad_field': instance.ad_field?.toJson(),
      'ad_model': instance.ad_model?.toJson(),
      'ad_year': instance.ad_year?.toJson(),
      'ad_auto_condition': instance.ad_auto_condition?.toJson(),
      'ad_condition': instance.ad_condition?.toJson(),
      'ad_color': instance.ad_color?.toJson(),
      'ad_transmission': instance.ad_transmission?.toJson(),
      'ad_fuel': instance.ad_fuel?.toJson(),
      'ad_type': instance.ad_type?.toJson(),
      'available': instance.available?.toJson(),
    };

EditHeadlines _$EditHeadlinesFromJson(Map json) => EditHeadlines(
      ad_headline: json['ad_headline'] == null
          ? null
          : PostDataField.fromJson(json['ad_headline'] as Map),
    );

Map<String, dynamic> _$EditHeadlinesToJson(EditHeadlines instance) =>
    <String, dynamic>{
      'ad_headline': instance.ad_headline?.toJson(),
    };

EditPostLocations _$EditPostLocationsFromJson(Map json) => EditPostLocations(
      province: json['province'] == null
          ? null
          : PostLocation.fromJson(json['province'] as Map),
      district: json['district'] == null
          ? null
          : PostLocation.fromJson(json['district'] as Map),
      commune: json['commune'] == null
          ? null
          : PostLocation.fromJson(json['commune'] as Map),
      address: json['address'] == null
          ? null
          : PostLocation.fromJson(json['address'] as Map),
      map: json['map'] == null
          ? null
          : PostLocation.fromJson(json['map'] as Map),
    );

Map<String, dynamic> _$EditPostLocationsToJson(EditPostLocations instance) =>
    <String, dynamic>{
      'province': instance.province?.toJson(),
      'district': instance.district?.toJson(),
      'commune': instance.commune?.toJson(),
      'address': instance.address?.toJson(),
      'map': instance.map?.toJson(),
    };

EditPostPhotos _$EditPostPhotosFromJson(Map json) => EditPostPhotos(
      ad_photo: json['ad_photo'] == null
          ? null
          : PostLocation.fromJson(json['ad_photo'] as Map),
    );

Map<String, dynamic> _$EditPostPhotosToJson(EditPostPhotos instance) =>
    <String, dynamic>{
      'ad_photo': instance.ad_photo?.toJson(),
    };

EditPost _$EditPostFromJson(Map json) => EditPost(
      photo: (json['photo'] as List<dynamic>?)
          ?.map((e) => e == null ? null : MessageResPhoto.fromJson(e as Map))
          .toList(),
      title: const ToString().fromJson(json['title']),
      cateid: const ToString().fromJson(json['cateid']),
      category: json['category'] == null
          ? null
          : PostCommune.fromJson(json['category'] as Map),
      description: const ToString().fromJson(json['description']),
    );

Map<String, dynamic> _$EditPostToJson(EditPost instance) => <String, dynamic>{
      'photo': instance.photo?.map((e) => e?.toJson()).toList(),
      'title': const ToString().toJson(instance.title),
      'cateid': const ToString().toJson(instance.cateid),
      'category': instance.category?.toJson(),
      'description': const ToString().toJson(instance.description),
    };

EditPostPrices _$EditPostPricesFromJson(Map json) => EditPostPrices(
      discount: json['discount'] == null
          ? null
          : PostPrice.fromJson(json['discount'] as Map),
      ad_price: json['ad_price'] == null
          ? null
          : PostPrice.fromJson(json['ad_price'] as Map),
    );

Map<String, dynamic> _$EditPostPricesToJson(EditPostPrices instance) =>
    <String, dynamic>{
      'discount': instance.discount?.toJson(),
      'ad_price': instance.ad_price?.toJson(),
    };
