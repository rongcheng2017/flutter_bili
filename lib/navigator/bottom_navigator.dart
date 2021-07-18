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

  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          HomePage(),
          RankingPage(),
          FavoritePage(),
          ProfilePage(),
        ],
        onPageChanged: (index) {
          //让底部tab 根据上面页面滑动而变
          setState(() {
            _currentIndex = index;
          });
        },
        //PageView页面就不能滚动
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          //让Page进行跳转
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
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
}
