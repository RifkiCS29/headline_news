import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/presentation/widgets/widgets.dart';

void main() {
  final article = Article(
    author: 'test author',
    title: 'test title',
    description: 'test description',
    url: 'test url',
    urlToImage: 'test url to image',
    publishedAt: DateTime.parse('2022-01-01T02:15:39Z'),
    content: 'test content',
  );

  group('Top Headline Article card Widget Test', () {
    Widget makeTestableWidget() {
      return MaterialApp(
        home: Scaffold(body: TopHeadlineArticleCard(article: article)),
      );
    }

    testWidgets('Testing if title Article shows', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget());
      expect(find.byType(Text), findsWidgets);
      expect(find.byType(GestureDetector), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });
  });
}
