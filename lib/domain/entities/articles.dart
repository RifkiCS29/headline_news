import 'package:equatable/equatable.dart';
import 'package:headline_news/domain/entities/article.dart';

class Articles extends Equatable {
    final String? status;
    final int? totalResults;
    final List<Article>? articles;

    const Articles({
      this.status,
      this.totalResults,
      this.articles,
    });

    @override
    List<Object?> get props => [
      status,
      totalResults,
      articles,
    ];
}