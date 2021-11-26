import 'package:equatable/equatable.dart';
import 'package:headline_news/data/models/article_model.dart';
import 'package:headline_news/domain/entities/article.dart';

class ArticleTable extends Equatable {
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  ArticleTable({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ArticleTable.fromEntity(Article article) => ArticleTable(
    author: article.author,
    title: article.title,
    description: article.description,
    url: article.url,
    urlToImage: article.urlToImage,
    publishedAt: article.publishedAt,
    content: article.content,
  );

  factory ArticleTable.fromMap(Map<String, dynamic> map) => ArticleTable(
    author: map['author'],
    title: map['title'],
    description: map['description'],
    url: map['url'],
    urlToImage: map['urlToImage'],
    publishedAt: DateTime.parse(map['publishedAt']),
    content: map['content'],
  );

  factory ArticleTable.fromDTO(ArticleModel article) => ArticleTable(
    author: article.author,
    title: article.title,
    description: article.description,
    url: article.url,
    urlToImage: article.urlToImage,
    publishedAt: article.publishedAt,
    content: article.content,
  );

  Map<String, dynamic> toJson() => {
    'author': author,
    'title': title,
    'description': description,
    'url': url,
    'urlToImage': urlToImage,
    'publishedAt': publishedAt?.toIso8601String(),
    'content': content,
  };

  Article toEntity() => Article.bookmark(
    author: author,
    title: title,
    description: description,
    url: url,
    urlToImage: urlToImage,
    publishedAt: publishedAt,
    content: content,
  );

  @override
  List<Object?> get props => [
    author,
    title,
    description,
    url,
    urlToImage,
    publishedAt,
    content,
  ];
}