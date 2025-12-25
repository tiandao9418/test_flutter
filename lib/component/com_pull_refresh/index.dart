import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/component/com_pull_refresh/footer.dart';
import 'package:test_flutter/component/com_pull_refresh/header.dart';

/// 下拉刷新、上拉加载
class ComPullRefresh extends StatefulWidget {
  final FutureOr<dynamic> Function()? onRefresh;
  final FutureOr<dynamic> Function()? onLoad;
  final EasyRefreshController? controller;
  final Widget child;
  final bool enablePullDown;
  final bool enablePullUp;
  const ComPullRefresh({
    super.key,
    required this.child,
    this.onRefresh,
    this.onLoad,
    this.controller,
    this.enablePullDown = true,
    this.enablePullUp = true,
  });

  @override
  State<ComPullRefresh> createState() => _ComPullRefreshState();
}

class _ComPullRefreshState extends State<ComPullRefresh> {
  late EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    print('enablePullDown,${widget.enablePullDown}');
    print('enablePullUp,${widget.enablePullUp}');
    _controller =
        widget.controller ??
        EasyRefreshController(
          controlFinishRefresh: true, // 必须设置为true
        );
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: _controller,
      header: widget.enablePullDown ? LottieRefreshHeader() : null,
      onRefresh: widget.enablePullDown ? widget.onRefresh : null,
      footer: widget.enablePullUp ? LottieMoreFooter() : null,
      onLoad: widget.enablePullUp ? widget.onLoad : null,
      triggerAxis: Axis.vertical, // 只监听垂直方向上的监听
      child: widget.child,
    );
  }

  @override
  void dispose() {
    // 仅释放内部创建的控制器
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
