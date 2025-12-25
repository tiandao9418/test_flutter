import 'package:flutter/material.dart';

// 错误
class Err extends StatelessWidget {
  const Err({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('首页')),
      body: const SafeArea(child: Text('错误')),
    );
  }
}
