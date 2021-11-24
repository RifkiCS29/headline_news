import 'package:equatable/equatable.dart';
import 'package:headline_news/data/models/article_model.dart';
import 'package:headline_news/domain/entities/article.dart';

class ArticleTable extends Equatable {
  final String title;
  final String? description;
  final String? url;
  final String? urlToImage;

  ArticleTable({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
  });

  factory ArticleTable.fromEntity(Article article) => ArticleTable(
    title: article.title,
    description: article.description,
    url: article.url,
    urlToImage: article.urlToImage,
  );

  factory ArticleTable.fromMap(Map<String, dynamic> map) => ArticleTable(
    title: map['title'],
    description: map['description'],
    url: map['url'],
    urlToImage: map['urlToImage'],
  );

  factory ArticleTable.fromDTO(ArticleModel article) => ArticleTable(
    title: article.title,
    description: article.description,
    url: article.url,
    urlToImage: article.urlToImage,
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'url': url,
    'urlToImage': urlToImage,
  };

  Article toEntity() => Article.watchlist(
    title: title,
    description: description,
    url: url,
    urlToImage: urlToImage,
  );

  @override
  List<Object?> get props => [
    title,
    description,
    url,
    urlToImage,
  ];
}