import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:headline_news/common/theme.dart';

class Error extends StatelessWidget {
  final String message;

  const Error({ required this.message });

  @override
  Widget build(BuildContext context) {
    return _buildError(context, message);
  }

  Widget _buildError(BuildContext context, String message) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/error.json',
            width: 250, height: 200, fit: BoxFit.fill,
            repeat: false,
            reverse: false,
            animate: false,
          ),
          SizedBox(height:8),
          Text(
            message, 
            style: primaryTextStyle
          )
        ]
      )
    );
  }
}