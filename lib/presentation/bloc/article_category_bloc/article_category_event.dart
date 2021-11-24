part of 'article_category_bloc.dart';

abstract class ArticleCategoryEvent extends Equatable {
  const ArticleCategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchArticleCategory extends ArticleCategoryEvent {
  final String category;
 
  FetchArticleCategory(this.category);
 
  @override
  List<Object> get props => [category];
}