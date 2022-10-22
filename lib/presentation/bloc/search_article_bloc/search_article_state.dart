part of 'search_article_bloc.dart';

abstract class SearchArticleState extends Equatable {
  const SearchArticleState();
  
  @override
  List<Object> get props => [];
}

class SearchArticleInitial extends SearchArticleState {}

class SearchArticleEmpty extends SearchArticleState {
  final String message;
 
  const SearchArticleEmpty(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class SearchArticleLoading extends SearchArticleState {}

class SearchArticleHasData extends SearchArticleState {
  final List<Article> searchResult;
  final int totalResult;
  final int currentPage;
 
  const SearchArticleHasData(
    this.searchResult,
    this.totalResult,
    this.currentPage,
  );
 
  @override
  List<Object> get props => [searchResult, totalResult, currentPage];
}

class SearchArticleError extends SearchArticleState {
  final String message;
 
  const SearchArticleError(this.message);
 
  @override
  List<Object> get props => [message];
}
