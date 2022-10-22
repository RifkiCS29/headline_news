import 'package:equatable/equatable.dart';
import 'package:headline_news/data/models/article_model.dart';
import 'package:headline_news/domain/entities/articles.dart';

class ArticleResponse extends Equatable {
  final int totalResults;
  final List<ArticleModel> articles;

  const ArticleResponse({
    required this.totalResults,
    required this.articles,
  });

  factory ArticleResponse.fromJson(Map<String, dynamic> json) => ArticleResponse(
    totalResults: json['totalResults'],
    articles: List<ArticleModel>.from((json["articles"] as List)
      .map((x) => ArticleModel.fromJson(x))
      .where((article) => 
        article.urlToImage != null &&
        article.publishedAt != null,),),
  );

  Map<String, dynamic> toJson() => {
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles.map((x) => x.toJson()))
  };

  Articles toEntity() {
    return Articles(
      totalResults: totalResults,
      articles: articles.map((article) => article.toEntity()).toList(),
    );
  } 

  @override
  List<Object?> get props => [
    totalResults,
    articles
  ];
}