part of 'bookmark_article_bloc.dart';

abstract class BookmarkArticleState extends Equatable {
  const BookmarkArticleState();

  @override
  List<Object> get props => [];
}

class BookmarkArticleEmpty extends BookmarkArticleState {
  final String message;

  const BookmarkArticleEmpty(this.message);

  @override
  List<Object> get props => [message];
}

class BookmarkArticleLoading extends BookmarkArticleState {}

class BookmarkArticleError extends BookmarkArticleState {
  final String message;

  const BookmarkArticleError(this.message);

  @override
  List<Object> get props => [message];
}

class BookmarkArticleHasData extends BookmarkArticleState {
  final List<Article> bookmarkArticle;

  const BookmarkArticleHasData(this.bookmarkArticle);

  @override
  List<Object> get props => [bookmarkArticle];
}
