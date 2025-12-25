import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_flutter/util/util_theme.dart';

/// 文本框
/// [controller]控制器
class ComTextField extends StatefulWidget {
  final int iconIndex;
  final double width;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final String hintText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const ComTextField({
    super.key,
    this.iconIndex = 1,
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = 0,
    this.backgroundColor = UtilTheme.dark1,
    this.hintText = '请输入...',
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
  });

  @override
  State<ComTextField> createState() => _ComTextFieldState();
}

class _ComTextFieldState extends State<ComTextField> {
  Widget _buildPrefixIcon() {
    if (widget.prefixIcon != null) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
        child: widget.prefixIcon,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildSuffixIcon() {
    if (widget.suffixIcon != null) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
        child: widget.suffixIcon,
      );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        border: Border.all(color: UtilTheme.dark5, width: 1.0),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPrefixIcon(),
          Expanded(
            child: TextField(
              controller: widget.controller,
              cursorColor: UtilTheme.white,
              cursorHeight: 14.0.r,
              style: TextStyle(
                color: UtilTheme.white,
                fontSize: ScreenUtil().setSp(14.0),
              ),
              textAlignVertical: TextAlignVertical.center, // 垂直居中
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(5),
                  right: ScreenUtil().setWidth(5),
                  top: 0,
                  bottom: 0,
                ),
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: UtilTheme.dark5),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none, // 隐藏边框
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none, // 隐藏边框
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none, // 隐藏边框
                ),
              ),
            ),
          ),
          _buildSuffixIcon(),
        ],
      ),
    );
  }
}
