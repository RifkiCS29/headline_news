import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/domain/usecases/search_articles.dart';
import 'package:rxdart/src/transformers/backpressure/debounce.dart';
import 'package:rxdart/src/transformers/flat_map.dart';

part 'search_article_event.dart';
part 'search_article_state.dart';

class SearchArticleBloc extends Bloc<SearchArticleEvent, SearchArticleState> {
  final SearchArticles _searchArticles;
  SearchArticleBloc(this._searchArticles) : super(SearchArticleEmpty('')) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      emit(SearchArticleLoading());
      final result = await _searchArticles.execute(query);
      result.fold(
        (failure) => emit(SearchArticleError(failure.message)),
        (articlesData) { 
          emit(SearchArticleHasData(articlesData));
          if(articlesData.isEmpty) {
            emit(SearchArticleEmpty('No Result Found'));
          }
        }
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<MyEvent> debounce<MyEvent>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
