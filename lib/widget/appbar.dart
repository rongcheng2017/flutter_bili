import 'package:flutter/material.dart';

/// 创建时间：2021/7/13
/// 作者：frc
/// 描述：自定义顶部appbar

appBar(String title, String rightTitle, VoidCallback? rightButtonClick) {
  return AppBar(
    centerTitle: false,
    titleSpacing: 0,
    leading: BackButton(),
    title: Text(title, style: TextStyle(fontSize: 18)),
    actions: [
      InkWell(
        onTap: rightButtonClick,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Text(
            rightTitle,
            style: TextStyle(fontSize: 18, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ),
      )
    ],
  );
}
