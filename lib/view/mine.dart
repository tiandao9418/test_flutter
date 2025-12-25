import 'package:flutter/material.dart';
import 'package:test_flutter/util/util_theme.dart';

// 我的
class Mine extends StatefulWidget {
  const Mine({super.key});

  @override
  State<Mine> createState() => _MineState();
}

class _MineState extends State<Mine> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Text('我的', style: UtilTheme.text14));
  }
}
