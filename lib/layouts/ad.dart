import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_flutter/component/com_ad.dart';
import 'package:test_flutter/component/com_loading.dart';
import 'package:test_flutter/component/com_toast.dart';
import 'package:test_flutter/model/ad.dart';
import 'package:test_flutter/util/util_sp.dart';

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
      String? jsonStr = UtilSp.getString('ad'); // 获取广告
      if (jsonStr != null && jsonStr.isNotEmpty) {
        final jsonMap = jsonDecode(jsonStr) as Map<String, dynamic>;
        for (var entry in _adMap.entries) {
          if (jsonMap.containsKey(entry.key)) {
            List<AdItem> newList = [];
            for (var itemJson in jsonMap[entry.key] as List) {
              newList.add(AdItem.fromJson(itemJson as Map<String, dynamic>));
            }
            entry.value.clear();
            entry.value.addAll(newList);
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
