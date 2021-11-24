import 'package:dartz/dartz.dart';
import 'package:headline_news/common/failure.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/domain/repositories/article_repository.dart';

class GetArticleCategory {
  final ArticleRepository repository;

  GetArticleCategory(this.repository);

  Future<Either<Failure, List<Article>>> execute(String category) {
    return repository.getArticleCategory(category);
  }
}
