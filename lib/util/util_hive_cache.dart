import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:test_flutter/util/util_log.dart';
import 'package:test_flutter/util/util_tool.dart';
import 'package:path_provider/path_provider.dart';
import 'package:encrypt/encrypt.dart';

// hive缓存
class UtilHiveCache {
  // 单例实例
  static final UtilHiveCache _instance = UtilHiveCache._internal();
  factory UtilHiveCache() => _instance;
  UtilHiveCache._internal();

  static const String _cacheBoxName = 'test_flutter_cache';
  Box<Uint8List>? _box;

  /// 初始化 Hive
  static Future<void> init() async {
    if (kIsWeb) {
      // web使用IndexedDB
      Hive.init(null);
    } else {
      // Android/iOS使用应用文档目录
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    }
    // 如果盒子没有打开，设置打开
    if (!Hive.isBoxOpen(_cacheBoxName)) {
      _instance._box = await Hive.openBox<Uint8List>(_cacheBoxName);
    }
  }

  /// 保存文件到缓存
  static Future<void> saveFile(String key, dynamic data) async {
    await _instance._box!.put(key, data);
  }

  /// 从缓存中读取文件
  static Future<dynamic> getFile(String key) async {
    return _instance._box!.get(key);
  }

  /// 删除缓存文件
  static Future<void> deleteFile(String key) async {
    await _instance._box!.delete(key);
  }

  /// 验证文件是否存在
  static bool verifyFile(String key) {
    return _instance._box!.containsKey(key);
  }

  /// 清空缓存
  static Future<void> clearCache() async {
    await _instance._box!.clear();
  }

  /// 关闭 Hive
  static Future<void> close() async {
    await _instance._box!.close();
  }

  /// 下载文件二进制
  static Future<Uint8List> _download(String url) async {
    try {
      Response<dynamic> response = await Dio().get<dynamic>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      if (response.statusCode == 200) {
        return Uint8List.fromList(response.data as List<int>);
      } else {
        throw '请求失败';
      }
    } catch (e) {
      UtilLog.e('下载失败:$e');
      return Uint8List(0);
    }
  }

  /// 图片下载并保存为Uint8List
  static Future<Uint8List> downloadImageAndSave(String url, String key) async {
    Uint8List uint8List = await _download(url);
    UtilLog.i('图片二进制$uint8List');
    await saveFile(key, uint8List); // 保存图片到Hive
    return uint8List; // 返回二进制流
  }

  /// M3U8解析索引文件生成列表
  static Future<List<String>> _parseM3u8PlayText(String m3u8PlayText) async {
    List<String> m3u8PlayList = [];
    try {
      if (m3u8PlayText.isEmpty) return [];
      m3u8PlayList = m3u8PlayText
          .split('\n')
          .where((line) => line.endsWith('.ts') && !line.startsWith('#'))
          .toList();
    } catch (e) {
      UtilLog.e('M3U8解析ts地址失败$e');
    }
    return m3u8PlayList;
  }

  /// M3U8缓存主文件及所有分片
  static Future<void> cacheHls(List<String> tsUrlList) async {
    try {
      for (final tsUrl in tsUrlList) {
        if (!_instance._box!.containsKey(tsUrl)) {
          // await saveFile(key, await _download(m3u8Url, 2));
          UtilLog.w('缓存ts成功:$tsUrl');
        } else {
          UtilLog.w('缓存ts已存在:$tsUrl');
        }
      }
    } catch (e) {
      UtilLog.e('缓存HLS失败: $e');
    }
  }

  /// 获取ts缓存地址
  static Future<String?> _getCachedTsPath(String tsKey) async {
    // 创建临时目录（检查目录是否存在）
    final tempDir = await getTemporaryDirectory();
    final tsCacheDir = Directory('${tempDir.path}/flutter_ts_cache');
    if (!await tsCacheDir.exists()) {
      await tsCacheDir.create(recursive: true); // 不存在则创建
    }
    // 从Hive缓存中提取ts数据
    Uint8List? tsData = await getFile(tsKey); // key=原始URL
    if (tsData == null) {
      UtilLog.e('hive内有ts的key但没数据:$tsKey');
    }
    // 保存.ts到本地临时文件
    final localTsName = '${tsKey.hashCode}.ts'; // 避免文件名冲突
    final localTsPath = '${tsCacheDir.path}/$localTsName';
    await File(localTsPath).writeAsBytes(tsData ?? []);
    return localTsPath; // 替换为本地路径
  }

  /// 验证m3u8
  static Future<String> verifyM3u8(String m3u8Url, String m3u8PlayText) async {
    String callback = '';
    try {
      // 1.获取m3u8的baseUrl
      String baseUrl = UtilTool.getBaseUrl(m3u8Url);
      // 2.解密ts索引文件
      final List<String> tsList = await _getDecryptTsInfo(
        baseUrl,
        m3u8PlayText,
      );
      // 3.把新数组转换成字符串
      String m3u8Text = tsList.join('\n');
      // 4.本地保存M3U8
      return await _createM3u8TempFile(m3u8Url, m3u8Text);
    } catch (e) {
      UtilLog.e("验证m3u8失败$e");
    }
    return callback;
  }

