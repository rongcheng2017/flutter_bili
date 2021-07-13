import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 创建时间：2021/7/13
/// 作者：frc
/// 描述：

void showWarnToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white);
}

void showToast(String text) {
  Fluttertoast.showToast(
      msg: text, gravity: ToastGravity.CENTER, textColor: Colors.white);
}
