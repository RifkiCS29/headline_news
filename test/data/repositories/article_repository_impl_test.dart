import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:headline_news/common/exception.dart';
import 'package:headline_news/common/failure.dart';
import 'package:headline_news/data/models/article_model.dart';
import 'package:headline_news/data/repositories/article_repository_impl.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late ArticleRepositoryImpl repository;
  late MockArticleRemoteDataSource mockRemoteDataSource;
  late MockArticleLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockArticleRemoteDataSource();
    mockLocalDataSource = MockArticleLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ArticleRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tArticleModel = ArticleModel(
    author: 'test author',
    title: 'test title',
    description: 'test description',
    url: 'test url',
    urlToImage: 'test url to image',
    publishedAt: DateTime.parse('2022-01-01T02:15:39Z'),
    content: 'test content',
  );

  final tArticle = Article(
    author: 'test author',
    title: 'test title',
    description: 'test description',
    url: 'test url',
    urlToImage: 'test url to image',
    publishedAt: DateTime.parse('2022-01-01T02:15:39Z'),
    content: 'test content',
  );

  final tArticleModelList = <ArticleModel>[tArticleModel];
  final tArticleList = <Article>[tArticle];

  group('Now Playing Articles', () {
    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTopHeadlineArticles())
        .thenAnswer((_) async => []);
      //act 
      await repository.getTopHeadlineArticles();
      //assert
       verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopHeadlineArticles())
            .thenAnswer((_) async => tArticleModelList);
        // act
        final result = await repository.getTopHeadlineArticles();
        // assert
        verify(mockRemoteDataSource.getTopHeadlineArticles());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tArticleList);
      });

      test(
      'should cache data locally when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTopHeadlineArticles())
            .thenAnswer((_) async => tArticleModelList);
        // act
        await repository.getTopHeadlineArticles();
        // assert
        verify(mockRemoteDataSource.getTopHeadlineArticles());
        verify(mockLocalDataSource.cacheTopHeadlineArticles([testArticleCache]));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopHeadlineArticles())
            .thenThrow(ServerException());
        // act
        final result = await repository.getTopHeadlineArticles();
        // assert
        verify(mockRemoteDataSource.getTopHeadlineArticles());
        expect(result, equals(Left(ServerFailure(''))));
      });

      test(
          'should return Certification Failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopHeadlineArticles())
            .thenThrow(TlsException());
        // act
        final result = await repository.getTopHeadlineArticles();
        // assert
        verify(mockRemoteDataSource.getTopHeadlineArticles());
        expect(result, equals(Left(CommonFailure('Certificated Not Valid:\n'))));
      });
    });
    
    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should return cached data when device is offline',
          () async {
        // arrange
        when(mockLocalDataSource.getCachedTopHeadlineArticles())
          .thenAnswer((_) async => [testArticleCache]);
        //act
        final result = await repository.getTopHeadlineArticles();
        //assert
        verify(mockLocalDataSource.getCachedTopHeadlineArticles());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testArticleFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedTopHeadlineArticles())
            .thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getTopHeadlineArticles();
        // assert
        verify(mockLocalDataSource.getCachedTopHeadlineArticles());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Headline Business Articles', () {
    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getHeadlineBusinessArticles())
        .thenAnswer((_) async => []);
      //act 
      await repository.getHeadlineBusinessArticles();
      //assert
       verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getHeadlineBusinessArticles())
            .thenAnswer((_) async => tArticleModelList);
        // act
        final result = await repository.getHeadlineBusinessArticles();
        // assert
        verify(mockRemoteDataSource.getHeadlineBusinessArticles());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tArticleList);
      });

      test(
      'should cache data locally when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getHeadlineBusinessArticles())
            .thenAnswer((_) async => tArticleModelList);
        // act
        await repository.getHeadlineBusinessArticles();
        // assert
        verify(mockRemoteDataSource.getHeadlineBusinessArticles());
        verify(mockLocalDataSource.cacheHeadlineBusinessArticles([testArticleCache]));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getHeadlineBusinessArticles())
            .thenThrow(ServerException());
        // act
        final result = await repository.getHeadlineBusinessArticles();
        // assert
        verify(mockRemoteDataSource.getHeadlineBusinessArticles());
        expect(result, equals(Left(ServerFailure(''))));
      });

      test(
          'should return Certification Failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getHeadlineBusinessArticles())
            .thenThrow(TlsException());
        // act
        final result = await repository.getHeadlineBusinessArticles();
        // assert
        verify(mockRemoteDataSource.getHeadlineBusinessArticles());
        expect(result, equals(Left(CommonFailure('Certificated Not Valid:\n'))));
      });
    });
    
    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should return cached data when device is offline',
          () async {
        // arrange
        when(mockLocalDataSource.getCachedHeadlineBusinessArticles())
          .thenAnswer((_) async => [testArticleCache]);
        //act
        final result = await repository.getHeadlineBusinessArticles();
        //assert
        verify(mockLocalDataSource.getCachedHeadlineBusinessArticles());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testArticleFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedHeadlineBusinessArticles())
            .thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getHeadlineBusinessArticles();
        // assert
        verify(mockLocalDataSource.getCachedHeadlineBusinessArticles());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Get Article Recommendations', () {
    final tArticleList = <ArticleModel>[];
    final tCategory = 'business';

    test('should return data (Article list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getArticleCategory(tCategory))
          .thenAnswer((_) async => tArticleList);
      // act
      final result = await repository.getArticleCategory(tCategory);
      // assert
      verify(mockRemoteDataSource.getArticleCategory(tCategory));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tArticleList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getArticleCategory(tCategory))
          .thenThrow(ServerException());
      // act
      final result = await repository.getArticleCategory(tCategory);
      // assertbuild runner
      verify(mockRemoteDataSource.getArticleCategory(tCategory));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getArticleCategory(tCategory))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getArticleCategory(tCategory);
      // assert
      verify(mockRemoteDataSource.getArticleCategory(tCategory));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test(
        'should return Certification Failure when the call to remote data source is unsuccessful',
          () async {
      // arrange
      when(mockRemoteDataSource.getArticleCategory(tCategory))
          .thenThrow(TlsException());
      // act
      final result = await repository.getArticleCategory(tCategory);
      // assert
      verify(mockRemoteDataSource.getArticleCategory(tCategory));
      expect(result, equals(Left(CommonFailure('Certificated Not Valid:\n'))));
    });
  });

  group('Search Articles', () {
    final tQuery = 'spiderman';

    test('should return Article list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchArticles(tQuery))
          .thenAnswer((_) async => tArticleModelList);
      // act
      final result = await repository.searchArticles(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tArticleList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchArticles(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchArticles(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return Connection Failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchArticles(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchArticles(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });

    test(
        'should return Certification Failure when the call to remote data source is unsuccessful',
          () async {
      // arrange
      when(mockRemoteDataSource.searchArticles(tQuery))
          .thenThrow(TlsException());
      // act
      final result = await repository.searchArticles(tQuery);
      // assert
      expect(result, equals(Left(CommonFailure('Certificated Not Valid:\n'))));
    });
  });

  group('save Bookmark', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertBookmarkArticle(testArticleTable))
          .thenAnswer((_) async => 'Added to Bookmark');
      // act
      final result = await repository.saveBookmarkArticle(testArticle);
      // assert
      expect(result, Right('Added to Bookmark'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertBookmarkArticle(testArticleTable))
          .thenThrow(DatabaseException('Failed to add Bookmark'));
      // act
      final result = await repository.saveBookmarkArticle(testArticle);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add Bookmark')));
    });
  });

  group('remove Bookmark', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeBookmarkArticle(testArticleTable))
          .thenAnswer((_) async => 'Removed from Bookmark');
      // act
      final result = await repository.removeBookmarkArticle(testArticle);
      // assert
      expect(result, Right('Removed from Bookmark'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeBookmarkArticle(testArticleTable))
          .thenThrow(DatabaseException('Failed to remove Bookmark'));
      // act
      final result = await repository.removeBookmarkArticle(testArticle);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove Bookmark')));
    });
  });

  group('get Bookmark status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tUrl = 'url';
      when(mockLocalDataSource.getArticleByUrl(tUrl)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToBookmarkArticle(tUrl);
      // assert
      expect(result, false);
    });
  });

  group('get Bookmark Articles', () {
    test('should return list of Articles', () async {
      // arrange
      when(mockLocalDataSource.getBookmarkArticles())
          .thenAnswer((_) async => [testArticleTable]);
      // act
      final result = await repository.getBookmarkArticles();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testBookmarkArticle]);
    });
  });
}
