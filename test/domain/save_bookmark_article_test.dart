import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:headline_news/domain/usecases/save_bookmark_article.dart';
import 'package:mockito/mockito.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late SaveBookmarkArticle usecase;
  late MockArticleRepository mockArticleRepository;

  setUp(() {
    mockArticleRepository = MockArticleRepository();
    usecase = SaveBookmarkArticle(mockArticleRepository);
  });

  test('should save Article to the repository', () async {
    // arrange
    when(mockArticleRepository.saveBookmarkArticle(testArticle))
        .thenAnswer((_) async => const Right('Added to Bookmark'));
    // act
    final result = await usecase.execute(testArticle);
    // assert
    verify(mockArticleRepository.saveBookmarkArticle(testArticle));
    expect(result, const Right('Added to Bookmark'));
  });
}