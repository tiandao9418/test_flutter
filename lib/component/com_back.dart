import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter/component/com_icon.dart';
import 'package:test_flutter/util/util_theme.dart';

/// 返回头
class ComBack extends StatefulWidget {
  final Widget? left;
  final Widget? center;
  final Widget? right;
  final String? title;
  final bool? isFloat;
  final Widget? child;
  const ComBack({
    super.key,
    this.left,
    this.center,
    this.right,
    this.title,
    this.isFloat,
    this.child,
  });

  @override
  State<ComBack> createState() => _MineState();
}

class _MineState extends State<ComBack> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildLeft() {
    if (widget.left != null) {
      return widget.left ?? SizedBox.shrink();
    }
    return GestureDetector(
      onTap: () {
        // 检查是否可以pop
        if (GoRouter.of(context).canPop()) {
          GoRouter.of(context).pop();
        }
      },
      child: ComIcon(
        width: 22.r,
        height: 22.r,
        padding: EdgeInsets.all(25.r),
        index: 15,
      ),
    );
  }

  Widget _buildCenter() {
    return Expanded(
      child:
          widget.center ??
          Container(
            alignment: Alignment.center,
            child: Text(widget.title ?? '', style: UtilTheme.text14),
          ),
    );
  }

  Widget _buildRight() {
    if (widget.right != null) {
      return widget.right ?? const SizedBox.shrink();
    }
    return const SizedBox.shrink();
  }

  Widget _buildBack() {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildLeft(), _buildCenter(), _buildRight()],
    );
  }

  Widget _buildLayout() {
    if (widget.isFloat == true) {
      return Stack(
        children: [
          widget.child ?? const SizedBox.shrink(),
          Positioned(left: 0, top: 0, right: 0, child: _buildBack()),
        ],
      );
    } else {
      return Column(
        children: [
          _buildBack(),
          Expanded(child: widget.child ?? const SizedBox.shrink()),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: _buildLayout()));
  }
}
