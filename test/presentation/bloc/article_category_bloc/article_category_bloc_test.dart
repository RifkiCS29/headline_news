import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:headline_news/common/failure.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/domain/usecases/get_article_category.dart';
import 'package:headline_news/presentation/bloc/article_category_bloc/article_category_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'article_category_bloc_test.mocks.dart';

@GenerateMocks([GetArticleCategory])
void main() {
  late ArticleCategoryBloc articleCategoryBloc;
  late MockGetArticleCategory mockGetArticleCategory;

  setUp(() {
    mockGetArticleCategory = MockGetArticleCategory();
    articleCategoryBloc = ArticleCategoryBloc(mockGetArticleCategory);
  });

  final tArticleModel = Article(
    author: 'test author',
    title: 'test title',
    description: 'test description',
    url: 'test url',
    urlToImage: 'test url to image',
    publishedAt: DateTime.parse('2022-01-01T02:15:39Z'),
    content: 'test content',
  );
  final tArticleList = <Article>[tArticleModel];
  const tCategory = 'business';

  group('Article Category', () {

    test('Initial state should be empty', () {
      expect(articleCategoryBloc.state, const ArticleCategoryEmpty(''));
    });

    blocTest<ArticleCategoryBloc, ArticleCategoryState> (
      'Should emit [ArticleCategoryLoading, ArticleCategoryHasData] when data is gotten successfully',
      build: () {
        when(mockGetArticleCategory.execute(tCategory))
          .thenAnswer((_) async => Right(tArticleList));
        return articleCategoryBloc;
      },
      act: (bloc) => bloc.add(const FetchArticleCategory(tCategory)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        ArticleCategoryLoading(),
        ArticleCategoryHasData(tArticleList),
      ],
      verify: (bloc) {
        verify(mockGetArticleCategory.execute(tCategory));
      },
    );
    
    blocTest<ArticleCategoryBloc, ArticleCategoryState> (
      'Should emit [ArticleCategoryLoading, ArticleCategoryHasData[], ArticleCategoryEmpty] when data is empty',
      build: () {
        when(mockGetArticleCategory.execute(tCategory))
          .thenAnswer((_) async => const Right(<Article>[]));
        return articleCategoryBloc;
      },
      act: (bloc) => bloc.add(const FetchArticleCategory(tCategory)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        ArticleCategoryLoading(),
        const ArticleCategoryHasData(<Article>[]),
        const ArticleCategoryEmpty('Empty Article'),
      ],
      verify: (bloc) {
        verify(mockGetArticleCategory.execute(tCategory));
      },
    );

    blocTest<ArticleCategoryBloc, ArticleCategoryState> (
      'Should emit [ArticleCategoryLoading, ArticleCategoryError] when data is unsuccessful',
      build: () {
        when(mockGetArticleCategory.execute(tCategory))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return articleCategoryBloc;
      },
      act: (bloc) => bloc.add(const FetchArticleCategory(tCategory)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        ArticleCategoryLoading(),
        const ArticleCategoryError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetArticleCategory.execute(tCategory));
      },
    );
  });
}