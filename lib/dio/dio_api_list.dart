import 'package:dio/dio.dart';
import 'package:test_flutter/dio/dio_api.dart';
import 'package:test_flutter/dio/dio_api_name.dart';
import 'package:test_flutter/model/ad.dart';
import 'package:test_flutter/model/category.dart';
import 'package:test_flutter/model/config.dart';

class DioApiList {
  /// 配置信息
  static Future<ModelConfig> apiGetConfig() async {
    Response response = await DioApi().get(DioApiName.config);
    ModelConfig modelAd = ModelConfig.fromJson(response.data);
    return modelAd;
  }

  /// 广告
  static Future<ModelAd> apiGetAd({required Map<String, dynamic> query}) async {
    Response response = await DioApi().get(DioApiName.openAd, query: query);
    return ModelAd.fromJson(response.data);
  }

  // 分类
  static Future<ModelCategory> apiGetCategory({
    required Map<String, dynamic> query,
  }) async {
    Response response = await DioApi().get(DioApiName.category, query: query);
    return ModelCategory.fromJson(response.data);
  }
}
