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

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  var listener;

  @override
  void initState() {
    super.initState();
    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      print('current: ${current.page}');
      print('pre: ${pre.page}');
      if (widget == current.page || current.page is HomePage) {
        print('打开了首页:onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print('首页: onPause');
      }
    });
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(this.listener);
    super.dispose();
  }

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

  ///让页面在ViewPage切换中不销毁
  @override
  bool get wantKeepAlive => true;
}
