import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/domain/usecases/search_articles.dart';
import 'package:rxdart/rxdart.dart';

part 'search_article_event.dart';
part 'search_article_state.dart';

class SearchArticleBloc extends Bloc<SearchArticleEvent, SearchArticleState> {
  final SearchArticles _searchArticles;
  List<Article> articles = [];
  SearchArticleBloc(this._searchArticles) : super(SearchArticleInitial()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      if(query.isEmpty) {
        emit(SearchArticleInitial());
      } else {
        emit(SearchArticleLoading());
        final result = await _searchArticles.execute(query);
        result.fold(
          (failure) => emit(SearchArticleError(failure.message)),
          (articlesData) { 
            articles = articlesData.articles;
            emit(SearchArticleHasData(articlesData.articles, articlesData.totalResults, 1));
            if(articlesData.articles.isEmpty) {
              emit(const SearchArticleEmpty('No Result Found'));
            }
          }
        );
      }
    }, transformer: debounce(const Duration(milliseconds: 500)),);
    on<OnNextPage>((event, emit) async {
      final query = event.query;
      final page = event.page + 1;
      if(query.isEmpty) {
        emit(SearchArticleInitial());
      } else {
        final result = await _searchArticles.execute(query, page: page);
        result.fold(
          (failure) => emit(SearchArticleError(failure.message)),
          (articleData) {
            articles.addAll(articleData.articles);
            emit(SearchArticleHasData(articles, articleData.totalResults, page));
            if (articleData.articles.isEmpty) {
              emit(const SearchArticleEmpty('No Result Found'));
            }
          }
        );
      }
    }, transformer: droppable(),);
  }
}

EventTransformer<MyEvent> debounce<MyEvent>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
