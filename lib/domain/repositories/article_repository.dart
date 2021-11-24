import 'package:dartz/dartz.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/common/failure.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<Article>>> getTopHeadlineArticles();
  Future<Either<Failure, List<Article>>> getHeadlineBusinessArticles();
  Future<Either<Failure, List<Article>>> getArticleCategory(String category);
  Future<Either<Failure, List<Article>>> searchArticles(String query);
  Future<Either<Failure, String>> saveBookmarkArticle(Article article);
  Future<Either<Failure, String>> removeBookmarkArticle(Article article);
  Future<bool> isAddedToBookmarkArticle(String url);
  Future<Either<Failure, List<Article>>> getBookmarkArticles();
}
