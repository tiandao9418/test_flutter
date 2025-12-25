import 'package:flutter/material.dart';

/// 可复用的固定Sliver头部组件
/// 用法：FixedSliverHeader(child: YourWidget(), height: 80)
class FixedSliverHeader extends StatelessWidget {
  final Widget child;
  final double height;
  final bool pinned;
  final Color? backgroundColor;
  
  const FixedSliverHeader({
    super.key,
    required this.child,
    this.height = 60,
    this.pinned = true,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: pinned,
      delegate: _FixedHeaderDelegate(
        height: height,
        child: child,
        backgroundColor: backgroundColor!,
      ),
    );
  }
}

/// 私有Delegate，外部无需关心
class _FixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;
  final Color backgroundColor;

  _FixedHeaderDelegate({
    required this.height,
    required this.child,
    required this.backgroundColor,
  });

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _FixedHeaderDelegate oldDelegate) {
    return height != oldDelegate.height ||
        child != oldDelegate.child ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}