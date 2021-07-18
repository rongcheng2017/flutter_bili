import 'package:bili/page/home_page.dart';
import 'package:bili/page/login_page.dart';
import 'package:bili/page/registration_page.dart';
import 'package:bili/page/video_detail_page.dart';
import 'package:flutter/material.dart';

/// 创建时间：2021/7/17
/// 作者：frc
/// 描述：

///创建路由页面
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

///自定义路由的封装，路由状态
enum RouteStatus { login, registration, home, detail, unknown }

///获取page对应的RouteStatus
RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is HomePage) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  } else {
    return RouteStatus.unknown;
  }
}

///路由信息\
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

///获取RouteStatus在路由堆栈的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    var materialPage = pages[i];
    if (getStatus(materialPage) == routeStatus) {
      return i;
    }
  }
  return -1;
}

///监听路由页面跳转
///感知当前页面是否压后台
class HiNavigator extends _RouteJumpListener {
  HiNavigator._();

  static HiNavigator? _instance;
  RouteJumpListener? _routeJumpListener;

  static HiNavigator getInstance() {
    if (_instance == null) {
      _instance = HiNavigator._();
    }

    return _instance!;
  }

  void registerRouteJump(RouteJumpListener routeJumpListener) {
    this._routeJumpListener = routeJumpListener;
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    _routeJumpListener?.onJumpTo?.call(routeStatus, args: args);
  }
}

///抽象类提供HiNavigator实现
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

///定义路由跳转逻辑要实现的功能
class RouteJumpListener {
  final OnJumpTo? onJumpTo;

  RouteJumpListener({this.onJumpTo});
}
