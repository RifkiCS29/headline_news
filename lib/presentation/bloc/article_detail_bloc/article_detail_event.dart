part of 'article_detail_bloc.dart';

abstract class ArticleDetailEvent extends Equatable {
  const ArticleDetailEvent();

  @override
  List<Object> get props => [];
}

class AddToBookmark extends ArticleDetailEvent {
  final Article article;

  const AddToBookmark(this.article);

  @override
  List<Object> get props => [article];
}

class RemoveFromBookmark extends ArticleDetailEvent {
  final Article article;

  const RemoveFromBookmark(this.article);

  @override
  List<Object> get props => [article];
}

class LoadBookmarkStatus extends ArticleDetailEvent {
  final String url;

  const LoadBookmarkStatus(this.url);

  @override
  List<Object> get props => [url];
}