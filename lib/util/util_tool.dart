import 'dart:convert';
import 'dart:typed_data';

import 'package:test_flutter/util/util_log.dart';
import 'package:url_launcher/url_launcher.dart';

/// 公共方法
class UtilTool {
  /// 字符串转buffer(Uint8List)
  static Uint8List stringToUint8List(String data) {
    List<int> tempList = data.codeUnits;
    Uint8List tempBytes = Uint8List.fromList(tempList);
    return tempBytes;
  }

  /// buffer(Uint8List)转字符串
  static String uint8ListToString(Uint8List data) {
    String tempStr = String.fromCharCodes(data);
    return tempStr;
  }

  /// 获取当前时间戳
  static int getTimestamp() {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  /// 把秒转换成时间
  static String getSecondsToTime(int totalSeconds) {
    Duration duration = Duration(seconds: totalSeconds);
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    // 补0处理
    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    return hours > 0
        ? '$hoursStr:$minutesStr:$secondsStr'
        : '$minutesStr:$secondsStr';
  }

  /// 格式化duration时间
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return duration.inHours > 0
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }

  /// 判定url是否含有http、https有就跳外部，否则跳转内部路由
  static void launch(String url) async {
    if (url == '') return;
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      UtilLog.e('无法跳转外部浏览器$url');
    }
  }

  /// 根据二进制判定图片格式
  static String getImgSuffixByUint8List(Uint8List bytes) {
    if (bytes.length >= 4 &&
        bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47) {
      return 'png'; // PNG: 89 50 4E 47
    } else if (bytes.length >= 3 &&
        bytes[0] == 0xFF &&
        bytes[1] == 0xD8 &&
        bytes[2] == 0xFF) {
      return 'jpeg'; // JPEG: FF D8 FF
    } else if (bytes.length >= 4 &&
        bytes[0] == 0x47 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        bytes[3] == 0x38) {
      return 'gif'; // GIF: 47 49 46 38
    } else {
      return 'unknown'; // 其他格式可以继续扩展...
    }
  }

  /// 根据图片二进制获取Base64链接（主要用于web端不支持显示二进制数据）
  static String getBase64ByUint8List(Uint8List bytes) {
    String base64String = base64Encode(bytes);
    String format = getImgSuffixByUint8List(bytes);
    return "data:image/$format;base64,$base64String";
  }

  /// 获取url的协议+域名+端口
  static String getBaseUrl(String url) {
    String baseUrl = '';
    try {
      Uri uri = Uri.parse(url);
      baseUrl = '${uri.scheme}://${uri.authority}';
    } catch (e) {
      UtilLog.e("根据url生成hive的key失败$e");
    }
    return baseUrl;
  }
}
