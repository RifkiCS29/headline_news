part of 'article_list_bloc.dart';

abstract class ArticleListState extends Equatable {
  const ArticleListState();
  
  @override
  List<Object> get props => [];
}

class ArticleListEmpty extends ArticleListState {}

class ArticleListLoading extends ArticleListState {}

class ArticleListLoaded extends ArticleListState {
  final List<Article> articles;

  ArticleListLoaded(this.articles);

  @override
  List<Object> get props => [articles];
}

class ArticleListError extends ArticleListState {
  final String message;

  ArticleListError(this.message);

  @override
  List<Object> get props => [message];
}
