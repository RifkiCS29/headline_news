import 'package:headline_news/common/exception.dart';
import 'package:headline_news/data/datasources/article_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late ArticleLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = ArticleLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('Save Bookmark', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertBookmarkArticle(testArticleTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertBookmarkArticle(testArticleTable);
      // assert
      expect(result, 'Added to Bookmark');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertBookmarkArticle(testArticleTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertBookmarkArticle(testArticleTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Remove Bookmark', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeBookmarkArticle(testArticleTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeBookmarkArticle(testArticleTable);
      // assert
      expect(result, 'Removed from Bookmark');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeBookmarkArticle(testArticleTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeBookmarkArticle(testArticleTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Bookmark Articles', () {
    test('should return list of ArticleTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getBookmarkArticles())
          .thenAnswer((_) async => [testArticleMap]);
      // act
      final result = await dataSource.getBookmarkArticles();
      // assert
      expect(result, [testArticleTable]);
    });
  });

  group('cache top headline Articles', () {
    test('should call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper.clearCacheArticles('top headline'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheTopHeadlineArticles([testArticleCache]);
      // assert
      verify(mockDatabaseHelper.clearCacheArticles('top headline'));
      verify(mockDatabaseHelper
          .insertCacheTransactionArticles([testArticleCache], 'top headline'),);
    });

    test('should return list of Articles from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheArticles('top headline'))
          .thenAnswer((_) async => [testArticleCacheMap]);
      // act
      final result = await dataSource.getCachedTopHeadlineArticles();
      // assert
      expect(result, [testArticleCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheArticles('top headline'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedTopHeadlineArticles();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('cache headline business Articles', () {
    test('should call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper.clearCacheArticles('headline business'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheHeadlineBusinessArticles([testArticleCache]);
      // assert
      verify(mockDatabaseHelper.clearCacheArticles('headline business'));
      verify(mockDatabaseHelper
          .insertCacheTransactionArticles([testArticleCache], 'headline business'),);
    });

    test('should return list of Articles from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheArticles('headline business'))
          .thenAnswer((_) async => [testArticleCacheMap]);
      // act
      final result = await dataSource.getCachedHeadlineBusinessArticles();
      // assert
      expect(result, [testArticleCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheArticles('headline business'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedHeadlineBusinessArticles();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}