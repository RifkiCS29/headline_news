part of 'search_article_bloc.dart';

abstract class SearchArticleState extends Equatable {
  const SearchArticleState();
  
  @override
  List<Object> get props => [];
}

class SearchArticleEmpty extends SearchArticleState {
  final String message;
 
  SearchArticleEmpty(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class SearchArticleLoading extends SearchArticleState {}

class SearchArticleHasData extends SearchArticleState {
  final List<Article> searchResult;
 
  SearchArticleHasData(this.searchResult);
 
  @override
  List<Object> get props => [searchResult];
}

class SearchArticleError extends SearchArticleState {
  final String message;
 
  SearchArticleError(this.message);
 
  @override
  List<Object> get props => [message];
}
