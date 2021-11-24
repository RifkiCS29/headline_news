import 'package:dartz/dartz.dart';
import 'package:headline_news/common/failure.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/domain/repositories/article_repository.dart';

class GetHeadlineBusinessArticles {
  final ArticleRepository repository;

  GetHeadlineBusinessArticles(this.repository);

  Future<Either<Failure, List<Article>>> execute() {
    return repository.getHeadlineBusinessArticles();
  }
}
