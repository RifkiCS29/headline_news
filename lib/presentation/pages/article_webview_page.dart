import 'package:flutter/material.dart';
import 'package:headline_news/presentation/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebviewPage extends StatefulWidget {
  final String url;

  const ArticleWebviewPage({Key? key, required this.url}) : super(key: key);

  @override
  State<ArticleWebviewPage> createState() => _ArticleWebviewPageState();
}

class _ArticleWebviewPageState extends State<ArticleWebviewPage> {
  final WebViewController webViewController = WebViewController();

  @override
  void initState() {
    super.initState();
    webViewController
      ..loadRequest(Uri.parse(widget.url))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
