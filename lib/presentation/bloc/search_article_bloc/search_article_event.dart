part of 'search_article_bloc.dart';

abstract class SearchArticleEvent extends Equatable {
  const SearchArticleEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends SearchArticleEvent {
  final String query;
 
  OnQueryChanged(this.query);
 
  @override
  List<Object> get props => [query];
}
