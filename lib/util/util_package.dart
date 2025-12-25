import 'package:package_info_plus/package_info_plus.dart';

/// 包信息
class UtilPackage {
  /// 获取版本号
  static Future<String> getVersion() async {
    try {
      final PackageInfo info = await PackageInfo.fromPlatform();
      return info.version;
    } catch (_) {
      return '';
    }
  }
}
