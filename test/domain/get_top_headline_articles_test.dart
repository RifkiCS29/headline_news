import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/domain/usecases/get_top_headline_articles.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetTopHeadlineArticles usecase;
  late MockArticleRepository mockArticleRepository;

  setUp(() {
    mockArticleRepository = MockArticleRepository();
    usecase = GetTopHeadlineArticles(mockArticleRepository);
  });

  final tArticles = <Article>[];

  test('should get list of Articles from the repository', () async {
    // arrange
    when(mockArticleRepository.getTopHeadlineArticles())
        .thenAnswer((_) async => Right(tArticles));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tArticles));
  });
}