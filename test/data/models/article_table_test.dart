import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final Map<String, dynamic> articleTableJson = {
    'author': 'test author',
    'title': 'test title',
    'description': 'test description',
    'url': 'test url',
    'urlToImage': 'test url to image',
    'publishedAt': '2022-01-01T02:15:39.000Z',
    'content': 'test content',
  };

  test('should return json Article table correctly', () {
    final result = testArticleTable.toJson();
    expect(result, articleTableJson);
  });
}