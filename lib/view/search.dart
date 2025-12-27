import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_flutter/component/com_loading.dart';
import 'package:test_flutter/util/util_theme.dart';

// 搜索页
class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  /// 定义
  List<String> historyList = []; // 搜索历史
  List<String> hotList = []; // 热门搜索
  List<String> recommendList = []; // 推荐搜索

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      _init();
    });
  }

  /// 初始化
  Future<void> _init() async {
    historyList = ['流浪地球3', '复联5', '宫崎骏', '国产科幻', '动作电影', '爱情片'];
    hotList = ['热辣滚烫', '第二十条', '飞驰人生2', '年会不能停', '熊出没', '深海'];
    recommendList = ['科幻大片', '动作爽片', '恐怖电影', '喜剧搞笑', '爱情电影', '动画片'];
    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildSearch() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: 3,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return _buildSearchItem(
              index: index,
              title: '搜索历史',
              items: historyList,
              showClear: true,
            );
          case 1:
            return _buildSearchItem(
              index: index,
              title: '热门搜索',
              items: hotList,
              showHotIcon: true,
            );
          case 2:
            return _buildSearchItem(
              index: index,
              title: '推荐搜索',
              items: recommendList,
              isText: true,
            );
          default:
            return const SizedBox();
        }
      },
    );
  }

  /// 列表项
  Widget _buildSearchItem({
    required int index,
    required String title,
    required List<String> items,
    bool showClear = false,
    bool showHotIcon = false,
    bool isText = false,
  }) {
    Widget buildClearButton = const SizedBox.shrink();
    if (showClear) {
      buildClearButton = GestureDetector(
        onTap: () => print('清空历史'),
        child: Text('清空', style: UtilTheme.text14),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            10.r,
            index == 0 ? 5.r : 17.5.r,
            10.r,
            15.r,
          ),
          child: Row(
            children: [
              Text(title, style: UtilTheme.title16Weight),
              const Spacer(),
              buildClearButton,
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.r),
          child: isText
              ? _buildTextList(items) // 文本样式
              : _buildBtnList(items), // 按钮样式
        ),
      ],
    );
  }

  /// 按钮列表
  Widget _buildBtnList(List<String> items) {
    return Wrap(
      spacing: 10.r,
      runSpacing: 10.r,
      children: items.map((item) {
        return GestureDetector(
          onTap: () => print('搜索标签: $item'),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 7.5.r),
            decoration: BoxDecoration(
              color: UtilTheme.theme3,
              borderRadius: BorderRadius.circular(5.r),
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

  /// 文字列表
  Widget _buildTextList(List<String> items) {
    return Column(
      children: items.map((item) {
        return GestureDetector(
          onTap: () => print('搜索: $item'),
          child: Padding(
            padding: EdgeInsets.only(bottom: 15.r),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5.r),
                  child: Icon(Icons.hotel_class, color: Colors.red, size: 16.r),
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

  /// 头部
  PreferredSizeWidget _buildHeader() {
    return AppBar(
      titleSpacing: 0,
      title: Container(
        height: 40.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: TextField(
          style: TextStyle(fontSize: 15.r),
          decoration: InputDecoration(
            hintText: '搜索...',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, size: 25.r, color: Colors.grey),
            contentPadding: EdgeInsets.all(7.5.r),
          ),
        ),
      ),
      actions: [
        Container(
          padding: EdgeInsets.all(10.r),
          alignment: Alignment.center,
          child: Text('搜索', style: UtilTheme.text14),
        ),
      ],
    );
  }

  /// 加载中
  bool _isLoading = true;
  Widget _buildLoading() {
    if (_isLoading) {
      return ComLoading();
    } else {
      return _buildSearch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildHeader(), body: _buildLoading());
  }
}
