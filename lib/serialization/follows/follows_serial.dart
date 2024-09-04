
import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/helper.dart';
import 'package:k24/serialization/try_convert.dart';

part 'follows_serial.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToInt()])
class FollowsSerial {
  String? total;
  int? limit;
  List<FollowsDatum?>? data;

  FollowsSerial({
    this.total,
    this.limit,
    this.data,
  });

  factory FollowsSerial.fromJson(Map json) => _$FollowsSerialFromJson(json);
  Map toJson() => _$FollowsSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(),])
class FollowsDatum {
  String? id;
  String? name;
  String? username;
  IconSerial? photo;
  String? type;

  FollowsDatum({
    this.id,
    this.name,
    this.username,
    this.photo,
    this.type,
  });

  factory FollowsDatum.fromJson(Map json) => _$FollowsDatumFromJson(json);
  Map toJson() => _$FollowsDatumToJson(this);

}

