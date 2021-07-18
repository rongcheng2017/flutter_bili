import 'package:bili/model/video_model.dart';
import 'package:flutter/material.dart';

/// 创建时间：2021/7/14
/// 作者：frc
/// 描述：

class TestPage1 extends StatefulWidget {
  final ValueChanged<VideoModel>? onJumpToDetail;

  const TestPage1({Key? key, this.onJumpToDetail}) : super(key: key);

  @override
  _TestPage1State createState() => _TestPage1State();
}

class _TestPage1State extends State<TestPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [Text('Test1')],
        ),
      ),
    );
  }
}
