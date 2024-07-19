
import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/try_convert.dart';

part 'banner_serial.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class BannerSerial {
  BannerData? data;

  BannerSerial({
    this.data,
  });

  factory BannerSerial.fromJson(Map<String, dynamic> json) => _$BannerSerialFromJson(json);
  Map toJson() => _$BannerSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true)
class BannerData {
  BannerListing? listing;
  SplashScreen? splash_screen;
  BannerListing? detail;
  BannerListing? home;
  BannerListing? account;

  BannerData({
    this.listing,
    this.splash_screen,
    this.detail,
    this.home,
    this.account,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => _$BannerDataFromJson(json);
  Map toJson() => _$BannerDataToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true)
class BannerListing {
  BannerA? a;
  BannerPopUp? pop_up;
  BannerA? b;

  BannerListing({
    this.a,
    this.pop_up,
    this.b,
  });

  factory BannerListing.fromJson(Map<String, dynamic> json) => _$BannerListingFromJson(json);
  Map toJson() => _$BannerListingToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToLists()])
class BannerA {
  String? display_type;
  String? width;
  String? height;
  List<BannerDat?>? data;

  BannerA({
    this.display_type,
    this.width,
    this.height,
    this.data,
  });

  factory BannerA.fromJson(Map<String, dynamic> json) => _$BannerAFromJson(json);
  Map toJson() => _$BannerAToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class BannerDat {
  String? id;
  String? page;
  String? type;
  String? link;
  String? image;
  String? width;
  String? height;

  BannerDat({
    this.id,
    this.page,
    this.type,
    this.link,
    this.image,
    this.width,
    this.height,
  });

  factory BannerDat.fromJson(Map<String, dynamic> json) => _$BannerDatFromJson(json);
  Map toJson() => _$BannerDatToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToInt(), ToBool(), ToLists()])
class BannerPopUp {
  String? display_type;
  String? width;
  String? height;
  int? delay;
  bool? loop;
  bool? auto_close;
  int? duration;
  int? refresh_after;
  bool? allow_skip;
  int? enable_skip_after;
  List<BannerDat?>? data;

  BannerPopUp({
    this.display_type,
    this.width,
    this.height,
    this.delay,
    this.loop,
    this.auto_close,
    this.duration,
    this.refresh_after,
    this.allow_skip,
    this.enable_skip_after,
    this.data,
  });

  factory BannerPopUp.fromJson(Map<String, dynamic> json) => _$BannerPopUpFromJson(json);
  Map toJson() => _$BannerPopUpToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToInt(), ToBool()])
class SplashScreen {
  String? display_type;
  String? width;
  String? height;
  bool? auto_close;
  int? duration;
  bool? allow_skip;
  int? enable_skip_after;
  BannerDat? data;

  SplashScreen({
    this.display_type,
    this.width,
    this.height,
    this.auto_close,
    this.duration,
    this.allow_skip,
    this.enable_skip_after,
    this.data,
  });

  factory SplashScreen.fromJson(Map<String, dynamic> json) => _$SplashScreenFromJson(json);
  Map toJson() => _$SplashScreenToJson(this);

}

