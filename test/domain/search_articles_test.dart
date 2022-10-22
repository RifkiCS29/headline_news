import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/domain/entities/articles.dart';
import 'package:headline_news/domain/usecases/search_articles.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late SearchArticles usecase;
  late MockArticleRepository mockArticleRepository;

  setUp(() {
    mockArticleRepository = MockArticleRepository();
    usecase = SearchArticles(mockArticleRepository);
  });

  final tArticles = Articles(totalResults: 1, articles: const <Article>[]);
  const tQuery = 'business';

  test('should get list of Articles from the repository', () async {
    // arrange
    when(mockArticleRepository.searchArticles(tQuery))
        .thenAnswer((_) async => Right(tArticles));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tArticles));
  });
}