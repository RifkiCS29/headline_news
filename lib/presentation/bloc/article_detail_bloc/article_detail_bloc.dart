import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/domain/usecases/get_bookmark_status.dart';
import 'package:headline_news/domain/usecases/remove_bookmark_article.dart';
import 'package:headline_news/domain/usecases/save_bookmark_article.dart';

part 'article_detail_event.dart';
part 'article_detail_state.dart';

class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  final GetBookmarkStatus getBookmarkStatus;
  final SaveBookmarkArticle saveBookmarkArticle;
  final RemoveBookmarkArticle removeBookmarkArticle;

  static const bookmarkAddSuccessMessage = 'Added to Bookmark';
  static const bookmarkRemoveSuccessMessage = 'Removed from Bookmark';

  ArticleDetailBloc({
    required this.getBookmarkStatus,
    required this.saveBookmarkArticle,
    required this.removeBookmarkArticle,
  }) : super(ArticleDetailState.initial()) {
    on<AddToBookmark>((event, emit) async {
      final result = await saveBookmarkArticle.execute(event.article);

      await result.fold(
        (failure) {
          emit(state.copyWith(bookmarkMessage: failure.message));
        },
        (successMessage) {
          emit(state.copyWith(bookmarkMessage: successMessage));
        }
      );

      add(LoadBookmarkStatus(event.article.url));

    });
    on<RemoveFromBookmark>((event, emit) async {
      final result = await removeBookmarkArticle.execute(event.article);

      await result.fold(
        (failure) {
          emit(state.copyWith(bookmarkMessage: failure.message));
        },
        (successMessage) {
          emit(state.copyWith(bookmarkMessage: successMessage));
        }
      );

      add(LoadBookmarkStatus(event.article.url));
      
    });
    on<LoadBookmarkStatus>((event, emit) async {
      final result = await getBookmarkStatus.execute(event.url);
      emit(state.copyWith(isAddedToBookmark: result));
    });
  }
}
