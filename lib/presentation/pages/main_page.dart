import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headline_news/common/theme.dart';
import 'package:headline_news/presentation/bloc/bookmark_article_bloc/bookmark_article_bloc.dart';
import 'package:headline_news/presentation/pages/bookmark_page.dart';
import 'package:headline_news/presentation/pages/search_page.dart';
import 'package:headline_news/presentation/widgets/widgets.dart';
import 'package:headline_news/injection.dart' as di;

import 'package:headline_news/presentation/pages/article_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _bottomNavIndex = 0;

  final List<BottomNavigationBarItem> _bottomNavbarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.search : Icons.search),
      label: "Search",
    ),
    BottomNavigationBarItem(
      icon:
          Icon(Platform.isIOS ? CupertinoIcons.bookmark_fill : Icons.bookmark),
      label: "Bookmark",
    ),
  ];

  final List<Widget> _listWidget = [
    const ArticlePage(),
    const SearchPage(),
    BlocProvider(
      create: (_) => di.locator<BookmarkArticleBloc>(),
      child: const BookmarkPage(),
    ),
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
        backgroundColor: kWhiteColor,
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
        items: _bottomNavbarItems,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }
}
