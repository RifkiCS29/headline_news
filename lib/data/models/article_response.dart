import 'package:equatable/equatable.dart';
import 'package:headline_news/data/models/article_model.dart';

class ArticleResponse extends Equatable {
  final List<ArticleModel> articles;

  ArticleResponse({required this.articles});

  factory ArticleResponse.fromJson(Map<String, dynamic> json) => ArticleResponse(
    articles: List<ArticleModel>.from((json["articles"] as List)
      .map((x) => ArticleModel.fromJson(x))
      .where((article) => 
        article.author != null &&
        article.description != null &&
        article.urlToImage != null &&
        article.publishedAt != null &&
        article.content != null)),
  );

  Map<String, dynamic> toJson() => {
    "articles": List<dynamic>.from(articles.map((x) => x.toJson()))
  };

  @override
  List<Object?> get props => [articles];
}