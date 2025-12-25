import 'dart:convert';
import 'package:test_flutter/model/basic.dart';

// 广告项
class AdItem {
  int id;
  String name;
  int sort;
  String url;
  String image;
  int position;
  dynamic createdAt;

  AdItem({
    required this.id,
    required this.name,
    required this.sort,
    required this.url,
    required this.image,
    required this.position,
    required this.createdAt,
  });

  factory AdItem.fromJson(Map<String, dynamic> json) => AdItem(
    id: json["id"],
    name: json["name"],
    sort: json["sort"],
    url: json["url"],
    image: json["image"],
    position: json["position"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "sort": sort,
    "url": url,
    "image": image,
    "position": position,
    "created_at": createdAt,
  };
}

// 广告扩展基类
class ModelAd extends ModelBasic<List<AdItem>> {
  ModelAd({required super.code, required super.msg, required super.data});

  factory ModelAd.fromJson(Map<String, dynamic> json) {
    return ModelAd(
      code: json['code'] as int,
      msg: json['msg'] as String,
      data: (json['data'] as List).map((e) => AdItem.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'msg': msg,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}
