import 'package:equatable/equatable.dart';
import 'package:headline_news/data/models/article_model.dart';
import 'package:headline_news/domain/entities/articles.dart';

class ArticleResponse extends Equatable {
  final String? status;
  final int? totalResults;
  final List<ArticleModel>? articles;

  const ArticleResponse({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory ArticleResponse.fromJson(Map<String, dynamic> json) =>
      ArticleResponse(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: json["articles"] == null
            ? null
            : List<ArticleModel>.from(
                json["articles"].map((x) => ArticleModel.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": articles == null
            ? null
            : List<dynamic>.from(articles!.map((x) => x.toJson())),
      };

  Articles toEntity() {
    return Articles(
      status: status,
      totalResults: totalResults,
      articles:
          articles == null ? null : articles!.map((x) => x.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        status,
        totalResults,
        articles,
      ];
}
