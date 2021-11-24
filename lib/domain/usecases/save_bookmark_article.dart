import 'package:dartz/dartz.dart';
import 'package:headline_news/common/failure.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/domain/repositories/article_repository.dart';

class SaveBookmarkArticle {
  final ArticleRepository repository;

  SaveBookmarkArticle(this.repository);

  Future<Either<Failure, String>> execute(Article article) {
    return repository.saveBookmarkArticle(article);
  }
}
