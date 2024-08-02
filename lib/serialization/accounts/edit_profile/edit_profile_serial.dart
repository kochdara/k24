
import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/helper.dart';
import 'package:k24/serialization/try_convert.dart';
import 'package:k24/serialization/users/user_serial.dart';

part 'edit_profile_serial.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class EditProfileSerial {
  EditProfileData data;

  EditProfileSerial({
    required this.data,
  });

  factory EditProfileSerial.fromJson(Map<String, dynamic> json) => _$EditProfileSerialFromJson(json);
  Map toJson() => _$EditProfileSerialToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString()])
class UploadData {
  String? status;
  String? message;
  String? image;
  String? thumbnail;
  IconSerial? photo;

  UploadData({
    this.status,
    this.message,
    this.image,
    this.thumbnail,
    this.photo,
  });

  factory UploadData.fromJson(Map<String, dynamic> json) => _$UploadDataFromJson(json);
  Map toJson() => _$UploadDataToJson(this);


}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToString(), ToDateTime(), ToBool(),])
class EditProfileData {
  String? id;
  String? username;
  String? first_name;
  String? last_name;
  String? name;
  String? company;
  IconSerial? photo;
  IconSerial? cover;
  DateTime? dob;
  String? gender;
  bool? auto_update_profile_picture;
  EditProfileContact? contact;

  EditProfileData({
    this.id,
    this.username,
    this.first_name,
    this.last_name,
    this.name,
    this.company,
    this.photo,
    this.cover,
    this.dob,
    this.gender,
    this.auto_update_profile_picture,
    this.contact,
  });

  factory EditProfileData.fromJson(Map<String, dynamic> json) => _$EditProfileDataFromJson(json);
  Map toJson() => _$EditProfileDataToJson(this);

}

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ToLists(), ToString()])
class EditProfileContact {
  List<String?>? phone;
  String? email;
  MapClass? map;
  CommuneUser? location;
  CommuneUser? commune;
  CommuneUser? district;
  String? address;

  EditProfileContact({
    this.phone,
    this.email,
    this.map,
    this.location,
    this.commune,
    this.district,
    this.address,
  });

  factory EditProfileContact.fromJson(Map<String, dynamic> json) => _$EditProfileContactFromJson(json);
  Map toJson() => _$EditProfileContactToJson(this);

}

