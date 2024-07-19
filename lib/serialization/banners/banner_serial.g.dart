// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_serial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerSerial _$BannerSerialFromJson(Map json) => BannerSerial(
      data: json['data'] == null
          ? null
          : BannerData.fromJson(Map<String, dynamic>.from(json['data'] as Map)),
    );

Map<String, dynamic> _$BannerSerialToJson(BannerSerial instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
    };

BannerData _$BannerDataFromJson(Map json) => BannerData(
      listing: json['listing'] == null
          ? null
          : BannerListing.fromJson(
              Map<String, dynamic>.from(json['listing'] as Map)),
      splash_screen: json['splash_screen'] == null
          ? null
          : SplashScreen.fromJson(
              Map<String, dynamic>.from(json['splash_screen'] as Map)),
      detail: json['detail'] == null
          ? null
          : BannerListing.fromJson(
              Map<String, dynamic>.from(json['detail'] as Map)),
      home: json['home'] == null
          ? null
          : BannerListing.fromJson(
              Map<String, dynamic>.from(json['home'] as Map)),
      account: json['account'] == null
          ? null
          : BannerListing.fromJson(
              Map<String, dynamic>.from(json['account'] as Map)),
    );

Map<String, dynamic> _$BannerDataToJson(BannerData instance) =>
    <String, dynamic>{
      'listing': instance.listing?.toJson(),
      'splash_screen': instance.splash_screen?.toJson(),
      'detail': instance.detail?.toJson(),
      'home': instance.home?.toJson(),
      'account': instance.account?.toJson(),
    };

BannerListing _$BannerListingFromJson(Map json) => BannerListing(
      a: json['a'] == null
          ? null
          : BannerA.fromJson(Map<String, dynamic>.from(json['a'] as Map)),
      pop_up: json['pop_up'] == null
          ? null
          : BannerPopUp.fromJson(
              Map<String, dynamic>.from(json['pop_up'] as Map)),
      b: json['b'] == null
          ? null
          : BannerA.fromJson(Map<String, dynamic>.from(json['b'] as Map)),
    );

Map<String, dynamic> _$BannerListingToJson(BannerListing instance) =>
    <String, dynamic>{
      'a': instance.a?.toJson(),
      'pop_up': instance.pop_up?.toJson(),
      'b': instance.b?.toJson(),
    };

BannerA _$BannerAFromJson(Map json) => BannerA(
      display_type: const ToString().fromJson(json['display_type']),
      width: const ToString().fromJson(json['width']),
      height: const ToString().fromJson(json['height']),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : BannerDat.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$BannerAToJson(BannerA instance) => <String, dynamic>{
      'display_type': const ToString().toJson(instance.display_type),
      'width': const ToString().toJson(instance.width),
      'height': const ToString().toJson(instance.height),
      'data': instance.data?.map((e) => e?.toJson()).toList(),
    };

BannerDat _$BannerDatFromJson(Map json) => BannerDat(
      id: const ToString().fromJson(json['id']),
      page: const ToString().fromJson(json['page']),
      type: const ToString().fromJson(json['type']),
      link: const ToString().fromJson(json['link']),
      image: const ToString().fromJson(json['image']),
      width: const ToString().fromJson(json['width']),
      height: const ToString().fromJson(json['height']),
    );

Map<String, dynamic> _$BannerDatToJson(BannerDat instance) => <String, dynamic>{
      'id': const ToString().toJson(instance.id),
      'page': const ToString().toJson(instance.page),
      'type': const ToString().toJson(instance.type),
      'link': const ToString().toJson(instance.link),
      'image': const ToString().toJson(instance.image),
      'width': const ToString().toJson(instance.width),
      'height': const ToString().toJson(instance.height),
    };

BannerPopUp _$BannerPopUpFromJson(Map json) => BannerPopUp(
      display_type: const ToString().fromJson(json['display_type']),
      width: const ToString().fromJson(json['width']),
      height: const ToString().fromJson(json['height']),
      delay: const ToInt().fromJson(json['delay']),
      loop: const ToBool().fromJson(json['loop']),
      auto_close: const ToBool().fromJson(json['auto_close']),
      duration: const ToInt().fromJson(json['duration']),
      refresh_after: const ToInt().fromJson(json['refresh_after']),
      allow_skip: const ToBool().fromJson(json['allow_skip']),
      enable_skip_after: const ToInt().fromJson(json['enable_skip_after']),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : BannerDat.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$BannerPopUpToJson(BannerPopUp instance) =>
    <String, dynamic>{
      'display_type': const ToString().toJson(instance.display_type),
      'width': const ToString().toJson(instance.width),
      'height': const ToString().toJson(instance.height),
      'delay': _$JsonConverterToJson<Object?, int>(
          instance.delay, const ToInt().toJson),
      'loop': _$JsonConverterToJson<Object?, bool>(
          instance.loop, const ToBool().toJson),
      'auto_close': _$JsonConverterToJson<Object?, bool>(
          instance.auto_close, const ToBool().toJson),
      'duration': _$JsonConverterToJson<Object?, int>(
          instance.duration, const ToInt().toJson),
      'refresh_after': _$JsonConverterToJson<Object?, int>(
          instance.refresh_after, const ToInt().toJson),
      'allow_skip': _$JsonConverterToJson<Object?, bool>(
          instance.allow_skip, const ToBool().toJson),
      'enable_skip_after': _$JsonConverterToJson<Object?, int>(
          instance.enable_skip_after, const ToInt().toJson),
      'data': instance.data?.map((e) => e?.toJson()).toList(),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

SplashScreen _$SplashScreenFromJson(Map json) => SplashScreen(
      display_type: const ToString().fromJson(json['display_type']),
      width: const ToString().fromJson(json['width']),
      height: const ToString().fromJson(json['height']),
      auto_close: const ToBool().fromJson(json['auto_close']),
      duration: const ToInt().fromJson(json['duration']),
      allow_skip: const ToBool().fromJson(json['allow_skip']),
      enable_skip_after: const ToInt().fromJson(json['enable_skip_after']),
      data: json['data'] == null
          ? null
          : BannerDat.fromJson(Map<String, dynamic>.from(json['data'] as Map)),
    );

Map<String, dynamic> _$SplashScreenToJson(SplashScreen instance) =>
    <String, dynamic>{
      'display_type': const ToString().toJson(instance.display_type),
      'width': const ToString().toJson(instance.width),
      'height': const ToString().toJson(instance.height),
      'auto_close': _$JsonConverterToJson<Object?, bool>(
          instance.auto_close, const ToBool().toJson),
      'duration': _$JsonConverterToJson<Object?, int>(
          instance.duration, const ToInt().toJson),
      'allow_skip': _$JsonConverterToJson<Object?, bool>(
          instance.allow_skip, const ToBool().toJson),
      'enable_skip_after': _$JsonConverterToJson<Object?, int>(
          instance.enable_skip_after, const ToInt().toJson),
      'data': instance.data?.toJson(),
    };
