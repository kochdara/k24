
import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/try_convert.dart';

import '../../helper.dart';

part 'comments_serial.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToLists(), ToInt()])
class CommentSerial {
  List<CommentDatum?>? data;
  int? limit;
  String? userid;
  String? storeid;

  CommentSerial({
    this.data,
    this.limit,
    this.userid,
    this.storeid,
  });

  factory CommentSerial.fromJson(Map<String, dynamic> json) => _$CommentSerialFromJson(json);
  Map toJson() => _$CommentSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToLists(), ToString(), ToDateTime()])
class CommentDatum {
  String? id;
  String? total;
  String? unread;
  String? total_users;
  DateTime? date;
  CommentObject? object;
  TComment? last_comment;
  List<TComment?>? recent_comments;
  String? comment;
  String? comment_status;
  String? type;
  String? status;
  String? total_reply;
  Profile? profile;
  List<CommentDatum?>? last_replies;
  List<String?>? actions;

  CommentDatum({
    this.id,
    this.total,
    this.unread,
    this.total_users,
    this.date,
    this.object,
    this.last_comment,
    this.recent_comments,
    this.comment,
    this.comment_status,
    this.type,
    this.status,
    this.total_reply,
    this.profile,
    this.last_replies,
    this.actions,
  });

  factory CommentDatum.fromJson(Map<String, dynamic> json) => _$CommentDatumFromJson(json);
  Map toJson() => _$CommentDatumToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToInt()])
class TComment {
  int? id;
  String? comment;
  String? type;
  String? status;
  Profile? profile;

  TComment({
    this.id,
    this.comment,
    this.type,
    this.status,
    this.profile,
  });

  factory TComment.fromJson(Map<String, dynamic> json) => _$TCommentFromJson(json);
  Map toJson() => _$TCommentToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class Profile {
  String? type;
  ProfileData? data;

  Profile({
    this.type,
    this.data,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
  Map toJson() => _$ProfileToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class ProfileData {
  String? id;
  String? username;
  String? name;
  String? photo;
  OnlineStatusProfile? online_status;

  ProfileData({
    this.id,
    this.username,
    this.name,
    this.photo,
    this.online_status,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => _$ProfileDataFromJson(json);
  Map toJson() => _$ProfileDataToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class CommentObject {
  String? type;
  ObjectData? data;

  CommentObject({
    this.type,
    this.data,
  });

  factory CommentObject.fromJson(Map<String, dynamic> json) => _$CommentObjectFromJson(json);
  Map toJson() => _$CommentObjectToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class ObjectData {
  String? id;
  String? title;
  String? price;
  String? photo;
  String? thumbnail;
  String? link;
  CommentDiscount? discount;

  ObjectData({
    this.id,
    this.title,
    this.price,
    this.photo,
    this.thumbnail,
    this.link,
    this.discount,
  });

  factory ObjectData.fromJson(Map<String, dynamic> json) => _$ObjectDataFromJson(json);
  Map toJson() => _$ObjectDataToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToInt()])
class CommentDiscount {
  int? sale_price;
  String? original_price;
  int? amount_saved;
  String? type;
  String? discount;

  CommentDiscount({
    this.sale_price,
    this.original_price,
    this.amount_saved,
    this.type,
    this.discount,
  });

  factory CommentDiscount.fromJson(Map<String, dynamic> json) => _$CommentDiscountFromJson(json);
  Map toJson() => _$CommentDiscountToJson(this);

}



