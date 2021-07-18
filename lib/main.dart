import 'package:bili/db/HiCache.dart';
import 'package:bili/http/dao/login_dao.dart';
import 'package:bili/model/video_model.dart';
import 'package:bili/page/login_page.dart';
import 'package:bili/page/registration_page.dart';
import 'package:bili/page/video_detail_page.dart';
import 'package:bili/util/color.dart';
import 'package:bili/util/toast.dart';
import 'package:flutter/material.dart';

import 'navigator/hi_navigator.dart';
import 'page/home_page.dart';

void main() {
  runApp(BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({Key? key}) : super(key: key);

  @override
  _BiliAppState createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  BiliRouteDelegate _routeDelegate = BiliRouteDelegate();
  BiliRouteInformationParser _routeInformationParser =
      BiliRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiCache>(
        //初始化
        future: HiCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
          var widget = snapshot.connectionState == ConnectionState.done
              ? Router(
                  routerDelegate: _routeDelegate,
                  routeInformationParser: _routeInformationParser,
                  routeInformationProvider: PlatformRouteInformationProvider(
                      initialRouteInformation: RouteInformation(location: "/")),
                )
              : Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
          return MaterialApp(
            home: widget,
            theme: ThemeData(
              primarySwatch: white,
            ),
          );
        });
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> navigatorKey;

  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    //实现跳转逻辑
    HiNavigator.getInstance().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map? args}) {
      _routeStatus = routeStatus;
      if (routeStatus == RouteStatus.detail) {
        this.videoModel = args?['videoMo'];
      }
      notifyListeners();
    }));
  }

  VideoModel? videoModel;
  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];

  RouteStatus get routeStatus {
    // if (_routeStatus != RouteStatus.registration && !hasLogin) {
    //   return _routeStatus = RouteStatus.login;
    // } else
    //
    if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    } else {
      return _routeStatus;
    }
  }

  bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    var tempPages = pages;
    if (index != -1) {
      //要打开的页面再栈中已经存在，则将该页面和它上面的所有页面进行出栈
      //最好要求栈中只允许有一个同样的页面实例
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      //跳转到首页时，将栈中其他页面进行出栈，以为首页不可回退。
      pages.clear();
      page = pageWrap(HomePage());
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(
        videoModel: videoModel,
      ));
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    }

    tempPages = [...tempPages, page];
    //通知路由发生变化
    HiNavigator.getInstance().notify(tempPages, pages);
    pages = tempPages;
    return WillPopScope(
      //android物理返回键
      onWillPop: () async => !await navigatorKey.currentState!.maybePop(),
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (route, result) {
          if (route.settings is MaterialPage) {
            //登录页未登录返回拦截
            if ((route.settings as MaterialPage).child is LoginPage) {
              if (!hasLogin) {
                showWarnToast("请先登录");
                return false;
              }
            }
          }
          //控制能否返回上一页
          if (!route.didPop(result)) {
            return false;
          }
          var tempPages = [...pages];
          pages.removeLast();
          //通知路由发生了变化
          HiNavigator.getInstance().notify(pages, tempPages);
          return true;
        },
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(BiliRoutePath configuration) async {}
}

///可缺省，应用于web,持有RouteInformationProvider 提供的 RouteInformation
class BiliRouteInformationParser extends RouteInformationParser<BiliRoutePath> {
  @override
  Future<BiliRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    print('uri: $uri');
    if (uri.pathSegments.length == 0) {
      return BiliRoutePath.home();
    }
    return BiliRoutePath.detail();
  }
}

///定义路由数据,path
class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = "/";

  BiliRoutePath.detail() : location = "/detail";
}
