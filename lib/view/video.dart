import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/component/com_back.dart';
import 'package:test_flutter/component/com_pull_refresh/index.dart';
import 'package:test_flutter/util/util_theme.dart';

// 视频
class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  final EasyRefreshController _easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true, // 必须设置为true
  );

  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleRefresh() async {
    debugPrint('刷新开始');
    await Future.delayed(const Duration(seconds: 1));
    _easyRefreshController.finishRefresh();
    debugPrint('刷新完成');
  }

  Future<void> _handleMore() async {
    debugPrint('加载开始');
    await Future.delayed(const Duration(seconds: 1));
    _easyRefreshController.finishRefresh();
    debugPrint('加载完成');
  }

  @override
  Widget build(BuildContext context) {
    return ComBack(
      child: ComPullRefresh(
        controller: _easyRefreshController,
        onRefresh: _handleRefresh,
        onLoad: _handleMore,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(), // 保留弹性效果
          itemCount: 20,
          itemBuilder: (context, index) =>
              ListTile(title: Text('列表$index', style: UtilTheme.text12)),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _easyRefreshController.dispose();
    super.dispose();
  }
}
