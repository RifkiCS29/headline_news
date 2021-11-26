import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:headline_news/presentation/pages/bookmark_page.dart';
import 'package:headline_news/presentation/pages/search_page.dart';
import 'package:headline_news/presentation/widgets/widgets.dart';

import 'article_page.dart';

class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _bottomNavIndex = 0;

  List<BottomNavigationBarItem> _bottomNavbarItems = [
      BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.search : Icons.search),
        label: "Search",
      ),
      BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.bookmark_fill : Icons.bookmark),
        label: "Bookmark",
      ),
  ]; 

  List<Widget> _listWidget = [
    ArticlePage(),
    SearchPage(),
    BookmarkPage()
  ];

  @override
  void initState() { 
    super.initState();
  } 

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavbarItems,
        onTap: (selected) {
          setState(() {
            _bottomNavIndex = selected;
          });
        },
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items:_bottomNavbarItems,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }
}