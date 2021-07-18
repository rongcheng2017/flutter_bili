import 'package:flutter/material.dart';

/// 创建时间：2021/7/18
/// 作者：frc
/// 描述：

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text('收藏'),
      ),
    );
  }
}
