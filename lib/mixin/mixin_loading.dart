import 'package:flutter/material.dart';
import 'package:test_flutter/component/com_loading.dart';

// 页面加载loading
mixin MixinLoading<T extends StatefulWidget> on State<T> {
  bool _isLoading = true;

  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  Widget buildMixLoading(Widget child) {
    if (_isLoading) {
      return const ComLoading();
    }
    return child;
  }
}
