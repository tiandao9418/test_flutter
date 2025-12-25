import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 轻提示
class ComToast {
  /// 成功提示
  /// [text]提示文字,[toastLength]轻提示长度,[gravity]显示位置,[timeInSecForIos]多少秒之后隐藏。
  static success(
    String text, {
    Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.TOP,
    int timeInSecForIos = 2,
  }) {
    return Fluttertoast.showToast(
      msg: text,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIos,
      backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
      textColor: const Color(0xff67c23a),
      fontSize: ScreenUtil().setSp(32),
    );
  }

  /// 失败提示
  /// [text]提示文字,[toastLength]轻提示长度,[gravity]显示位置,[timeInSecForIos]多少秒之后隐藏。
  static error(
    String text, {
    Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.TOP,
    int timeInSecForIos = 2,
  }) {
    return Fluttertoast.showToast(
      msg: text,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIos,
      backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
      textColor: const Color(0xff67c23a),
      fontSize: ScreenUtil().setSp(32),
    );
  }

  /// 消息提示
  /// [text]提示文字,[toastLength]轻提示长度,[gravity]显示位置,[timeInSecForIos]多少秒之后隐藏。
  static info(
    String text, {
    Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.TOP,
    int timeInSecForIos = 2,
  }) {
    return Fluttertoast.showToast(
      msg: text,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIos,
      backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
      textColor: const Color(0xff67c23a),
      fontSize: ScreenUtil().setSp(32),
    );
  }
}
