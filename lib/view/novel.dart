import 'package:flutter/material.dart';
import 'package:test_flutter/util/util_theme.dart';

// 小说
class Novel extends StatefulWidget {
  const Novel({super.key});

  @override
  State<Novel> createState() => _NovelState();
}

class _NovelState extends State<Novel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Text('小说', style: UtilTheme.text14));
  }
}
