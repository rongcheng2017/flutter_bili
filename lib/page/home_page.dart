import 'package:bili/model/video_model.dart';
import 'package:flutter/material.dart';

/// 创建时间：2021/7/14
/// 作者：frc
/// 描述：

class HomePage extends StatefulWidget {
  final ValueChanged<VideoModel>? onJumpToDetail;

  const HomePage({Key? key, this.onJumpToDetail}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text('首页'),
            MaterialButton(
              onPressed: () => widget.onJumpToDetail?.call(VideoModel(111)),
              child: Text('详情'),
            )
          ],
        ),
      ),
    );
  }
}
