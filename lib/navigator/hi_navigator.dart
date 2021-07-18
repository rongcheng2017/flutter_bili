import 'package:bili/navigator/bottom_navigator.dart';
import 'package:bili/page/login_page.dart';
import 'package:bili/page/registration_page.dart';
import 'package:bili/page/video_detail_page.dart';
import 'package:flutter/material.dart';

/// 创建时间：2021/7/17
/// 作者：frc
/// 描述：

typedef RouteChangeListener(RouteStatusInfo current, RouteStatusInfo? pre);

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
  } else if (page.child is BottomNavigator) {
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

  List<RouteChangeListener> _listeners = [];

  RouteStatusInfo? _current;

  //底部tab
  RouteStatusInfo? _bottomTab;

  static HiNavigator getInstance() {
    if (_instance == null) {
      _instance = HiNavigator._();
    }

    return _instance!;
  }

  ///底部tab切换的监听
  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab!);
  }

  void registerRouteJump(RouteJumpListener routeJumpListener) {
    this._routeJumpListener = routeJumpListener;
  }

  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  ///通知路由页面变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;
    var current =
        RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    _routeJumpListener?.onJumpTo?.call(routeStatus, args: args);
  }

  void _notify(RouteStatusInfo current) {
    if (current.page is BottomNavigator && _bottomTab != null) {
      //如果打开的是bottomTab，则明确到首页具体的tab页面
      current = _bottomTab!;
    }
    print('hi_navigator:  current ${current.page}');
    print('hi_navigator:  pre ${_current?.page}');

    _listeners.forEach((listener) {
      listener(current, _current);
    });
    _current = current;
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
