import 'package:dio/dio.dart';
import 'package:test_flutter/dio/dio_api_interceptor.dart';
import 'package:test_flutter/util/util_config.dart';
import 'package:test_flutter/util/util_log.dart';

/// 封装dio
class DioApi {
  static final DioApi _instance = DioApi._internal();

  factory DioApi() => _instance;

  late Dio _dio;

  static final List<String> _baseUrls = UtilConfig().getApiList;

  static int _curBaseUrlIndex = 0;
  DioApi._internal() {
    init();
  }

  void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrls[_curBaseUrlIndex],
        sendTimeout: const Duration(seconds: 10 * 1000),
      ),
    );
    _dio.interceptors.add(DioApiInterceptor());
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  /// get
  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    try {
      final Response response = await _dio.get(path, queryParameters: query);
      return response;
    } catch (e) {
      throw Exception('get方法错误: $e');
    }
  }

  /// post
  Future post(String path, {Map<String, dynamic>? data}) async {
    try {
      final Response response = await _dio.post(path, data: data);
      return response;
    } catch (e) {
      throw Exception('post方法错误: $e');
    }
  }
}
