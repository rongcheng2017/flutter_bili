import 'package:bili/model/video_model.dart';
import 'package:flutter/material.dart';

/// 创建时间：2021/7/14
/// 作者：frc
/// 描述：

class TestPage extends StatefulWidget {
  final ValueChanged<VideoModel>? onJumpToDetail;

  const TestPage({Key? key, this.onJumpToDetail}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [Text('Test')],
        ),
      ),
    );
  }
}
