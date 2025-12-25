import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_flutter/util/util_theme.dart';

class ComLoading extends StatefulWidget {
  const ComLoading({super.key});

  @override
  State createState() => _ComLoadingState();
}

class _ComLoadingState extends State<ComLoading> {
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _opacity = _opacity == 1.0 ? 0.3 : 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: _opacity,
        child: const SizedBox(
          width: 20,
          height: 20,
          child: Center(
            child: CircularProgressIndicator(
              color: UtilTheme.dark6,
              strokeWidth: 3,
            ),
          ),
        ),
      ),
    );
  }
}

/// 加载失败
class ComLoadingErr extends StatelessWidget {
  const ComLoadingErr({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('加载失败', style: UtilTheme.text12));
  }
}
