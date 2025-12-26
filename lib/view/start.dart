import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/component/com_img.dart';
import 'package:test_flutter/component/com_loading.dart';
import 'package:test_flutter/dio/dio_api_list.dart';
import 'package:test_flutter/model/ad.dart';
import 'package:test_flutter/model/start_ad.dart';
import 'package:test_flutter/router/index.dart';
import 'package:test_flutter/util/util_hive_cache.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter/util/util_sp.dart';
import 'package:test_flutter/util/util_theme.dart';

/// 欢迎界面（有状态）
@immutable
class Start extends StatefulWidget {
  const Start({super.key});
  @override
  State createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  /// 初始化
  bool isLoading = true;
  void _init() async {
    await _getOpenAd();
    await _getCheckLine();
    await _getAd();
  }

  /// 线路检测
  late bool _isCheck = true;
  Future<void> _getCheckLine() async {
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      _isCheck = false;
    });
    _countdown();
  }

  /// 启屏广告
  late final ModelStartAd _openAd;
  Future<void> _getOpenAd() async {
    Uint8List? uint8List = await UtilHiveCache.getFile('open_ad');
    if (uint8List != null) {
      _openAd = ModelStartAd(type: 4, url: uint8List, link: "");
    } else {
      _openAd = ModelStartAd(
        type: 2,
        url: 'assets/image/ad_open.webp',
        link: "",
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget _buildCheck() {
    Widget img = const SizedBox.shrink();
    if (_openAd.type == 2) {
      img = Image.asset(_openAd.url, fit: BoxFit.cover);
    }
    if (_openAd.type == 4) {
      img = Image.memory(_openAd.url, fit: BoxFit.cover);
    }
    return Stack(
      children: [
        SizedBox(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          child: img,
        ),
        Positioned(
          width: ScreenUtil().screenWidth,
          bottom: 50.r,
          child: Text(
            '线路检测中...',
            textAlign: TextAlign.center,
            style: UtilTheme.text14Theme,
          ),
        ),
      ],
    );
  }

  // 倒计时
  int _currentTime = 5;
  late Timer _timer;
  void _countdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_currentTime <= 0) {
        _clearCountdown();
        router.go('/home');
        return;
      }
      setState(() {
        _currentTime--;
      });
    });
  }

  void _clearCountdown() {
    setState(() {
      _timer.cancel();
      setState(() {
        _currentTime = 0;
      });
    });
  }

  Widget _buildCountdown() {
    if (_currentTime == 0) {
      return const SizedBox.shrink();
    } else {
      return Positioned(
        top: 30.r,
        right: 30.r,
        child: GestureDetector(
          onTap: () => {_clearCountdown()},
          child: Container(
            width: 50.r,
            height: 50.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: UtilTheme.transparentBlack30,
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Text(_currentTime.toString(), style: UtilTheme.text20),
          ),
        ),
      );
    }
  }

  /// 广告
  int _curIndex = 0;
  Map<String, List<AdItem>> _adMap = {
    'topSwiper': [],
    'topIcon': [],
    'topBanner': [],
    'bottomImg': [],
    'bottomBanner': [],
    'bottomIcon': [],
  };
  Future<void> _getAd() async {
    String? jsonStr = UtilSp.getString('ad'); // 获取广告
    if (jsonStr != null && jsonStr.isNotEmpty) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonStr);
      _adMap = {
        for (var entry in jsonMap.entries)
          entry.key: (entry.value as List)
              .map((itemJson) => AdItem.fromJson(itemJson))
              .toList(),
      };
    } else {
      final ModelAd apiGet = await DioApiList.apiGetAd(
        query: {'ads_type': '3,4,8,9,11,12'},
      );
      if (apiGet.code == 200) {
        final positionMap = {
          8: 'topSwiper',
          9: 'topIcon',
          3: 'topBanner',
          4: 'bottomImg',
          11: 'bottomBanner',
          12: 'bottomIcon',
        };
        for (var item in apiGet.data!) {
          final key = positionMap[item.position];
          if (key != null) {
            _adMap[key]!.add(item);
          }
        }
        await UtilSp.setMap('ad', _adMap); // 保存广告
      }
    }
  }

  Widget _buildSwiper(BuildContext context) {
    if (_adMap['topSwiper']!.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Stack(
        alignment: Alignment.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: ScreenUtil().screenHeight,
              viewportFraction: 1.0, // 让每个 item 占满整个屏幕
              enlargeCenterPage: false, // 避免页面缩放
              enableInfiniteScroll: false, // 允许循环
              onPageChanged: (index, _) {
                setState(() {
                  _curIndex = index;
                });
              },
            ),
            items: _adMap['topSwiper']!.map((item) {
              return ComImg(
                type: 1,
                url: item.image,
                link: item.url,
                fit: BoxFit.cover,
              );
            }).toList(),
          ),
          _buildPoint(),
        ],
      );
    }
  }

  Widget _buildPoint() {
    if (_adMap['topSwiper']!.isEmpty) {
      return const SizedBox.shrink();
    }
    Widget activeBox = const SizedBox.shrink();
    if (_curIndex == (_adMap['topSwiper']!.length - 1)) {
      activeBox = GestureDetector(
        onTap: () {
          GoRouter.of(context).go('/home');
        },
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Text('进入首页', style: UtilTheme.text18),
        ),
      );
    }
    return Positioned(
      bottom: 50.r,
      child: Column(
        children: [
          activeBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _adMap['topSwiper']!.asMap().entries.map((entry) {
              int index = entry.key;
              return Container(
                margin: EdgeInsets.all(3.r),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: UtilTheme.transparentBlack20,
                  ),
                  color: index == _curIndex ? UtilTheme.theme : UtilTheme.dark4,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                width: index == _curIndex ? 40.r : 15.r,
                height: 15.r,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAd() {
    return Stack(children: [_buildSwiper(context), _buildCountdown()]);
  }

  // 加载中
  Widget _buildLoading() {
    if (isLoading) {
      return const ComLoading();
    } else {
      return _isCheck ? _buildCheck() : _buildAd();
    }
  }

  /// 构建
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildLoading());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
