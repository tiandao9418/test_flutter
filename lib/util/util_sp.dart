import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// 存储数据
class UtilSp {
  static late SharedPreferences _prefs;

  // 初始化
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // 存数据
  static Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  static Future<bool> setInt(String key, int value) =>
      _prefs.setInt(key, value);

  static Future<bool> setBool(String key, bool value) =>
      _prefs.setBool(key, value);

  static Future<bool> setDouble(String key, double value) =>
      _prefs.setDouble(key, value);

  static Future<bool> setStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);

  static Future<bool> setMap(String key, Map<String, dynamic> map) {
    final jsonStr = jsonEncode(map);
    return _prefs.setString(key, jsonStr);
  }

  static Future<bool> setMapList(String key, List<Map<String, dynamic>> list) {
    final jsonStr = jsonEncode(list);
    return _prefs.setString(key, jsonStr);
  }

  // 取数据
  static String? getString(String key) => _prefs.getString(key);
  static int? getInt(String key) => _prefs.getInt(key);
  static bool? getBool(String key) => _prefs.getBool(key);
  static double? getDouble(String key) => _prefs.getDouble(key);
  static List<String>? getStringList(String key) => _prefs.getStringList(key);
  static Map<String, dynamic>? getMap(String key) {
    final jsonStr = _prefs.getString(key);
    if (jsonStr == null) return null;
    try {
      return jsonDecode(jsonStr) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  static List<Map<String, dynamic>>? getMapList(String key) {
    final jsonStr = _prefs.getString(key);
    if (jsonStr == null) return null;

    try {
      final list = jsonDecode(jsonStr) as List;
      return list.cast<Map<String, dynamic>>();
    } catch (e) {
      return null;
    }
  }

  // 删除
  static Future<bool> remove(String key) => _prefs.remove(key);
  static Future<bool> clear() => _prefs.clear();

  // 检查
  static bool containsKey(String key) => _prefs.containsKey(key);
}
