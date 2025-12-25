import 'package:flutter/material.dart';

class BottomTabItem {
  final int index;
  final String name;
  final String link;
  final String icon;
  final int iconActive;
  final Widget component;

  BottomTabItem({
    required this.index,
    required this.name,
    required this.link,
    required this.icon,
    required this.iconActive,
    required this.component,
  });

  // JSON 转对象（如果数据从 JSON 来）
  factory BottomTabItem.fromJson(Map<String, dynamic> json) {
    return BottomTabItem(
      index: json['index'],
      name: json['name'],
      link: json['link'],
      icon: json['icon'],
      iconActive: json['iconActive'],
      component: json['component'],
    );
  }

  // 对象转 JSON（如果需要）
  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'name': name,
      'link': link,
      'icon': icon,
      'iconActive': iconActive,
      'component': component,
    };
  }
}
