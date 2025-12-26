import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter/router/router_name.dart';
import 'package:test_flutter/view/search.dart';
import 'package:test_flutter/view/video.dart';
import 'package:test_flutter/view/home/index.dart';
import 'package:test_flutter/view/mine.dart';
import 'package:test_flutter/view/cartoon.dart';
import 'package:test_flutter/view/start.dart';
import 'package:test_flutter/view/novel.dart';

/// 启屏页
final GoRoute routerStartPage = GoRoute(
  path: RouterName.start,
  builder: (context, GoRouterState state) => const Start(),
);

/// 底部导航
final List<GoRoute> routerNavPage = [
  GoRoute(
    path: RouterName.home,
    builder: (context, GoRouterState state) => const Home(),
  ),
  GoRoute(
    path: RouterName.video,
    builder: (context, GoRouterState state) => const Video(),
  ),
  GoRoute(
    path: RouterName.cartoon,
    builder: (context, GoRouterState state) => const Cartoon(),
  ),
  GoRoute(
    path: RouterName.novel,
    builder: (context, GoRouterState state) => const Novel(),
  ),
  GoRoute(
    path: RouterName.mine,
    builder: (context, GoRouterState state) => const Mine(),
  ),
];

/// 搜索页
final GoRoute routerSearchPage = GoRoute(
  path: '/search',
  pageBuilder: (context, state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: Search(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // 从右侧滑入动画
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        final tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 300),
    );
  },
);