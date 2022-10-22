import 'package:equatable/equatable.dart';
import 'package:headline_news/domain/entities/article.dart';

// ignore: must_be_immutable
class Articles extends Equatable { 
  Articles({
    required this.totalResults,
    required this.articles,
  });

  int totalResults;
  List<Article> articles;

  @override
  List<Object?> get props => [
    totalResults,
    articles
  ];
}