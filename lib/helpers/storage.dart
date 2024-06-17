import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

save(String key, var value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if(value is bool) return await prefs.setBool(key, value);
  String newValue = value is String ? value : "";
  if(value is Map) newValue = jsonEncode(value);
  if(value is List) newValue = jsonEncode({"data":value});
  await prefs.setString(key, newValue);
}

get(String key, {var type = String}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if(type is  bool) return prefs.getBool(key);
  String? value = prefs.getString(key);
  if(type is Map) return value != null ? jsonDecode(value) : null;
  if(type is List) return value != null ? jsonDecode(value)["data"] : null;
  return value;
}

remove(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

// ==================== //
// using secure library //
// ==================== //
getSecure(String key, {Type type = String}) async {
  String? value = await storage.read(key: key);
  if(value != null) {
    if(type == Map) return jsonDecode(value);
    return value;
  }
  return value;
}

saveSecure(String key, var value) async {
  if(value is Map || value is List) {await storage.write(key: key, value: jsonEncode(value));}
  else {await storage.write(key: key, value: value);}
}

deleteSecure(String key) async {
  await storage.delete(key: key);
}

deleteAll(String key) async {
  await storage.deleteAll();
}