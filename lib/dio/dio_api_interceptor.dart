import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:test_flutter/util/util_encrypt.dart';
import 'package:test_flutter/util/util_log.dart';

// 创建dio拦截器
class DioApiInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.data != null) {
      String encrypt = UtilEncrypt.aesEncrypt(options.data);
      options.data = encrypt;
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      final data = response.data;
      if (data is Map &&
          data.containsKey('code') &&
          data.containsKey('msg') &&
          data.containsKey('data')) {
        // UtilLog.i('响应格式正确，code: ${data["code"]}, msg: ${data["msg"]}, data: ${data["data"]}');
        data["code"] = 200;
        data["msg"] = '请求成功';
        data["data"] = data['data'];
      } else {
        data["code"] = 500;
        data["msg"] = '返回格式异常';
        data["data"] = null;
      }
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    throw Exception(err.message);
  }
}
