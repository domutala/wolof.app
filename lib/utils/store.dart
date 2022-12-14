import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Store {
  static Future<String> getPath(String? folder) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    var path = appDocDir.path;
    if (folder != null) path += '/$folder';

    return path;
  }

  static Future<dynamic> get(String key, {String? folder}) async {
    try {
      String path = await getPath(folder);
      var file = File('$path/$key');
      if (!await file.exists()) return null;

      var value = jsonDecode(file.readAsStringSync());

      return value;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> save({
    required String key,
    dynamic value,
    String? folder,
  }) async {
    try {
      if (folder is String) await createFolder(folder);

      String path = await getPath(folder);
      var file = File('$path/$key');
      file.writeAsStringSync(jsonEncode(value));
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> clear(String key, {String? folder}) async {
    try {
      String path = await getPath(folder);
      var file = File('$path/$key');
      if (await file.exists()) file.deleteSync();
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> clearAll() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      appDocDir.deleteSync(recursive: true);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> createFolder(String name) async {
    try {
      Directory folder = await getApplicationDocumentsDirectory();
      folder = Directory('${folder.path}/$name');

      if (!await folder.exists()) folder.createSync();
    } catch (e) {
      rethrow;
    }
  }
}

class StorageManager {
  static Future<void> saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      prefs.remove(key);
    } else if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    }
  }

  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
