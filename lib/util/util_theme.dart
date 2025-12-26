import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 主题
class UtilTheme {
  /// 颜色
  static const Color black = Color(0xFF000000); // 黑色
  static const Color dark1 = Color(0xFF252525);
  static const Color dark2 = Color(0xFF313131);
  static const Color dark3 = Color(0xFF3C3C3C);
  static const Color dark4 = Color(0xFF999999);
  static const Color dark5 = Color(0xFFA5A5A5);
  static const Color dark6 = Color(0xFFA6A6A6);
  static const Color dark7 = Color(0xFFB1B1B1);
  static const Color dark8 = Color(0xFFDEDAD7);
  static const Color white = Color(0xFFFFFFFF); // 白色
  static const Color theme = Color(0xFF3276ff); // 主题色
  static const Color theme1 = Color(0xFF5a8dff); // 主题色2
  static const Color theme2 = Color(0xFFa0bfff); // 主题色2
  static const Color theme3 = Color(0xFFd9e4fe); // 主题色3
  static const Color inverse = Color(0xFFff7f32); // 主题反色
  static const Color inverse1 = Color(0xFFff8c5a); // 主题反色1
  static const Color inverse2 = Color(0xFFffa680); // 主题反色2
  static const Color inverse3 = Color(0xFFfed9d9); // 主题反色3
  static const Color transparent = Colors.transparent; // 90%透明黑色
  static const Color transparentBlack90 = Color(0xE6000000); // 90%透明黑色
  static const Color transparentBlack80 = Color(0xCC000000); // 80%透明黑色
  static const Color transparentBlack70 = Color(0xB3000000); // 70%透明黑色
  static const Color transparentBlack60 = Color(0x99000000); // 60%透明黑色
  static const Color transparentBlack50 = Color(0x80000000); // 50%透明黑色
  static const Color transparentBlack40 = Color(0x66000000); // 40%透明黑色
  static const Color transparentBlack30 = Color(0x4D000000); // 30%透明黑色
  static const Color transparentBlack20 = Color(0x33000000); // 20%透明黑色
  static const Color transparentBlack10 = Color(0x1A000000); // 10%透明黑色
  static const Color danger = Color(0xFFFF4B00); // 危险
  static const Color warning = Color(0xFFF6AA00); // 警告
  static const Color info = Color(0xFFF2E700); // 注意
  static const Color success = Color(0xFF00B06B); // 成功

  /// 文字
  static TextStyle text10 = TextStyle(color: dark2, fontSize: 10.r);
  static TextStyle text12 = TextStyle(color: dark2, fontSize: 12.r);
  static TextStyle text14 = TextStyle(color: dark2, fontSize: 14.r);
  static TextStyle text16 = TextStyle(color: dark2, fontSize: 16.r);
  static TextStyle text18 = TextStyle(color: dark2, fontSize: 18.r);
  static TextStyle text20 = TextStyle(color: dark2, fontSize: 20.r);
  static TextStyle text14Theme = TextStyle(color: theme, fontSize: 14.r);
  // 标题
  static TextStyle title16Weight = TextStyle(color: dark2, fontSize: 16.r, fontWeight: FontWeight.w900);
}
