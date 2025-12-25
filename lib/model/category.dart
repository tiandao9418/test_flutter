import 'package:test_flutter/model/basic.dart';

// 分类
class CategoryItem {
  int? id;
  String? name;
  int? categoryType;
  String? seoTitle;
  String? seoDesc;
  String? seoKeyword;
  CategoryItem({
    this.id,
    this.name,
    this.categoryType,
    this.seoTitle,
    this.seoDesc,
    this.seoKeyword,
  });
  CategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryType = json['category_type'];
    seoTitle = json['seo-title'];
    seoDesc = json['seo-desc'];
    seoKeyword = json['seo-keyword'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category_type'] = categoryType;
    data['seo-title'] = seoTitle;
    data['seo-desc'] = seoDesc;
    data['seo-keyword'] = seoKeyword;
    return data;
  }
}

// 分类扩展基类
class ModelCategory extends ModelBasic<List<CategoryItem>> {
  ModelCategory({required super.code, required super.msg, required super.data});
  factory ModelCategory.fromJson(Map<dynamic, dynamic> json) {
    int code = json['code'] ?? 500;
    String msg = json['msg'] ?? '请求成功';
    List<CategoryItem> list = [];
    final dynamic data = json['data'];
    if (data is List) {
      list = data
          .whereType<Map<String, dynamic>>() // 只保留Map类型
          .map((item) => CategoryItem.fromJson(item))
          .toList();
    }
    return ModelCategory(code: code, msg: msg, data: list);
  }
}
