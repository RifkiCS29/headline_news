import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:headline_news/common/failure.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/domain/usecases/search_articles.dart';
import 'package:headline_news/presentation/bloc/search_article_bloc/search_article_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_article_bloc_test.mocks.dart';

@GenerateMocks([SearchArticles])
void main() {
  late SearchArticleBloc searchArticleBloc;
  late MockSearchArticles mockSearchArticles;

  setUp(() {
    mockSearchArticles = MockSearchArticles();
    searchArticleBloc = SearchArticleBloc(mockSearchArticles);
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
  final tQuery = 'business';

  group('Search Articles', () {

    test('Initial state should be empty', () {
      expect(searchArticleBloc.state, SearchArticleEmpty(''));
    });

    blocTest<SearchArticleBloc, SearchArticleState> (
      'Should emit [SearchLoading, SearchHasData] when data is gotten successfully',
      build: () {
        when(mockSearchArticles.execute(tQuery))
          .thenAnswer((_) async => Right(tArticleList));
        return searchArticleBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchArticleLoading(),
        SearchArticleHasData(tArticleList),
      ],
      verify: (bloc) {
        verify(mockSearchArticles.execute(tQuery));
      },
    );
    
    blocTest<SearchArticleBloc, SearchArticleState> (
      'Should emit [SearchLoading, SearchHasData[], SearchEmpty] when data is empty',
      build: () {
        when(mockSearchArticles.execute(tQuery))
          .thenAnswer((_) async => Right(<Article>[]));
        return searchArticleBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchArticleLoading(),
        SearchArticleHasData(<Article>[]),
        SearchArticleEmpty('No Result Found'),
      ],
      verify: (bloc) {
        verify(mockSearchArticles.execute(tQuery));
      },
    );

    blocTest<SearchArticleBloc, SearchArticleState> (
      'Should emit [SearchLoading, SearchError] when data is unsuccessful',
      build: () {
        when(mockSearchArticles.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchArticleBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchArticleLoading(),
        SearchArticleError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchArticles.execute(tQuery));
      },
    );
  });
}
