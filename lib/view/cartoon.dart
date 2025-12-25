import 'package:flutter/material.dart';
import 'package:test_flutter/util/util_theme.dart';

// 动漫
class Cartoon extends StatefulWidget {
  const Cartoon({super.key});

  @override
  State<Cartoon> createState() => _CartoonState();
}

class _CartoonState extends State<Cartoon> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Text('动漫', style: UtilTheme.text14));
  }
}
