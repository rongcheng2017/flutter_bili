import 'package:bili/widget/appbar.dart';
import 'package:bili/widget/login_effect.dart';
import 'package:bili/widget/login_input.dart';
import 'package:flutter/material.dart';

/// 创建时间：2021/7/13
/// 作者：frc
/// 描述：注册页面

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('注册', '登录', () {
        print('right button click');
      }),
      body: Container(
        child: ListView(
          //自适应键盘弹起,防止遮挡
          children: [
            LoginEffect(protect: protect),
            LoginInput(
              title: '用户名',
              hint: '请输入用户名',
              onChanged: (text) {
                print(text);
              },
            ),
            LoginInput(
              title: '密码',
              hint: '请输入密码',
              lineStretch: true,
              obscureText: true,
              onChanged: (text) {
                print(text);
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
