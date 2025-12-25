import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_flutter/component/com_img.dart';
import 'package:test_flutter/model/ad.dart';

/// 广告
class ComAd extends StatefulWidget {
  final List<AdItem> list;
  final int type;
  const ComAd({super.key, required this.list, required this.type});

  @override
  State<ComAd> createState() => _ComBtnState();
}

class _ComBtnState extends State<ComAd> {
  /// 轮播
  Widget _buildScroll() {
    if (widget.list.isEmpty) {
      return const SizedBox.shrink();
    }
    final double height = ScreenUtil().screenWidth * 0.33;
    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        viewportFraction: 1.0, // 让每个item占满整个屏幕
        enlargeCenterPage: false, // 避免页面缩放
        enableInfiniteScroll: false, // 允许循环
      ),
      items: widget.list.map((item) {
        return ComImg(
          type: 1,
          url: item.image,
          link: item.url,
          fit: BoxFit.cover,
        );
      }).toList(),
    );
  }

  /// icon
  Widget _buildIcon() {
    if (widget.list.isEmpty) {
      return const SizedBox.shrink();
    }
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: widget.list
          .map(
            (item) => FractionallySizedBox(
              widthFactor: 1 / 6,
              child: AspectRatio(
                aspectRatio: 1,
                child: ComImg(
                  type: 1,
                  url: item.image,
                  link: item.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  /// banner
  Widget _buildBanner() {
    if (widget.list.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: widget.list
          .map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: AspectRatio(
                aspectRatio: 8.5,
                child: ComImg(
                  type: 1,
                  url: item.image,
                  link: item.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  /// 大图
  Widget _buildBigImg() {
    if (widget.list.isEmpty) {
      return const SizedBox.shrink();
    }
    return ComImg(
      type: 1,
      url: widget.list[0].url,
      link: widget.list[0].url,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case 1:
        return _buildScroll();
      case 2:
        return _buildIcon();
      case 3:
        return _buildBanner();
      case 4:
        return _buildBigImg();
      default:
        return SizedBox.shrink();
    }
  }
}
