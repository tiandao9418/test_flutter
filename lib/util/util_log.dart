import 'dart:convert';

import 'package:logger/web.dart';

/// 打印
class UtilLog {
  static final Logger _logger = Logger();

  /// 普通白色日志
  static void d(String message) {
    _logger.d(message);
  }

  /// 蓝色日志
  static void i(String message) {
    _logger.i(message);
  }

  /// 橘色日志
  static void w(String message) {
    _logger.w(message);
  }

  /// 红色日志
  static void e(String message) {
    _logger.e(message);
  }

  /// 分段打印所有白色日志
  // static void a(Map<String, dynamic> json) {
  //   String jsonStr = jsonEncode(json);
  //   StringBuffer outStr = StringBuffer();
  //   int limitLength = 500;
  //   for (var index = 0; index < jsonStr.length; index++) {
  //     outStr.write(jsonStr[index]);
  //     if (index % limitLength == 0 && index != 0) {
  //       print("长日志→$outStr");
  //       outStr.clear();
  //     }
  //   }
  //   if (outStr.isNotEmpty) print("长日志→$outStr");
  // }

  static void a(dynamic data) {
    try {
      // 1. 统一转换为字符串（支持Map、List、对象、字符串）
      String jsonStr;
      if (data is Map || data is List) {
        jsonStr = jsonEncode(data);
      } else if (data is String) {
        jsonStr = data;
      } else if (data is num || data is bool) {
        jsonStr = data.toString();
      } else {
        // 尝试调用对象的 toJson() 或 toString()
        jsonStr = _tryConvertToString(data);
      }
      // 2. 尝试格式化JSON（如果是有效的JSON字符串）
      String formatted = _tryFormatJson(jsonStr);
      // 3. 分段打印（真正的分段）
      const limit = 1000; // 每段字符数（可调整）
      for (int i = 0; i < formatted.length; i += limit) {
        int end = (i + limit) < formatted.length
            ? (i + limit)
            : formatted.length;
        String segment = formatted.substring(i, end);
        print('[JSON分段 ${i ~/ limit + 1}] $segment');
      }
    } catch (e) {
      print('JSON打印失败: $e');
    }
  }

  // 辅助方法：尝试格式化JSON字符串
  static String _tryFormatJson(String jsonStr) {
    try {
      // 先解码再编码，实现格式化
      var decoded = jsonDecode(jsonStr);
      return JsonEncoder.withIndent('  ').convert(decoded);
    } catch (e) {
      // 不是有效JSON，返回原字符串
      return jsonStr;
    }
  }

  // 辅助方法：尝试转换对象为字符串
  static String _tryConvertToString(dynamic obj) {
    try {
      // 优先尝试 toJson()
      if (obj.toJson != null) {
        return jsonEncode(obj.toJson());
      }
      // 其次尝试 toString()
      return obj.toString();
    } catch (e) {
      return '无法转换为字符串: $e';
    }
  }
}
