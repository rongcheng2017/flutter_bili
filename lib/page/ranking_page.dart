import 'package:flutter/material.dart';

/// 创建时间：2021/7/18
/// 作者：frc
/// 描述：

class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text('排行'),
      ),
    );
  }
}
