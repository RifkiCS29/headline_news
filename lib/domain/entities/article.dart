import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Article extends Equatable { 
  Article({
     this.author,
     this.title,
     this.description,
     this.url,
     this.urlToImage,
     this.publishedAt,
     this.content,
  });

  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;
  
  Article.bookmark({
     this.author,
     this.title,
     this.description,
     this.url,
     this.urlToImage,
     this.publishedAt,
     this.content,
  });

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