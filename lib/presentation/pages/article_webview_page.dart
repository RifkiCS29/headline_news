import 'package:flutter/material.dart';
import 'package:headline_news/presentation/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebviewPage extends StatelessWidget {
  final String url;

  ArticleWebviewPage({required this.url});

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}