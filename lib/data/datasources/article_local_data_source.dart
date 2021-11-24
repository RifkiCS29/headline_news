import 'package:headline_news/common/exception.dart';
import 'package:headline_news/data/datasources/db/database_helper.dart';
import 'package:headline_news/data/models/article_table.dart';

abstract class ArticleLocalDataSource {
  Future<String> insertBookmarkArticle(ArticleTable article);
  Future<String> removeBookmarkArticle(ArticleTable article);
  Future<ArticleTable?> getArticleByUrl(String url);
  Future<List<ArticleTable>> getBookmarkArticles();
  Future<void> cacheTopHeadlineArticles(List<ArticleTable> articles);
  Future<List<ArticleTable>> getCachedTopHeadlineArticles();
  Future<void> cacheHeadlineBusinessArticles(List<ArticleTable> articles);
  Future<List<ArticleTable>> getCachedHeadlineBusinessArticles();
}

class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  final DatabaseHelper databaseHelper;

  ArticleLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertBookmarkArticle(ArticleTable article) async {
    try {
      await databaseHelper.insertBookmarkArticle(article);
      return 'Added to Bookmark';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeBookmarkArticle(ArticleTable article) async {
    try {
      await databaseHelper.removeBookmarkArticle(article);
      return 'Removed from Bookmark';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<ArticleTable?> getArticleByUrl(String url) async {
    final result = await databaseHelper.getArticleByUrl(url);
    if (result != null) {
      return ArticleTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<ArticleTable>> getBookmarkArticles() async {
    final result = await databaseHelper.getBookmarkArticles();
    return result.map((data) => ArticleTable.fromMap(data)).toList();
  }

  @override
  Future<void> cacheTopHeadlineArticles(List<ArticleTable> articles) async {
    await databaseHelper.clearCacheArticles('top headline');
    await databaseHelper.insertCacheTransactionArticles(articles, 'top headline');
  }

  @override
  Future<List<ArticleTable>> getCachedTopHeadlineArticles() async {
    final result = await databaseHelper.getCacheArticles('top headline');
    if (result.length > 0) {
      return result.map((data) => ArticleTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<void> cacheHeadlineBusinessArticles(List<ArticleTable> articles) async {
    await databaseHelper.clearCacheArticles('headline business');
    await databaseHelper.insertCacheTransactionArticles(articles, 'headline business');
  }

  @override
  Future<List<ArticleTable>> getCachedHeadlineBusinessArticles() async {
    final result = await databaseHelper.getCacheArticles('headline business');
    if (result.length > 0) {
      return result.map((data) => ArticleTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
}
