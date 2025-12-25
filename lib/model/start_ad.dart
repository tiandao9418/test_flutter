// To parse this JSON data, do
//
//     final startAd = startAdFromJson(jsonString);

import 'dart:convert';

ModelStartAd startAdFromJson(String str) =>
    ModelStartAd.fromJson(json.decode(str));

String startAdToJson(ModelStartAd data) => json.encode(data.toJson());

/// 启屏广告
/// [type]图片类型{1: 网络图片,2:本地图片,3:本地文件,4:本地缓存二进制}
/// [url]图片地址、信息
/// [link]图片跳转地址
class ModelStartAd {
  int type;
  dynamic url;
  String link;

  ModelStartAd({required this.type, required this.url, required this.link});

  factory ModelStartAd.fromJson(Map<String, dynamic> json) =>
      ModelStartAd(type: json["type"], url: json["url"], link: json["link"]);

  Map<String, dynamic> toJson() => {"type": type, "url": url, "link": link};
}
