import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_flutter/util/util_theme.dart';

/// 按钮
class ComBtn extends StatefulWidget {
  final double? width;
  final double? height;
  final Decoration? decoration;
  final Widget? textWidget;
  final String text;
  final TextStyle? textStyle;
  const ComBtn({
    super.key,
    this.width,
    this.height,
    this.decoration,
    this.textWidget,
    this.text = '按钮',
    this.textStyle,
  });

  @override
  State<ComBtn> createState() => _ComBtnState();
}

class _ComBtnState extends State<ComBtn> {
  /// 设置背景
  Decoration? _buildDecoration() {
    if (widget.decoration != null) {
      return widget.decoration;
    } else {
      return BoxDecoration(
        color: UtilTheme.dark2,
        borderRadius: BorderRadius.all(Radius.circular(6.r)),
      );
    }
  }

  /// 设置文字
  Widget? _buildText() {
    if (widget.textWidget != null) {
      return widget.textWidget;
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
        child: Text(widget.text, style: widget.textStyle ?? UtilTheme.text12),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: _buildDecoration(),
      alignment: Alignment.center,
      child: _buildText(),
    );
  }
}
