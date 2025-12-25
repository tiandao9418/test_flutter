import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_flutter/util/util_theme.dart';

/// 列表下拉loading动画
class ComAnimateListRefresh extends StatefulWidget {
  final double width;
  final double height;
  const ComAnimateListRefresh({super.key, this.width = 0.0, this.height = 0.0});

  @override
  State<ComAnimateListRefresh> createState() => _ComAnimateListRefreshState();
}

class _ComAnimateListRefreshState extends State<ComAnimateListRefresh>
    with SingleTickerProviderStateMixin {
  /// 动画控制器
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  /// 动画效果
  late final Animation<double> _animation = Tween(
    begin: 1.0,
    end: 1.29,
  ).animate(_animationController);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/list_top_load_bg.webp'),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _animation,
            child: Image.asset(
              'assets/image/list_top_load.webp',
              height: widget.height * .5,
              width: ScreenUtil().screenWidth * .5,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

/// 列表上拉loading动画
class ComAnimateListMore extends StatefulWidget {
  final String text;
  final double height;
  const ComAnimateListMore({
    super.key,
    required this.text,
    required this.height,
  });

  @override
  State<ComAnimateListMore> createState() => _ComAnimateListLoadState();
}

class _ComAnimateListLoadState extends State<ComAnimateListMore> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      color: Colors.amber,
      alignment: Alignment.center, // 内容垂直居中
      child: Text(widget.text, style: UtilTheme.text10),
    );
  }
}