  /// 创建M3U8临时索引文件
  static Future<String> _createM3u8TempFile(
    String m3u8Url,
    String content,
  ) async {
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/${m3u8Url.hashCode}.m3u8');
    await tempFile.writeAsString(content);
    return tempFile.path;
  }

  /// 解密ts-解密M3U8索引文件
  static Future<List<String>> _getDecryptTsInfo(
    String baseUrl,
    String m3u8Text,
  ) async {
    final List<String> rowList = m3u8Text.split('\n');
    String uri = '';
    String key = '';
    String iv = '';
    double duration = 0;
    List<String> callback = [];
    for (var row in rowList) {
      // 解析加密密钥信息
      if (row.startsWith('#EXT-X-KEY:')) {
        final tsBaseInfo = parseTsInfo(row);
        uri = baseUrl + tsBaseInfo['URI']!;
        iv = tsBaseInfo['IV'] ?? '';
        key = await _getTsDecryptKey(uri);
        String text = '';
        for (var entry in tsBaseInfo.entries) {
          String key = entry.key;
          String value = entry.value;
          if (entry.key == 'URI') {
            // 更新URI的相对路径为绝对路劲
            value = "$baseUrl${entry.value}";
          }
          text += "$key=$value${entry == tsBaseInfo.entries.last ? '' : ','}";
        }
        row = "#EXT-X-KEY:$text";
      }
      // 解析片段时长
      if (row.startsWith('#EXTINF:')) {
        duration = double.parse(row.substring(8).replaceAll(',', ''));
      }
      // 验证是否存在缓存
      if (row.endsWith('.jpg') && !row.startsWith('#')) {
        if (verifyFile(row)) {
          UtilLog.w('缓存ts已存在');
          final String? localTsPath = await _getCachedTsPath(row); // 使用本地缓存
          if (localTsPath != null) {
            row = localTsPath;
          } else {
            row = baseUrl + row;
          }
        } else {
          UtilLog.w('缓存ts不存在$row');
          row = baseUrl + row;
        }
      }
      callback.add(row);
    }
    return callback;
  }

  /// 解密ts-获取解密ts的key
  static Future<String> _getTsDecryptKey(String url) async {
    String callback = '';
    try {
      final Response response = await Dio().get<String>(
        url,
        options: Options(responseType: ResponseType.plain), // 以文本形式接收
      );
      if (response.statusCode == 200) {
        callback = response.data;
      } else {
        throw '请求ts的解密key请求失败';
      }
    } catch (e) {
      UtilLog.e('获取ts的解密key失败$e');
    }
    return callback;
  }

  /// 解密ts-获取ts加解密信息
  static Map<String, String> parseTsInfo(String line) {
    final List<String> params = line.substring(11).split(',');
    final result = <String, String>{};
    for (final param in params) {
      final parts = param.split('=');
      if (parts.length == 2) {
        result[parts[0].trim()] = parts[1].trim().replaceAll('"', '');
      }
    }
    return result;
  }

  /// 解密ts-AES解密
  static String decryptAes128(String encryptedData, String key, String iv) {
    final Encrypter encrypter = Encrypter(
      AES(encrypt.Key.fromUtf8(key), mode: AESMode.cbc, padding: 'PKCS7'),
    );
    final encryptedFromString = Encrypted.fromBase64(encryptedData);
    try {
      final String decrypted = encrypter.decrypt(
        encryptedFromString,
        iv: encrypt.IV.fromUtf8(iv),
      );
      return decrypted;
    } catch (e) {
      return "";
    }
  }

  /// M3U8缓存ts片段
  static Future<void> _cacheTs(String key, String tsUrl) async {
    if (!_instance._box!.containsKey(key)) {
      await saveFile(key, await _download(tsUrl));
    }
  }

  ///
  // static String _resolveUrl(String relativeUrl) {
  //   if (relativeUrl.startsWith('http')) {
  //     return relativeUrl;
  //   }
  //   return baseUrl + relativeUrl;
  // }

  /// 给已缓存的ts分片创建临时目录
  // static Future<String> getTsTempDir(String tsKey) async {
  //   final Uint8List tsData = await getFile(tsKey);
  //   Log.i('移动端缓存');
  //   // final appDir = await getApplicationDocumentsDirectory();
  //   // final cacheDir = Directory('${appDir.path}/ts_cache');
  //   // if (!await cacheDir.exists()) {
  //   //   await cacheDir.create(recursive: true);
  //   // }
  //   // final file = File('${cacheDir.path}/$tsKey.ts');
  //   // await file.writeAsBytes(tsData);
  //   // return file.path;
  //   return tsKey;
  // }
}
