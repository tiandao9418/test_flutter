import 'dart:convert';
import 'package:test_flutter/model/basic.dart';

// 侧边栏导航项
class LeftNavItem {
  int id;
  String name;
  String link;
  String? icon;
  List<LeftNavItem>? children;

  LeftNavItem({
    required this.id,
    required this.name,
    required this.link,
    this.icon,
    this.children,
  });

  factory LeftNavItem.fromJson(Map<String, dynamic> json) => LeftNavItem(
    id: json["id"],
    name: json["name"],
    link: json["link"],
    icon: json["icon"],
    children: json["children"] != null
        ? List<LeftNavItem>.from(
            (json["children"] as List).map((x) => LeftNavItem.fromJson(x)),
          )
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "link": link,
    "icon": icon,
    "children": children,
  };
}

// 侧边栏导航
class ModelLeftNav extends ModelBasic<List<LeftNavItem>> {
  ModelLeftNav({required super.code, required super.msg, required super.data});

  factory ModelLeftNav.fromJson(Map<String, dynamic> json) {
    return ModelLeftNav(
      code: json['code'] as int,
      msg: json['msg'] as String,
      data: (json['data'] as List).map((e) => LeftNavItem.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'msg': msg,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}
