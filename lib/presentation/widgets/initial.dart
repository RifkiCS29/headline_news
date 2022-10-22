import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:headline_news/common/theme.dart';

class Initial extends StatelessWidget {
  final String message;

  const Initial({Key? key,  required this.message }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildInitial(context, message);
  }

  Widget _buildInitial(BuildContext context, String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/news_initial.json',
          width: 200, height: 200, fit: BoxFit.fill,
          repeat: false,
          reverse: false,
          animate: false,
        ),
        const SizedBox(height:8),
        Text(
          message, 
          style: primaryTextStyle,
        )
      ],
    );
  }
}