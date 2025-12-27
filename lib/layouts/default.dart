import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter/model/bottom_tab.dart';
import 'package:test_flutter/model/leftNav.dart';
import 'package:test_flutter/router/index.dart';
import 'package:test_flutter/util/util_theme.dart';
import 'package:test_flutter/view/video.dart';
import 'package:test_flutter/view/home/index.dart';
import 'package:test_flutter/view/mine.dart';
import 'package:test_flutter/view/cartoon.dart';
import 'package:test_flutter/view/novel.dart';

/// 布局
class Layout extends StatefulWidget {
  final Widget child;
  const Layout({super.key, required this.child});

  @override
  State createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  /// 头部-标题
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: Icon(
              Icons.format_indent_increase,
              size: 24.r,
              color: UtilTheme.theme,
            ),
          ),
          Expanded(
            child: Align(
              child: GestureDetector(
                onTap: () {
                  router.push("/home");
                },
                child: Image.asset("assets/image/logo_text.webp", height: 18.r),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _scaffoldKey.currentState?.openEndDrawer();
              router.push('/search');
            },
            child: Icon(Icons.search, size: 24.r, color: UtilTheme.theme),
          ),
        ],
      ),
    );
  }

  /// 头部-侧边栏
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<LeftNavItem> _nav = [
    LeftNavItem(
      id: 1,
      name: "海角吃瓜",
      link: "/home",
      icon: Icons.home,
      children: [
        LeftNavItem(id: 11, name: "海角首页", link: "/?id=2", icon: null),
        LeftNavItem(id: 12, name: "海角热门", link: "/?id=3", icon: null),
        LeftNavItem(id: 13, name: "海角今日", link: "/?id=4", icon: null),
        LeftNavItem(id: 14, name: "海角乱伦", link: "/?id=5", icon: null),
        LeftNavItem(id: 15, name: "海角吃瓜", link: "/?id=6", icon: null),
        LeftNavItem(id: 16, name: "海角网黄", link: "/?id=7", icon: null),
      ],
    ),
    LeftNavItem(
      id: 2,
      name: "视频专区",
      link: "/video?id=2",
      icon: Icons.smart_display,
      children: [
        LeftNavItem(id: 21, name: "日本av", link: "/video?id=21", icon: null),
        LeftNavItem(id: 22, name: "国产av", link: "/video?id=22", icon: null),
      ],
    ),
  ];
  Widget _buildLeftNav() {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // 圆角设为0
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(vertical: 10.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/image/logo.webp",
                    width: 50.r,
                    height: 50.r,
                  ),
                  SizedBox(width: 7.5.r),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "海角社区破解版",
                        style: TextStyle(
                          color: UtilTheme.dark1,
                          fontSize: 18.r,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text("海角乱伦免费看", style: UtilTheme.text14),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _nav.length,
                itemBuilder: (context, index) {
                  return _buildLeftMenuItem(context, _nav[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftMenuItem(BuildContext context, LeftNavItem item) {
    return ExpansionTile(
      initiallyExpanded: true, // 默认展开
      shape: const RoundedRectangleBorder(
        side: BorderSide.none, // 无边框
      ),
      leading: Icon(item.icon, size: 20.r, color: UtilTheme.dark3),
      title: Text(item.name, style: UtilTheme.text16),
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.r),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10.r,
            mainAxisSpacing: 12.r,
            childAspectRatio: 2.5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: item.children!.map((child) {
              return _buildLeftItemChild(child);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildLeftItemChild(LeftNavItem child) {
    return GestureDetector(
      onTap: () {
        print('点击了: ${child.name}');
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: UtilTheme.theme3,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Text(child.name, style: UtilTheme.text14Theme),
      ),
    );
  }

  /// 底部选项卡
  int _activeIndex = 0;
  final List<BottomTabItem> _tabList = [
    BottomTabItem(
      index: 0,
      name: '首页',
      link: '/home',
      icon: Icons.home,
      iconActive: Icons.home,
      component: const Home(),
    ),
    BottomTabItem(
      index: 1,
      name: '视频',
      link: '/video',
      icon: Icons.smart_display,
      iconActive: Icons.smart_display,
      component: const Video(),
    ),
    BottomTabItem(
      index: 2,
      name: '动漫',
      link: '/cartoon',
      icon: Icons.photo,
      iconActive: Icons.photo,
      component: const Cartoon(),
    ),
    BottomTabItem(
      index: 3,
      name: '小说',
      link: '/novel',
      icon: Icons.text_snippet,
      iconActive: Icons.text_snippet,
      component: const Novel(),
    ),
    BottomTabItem(
      index: 4,
      name: '我的',
      link: '/mine',
      icon: Icons.account_circle,
      iconActive: Icons.account_circle,
      component: const Mine(),
    ),
  ];
  void _onTapNav(int index) {
    if (_activeIndex != index) {
      setState(() {
        _activeIndex = index;
      });
      GoRouter.of(context).go(_tabList[index].link);
    }
  }

  List<Widget> _buildBottomNavList() {
    return _tabList.asMap().entries.map((entry) {
      int index = entry.key;
      BottomTabItem item = entry.value;
      bool isSelect = item.index == _activeIndex;
      Color selectColor = UtilTheme.theme;
      Color unSelectColor = UtilTheme.dark2;
      Color textColor = isSelect ? selectColor : unSelectColor;
      return Expanded(
        child: GestureDetector(
          onTap: () => _onTapNav(index),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, size: 24.r, color: textColor),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text(
                  item.name,
                  style: TextStyle(fontSize: 14.r, color: textColor),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> componentList = _tabList
        .map((item) => item.component)
        .toList();
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildLeftNav(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: SafeArea(bottom: false, child: _buildHeader()),
      ),
      body: IndexedStack(index: _activeIndex, children: componentList),
      bottomNavigationBar: SizedBox(
        width: ScreenUtil().screenWidth,
        height: 60.r,
        child: Flex(
          direction: Axis.horizontal,
          children: _buildBottomNavList(),
        ),
      ),
    );
  }
}
