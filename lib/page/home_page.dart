import 'package:bili/model/video_model.dart';
import 'package:bili/navigator/hi_navigator.dart';
import 'package:flutter/material.dart';

/// 创建时间：2021/7/14
/// 作者：frc
/// 描述：

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

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
              onPressed: () {
                HiNavigator.getInstance().onJumpTo(RouteStatus.detail,
                    args: {'videoMo': VideoModel(1001)});
              },
              child: Text('详情'),
            )
          ],
        ),
      ),
    );
  }
}
