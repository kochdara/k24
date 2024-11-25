// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart' as path;

const storage = FlutterSecureStorage();

// save(String key, var value) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   if(value is bool) return await prefs.setBool(key, value);
//   String newValue = value is String ? value : "";
//   if(value is Map) newValue = jsonEncode(value);
//   if(value is List) newValue = jsonEncode({"data":value});
//   await prefs.setString(key, newValue);
// }
//
// get(String key, {var type = String}) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   if(type is  bool) return prefs.getBool(key);
//   String? value = prefs.getString(key);
//   if(type is Map) return value != null ? jsonDecode(value) : null;
//   if(type is List) return value != null ? jsonDecode(value)["data"] : null;
//   return value;
// }
//
// remove(String key) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.remove(key);
// }

// ==================== //
// using secure library //
// ==================== //
getSecure(String key, {Type type = String}) async {
  String? value = await storage.read(key: key);
  if(value != null) {
    if(type == Map || type == List) return jsonDecode(value);
    return value;
  }
  return null;
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

Future<File> downloadAndSaveFile(String fileUrl, { String? type = 'pdf' }) async {
  await requestPermissions();
  try {
    Dio dio = Dio();
    final targetDirectory = Directory('/storage/emulated/0/DCIM/k24');

    if (!await targetDirectory.exists()) {
      await targetDirectory.create(recursive: true);
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final filePath = path.join(targetDirectory.path, '$timestamp.$type');

    await dio.download(fileUrl, filePath);
    return File(filePath);
  } catch (e) {
    throw Exception('Failed to download file: $e');
  }
}

Future<File> downloadAndSaveImage(String imageUrl) async {
  await requestPermissions();
  try {
    // Create Dio instance
    Dio dio = Dio();
    // Get the external storage directory
    final directory = Directory('/storage/emulated/0/DCIM/k24');
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    // Generate timestamp
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    // Create the file path with timestamp as filename
    final filePath = path.join(directory.path, '$timestamp.jpg');
    // Download the image and save it to the file
    await dio.download(imageUrl, filePath);
    return File(filePath);
  } catch (e) {
    throw Exception('Failed to download image: $e');
  }
}

Future<void> requestPermissions() async {
  if (await Permission.storage.isDenied) {
    await Permission.storage.request();
  }
  if (await Permission.manageExternalStorage.isDenied) {
    await Permission.manageExternalStorage.request();
  }
}
