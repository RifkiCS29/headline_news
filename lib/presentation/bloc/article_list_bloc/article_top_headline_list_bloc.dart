part of 'article_list_bloc.dart';

class ArticleTopHeadlineListBloc extends Bloc<ArticleListEvent, ArticleListState> {
  final GetTopHeadlineArticles getTopHeadlineArticles; 
  ArticleTopHeadlineListBloc(this.getTopHeadlineArticles) : super(ArticleListEmpty()) {
    on<ArticleListEvent>((event, emit) async {
      emit(ArticleListLoading());
      final result = await getTopHeadlineArticles.execute();
      result.fold(
        (failure) => emit(ArticleListError(failure.message)),
        (articlesData) { 
          emit(ArticleListLoaded(articlesData));
          if(articlesData.isEmpty) {
            emit(ArticleListEmpty());
          }
        }
      );
    });
  }
}