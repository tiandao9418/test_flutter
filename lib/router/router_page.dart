import 'package:go_router/go_router.dart';
import 'package:test_flutter/router/router_name.dart';
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