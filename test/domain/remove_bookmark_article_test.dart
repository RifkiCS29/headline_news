import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:headline_news/domain/usecases/remove_bookmark_article.dart';
import 'package:mockito/mockito.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late RemoveBookmarkArticle usecase;
  late MockArticleRepository mockArticleRepository;

  setUp(() {
    mockArticleRepository = MockArticleRepository();
    usecase = RemoveBookmarkArticle(mockArticleRepository);
  });

  test('should remove Bookmark Article from repository', () async {
    // arrange
    when(mockArticleRepository.removeBookmarkArticle(testArticle))
        .thenAnswer((_) async => const Right('Removed from Bookmark'));
    // act
    final result = await usecase.execute(testArticle);
    // assert
    verify(mockArticleRepository.removeBookmarkArticle(testArticle));
    expect(result, const Right('Removed from Bookmark'));
  });
}