// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grid_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeSerial _$HomeSerialFromJson(Map json) => HomeSerial(
      total: const ToInt().fromJson(json['total']),
      limit: const ToInt().fromJson(json['limit']),
      offset: const ToInt().fromJson(json['offset']),
      current_result: const ToInt().fromJson(json['current_result']),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null ? null : GridCard.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$HomeSerialToJson(HomeSerial instance) =>
    <String, dynamic>{
      'total': _$JsonConverterToJson<Object?, int>(
          instance.total, const ToInt().toJson),
      'limit': _$JsonConverterToJson<Object?, int>(
          instance.limit, const ToInt().toJson),
      'offset': _$JsonConverterToJson<Object?, int>(
          instance.offset, const ToInt().toJson),
      'current_result': _$JsonConverterToJson<Object?, int>(
          instance.current_result, const ToInt().toJson),
      'data': instance.data,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

GridCard _$GridCardFromJson(Map json) => GridCard(
      type: ToString.tryConvert(json['type']),
      data: json['data'] == null ? null : Data_.fromJson(json['data'] as Map),
      setting: json['setting'] == null
          ? null
          : Setting_.fromJson(
              Map<String, dynamic>.from(json['setting'] as Map)),
      actions: (json['actions'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
    );

Map<String, dynamic> _$GridCardToJson(GridCard instance) => <String, dynamic>{
      'type': const ToString().toJson(instance.type),
      'data': instance.data?.toJson(),
      'setting': instance.setting?.toJson(),
      'actions': instance.actions?.map(const ToString().toJson).toList(),
    };

Data_ _$Data_FromJson(Map json) => Data_(
      id: ToString.tryConvert(json['id']),
      title: const ToString().fromJson(json['title']),
      is_premium: const ToBool().fromJson(json['is_premium']),
      description: const ToString().fromJson(json['description']),
      photo: const ToString().fromJson(json['photo']),
      photos: (json['photos'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      thumbnail: const ToString().fromJson(json['thumbnail']),
      thumbnails: (json['thumbnails'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      phone: (json['phone'] as List<dynamic>?)
          ?.map(const ToString().fromJson)
          .toList(),
      phone_white_operator: (json['phone_white_operator'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : PhoneWhiteOperator_.fromJson(
                  Map<String, dynamic>.from(e as Map)))
          .toList(),
      views: const ToString().fromJson(json['views']),
      renew_date: const ToDateTime().fromJson(json['renew_date']),
      posted_date: const ToDateTime().fromJson(json['posted_date']),
      link: const ToString().fromJson(json['link']),
      short_link: const ToString().fromJson(json['short_link']),
      user: json['user'] == null
          ? null
          : User_.fromJson(Map<String, dynamic>.from(json['user'] as Map)),
      store: json['store'] == null
          ? null
          : Store_.fromJson(Map<String, dynamic>.from(json['store'] as Map)),
      location: json['location'] == null
          ? null
          : Location_.fromJson(
              Map<String, dynamic>.from(json['location'] as Map)),
      category: json['category'] == null
          ? null
          : Category_.fromJson(
              Map<String, dynamic>.from(json['category'] as Map)),
      highlight_specs: (json['highlight_specs'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : HighlightSpec.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      specs: (json['specs'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : Spec_.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      status: const ToString().fromJson(json['status']),
      condition: json['condition'] == null
          ? null
          : Condition_.fromJson(
              Map<String, dynamic>.from(json['condition'] as Map)),
      type: const ToString().fromJson(json['type']),
      price: const ToDouble().fromJson(json['price']),
      total_like: const ToInt().fromJson(json['total_like']),
    );

Map<String, dynamic> _$Data_ToJson(Data_ instance) => <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'title': const ToString().toJson(instance.title),
      'is_premium': _$JsonConverterToJson<Object?, bool>(
          instance.is_premium, const ToBool().toJson),
      'description': const ToString().toJson(instance.description),
      'photo': const ToString().toJson(instance.photo),
      'photos': instance.photos?.map(const ToString().toJson).toList(),
      'thumbnail': const ToString().toJson(instance.thumbnail),
      'thumbnails': instance.thumbnails?.map(const ToString().toJson).toList(),
      'phone': instance.phone?.map(const ToString().toJson).toList(),
      'phone_white_operator':
          instance.phone_white_operator?.map((e) => e?.toJson()).toList(),
      'views': const ToString().toJson(instance.views),
      'renew_date': const ToDateTime().toJson(instance.renew_date),
      'posted_date': const ToDateTime().toJson(instance.posted_date),
      'link': const ToString().toJson(instance.link),
      'short_link': const ToString().toJson(instance.short_link),
      'user': instance.user?.toJson(),
      'store': instance.store?.toJson(),
      'location': instance.location?.toJson(),
      'category': instance.category?.toJson(),
      'highlight_specs':
          instance.highlight_specs?.map((e) => e?.toJson()).toList(),
      'specs': instance.specs?.map((e) => e?.toJson()).toList(),
      'status': const ToString().toJson(instance.status),
      'condition': instance.condition?.toJson(),
      'type': const ToString().toJson(instance.type),
      'price': _$JsonConverterToJson<Object?, double>(
          instance.price, const ToDouble().toJson),
      'total_like': _$JsonConverterToJson<Object?, int>(
          instance.total_like, const ToInt().toJson),
    };

Category_ _$Category_FromJson(Map<String, dynamic> json) => Category_(
      id: const ToString().fromJson(json['id']),
      en_name: const ToString().fromJson(json['en_name']),
      km_name: const ToString().fromJson(json['km_name']),
      slug: const ToString().fromJson(json['slug']),
      parent: const ToString().fromJson(json['parent']),
      parent_data: json['parent_data'] == null
          ? null
          : ParentData.fromJson(json['parent_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$Category_ToJson(Category_ instance) => <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'en_name': const ToString().toJson(instance.en_name),
      'km_name': const ToString().toJson(instance.km_name),
      'slug': const ToString().toJson(instance.slug),
      'parent': const ToString().toJson(instance.parent),
      'parent_data': instance.parent_data,
    };

ParentData _$ParentDataFromJson(Map<String, dynamic> json) => ParentData(
      id: const ToString().fromJson(json['id']),
      en_name: const ToString().fromJson(json['en_name']),
      km_name: const ToString().fromJson(json['km_name']),
      slug: const ToString().fromJson(json['slug']),
    );

Map<String, dynamic> _$ParentDataToJson(ParentData instance) =>
    <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'en_name': const ToString().toJson(instance.en_name),
      'km_name': const ToString().toJson(instance.km_name),
      'slug': const ToString().toJson(instance.slug),
    };

PhoneWhiteOperator_ _$PhoneWhiteOperator_FromJson(Map<String, dynamic> json) =>
    PhoneWhiteOperator_(
      title: const ToString().fromJson(json['title']),
      slug: const ToString().fromJson(json['slug']),
      icon: const ToString().fromJson(json['icon']),
      phone: const ToString().fromJson(json['phone']),
    );

Map<String, dynamic> _$PhoneWhiteOperator_ToJson(
        PhoneWhiteOperator_ instance) =>
    <String, dynamic>{
      'title': const ToString().toJson(instance.title),
      'slug': const ToString().toJson(instance.slug),
      'icon': const ToString().toJson(instance.icon),
      'phone': const ToString().toJson(instance.phone),
    };

Spec_ _$Spec_FromJson(Map<String, dynamic> json) => Spec_(
      title: const ToString().fromJson(json['title']),
      field: const ToString().fromJson(json['field']),
      value: const ToString().fromJson(json['value']),
      display_value: const ToString().fromJson(json['display_value']),
      value_slug: const ToString().fromJson(json['value_slug']),
    );

Map<String, dynamic> _$Spec_ToJson(Spec_ instance) => <String, dynamic>{
      'title': const ToString().toJson(instance.title),
      'field': const ToString().toJson(instance.field),
      'value': const ToString().toJson(instance.value),
      'display_value': const ToString().toJson(instance.display_value),
      'value_slug': const ToString().toJson(instance.value_slug),
    };

Condition_ _$Condition_FromJson(Map<String, dynamic> json) => Condition_(
      title: const ToString().fromJson(json['title']),
      field: const ToString().fromJson(json['field']),
      value: const ToString().fromJson(json['value']),
    );

Map<String, dynamic> _$Condition_ToJson(Condition_ instance) =>
    <String, dynamic>{
      'title': const ToString().toJson(instance.title),
      'field': const ToString().toJson(instance.field),
      'value': const ToString().toJson(instance.value),
    };

HighlightSpec _$HighlightSpecFromJson(Map<String, dynamic> json) =>
    HighlightSpec(
      title: const ToString().fromJson(json['title']),
      field: const ToString().fromJson(json['field']),
      value: const ToString().fromJson(json['value']),
      display_value: const ToString().fromJson(json['display_value']),
      value_slug: const ToString().fromJson(json['value_slug']),
    );

Map<String, dynamic> _$HighlightSpecToJson(HighlightSpec instance) =>
    <String, dynamic>{
      'title': const ToString().toJson(instance.title),
      'field': const ToString().toJson(instance.field),
      'value': const ToString().toJson(instance.value),
      'display_value': const ToString().toJson(instance.display_value),
      'value_slug': const ToString().toJson(instance.value_slug),
    };

Location_ _$Location_FromJson(Map<String, dynamic> json) => Location_(
      id: const ToString().fromJson(json['id']),
      en_name: const ToString().fromJson(json['en_name']),
      km_name: const ToString().fromJson(json['km_name']),
      en_name2: const ToString().fromJson(json['en_name2']),
      km_name2: const ToString().fromJson(json['km_name2']),
      en_name3: const ToString().fromJson(json['en_name3']),
      km_name3: const ToString().fromJson(json['km_name3']),
      slug: const ToString().fromJson(json['slug']),
      address: const ToString().fromJson(json['address']),
      long_location: const ToString().fromJson(json['long_location']),
    );

Map<String, dynamic> _$Location_ToJson(Location_ instance) => <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'en_name': const ToString().toJson(instance.en_name),
      'km_name': const ToString().toJson(instance.km_name),
      'en_name2': const ToString().toJson(instance.en_name2),
      'km_name2': const ToString().toJson(instance.km_name2),
      'en_name3': const ToString().toJson(instance.en_name3),
      'km_name3': const ToString().toJson(instance.km_name3),
      'slug': const ToString().toJson(instance.slug),
      'address': const ToString().toJson(instance.address),
      'long_location': const ToString().toJson(instance.long_location),
    };

Store_ _$Store_FromJson(Map<String, dynamic> json) => Store_(
      id: const ToString().fromJson(json['id']),
      title: const ToString().fromJson(json['title']),
      username: const ToString().fromJson(json['username']),
      userid: const ToString().fromJson(json['userid']),
      is_verify: const ToBool().fromJson(json['is_verify']),
      created_date: json['created_date'],
      taxed: const ToString().fromJson(json['taxed']),
    );

Map<String, dynamic> _$Store_ToJson(Store_ instance) => <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'title': const ToString().toJson(instance.title),
      'username': const ToString().toJson(instance.username),
      'userid': const ToString().toJson(instance.userid),
      'is_verify': _$JsonConverterToJson<Object?, bool>(
          instance.is_verify, const ToBool().toJson),
      'created_date': instance.created_date,
      'taxed': const ToString().toJson(instance.taxed),
    };

User_ _$User_FromJson(Map<String, dynamic> json) => User_(
      id: const ToString().fromJson(json['id']),
      name: const ToString().fromJson(json['name']),
      username: const ToString().fromJson(json['username']),
      photo: json['photo'] == null
          ? null
          : Photo_.fromJson(json['photo'] as Map<String, dynamic>),
      online_status: json['online_status'] == null
          ? null
          : OnlineStatus.fromJson(
              json['online_status'] as Map<String, dynamic>),
      is_verify: const ToBool().fromJson(json['is_verify']),
      registered_date: const ToDateTime().fromJson(json['registered_date']),
      taxed: const ToString().fromJson(json['taxed']),
      user_type: const ToString().fromJson(json['user_type']),
    );

Map<String, dynamic> _$User_ToJson(User_ instance) => <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'name': const ToString().toJson(instance.name),
      'username': const ToString().toJson(instance.username),
      'photo': instance.photo,
      'online_status': instance.online_status,
      'is_verify': _$JsonConverterToJson<Object?, bool>(
          instance.is_verify, const ToBool().toJson),
      'registered_date': const ToDateTime().toJson(instance.registered_date),
      'taxed': const ToString().toJson(instance.taxed),
      'user_type': const ToString().toJson(instance.user_type),
    };

OnlineStatus _$OnlineStatusFromJson(Map<String, dynamic> json) => OnlineStatus(
      is_active: const ToBool().fromJson(json['is_active']),
      last_active: const ToString().fromJson(json['last_active']),
      time: json['time'],
      date: const ToDateTime().fromJson(json['date']),
    );

Map<String, dynamic> _$OnlineStatusToJson(OnlineStatus instance) =>
    <String, dynamic>{
      'is_active': _$JsonConverterToJson<Object?, bool>(
          instance.is_active, const ToBool().toJson),
      'last_active': const ToString().toJson(instance.last_active),
      'time': instance.time,
      'date': const ToDateTime().toJson(instance.date),
    };

Photo_ _$Photo_FromJson(Map<String, dynamic> json) => Photo_(
      url: const ToString().fromJson(json['url']),
      width: const ToString().fromJson(json['width']),
      height: const ToString().fromJson(json['height']),
      small: json['small'] == null
          ? null
          : Large.fromJson(json['small'] as Map<String, dynamic>),
      medium: json['medium'] == null
          ? null
          : Large.fromJson(json['medium'] as Map<String, dynamic>),
      large: json['large'] == null
          ? null
          : Large.fromJson(json['large'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$Photo_ToJson(Photo_ instance) => <String, dynamic>{
      'url': const ToString().toJson(instance.url),
      'width': const ToString().toJson(instance.width),
      'height': const ToString().toJson(instance.height),
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
    };

Large _$LargeFromJson(Map<String, dynamic> json) => Large(
      url: const ToString().fromJson(json['url']),
      width: const ToString().fromJson(json['width']),
      height: const ToString().fromJson(json['height']),
    );

Map<String, dynamic> _$LargeToJson(Large instance) => <String, dynamic>{
      'url': const ToString().toJson(instance.url),
      'width': const ToString().toJson(instance.width),
      'height': const ToString().toJson(instance.height),
    };

Setting_ _$Setting_FromJson(Map<String, dynamic> json) => Setting_(
      show_contact: const ToBool().fromJson(json['show_contact']),
      enable_chat: const ToBool().fromJson(json['enable_chat']),
      enable_like: const ToBool().fromJson(json['enable_like']),
      enable_save: const ToBool().fromJson(json['enable_save']),
      enable_comment: const ToBool().fromJson(json['enable_comment']),
      enable_buy: const ToBool().fromJson(json['enable_buy']),
      enable_offer: const ToBool().fromJson(json['enable_offer']),
      enable_apply_job: const ToBool().fromJson(json['enable_apply_job']),
      enable_shipping: const ToBool().fromJson(json['enable_shipping']),
    );

Map<String, dynamic> _$Setting_ToJson(Setting_ instance) => <String, dynamic>{
      'show_contact': _$JsonConverterToJson<Object?, bool>(
          instance.show_contact, const ToBool().toJson),
      'enable_chat': _$JsonConverterToJson<Object?, bool>(
          instance.enable_chat, const ToBool().toJson),
      'enable_like': _$JsonConverterToJson<Object?, bool>(
          instance.enable_like, const ToBool().toJson),
      'enable_save': _$JsonConverterToJson<Object?, bool>(
          instance.enable_save, const ToBool().toJson),
      'enable_comment': _$JsonConverterToJson<Object?, bool>(
          instance.enable_comment, const ToBool().toJson),
      'enable_offer': _$JsonConverterToJson<Object?, bool>(
          instance.enable_offer, const ToBool().toJson),
      'enable_buy': _$JsonConverterToJson<Object?, bool>(
          instance.enable_buy, const ToBool().toJson),
      'enable_apply_job': _$JsonConverterToJson<Object?, bool>(
          instance.enable_apply_job, const ToBool().toJson),
      'enable_shipping': _$JsonConverterToJson<Object?, bool>(
          instance.enable_shipping, const ToBool().toJson),
    };
