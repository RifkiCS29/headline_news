import 'package:dartz/dartz.dart';
import 'package:headline_news/common/failure.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/domain/repositories/article_repository.dart';

class RemoveBookmarkArticle {
  final ArticleRepository repository;

  RemoveBookmarkArticle(this.repository);

  Future<Either<Failure, String>> execute(Article article) {
    return repository.removeBookmarkArticle(article);
  }
}
