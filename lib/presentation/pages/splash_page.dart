import 'dart:async';
import 'package:flutter/material.dart';
import 'package:headline_news/common/theme.dart';
import 'package:headline_news/presentation/pages/main_page.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(Duration(milliseconds: 2000), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Center(
            child:
              Container(
                height: 330,
                width: 300,
                child: Lottie.asset('assets/news.json',
                    width: 350, height: 350, fit: BoxFit.fill),
              ),
          ),
        )
    );
  }
}
