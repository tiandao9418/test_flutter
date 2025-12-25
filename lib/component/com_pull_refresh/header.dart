import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:lottie/lottie.dart';

// 头部
class LottieRefreshHeader extends Header {
  LottieRefreshHeader() : super(triggerOffset: 80, clamping: false);

  @override
  Widget build(BuildContext context, IndicatorState state) {
    return Container(
      height: state.offset,
      alignment: Alignment.center,
      child: Lottie.asset(
        'assets/lottie/load.json',
        height: 75.r,
        width: 75.r,
        repeat: true,
        reverse: false,
        animate: true,
      ),
    );
  }
}
