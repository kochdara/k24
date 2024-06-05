
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

// to string //
class ToString implements JsonConverter<String?, Object?>{
  const ToString();

  static String? tryConvert(Object? json){
    if(json is String) return json;

    final result = json.toString().trim().toLowerCase();
    if(result.contains("null") == false) return json.toString();
    return null;
  }

  @override
  String? fromJson(Object? json) {
    if(json is String) return json;
    if(tryConvert(json) != null) return json.toString();
    return null;
  }

  @override
  Object? toJson(String? object) {
    return object;
  }
}

// to bool //
class ToBool implements JsonConverter<bool, Object?>{
  const ToBool();

  static bool tryConvert(Object? json){
    if(json is bool) return json;

    final result = json.toString().trim().toLowerCase() == 'true';
    return result;
  }

  @override
  bool fromJson(Object? json) {
    if(json is bool) return json;
    bool? b = tryConvert(json);
    return b;
  }

  @override
  Object? toJson(bool? object) {
    return object;
  }
}

// to int //
class ToInt implements JsonConverter<int, Object?>{
  const ToInt();

  static int? tryConvert(Object? json){
    if(json is int) return json;

    try {
      final result = int.parse(json.toString().trim().toLowerCase());
      return result;
    } catch (e) {
      return null;
    }
  }

  @override
  int fromJson(Object? json) {
    if(json is int) return json;
    int? b = tryConvert(json);
    if(b != null) return b;
    return 0;
  }

  @override
  Object? toJson(int? object) {
    return object;
  }
}

// to double //
class ToDouble implements JsonConverter<double, Object?>{
  const ToDouble();

  static double? tryConvert(Object? json){
    if(json is double) return json;

    try {
      final result = double.parse(json.toString().trim().toLowerCase());
      return result;
    } catch (e) {
      return null;
    }
  }

  @override
  double fromJson(Object? json) {
    if(json is double) return json;
    double? b = tryConvert(json);
    if(b != null) return b;
    return 0.0;
  }

  @override
  Object? toJson(double? object) {
    return object;
  }
}

// to datetime //
class ToDateTime implements JsonConverter<DateTime?, Object?>{
  const ToDateTime();

  static DateTime? tryConvert(Object? json){
    if(json is DateTime) return json;

    try {
      final result = DateTime.tryParse(json.toString().trim().toLowerCase());
      return result;
    } catch (e) {
      return null;
    }
  }

  @override
  DateTime? fromJson(Object? json) {
    if(json is DateTime) return json;
    DateTime? b = tryConvert(json);
    if(b != null) return b;
    return null;
  }

  @override
  Object? toJson(DateTime? object) {
    return object;
  }
}

// to list //
class ToLists implements JsonConverter<List, Object?>{
  const ToLists();

  static List? tryConvert(Object? json) {
    if(json is List) return json;

    try {
      final list = jsonDecode(json.toString()).cast().toList();
      return list;
    } catch(e) {
      return null;
    }
  }

  @override
  List fromJson(Object? json) {
    if(json is List) return json;
    List? b = tryConvert(json);
    if(b != null) return b;
    return [];
  }

  @override
  Object? toJson(List? object) {
    return object;
  }
}
