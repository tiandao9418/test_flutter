import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:test_flutter/component/com_ad.dart';
import 'package:test_flutter/component/com_toast.dart';
import 'package:test_flutter/model/ad.dart';

/// 广告布局
class LayoutAd extends StatefulWidget {
  final Widget child;
  const LayoutAd({super.key, required this.child});

  @override
  State<LayoutAd> createState() => _LayoutAdState();
}

class _LayoutAdState extends State<LayoutAd> {
  bool isLoading = true;
  final Map<String, List<AdItem>> _adMap = {
    'topSwiper': [],
    'topIcon': [],
    'topBanner': [],
    'bottomImg': [],
    'bottomBanner': [],
    'bottomIcon': [],
  };

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      setState(() {
        isLoading = true;
      });
      List<Map<dynamic, dynamic>>? listMap = SpUtil.getObjectList('ad'); // 获取广告
      if (listMap != null) {
        for (var item in listMap) {
          final AdItem adItem = AdItem.fromJson(item.cast<String, dynamic>());
          final int position = adItem.position;
          switch (position) {
            case 8:
              _adMap['topSwiper']!.add(adItem);
              break;
            case 9:
              _adMap['topIcon']!.add(adItem);
              break;
            case 3:
              _adMap['topBanner']!.add(adItem);
              break;
            case 4:
              _adMap['bottomImg']!.add(adItem);
              break;
            case 11:
              _adMap['bottomBanner']!.add(adItem);
              break;
            case 12:
              _adMap['bottomIcon']!.add(adItem);
              break;
          }
        }
      }
    } catch (e) {
      ComToast.error('请求广告错误');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: ComAd(list: _adMap['topSwiper']!, type: 1)),
        SliverToBoxAdapter(child: ComAd(list: _adMap['topIcon']!, type: 2)),
        SliverToBoxAdapter(child: ComAd(list: _adMap['topBanner']!, type: 3)),
        SliverFillRemaining(hasScrollBody: false, child: widget.child),
        SliverToBoxAdapter(child: ComAd(list: _adMap['bottomImg']!, type: 4)),
        SliverToBoxAdapter(
          child: ComAd(list: _adMap['bottomBanner']!, type: 3),
        ),
        SliverToBoxAdapter(child: ComAd(list: _adMap['bottomIcon']!, type: 2)),
      ],
    );
  }
}
