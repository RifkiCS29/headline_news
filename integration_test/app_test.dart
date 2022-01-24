import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:headline_news/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration Test: ', () {
    testWidgets('All Integration Test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      //add boomark headline news and back to home page
      final Finder firstItem = find.byKey(Key('headline_news_item')).first;
      await tester.tap(firstItem);
      await tester.pumpAndSettle();

      final Finder btnBookmark = find.byIcon(Icons.bookmark_border);
      await tester.tap(btnBookmark);
      await tester.pumpAndSettle();

      final Finder btnReadMore = find.byKey(Key('button_read_more'));
      await tester.tap(btnReadMore);
      await tester.pumpAndSettle();

      final Finder btnBackWebView = find.byIcon(Icons.arrow_back);
      await tester.tap(btnBackWebView);
      await tester.pumpAndSettle();

      final Finder btnBackDetail = find.byIcon(Icons.arrow_back_ios);
      await tester.tap(btnBackDetail);
      await tester.pumpAndSettle();

      // add boomark category new and back to home page
      final Finder articleCategory = find.byKey(Key('article_category')).first;
      await tester.tap(articleCategory);
      await tester.pumpAndSettle();

      final Finder firstItemCategory = find.byKey(Key('article_list_item')).first;
      await tester.tap(firstItemCategory);
      await tester.pumpAndSettle();

      final Finder btnBookmarkCategory = find.byIcon(Icons.bookmark_border);
      await tester.tap(btnBookmarkCategory);
      await tester.pumpAndSettle();

      final Finder btnReadMoreCategory = find.byKey(Key('button_read_more'));
      await tester.tap(btnReadMoreCategory);
      await tester.pumpAndSettle();

      final Finder btnBackWebViewCategory = find.byIcon(Icons.arrow_back);
      await tester.tap(btnBackWebViewCategory);
      await tester.pumpAndSettle();

      final Finder btnBackDetailCategory = find.byIcon(Icons.arrow_back_ios);
      await tester.tap(btnBackDetailCategory);
      await tester.pumpAndSettle();
    });
  });
}