import 'package:flutter/material.dart';
import 'package:test_flutter/util/util_config.dart';

/// 图标
/// [index]第几个图标（1开始计数）
/// [width]图标盒子宽度
/// [height]图标盒子高度
class ComIcon extends StatefulWidget {
  final int index;
  final double width;
  final double height;
  final Decoration? decoration;
  final EdgeInsetsGeometry? padding;
  final Function()? onTap;
  const ComIcon({
    super.key,
    this.index = 1,
    this.width = double.infinity,
    this.height = double.infinity,
    this.decoration,
    this.padding,
    this.onTap,
  });

  @override
  State<ComIcon> createState() => _ComImgState();
}

class _ComImgState extends State<ComIcon> {
  // 序列号（0开始计数）
  late int _curIndex;

  @override
  void initState() {
    super.initState();
    _curIndex = widget.index - 1;
  }

  @override
  void didUpdateWidget(covariant ComIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      setState(() {
        _curIndex = widget.index - 1; // 如果index改变了，更新_curIndex
      });
    }
  }

  /// 图标
  Widget _buildImage() {
    int index = _curIndex;
    double boxWidth = widget.width;
    double boxHeight = widget.height;
    double imageWidth = (widget.width / 40) * UtilConfig().iconImageWidth;
    double imageHeight = (widget.height / 40) * UtilConfig().iconImageHeight;
    double left = -(index % 5) * boxHeight; // 列号（取余）
    double top = -(index ~/ 5) * boxWidth; // 行号（整除）
    return SizedBox(
      width: boxWidth,
      height: boxHeight,
      child: Stack(
        children: [
          Positioned(
            left: left,
            top: top,
            child: Image.asset(
              'assets/image/icon.webp',
              width: imageWidth,
              height: imageHeight,
            ),
          ),
        ],
      ),
    );
  }

  /// 点击事件
  void _onToggle() {
    widget.onTap!();
  }

  Widget _buildBox() {
    return GestureDetector(
      onTap: widget.onTap != null ? _onToggle : null,
      child: Container(
        decoration: widget.decoration,
        padding: widget.padding,
        child: _buildImage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBox();
  }
}
