import 'package:flutter/material.dart';

// 视频
class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text('视频');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
