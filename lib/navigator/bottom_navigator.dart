import 'package:bili/navigator/hi_navigator.dart';
import 'package:bili/page/favorite_page.dart';
import 'package:bili/page/home_page.dart';
import 'package:bili/page/profile_page.dart';
import 'package:bili/page/ranking_page.dart';
import 'package:bili/util/color.dart';
import 'package:flutter/material.dart';

/// 创建时间：2021/7/18
/// 作者：frc
/// 描述：

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = primary;
  static int initialPage = 0;
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: initialPage);

  List<Widget>? _pages;
  bool _hasBuild = false;

  @override
  Widget build(BuildContext context) {
    _pages = [
      HomePage(),
      RankingPage(),
      FavoritePage(),
      ProfilePage(),
    ];
    if (!_hasBuild) {
      //页面第一次打开时通知打开的是哪个tab
      HiNavigator.getInstance()
          .onBottomTabChange(initialPage, _pages![initialPage]);
      _hasBuild = true;
    }
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: _pages!,
        onPageChanged: (index) => _onJumpTo(index, pageChange: true),
        //PageView页面就不能滚动
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _onJumpTo(index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _activeColor,
        items: [
          _bottomItem('首页', Icons.home, 0),
          _bottomItem('排行', Icons.local_fire_department, 1),
          _bottomItem('收藏', Icons.favorite, 2),
          _bottomItem('我的', Icons.live_tv, 3),
        ],
      ),
    );
  }

  _bottomItem(String title, IconData icon, int i) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: _defaultColor,
      ),
      activeIcon: Icon(
        icon,
        color: _activeColor,
      ),
      label: title,
    );
  }

  /// [pageChange]如果是点击tab触发的为false，Page切换触发的为true
  void _onJumpTo(int index, {pageChange = false}) {
    if (!pageChange) {
      //让Page进行跳转
      _controller.jumpToPage(index);
    } else {
      HiNavigator.getInstance().onBottomTabChange(index, _pages![index]);
    }
    //切换tab位置
    setState(() {
      _currentIndex = index;
    });
  }
}
