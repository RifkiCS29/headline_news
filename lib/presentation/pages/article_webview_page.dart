import 'package:flutter/material.dart';
import 'package:headline_news/presentation/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebviewPage extends StatelessWidget {
  final String url;

  const ArticleWebviewPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}