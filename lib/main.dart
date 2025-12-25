import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_flutter/router/index.dart';
import 'package:test_flutter/util/util_config.dart';
import 'package:test_flutter/util/util_device.dart';
import 'package:test_flutter/util/util_hive_cache.dart';
import 'package:test_flutter/util/util_language.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_flutter/util/util_package.dart';
import 'package:test_flutter/util/util_sp.dart';
import 'package:test_flutter/util/util_theme.dart';
import 'package:media_kit/media_kit.dart';

/// 应用入口
void main() async {
  // debugPaintSizeEnabled = true; // 开启布局线

  WidgetsFlutterBinding.ensureInitialized();

  /// MediaKit播放器同步初始化调用
  // MediaKit.ensureInitialized();

  /// 初始化设备类型
  String deviceType = UtilDevice.getDeviceType();
  debugPrint('设备类型: $deviceType');
  UtilConfig().setDeviceType(deviceType);

  /// 初始化设备ID
  String deviceId = await UtilDevice.getDeviceId();
  debugPrint('设备ID: $deviceId');
  UtilConfig().setDeviceId(deviceId);

  /// 初始化包信息
  String packageVersion = await UtilPackage.getVersion();
  debugPrint('包信息: $packageVersion');
  UtilConfig().setVersion(packageVersion);

  /// 初始化shared_preferences
  await UtilSp.init();

  /// 初始化hive
  await UtilHiveCache.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// 根据屏幕方向动态更改设计稿尺寸
  Size _getDesignSize(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return const Size(375, 812); // 竖屏设计稿尺寸
    } else {
      return const Size(812, 375); // 横屏设计稿尺寸（宽高互换）
    }
  }

  @override
  Widget build(BuildContext context) {
    /// 设置设计稿宽高
    return ScreenUtilInit(
      designSize: _getDesignSize(context),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          title: UtilLanguage.appName,
          debugShowCheckedModeBanner: false, // 关闭Debug标志
          theme: ThemeData(
            primaryColor: UtilTheme.dark1, // 主色调
            canvasColor: Colors.transparent, // 画布颜色
            scaffoldBackgroundColor: UtilTheme.white, // Scaffold背景色
            visualDensity: VisualDensity.adaptivePlatformDensity, // 平台自适应的视觉密度
            textTheme: const TextTheme(), // 默认文本主题，可以自定义文本样式
            splashColor: Colors.transparent, // 水波纹颜色透明
            highlightColor: Colors.transparent, // 高亮颜色透明
            hoverColor: Colors.transparent, // 悬停颜色透明
            useMaterial3: false, // 关闭Material3
            appBarTheme: const AppBarTheme(
              elevation: 0, // 阴影
              shadowColor: Colors.transparent, // 外阴影
              backgroundColor: Colors.white, // 背景色
              foregroundColor: Colors.black, // 前景色（图标、文字）
              surfaceTintColor: Colors.transparent, // Material 3 需要
            ),
            drawerTheme: DrawerThemeData(
              backgroundColor: UtilTheme.white, // 全局Drawer背景色
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 0, // 全局阴影为0
              ),
            ), // 全局设置按钮阴影
            splashFactory: NoSplash.splashFactory,
          ),
          // 路由配置
          routerConfig: router,
        );
      },
    );
  }
}
