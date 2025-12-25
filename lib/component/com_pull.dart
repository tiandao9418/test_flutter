import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_flutter/component/com_animate.dart';

/// 下拉刷新、上拉加载更多
class ComPull extends StatefulWidget {
  final Widget child;
  final RefreshCallback onRefresh;
  final Function onLoadMore;
  const ComPull({
    super.key,
    required this.child,
    required this.onRefresh,
    required this.onLoadMore,
  });

  @override
  State<ComPull> createState() => _ComPullState();
}

class _ComPullState extends State<ComPull> {
  int _count = 10;
  late EasyRefreshController easyRefreshController;

  @override
  void initState() {
    super.initState();
    easyRefreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: easyRefreshController,
      header: ComPullHeader(triggerOffset: 40.0, clamping: false),
      footer: const ClassicFooter(),
      onRefresh: () async {
        print('请求数据');
        await Future.delayed(const Duration(seconds: 4));
        if (!mounted) {
          return;
        }
        setState(() {
          _count = 10;
        });
        easyRefreshController.finishRefresh();
        easyRefreshController.resetFooter();
      },
      onLoad: () async {
        await Future.delayed(const Duration(seconds: 4));
        if (!mounted) {
          return;
        }
        setState(() {
          _count += 5;
        });
        easyRefreshController.finishLoad(
          _count >= 20 ? IndicatorResult.noMore : IndicatorResult.success,
        );
      },
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              alignment: Alignment.center,
              height: 80,
              child: Text('${index + 1}'),
            ),
          );
        },
        itemCount: _count,
      ),
    );
  }

  @override
  void dispose() {
    easyRefreshController.dispose();
    super.dispose();
  }
}

/// 下拉刷新头部
class ComPullHeader extends Header {
  ComPullHeader({required super.triggerOffset, required super.clamping});

  @override
  Widget build(BuildContext context, IndicatorState state) {
    double offset = state.offset;
    print('状态:${state.mode},距离:$offset');
    switch (state.mode) {
      // case IndicatorMode.inactive:
      //   return Container(
      //     height: ScreenUtil().setWidth(80),
      //     alignment: Alignment.center,
      //     child: const Text('下拉刷新'),
      //   );
      case IndicatorMode.drag:
        return Container(
          height: ScreenUtil().setWidth(80),
          alignment: Alignment.center,
          child: const Text('继续下拉以刷新'),
        );
      case IndicatorMode.armed:
        return Container(
          height: ScreenUtil().setWidth(80),
          alignment: Alignment.center,
          child: const Text('释放以刷新'),
        );
      case IndicatorMode.ready:
        return Container(
          height: ScreenUtil().setWidth(80),
          alignment: Alignment.center,
          child: const Text('超限,用户已释放。'),
        );
      // case IndicatorMode.processing:
      //   return Container(
      //     height: ScreenUtil().setWidth(80),
      //     alignment: Alignment.center,
      //     child: const Text('请求动画'),
      //   );
      case IndicatorMode.processed:
        return Container(
          height: ScreenUtil().setWidth(80),
          alignment: Alignment.center,
          child: const Text('任务结束过程没完成'),
        );
      case IndicatorMode.done:
        return Container(
          height: ScreenUtil().setWidth(80),
          alignment: Alignment.center,
          child: const Text('刷新完成'),
        );
      default:
        return Container();
    }
    // return ComAnimateListRefresh(
    //   height: offset,
    // );
  }
}
