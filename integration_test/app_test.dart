import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:headline_news/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration Test: ', () {
    testWidgets('Add Headline News to Bookmark', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      //click first item
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
    });
  });
}