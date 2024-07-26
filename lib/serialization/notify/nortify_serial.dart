

import 'package:json_annotation/json_annotation.dart';

import '../chats/comments/comments_serial.dart';
import '../grid_card/grid_card.dart';
import '../try_convert.dart';

part 'nortify_serial.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToInt()])
class NotifySerial {
  List<NotifyDatum> data;
  int limit;

  NotifySerial({
    required this.data,
    required this.limit,
  });

  factory NotifySerial.fromJson(Map<String, dynamic> json) => _$NotifySerialFromJson(json);
  Map? toJson() => _$NotifySerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class NotifyBadges {
  String? notification;
  String? chat;
  String? comment;

  NotifyBadges({
    this.notification,
    this.chat,
    this.comment,
  });

  factory NotifyBadges.fromJson(Map<String, dynamic> json) => _$NotifyBadgesFromJson(json);
  Map? toJson() => _$NotifyBadgesToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToInt(), ToString(), ToDateTime(), ToBool()])
class NotifyDatum {
  NotifyDatum({
    this.notid,
    this.title,
    this.message,
    this.is_open,
    this.open_date,
    this.send_date,
    this.id,
    this.id_type,
    this.type,
    this.data,
  });

  final String? notid;
  final String? title;
  final String? message;
  final bool? is_open;
  final DateTime? open_date;
  final DateTime? send_date;
  final String? id;
  final dynamic id_type;
  final String? type;
  final NotifyData? data;

  factory NotifyDatum.fromJson(Map<String, dynamic> json) => _$NotifyDatumFromJson(json);
  Map? toJson() => _$NotifyDatumToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class NotifyData {
  NotifyData({
    this.type,
    this.post,
    this.user,
    this.comment,
    this.id,
    this.adid,
  });

  final String? type;
  final Data_? post;
  final User_? user;
  final CommentDatum? comment;
  final String? id;
  final String? adid;

  factory NotifyData.fromJson(Map<String, dynamic> json) => _$NotifyDataFromJson(json);
  Map? toJson() => _$NotifyDataToJson(this);

}

