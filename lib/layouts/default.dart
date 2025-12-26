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
import 'package:test_flutter/widgets/fixed_sliver_header.dart';

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
            child: Text(
              "\uf010",
              style: TextStyle(
                fontFamily: "Untitled",
                fontSize: 24.r,
                color: UtilTheme.theme,
              ),
            ),
          ),
          Expanded(
            child: Align(
              child: GestureDetector(
                onTap: () {
                  GoRouter.of(context).push("/home");
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
            child: Text(
              "\uf00a",
              style: TextStyle(
                fontFamily: "Untitled",
                fontSize: ScreenUtil().setSp(24.0),
                color: UtilTheme.theme,
              ),
            ),
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
      icon: "\uf014",
      children: [
        LeftNavItem(id: 11, name: "海角首页", link: "/?id=2", icon: ""),
        LeftNavItem(id: 12, name: "海角热门", link: "/?id=3", icon: ""),
        LeftNavItem(id: 13, name: "海角今日", link: "/?id=4", icon: ""),
        LeftNavItem(id: 14, name: "海角乱伦", link: "/?id=5", icon: ""),
        LeftNavItem(id: 15, name: "海角吃瓜", link: "/?id=6", icon: ""),
        LeftNavItem(id: 16, name: "海角网黄", link: "/?id=7", icon: ""),
      ],
    ),
    LeftNavItem(
      id: 2,
      name: "视频专区",
      link: "/video?id=2",
      icon: "\uf014",
      children: [
        LeftNavItem(id: 21, name: "日本av", link: "/video?id=21", icon: ""),
        LeftNavItem(id: 22, name: "国产av", link: "/video?id=22", icon: ""),
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
      leading: Text(
        item.icon!,
        style: TextStyle(
          fontFamily: 'Untitled',
          fontSize: 20.r,
          color: UtilTheme.dark2,
        ),
      ),
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

  /// 头部-搜索
  final List<String> historyList = [
    '流浪地球3',
    '复联5',
    '宫崎骏',
    '国产科幻',
    '动作电影',
    '爱情片',
  ]; // 搜索历史
  final List<String> hotList = [
    '热辣滚烫',
    '第二十条',
    '飞驰人生2',
    '年会不能停',
    '熊出没',
    '深海',
  ]; // 热门搜索
  final List<String> recommendList = [
    '科幻大片',
    '动作爽片',
    '恐怖电影',
    '喜剧搞笑',
    '爱情电影',
    '动画片',
  ]; // 推荐搜索
  Widget _buildRightSearch() {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // 圆角设为0
      ),
      child: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 3, // 3个块
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return _buildSearchItem(
                  title: '搜索历史',
                  items: historyList,
                  showClear: true,
                );
              case 1:
                return _buildSearchItem(
                  title: '热门搜索',
                  items: hotList,
                  showHotIcon: true,
                );
              case 2:
                return _buildSearchItem(
                  title: '推荐搜索',
                  items: recommendList,
                  showTags: true,
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  // 头部-搜索栏-列表项
  Widget _buildSearchItem({
    required String title,
    required List<String> items,
    bool showClear = false,
    bool showHotIcon = false,
    bool showTags = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.r, 20.r, 16.r, 12.r),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.r,
                  fontWeight: FontWeight.bold,
                  color: UtilTheme.dark1,
                ),
              ),
              const Spacer(),
              if (showClear)
                GestureDetector(
                  onTap: () => print('清空历史'),
                  child: Text(
                    '清空',
                    style: TextStyle(fontSize: 14.r, color: UtilTheme.dark3),
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: showTags
              ? _buildTagList(items) // 标签样式
              : _buildTextList(items, showHotIcon), // 文本样式
        ),
        // 分隔线
        Container(
          height: 1,
          margin: EdgeInsets.only(top: 16.r),
          color: Colors.grey[200],
        ),
      ],
    );
  }
  Widget _buildTextList(List<String> items, bool showHotIcon) {
    return Column(
      children: items.map((item) {
        return GestureDetector(
          onTap: () => print('搜索: $item'),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.r),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[200]!, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                if (showHotIcon)
                  Padding(
                    padding: EdgeInsets.only(right: 8.r),
                    child: Icon(Icons.whatshot, color: Colors.red, size: 16.r),
                  ),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 14.r, color: UtilTheme.dark2),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12.r,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTagList(List<String> items) {
    return Wrap(
      spacing: 10.r,
      runSpacing: 10.r,
      children: items.map((item) {
        return GestureDetector(
          onTap: () => print('搜索标签: $item'),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
            decoration: BoxDecoration(
              color: UtilTheme.theme3,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              item,
              style: TextStyle(fontSize: 14.r, color: UtilTheme.theme),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// 底部选项卡
  int _activeIndex = 0;
  final List<BottomTabItem> _tabList = [
    BottomTabItem(
      index: 0,
      name: '首页',
      link: '/home',
      icon: '\uf014',
      iconActive: 7,
      component: const Home(),
    ),
    BottomTabItem(
      index: 1,
      name: '视频',
      link: '/video',
      icon: '\uf01d',
      iconActive: 8,
      component: const Video(),
    ),
    BottomTabItem(
      index: 2,
      name: '动漫',
      link: '/cartoon',
      icon: '\uf013',
      iconActive: 9,
      component: const Cartoon(),
    ),
    BottomTabItem(
      index: 4,
      name: '小说',
      link: '/novel',
      icon: '\uf00c',
      iconActive: 11,
      component: const Novel(),
    ),
    BottomTabItem(
      index: 5,
      name: '我的',
      link: '/mine',
      icon: '\uf003',
      iconActive: 12,
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
      return Expanded(
        child: GestureDetector(
          onTap: () => _onTapNav(index), // 通过箭头函数传递 index 参数
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.icon,
                style: TextStyle(
                  fontFamily: 'Untitled',
                  fontSize: 24.r,
                  color: item.index == _activeIndex
                      ? UtilTheme.theme
                      : UtilTheme.dark2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text(
                  item.name,
                  style: item.index == _activeIndex
                      ? UtilTheme.text14Theme
                      : UtilTheme.text14,
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
      // endDrawer: _buildRightSearch(),
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
