// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profiles_own.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnTotalPost _$OwnTotalPostFromJson(Map json) => OwnTotalPost(
      data: OwnDataTotalPost.fromJson(
          Map<String, dynamic>.from(json['data'] as Map)),
    );

Map<String, dynamic> _$OwnTotalPostToJson(OwnTotalPost instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

OwnDataTotalPost _$OwnDataTotalPostFromJson(Map json) => OwnDataTotalPost(
      paid: const ToString().fromJson(json['paid']),
      active: const ToString().fromJson(json['active']),
      expired: const ToString().fromJson(json['expired']),
      total: const ToString().fromJson(json['total']),
      saved: const ToString().fromJson(json['saved']),
    );

Map<String, dynamic> _$OwnDataTotalPostToJson(OwnDataTotalPost instance) =>
    <String, dynamic>{
      'paid': const ToString().toJson(instance.paid),
      'active': const ToString().toJson(instance.active),
      'expired': const ToString().toJson(instance.expired),
      'total': const ToString().toJson(instance.total),
      'saved': const ToString().toJson(instance.saved),
    };

OwnProfileSerial _$OwnProfileSerialFromJson(Map json) => OwnProfileSerial(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : DatumProfile.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      limit: const ToInt().fromJson(json['limit']),
      available_paid_ads: json['available_paid_ads'],
    );

Map<String, dynamic> _$OwnProfileSerialToJson(OwnProfileSerial instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e?.toJson()).toList(),
      'limit': _$JsonConverterToJson<Object?, int>(
          instance.limit, const ToInt().toJson),
      'available_paid_ads': instance.available_paid_ads,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

DatumProfile _$DatumProfileFromJson(Map json) => DatumProfile(
      id: const ToString().fromJson(json['id']),
      storeid: json['storeid'],
      title: const ToString().fromJson(json['title']),
      price: json['price'],
      discount: json['discount'] == null
          ? null
          : DiscountProfile.fromJson(
              Map<String, dynamic>.from(json['discount'] as Map)),
      photo: const ToString().fromJson(json['photo']),
      thumbnail: const ToString().fromJson(json['thumbnail']),
      status: const ToString().fromJson(json['status']),
      status_message: const ToString().fromJson(json['status_message']),
      is_premium: const ToBool().fromJson(json['is_premium']),
      views: const ToString().fromJson(json['views']),
      location: json['location'] == null
          ? null
          : Location_.fromJson(
              Map<String, dynamic>.from(json['location'] as Map)),
      posted_date: const ToDateTime().fromJson(json['posted_date']),
      last_update: const ToDateTime().fromJson(json['last_update']),
      renew_date: const ToDateTime().fromJson(json['renew_date']),
      link: const ToString().fromJson(json['link']),
      total_like: const ToString().fromJson(json['total_like']),
      total_comment: const ToString().fromJson(json['total_comment']),
      shipping: json['shipping'] == null
          ? null
          : CategoryTypeProfile.fromJson(
              Map<String, dynamic>.from(json['shipping'] as Map)),
      short_link: const ToString().fromJson(json['short_link']),
      insights: json['insights'] == null
          ? null
          : InsightsProfile.fromJson(
              Map<String, dynamic>.from(json['insights'] as Map)),
      category_type: json['category_type'] == null
          ? null
          : CategoryTypeProfile.fromJson(
              Map<String, dynamic>.from(json['category_type'] as Map)),
      actions:
          (json['actions'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DatumProfileToJson(DatumProfile instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'storeid': instance.storeid,
      'title': const ToString().toJson(instance.title),
      'price': instance.price,
      'discount': instance.discount?.toJson(),
      'photo': const ToString().toJson(instance.photo),
      'thumbnail': const ToString().toJson(instance.thumbnail),
      'status': const ToString().toJson(instance.status),
      'status_message': const ToString().toJson(instance.status_message),
      'is_premium': _$JsonConverterToJson<Object?, bool>(
          instance.is_premium, const ToBool().toJson),
      'views': const ToString().toJson(instance.views),
      'location': instance.location?.toJson(),
      'posted_date': const ToDateTime().toJson(instance.posted_date),
      'last_update': const ToDateTime().toJson(instance.last_update),
      'renew_date': const ToDateTime().toJson(instance.renew_date),
      'link': const ToString().toJson(instance.link),
      'short_link': const ToString().toJson(instance.short_link),
      'total_like': const ToString().toJson(instance.total_like),
      'total_comment': const ToString().toJson(instance.total_comment),
      'shipping': instance.shipping?.toJson(),
      'insights': instance.insights?.toJson(),
      'category_type': instance.category_type?.toJson(),
      'actions': instance.actions,
    };

CategoryTypeProfile _$CategoryTypeProfileFromJson(Map json) =>
    CategoryTypeProfile(
      type: const ToString().fromJson(json['type']),
      title: const ToString().fromJson(json['title']),
      category_type_slug: const ToString().fromJson(json['category_type_slug']),
      slug: const ToString().fromJson(json['slug']),
    );

Map<String, dynamic> _$CategoryTypeProfileToJson(
        CategoryTypeProfile instance) =>
    <String, dynamic>{
      'type': const ToString().toJson(instance.type),
      'title': const ToString().toJson(instance.title),
      'category_type_slug':
          const ToString().toJson(instance.category_type_slug),
      'slug': const ToString().toJson(instance.slug),
    };

DiscountProfile _$DiscountProfileFromJson(Map json) => DiscountProfile(
      sale_price: const ToInt().fromJson(json['sale_price']),
      original_price: const ToString().fromJson(json['original_price']),
      amount_saved: const ToInt().fromJson(json['amount_saved']),
      type: const ToString().fromJson(json['type']),
      discount: const ToString().fromJson(json['discount']),
    );

Map<String, dynamic> _$DiscountProfileToJson(DiscountProfile instance) =>
    <String, dynamic>{
      'sale_price': _$JsonConverterToJson<Object?, int>(
          instance.sale_price, const ToInt().toJson),
      'original_price': const ToString().toJson(instance.original_price),
      'amount_saved': _$JsonConverterToJson<Object?, int>(
          instance.amount_saved, const ToInt().toJson),
      'type': const ToString().toJson(instance.type),
      'discount': const ToString().toJson(instance.discount),
    };

InsightsProfile _$InsightsProfileFromJson(Map json) => InsightsProfile(
      reach: const ToInt().fromJson(json['reach']),
      engagement: const ToInt().fromJson(json['engagement']),
      impression: const ToInt().fromJson(json['impression']),
    );

Map<String, dynamic> _$InsightsProfileToJson(InsightsProfile instance) =>
    <String, dynamic>{
      'reach': _$JsonConverterToJson<Object?, int>(
          instance.reach, const ToInt().toJson),
      'engagement': _$JsonConverterToJson<Object?, int>(
          instance.engagement, const ToInt().toJson),
      'impression': _$JsonConverterToJson<Object?, int>(
          instance.impression, const ToInt().toJson),
    };

DeleteReasonSerial _$DeleteReasonSerialFromJson(Map json) => DeleteReasonSerial(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : DeleteReasonDatum.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$DeleteReasonSerialToJson(DeleteReasonSerial instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e?.toJson()).toList(),
    };

DeleteReasonDatum _$DeleteReasonDatumFromJson(Map json) => DeleteReasonDatum(
      value: const ToString().fromJson(json['value']),
      km: const ToString().fromJson(json['km']),
      en: const ToString().fromJson(json['en']),
    );

Map<String, dynamic> _$DeleteReasonDatumToJson(DeleteReasonDatum instance) =>
    <String, dynamic>{
      'value': const ToString().toJson(instance.value),
      'km': const ToString().toJson(instance.km),
      'en': const ToString().toJson(instance.en),
    };
