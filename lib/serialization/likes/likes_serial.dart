
import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/helper.dart';
import 'package:k24/serialization/try_convert.dart';

part 'likes_serial.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToInt(), ToLists()])
class LikeSerial {
  int? limit;
  List<LikesDatum?>? data;

  LikeSerial({
    this.limit,
    this.data,
  });

  factory LikeSerial.fromJson(Map<String, dynamic> json) => _$LikeSerialFromJson(json);
  Map? toJson() => _$LikeSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToDateTime()])
class LikesDatum {
  String? id;
  String? type;
  dynamic data;
  DateTime? date;

  LikesDatum({
    this.id,
    this.type,
    this.data,
    this.date,
  });

  factory LikesDatum.fromJson(Map<String, dynamic> json) => _$LikesDatumFromJson(json);
  Map? toJson() => _$LikesDatumToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToLists()])
class LikesData {
  String? id;
  String? title;
  String? price;
  String? userid;
  LikesContact? contact;
  String? link;
  String? name;
  String? username;
  dynamic photo;
  bool? is_verify;
  List<String?>? photos;
  String? thumbnail;
  List<String?>? thumbnails;
  OnlineStatusProfile? online_status;

  LikesData({
    this.id,
    this.title,
    this.price,
    this.userid,
    this.contact,
    this.link,
    this.name,
    this.username,
    this.photo,
    this.photos,
    this.thumbnail,
    this.thumbnails,
    this.online_status,
  });

  factory LikesData.fromJson(Map<String, dynamic> json) => _$LikesDataFromJson(json);
  Map? toJson() => _$LikesDataToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToLists()])
class LikesContact {
  String? name;
  Location_? location;
  List<String?>? phone;

  LikesContact({
    this.name,
    this.location,
    this.phone,
  });

  factory LikesContact.fromJson(Map<String, dynamic> json) => _$LikesContactFromJson(json);
  Map? toJson() => _$LikesContactToJson(this);

}


