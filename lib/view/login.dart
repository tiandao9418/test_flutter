import 'package:flutter/material.dart';

/// 登陆
class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('登陆')),
      body: const Center(child: Text('登陆界面')),
    );
  }
}
