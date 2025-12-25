import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class UtilDevice {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  /// 获取设备类型
  static String getDeviceType() {
    if (kIsWeb) {
      return 'web';
    } else if (Platform.isAndroid) {
      return 'android';
    } else if (Platform.isIOS) {
      return 'ios';
    } else {
      return 'unknown';
    }
  }

  /// 获取设备ID
  static Future<String> getDeviceId() async {
    try {
      if (kIsWeb) {
        return const Uuid().v4(); // Web端使用UUID生成
      } else if (Platform.isAndroid) {
        var androidInfo = await _deviceInfoPlugin.androidInfo;
        return androidInfo.id; // 例如: "f1a2b3c4d5e6";
      } else if (Platform.isIOS) {
        var iosInfo = await _deviceInfoPlugin.iosInfo;
        return iosInfo.identifierForVendor ??
            Uuid().v4(); // 例如: "E1D2C3A4B5-1234-5678-ABCD-9876543210EF"
      } else {
        return Uuid().v4(); // 其他平台使用 UUID
      }
    } on PlatformException catch (_) {
      return Uuid().v4(); // 异常情况下返回随机UUID
    }
  }
}
