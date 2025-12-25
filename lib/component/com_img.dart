import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/util/util_tool.dart';

/// 图片模块
/// [type]图片类型{1: 网络图片,2:本地图片,3:本地缓存文件,4:本地缓存二进制}
class ComImg extends StatefulWidget {
  final int? type;
  final Object? url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadiusGeometry borderRadius;
  final BoxDecoration? decoration;
  final String? link;
  const ComImg({
    super.key,
    this.type = 1,
    this.url,
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = BorderRadius.zero,
    this.fit,
    this.decoration,
    this.link = '',
  });

  @override
  State<ComImg> createState() => _ComImgState();
}

class _ComImgState extends State<ComImg> {
  Widget buildImage() {
    Object? url = widget.url;
    if (url == '') {
      return const SizedBox();
    }
    if (widget.type == 1 && url is String) {
      return Image.network(url, fit: widget.fit);
    } else if (widget.type == 2 && url is String) {
      return Image.asset(url, fit: widget.fit);
    } else if (widget.type == 3 && url is File) {
      return Image.file(url, fit: widget.fit);
    } else if (widget.type == 4 && url is Uint8List) {
      // web端不支持Uint8List转成base64
      if (kIsWeb) {
        return Image.network(
          UtilTool.getBase64ByUint8List(url),
          fit: widget.fit,
        ); // 显示Base64图片
      } else {
        return Image.memory(url, fit: widget.fit); // 移动端使用Uint8List
      }
    } else {
      return const SizedBox();
    }
  }

  void _onTap() {
    if (widget.link != null && widget.link!.isNotEmpty) {
      UtilTool.launch(widget.link!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.link!.isNotEmpty ? _onTap : null,
      child: ClipRRect(
        borderRadius: widget.borderRadius,
        child: Stack(
          children: [
            Positioned.fill(
              child: FractionallySizedBox(
                alignment: Alignment.center, // 图片居中
                widthFactor: 0.5, // 宽度为父容器的 50%
                heightFactor: 0.5, // 高度为父容器的 50%
                child: Image.asset('assets/image/bg_base.webp'),
              ),
            ),
            Container(
              width: widget.width,
              height: widget.height,
              decoration: widget.decoration,
              child: buildImage(),
            ),
          ],
        ),
      ),
    );
  }
}
