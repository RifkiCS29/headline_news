part of 'article_category_bloc.dart';

abstract class ArticleCategoryState extends Equatable {
  const ArticleCategoryState();
  
  @override
  List<Object> get props => [];
}

class ArticleCategoryEmpty extends ArticleCategoryState {
  final String message;
 
  ArticleCategoryEmpty(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class ArticleCategoryLoading extends ArticleCategoryState {}

class ArticleCategoryHasData extends ArticleCategoryState {
  final List<Article> articles;
 
  ArticleCategoryHasData(this.articles);
 
  @override
  List<Object> get props => [articles];
}

class ArticleCategoryError extends ArticleCategoryState {
  final String message;
 
  ArticleCategoryError(this.message);
 
  @override
  List<Object> get props => [message];
}

