// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_serial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentSerial _$CommentSerialFromJson(Map json) => CommentSerial(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CommentDatum.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      limit: const ToInt().fromJson(json['limit']),
      userid: json['userid'] as String?,
      storeid: json['storeid'] as String?,
    );

Map<String, dynamic> _$CommentSerialToJson(CommentSerial instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e?.toJson()).toList(),
      'limit': _$JsonConverterToJson<Object?, int>(
          instance.limit, const ToInt().toJson),
      'userid': instance.userid,
      'storeid': instance.storeid,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

CommentDatum _$CommentDatumFromJson(Map json) => CommentDatum(
      id: const ToString().fromJson(json['id']),
      total: const ToString().fromJson(json['total']),
      unread: const ToString().fromJson(json['unread']),
      total_users: const ToString().fromJson(json['total_users']),
      date: const ToDateTime().fromJson(json['date']),
      object: json['object'] == null
          ? null
          : CommentObject.fromJson(
              Map<String, dynamic>.from(json['object'] as Map)),
      last_comment: json['last_comment'] == null
          ? null
          : TComment.fromJson(
              Map<String, dynamic>.from(json['last_comment'] as Map)),
      recent_comments: (json['recent_comments'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : TComment.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      comment: const ToString().fromJson(json['comment']),
      type: const ToString().fromJson(json['type']),
      status: const ToString().fromJson(json['status']),
      total_reply: const ToString().fromJson(json['total_reply']),
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(Map<String, dynamic>.from(json['profile'] as Map)),
      last_replies: (json['last_replies'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CommentDatum.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      actions: (json['actions'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
    );

Map<String, dynamic> _$CommentDatumToJson(CommentDatum instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'total': const ToString().toJson(instance.total),
      'unread': const ToString().toJson(instance.unread),
      'total_users': const ToString().toJson(instance.total_users),
      'date': const ToDateTime().toJson(instance.date),
      'object': instance.object?.toJson(),
      'last_comment': instance.last_comment?.toJson(),
      'recent_comments':
          instance.recent_comments?.map((e) => e?.toJson()).toList(),
      'comment': const ToString().toJson(instance.comment),
      'type': const ToString().toJson(instance.type),
      'status': const ToString().toJson(instance.status),
      'total_reply': const ToString().toJson(instance.total_reply),
      'profile': instance.profile?.toJson(),
      'last_replies': instance.last_replies?.map((e) => e?.toJson()).toList(),
      'actions': instance.actions?.map(const ToString().toJson).toList(),
    };

TComment _$TCommentFromJson(Map json) => TComment(
      id: const ToInt().fromJson(json['id']),
      comment: const ToString().fromJson(json['comment']),
      type: const ToString().fromJson(json['type']),
      status: const ToString().fromJson(json['status']),
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(Map<String, dynamic>.from(json['profile'] as Map)),
    );

Map<String, dynamic> _$TCommentToJson(TComment instance) => <String, dynamic>{
      'id': _$JsonConverterToJson<Object?, int>(
          instance.id, const ToInt().toJson),
      'comment': const ToString().toJson(instance.comment),
      'type': const ToString().toJson(instance.type),
      'status': const ToString().toJson(instance.status),
      'profile': instance.profile?.toJson(),
    };

Profile _$ProfileFromJson(Map json) => Profile(
      type: const ToString().fromJson(json['type']),
      data: json['data'] == null
          ? null
          : ProfileData.fromJson(
              Map<String, dynamic>.from(json['data'] as Map)),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'type': const ToString().toJson(instance.type),
      'data': instance.data?.toJson(),
    };

ProfileData _$ProfileDataFromJson(Map json) => ProfileData(
      id: const ToString().fromJson(json['id']),
      username: const ToString().fromJson(json['username']),
      name: const ToString().fromJson(json['name']),
      photo: const ToString().fromJson(json['photo']),
      online_status: json['online_status'] == null
          ? null
          : OnlineStatusProfile.fromJson((json['online_status'] as Map?)?.map(
              (k, e) => MapEntry(k as String, e),
            )),
    );

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'username': const ToString().toJson(instance.username),
      'name': const ToString().toJson(instance.name),
      'photo': const ToString().toJson(instance.photo),
      'online_status': instance.online_status?.toJson(),
    };

CommentObject _$CommentObjectFromJson(Map json) => CommentObject(
      type: const ToString().fromJson(json['type']),
      data: json['data'] == null
          ? null
          : ObjectData.fromJson(Map<String, dynamic>.from(json['data'] as Map)),
    );

Map<String, dynamic> _$CommentObjectToJson(CommentObject instance) =>
    <String, dynamic>{
      'type': const ToString().toJson(instance.type),
      'data': instance.data?.toJson(),
    };

ObjectData _$ObjectDataFromJson(Map json) => ObjectData(
      id: const ToString().fromJson(json['id']),
      title: const ToString().fromJson(json['title']),
      price: const ToString().fromJson(json['price']),
      photo: const ToString().fromJson(json['photo']),
      thumbnail: const ToString().fromJson(json['thumbnail']),
      link: const ToString().fromJson(json['link']),
      discount: json['discount'] == null
          ? null
          : CommentDiscount.fromJson(
              Map<String, dynamic>.from(json['discount'] as Map)),
    );

Map<String, dynamic> _$ObjectDataToJson(ObjectData instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'title': const ToString().toJson(instance.title),
      'price': const ToString().toJson(instance.price),
      'photo': const ToString().toJson(instance.photo),
      'thumbnail': const ToString().toJson(instance.thumbnail),
      'link': const ToString().toJson(instance.link),
      'discount': instance.discount?.toJson(),
    };

CommentDiscount _$CommentDiscountFromJson(Map json) => CommentDiscount(
      sale_price: const ToInt().fromJson(json['sale_price']),
      original_price: const ToString().fromJson(json['original_price']),
      amount_saved: const ToInt().fromJson(json['amount_saved']),
      type: const ToString().fromJson(json['type']),
      discount: const ToString().fromJson(json['discount']),
    );

Map<String, dynamic> _$CommentDiscountToJson(CommentDiscount instance) =>
    <String, dynamic>{
      'sale_price': _$JsonConverterToJson<Object?, int>(
          instance.sale_price, const ToInt().toJson),
      'original_price': const ToString().toJson(instance.original_price),
      'amount_saved': _$JsonConverterToJson<Object?, int>(
          instance.amount_saved, const ToInt().toJson),
      'type': const ToString().toJson(instance.type),
      'discount': const ToString().toJson(instance.discount),
    };
