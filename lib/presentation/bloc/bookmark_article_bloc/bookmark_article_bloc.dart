import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/domain/usecases/get_bookmark_articles.dart';

part 'bookmark_article_event.dart';
part 'bookmark_article_state.dart';

class BookmarkArticleBloc extends Bloc<BookmarkArticleEvent, BookmarkArticleState> {
  final GetBookmarkArticles _getBookmarkArticles;
  BookmarkArticleBloc(this._getBookmarkArticles) : super(BookmarkArticleEmpty('')) {
    on<BookmarkArticleEvent>((event, emit) async {
      emit(BookmarkArticleLoading());
      final result = await _getBookmarkArticles.execute();
      result.fold(
        (failure) => emit(BookmarkArticleError(failure.message)),
        (articlesData) { 
          emit(BookmarkArticleHasData(articlesData));
          if(articlesData.isEmpty) {
            emit(BookmarkArticleEmpty('You haven\'t added a bookmark'));
          }
        }
      );
    });
  }
}
