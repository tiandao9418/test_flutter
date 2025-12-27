import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:pull_to_refresh/pull_to_refresh.dart";
import "package:test_flutter/component/com_icon.dart";
import "package:test_flutter/component/com_loading.dart";
import "package:test_flutter/dio/dio_api_list.dart";
import "package:test_flutter/layouts/ad.dart";
import "package:test_flutter/model/category.dart";
import "package:test_flutter/util/util_log.dart";
import "package:test_flutter/util/util_theme.dart";

// 首页
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _init();
  }

  /// 初始化
  bool _isLoading = true;
  Future<void> _init() async {
    final ModelCategory response = await DioApiList.apiGetCategory(
      query: {'type': '1'},
    );
    if (response.code == 200) {
      if (response.data!.isNotEmpty) {
        setState(() {
          _tabs = response.data ?? []; // 选项卡
          _isLoading = false;
          // 异步请求完成后初始化TabController
          _tabController = TabController(length: _tabs.length, vsync: this);
        });
      }
    }
  }

  /// 头部-选项卡
  List<CategoryItem> _tabs = []; // 选项卡列表
  TabController? _tabController; // 选项卡控制器
  Widget _buildTabBar() {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TabBar(
            controller: _tabController,
            labelStyle: TextStyle(
              color: UtilTheme.theme,
              fontSize: 16.r,
              fontWeight: FontWeight.bold,
            ), // 选中
            unselectedLabelStyle: const TextStyle(
              color: UtilTheme.dark2,
            ), // 未选中
            isScrollable: true, // 可滚动
            padding: EdgeInsets.zero, // 默认间距去掉
            indicator: const BoxDecoration(), // 背景色
            indicatorWeight: 0, // 指示器高度为0
            dividerColor: Colors.transparent, // Material3主题去除底部线条
            labelPadding: EdgeInsets.zero, // 文字间距
            tabAlignment: TabAlignment.start, // 对齐方式
            tabs: _tabs.asMap().entries.map((entry) {
              int index = entry.key;
              CategoryItem value = entry.value;
              return Tab(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 10.r : 20.r,
                    top: 0,
                    right: index == _tabs.length - 1 ? 10.r : 20.r,
                    bottom: 0,
                  ),
                  child: Text(value.name!),
                ),
              );
            }).toList(),
          ),
        ),
        Container(
          width: 40.r,
          height: 20.r,
          alignment: Alignment.center,
          child: ComIcon(width: 20.r, height: 20.r, index: 17),
        ),
      ],
    );
  }

  Widget _buildTabView() {
    return Expanded(
      child: TabBarView(
        physics: const ClampingScrollPhysics(), // 禁用过度滚动
        controller: _tabController,
        children: _tabs.map((item) {
          return LayoutAd(child: _buildRefreshAndPull());
        }).toList(),
      ),
    );
  }

  /// 下拉刷新上拉加载
  List _list = [];
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    items.add((items.length + 1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  Widget _buildRefreshAndPull() {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      // footer: CustomFooter(
      //   builder: (BuildContext context,LoadStatus mode){
      //     Widget body ;
      //     if(mode==LoadStatus.idle){
      //       body =  Text("上拉加载");
      //     }
      //     else if(mode==LoadStatus.loading){
      //       body =  CupertinoActivityIndicator();
      //     }
      //     else if(mode == LoadStatus.failed){
      //       body = Text("加载失败！点击重试！");
      //     }
      //     else if(mode == LoadStatus.canLoading){
      //        body = Text("松手,加载更多!");
      //     }
      //     else{
      //       body = Text("没有更多数据了!");
      //     }
      //     return Container(
      //       height: 55.0,
      //       child: Center(child:body),
      //     );
      //   },
      // ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
        itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
        itemExtent: 100.0,
        itemCount: items.length,
      ),
    );
  }

  /// 加载中
  Widget _buildLoading() {
    if (_isLoading) {
      return ComLoading();
    } else {
      return Column(children: [_buildTabBar(), _buildTabView()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: _buildLoading());
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _refreshController.dispose();
    super.dispose();
  }
}
