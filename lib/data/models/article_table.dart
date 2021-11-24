import 'package:equatable/equatable.dart';
import 'package:headline_news/data/models/article_model.dart';
import 'package:headline_news/domain/entities/article.dart';

class ArticleTable extends Equatable {
  final String? author;
  final String title;
  final String? description;
  final String? url;
  final String? urlToImage;

  ArticleTable({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
  });

  factory ArticleTable.fromEntity(Article article) => ArticleTable(
    author: article.author,
    title: article.title,
    description: article.description,
    url: article.url,
    urlToImage: article.urlToImage,
  );

  factory ArticleTable.fromMap(Map<String, dynamic> map) => ArticleTable(
    author: map['author'],
    title: map['title'],
    description: map['description'],
    url: map['url'],
    urlToImage: map['urlToImage'],
  );

  factory ArticleTable.fromDTO(ArticleModel article) => ArticleTable(
    author: article.author,
    title: article.title,
    description: article.description,
    url: article.url,
    urlToImage: article.urlToImage,
  );

  Map<String, dynamic> toJson() => {
    'author': author,
    'title': title,
    'description': description,
    'url': url,
    'urlToImage': urlToImage,
  };

  Article toEntity() => Article.bookmark(
    author: author,
    title: title,
    description: description,
    url: url,
    urlToImage: urlToImage,
  );

  @override
  List<Object?> get props => [
    author,
    title,
    description,
    url,
    urlToImage,
  ];
}