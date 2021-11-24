import 'package:dartz/dartz.dart';
import 'package:headline_news/common/failure.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/domain/repositories/article_repository.dart';

class SearchArticles {
  final ArticleRepository repository;

  SearchArticles(this.repository);

  Future<Either<Failure, List<Article>>> execute(String query) {
    return repository.searchArticles(query);
  }
}
