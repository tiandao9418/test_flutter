import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:lottie/lottie.dart';

// 底部
class LottieMoreFooter extends Footer {
  LottieMoreFooter() : super(triggerOffset: 50, clamping: false);

  /// 根据不同状态返回 Lottie 动画或提示文字
  Widget _buildAnimation(IndicatorMode mode) {
    switch (mode) {
      case IndicatorMode.inactive:
        return const SizedBox.shrink(); // 不显示任何内容
      case IndicatorMode.ready:
      case IndicatorMode.processing:
        return Lottie.asset(
          'assets/lottie/more.json',
          height: 50.r,
          width: 50.r,
          repeat: true,
          animate: true,
        );
      case IndicatorMode.done:
        return const Text("加载完成", style: TextStyle(color: Colors.grey));
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context, IndicatorState state) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: state.offset,
      alignment: Alignment.center,
      child: _buildAnimation(state.mode),
    );
  }
}
