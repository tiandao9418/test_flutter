import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:hex/hex.dart';

/// 加解密
class UtilEncrypt {
  // 密钥和IV的十六进制字符串
  static const String keyHex = '';
  static const String ivHex = '';

  // 将十六进制字符串转换为Uint8List
  static final Uint8List keyUint8List = Uint8List.fromList(HEX.decode(keyHex));
  static final Uint8List ivUint8List = Uint8List.fromList(HEX.decode(ivHex));

  // 创建Key和IV对象
  // static final _key  = Key.fromUtf8(keyHex);
  // static final _iv = IV.fromUtf8(ivHex);
  static final _key = Key(keyUint8List);
  static final _iv = IV(ivUint8List);

  // aes方法
  static final Encrypter _encrypter = Encrypter(
    AES(_key, mode: AESMode.cbc, padding: 'PKCS7'),
  );

  // aes加密
  static aesEncrypt(Map param) {
    try {
      final String jsonString = jsonEncode(param);
      final Encrypted encrypted = _encrypter.encrypt(jsonString, iv: _iv);
      // 转换为十六进制字符串并转成大写
      final String cb = HEX.encode(encrypted.bytes).toUpperCase();
      return cb;
    } catch (e) {
      return null;
    }
  }

  // AES解密
  static aesDecrypt(dynamic data) {
    try {
      // 转换成十六位十六进制字符串
      final Uint8List encryptedBytes = Uint8List.fromList(HEX.decode(data));
      final String decrypted = _encrypter.decrypt(
        Encrypted(encryptedBytes),
        iv: _iv,
      );
      return decrypted;
    } catch (e) {
      return "";
    }
  }
}
