import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/domain/usecases/get_article_category.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetArticleCategory usecase;
  late MockArticleRepository mockArticleRepository;

  setUp(() {
    mockArticleRepository = MockArticleRepository();
    usecase = GetArticleCategory(mockArticleRepository);
  });

  const tCategory = 'business';
  final tArticles = <Article>[];

  test('should get list of Article Category from the repository',
      () async {
    // arrange
    when(mockArticleRepository.getArticleCategory(tCategory))
        .thenAnswer((_) async => Right(tArticles));
    // act
    final result = await usecase.execute(tCategory);
    // assert
    expect(result, Right(tArticles));
  });
}