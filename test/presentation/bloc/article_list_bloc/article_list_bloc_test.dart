import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:headline_news/common/failure.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/domain/usecases/get_headline_business_articles.dart';
import 'package:headline_news/domain/usecases/get_top_headline_articles.dart';
import 'package:headline_news/presentation/bloc/article_list_bloc/article_list_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'article_list_bloc_test.mocks.dart';

@GenerateMocks([GetTopHeadlineArticles, GetHeadlineBusinessArticles])
void main() {
  late ArticleTopHeadlineListBloc articleTopHeadlineListBloc;
  late MockGetTopHeadlineArticles mockGetTopHeadlineArticles;
  late ArticleHeadlineBusinessListBloc articleHeadlineBusinessListBloc;
  late MockGetHeadlineBusinessArticles mockGetHeadlineBusinessArticles;

  setUp(() {
    mockGetTopHeadlineArticles = MockGetTopHeadlineArticles();
    articleTopHeadlineListBloc = ArticleTopHeadlineListBloc(mockGetTopHeadlineArticles);
    mockGetHeadlineBusinessArticles = MockGetHeadlineBusinessArticles();
    articleHeadlineBusinessListBloc = ArticleHeadlineBusinessListBloc(mockGetHeadlineBusinessArticles);
  });

  final tArticle = Article(
    author: 'test author',
    title: 'test title',
    description: 'test description',
    url: 'test url',
    urlToImage: 'test url to image',
    publishedAt: DateTime.parse('2022-01-01T02:15:39Z'),
    content: 'test content',
  );

  final tArticleList = <Article>[tArticle];

  group('Top Headline Article list', () {
    test('Initial state should be empty', () {
      expect(articleTopHeadlineListBloc.state, ArticleListEmpty());
    });

    blocTest<ArticleTopHeadlineListBloc, ArticleListState> (
      'Should emit [ArticleListLoading, ArticleListLoaded] when data is gotten successfully',
      build: () {
        when(mockGetTopHeadlineArticles.execute())
          .thenAnswer((_) async => Right(tArticleList));
        return articleTopHeadlineListBloc;
      },
      act: (bloc) => bloc.add(ArticleListEvent()),
      expect: () => [
        ArticleListLoading(),
        ArticleListLoaded(tArticleList),
      ],
      verify: (bloc) {
        verify(mockGetTopHeadlineArticles.execute());
      },
    );

    blocTest<ArticleTopHeadlineListBloc, ArticleListState> (
      'Should emit [ArticleListLoading, ArticleListLoaded[], ArticleListEmpty] when data was Empty',
      build: () {
        when(mockGetTopHeadlineArticles.execute())
            .thenAnswer((_) async => const Right(<Article>[]));
        return articleTopHeadlineListBloc;
      },
      act: (bloc) => bloc.add(ArticleListEvent()),
      expect: () => [
        ArticleListLoading(),
        const ArticleListLoaded([]),
        ArticleListEmpty(),
      ],
      verify: (_) {
        verify(mockGetTopHeadlineArticles.execute());
      },
    );

    blocTest<ArticleTopHeadlineListBloc, ArticleListState> (
      'Should emit [ArticleListLoading, ArticleListError] when get Failure',
      build: () {
        when(mockGetTopHeadlineArticles.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return articleTopHeadlineListBloc;
      },
      act: (bloc) => bloc.add(ArticleListEvent()),
      expect: () => [
        ArticleListLoading(),
        const ArticleListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetTopHeadlineArticles.execute());
      },
    );
  });

  group('Headline Business Article list', () {
    test('Initial state should be empty', () {
      expect(articleHeadlineBusinessListBloc.state, ArticleListEmpty());
    });

    blocTest<ArticleHeadlineBusinessListBloc, ArticleListState> (
      'Should emit [ArticleListLoading, ArticleListLoaded] when data is gotten successfully',
      build: () {
        when(mockGetHeadlineBusinessArticles.execute())
          .thenAnswer((_) async => Right(tArticleList));
        return articleHeadlineBusinessListBloc;
      },
      act: (bloc) => bloc.add(ArticleListEvent()),
      expect: () => [
        ArticleListLoading(),
        ArticleListLoaded(tArticleList),
      ],
      verify: (bloc) {
        verify(mockGetHeadlineBusinessArticles.execute());
      },
    );

    blocTest<ArticleHeadlineBusinessListBloc, ArticleListState> (
      'Should emit [ArticleListLoading, ArticleListLoaded[], ArticleListEmpty] when data was Empty',
      build: () {
        when(mockGetHeadlineBusinessArticles.execute())
            .thenAnswer((_) async => const Right(<Article>[]));
        return articleHeadlineBusinessListBloc;
      },
      act: (bloc) => bloc.add(ArticleListEvent()),
      expect: () => [
        ArticleListLoading(),
        const ArticleListLoaded([]),
        ArticleListEmpty(),
      ],
      verify: (_) {
        verify(mockGetHeadlineBusinessArticles.execute());
      },
    );

    blocTest<ArticleHeadlineBusinessListBloc, ArticleListState> (
      'Should emit [ArticleListLoading, ArticleListError] when get Failure',
      build: () {
        when(mockGetHeadlineBusinessArticles.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return articleHeadlineBusinessListBloc;
      },
      act: (bloc) => bloc.add(ArticleListEvent()),
      expect: () => [
        ArticleListLoading(),
        const ArticleListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetHeadlineBusinessArticles.execute());
      },
    );
  });
}
