import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:headline_news/domain/usecases/get_bookmark_articles.dart';
import 'package:mockito/mockito.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late GetBookmarkArticles usecase;
  late MockArticleRepository mockArticleRepository;

  setUp(() {
    mockArticleRepository = MockArticleRepository();
    usecase = GetBookmarkArticles(mockArticleRepository);
  });

  test('should get list of Articles from the repository', () async {
    // arrange
    when(mockArticleRepository.getBookmarkArticles())
        .thenAnswer((_) async => Right(testArticleList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testArticleList));
  });
}