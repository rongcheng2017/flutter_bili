import 'package:flutter/material.dart';

/// 创建时间：2021/7/13
/// 作者：frc
/// 描述：

bool isNotEmpty(String? text) {
  return text?.isNotEmpty ?? false;
}

bool isEmpty(String? text) {
  return text?.isEmpty ?? true;
}
