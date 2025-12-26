import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter/layouts/default.dart';
import 'package:test_flutter/router/router_page.dart';
import 'package:test_flutter/view/err.dart';

// 路由列表
final GoRouter router = GoRouter(
  // 设置初始路由路径
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) {
    // if (!AuthState.of(context).isSignedIn) {
    //   return '/';
    // } else {
    //   return null;
    // }
    return null;
  },
  // 定义路由列表
  routes: [
    /// 启动页
    routerStartPage,
    /// 底部导航
    ShellRoute(
      builder: (context, state, child) {
        return Layout(child: child);
      },
      routes: routerNavPage,
    ),
    /// 搜索页
    routerSearchPage,
  ],
  errorBuilder: (context, state) => const Err(),
);
