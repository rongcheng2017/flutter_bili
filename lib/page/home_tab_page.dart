import 'package:flutter/material.dart';

/// 创建时间：2021/7/18
/// 作者：frc
/// 描述：首页中顶部导航对应的Page

class HomeTabPage extends StatefulWidget {
  final String name;

  const HomeTabPage(this.name, {Key? key}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.name),
    );
  }
}
