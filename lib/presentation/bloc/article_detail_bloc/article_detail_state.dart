part of 'article_detail_bloc.dart';

class ArticleDetailState extends Equatable {
  final String bookmarkMessage;
  final bool isAddedToBookmark;

  ArticleDetailState({
    required this.bookmarkMessage,
    required this.isAddedToBookmark,
  });

  ArticleDetailState copyWith({
    String? bookmarkMessage,
    bool? isAddedToBookmark,
  }) {
    return ArticleDetailState(
      bookmarkMessage: bookmarkMessage ?? this.bookmarkMessage,
      isAddedToBookmark: isAddedToBookmark ?? this.isAddedToBookmark,
    );
  }

  factory ArticleDetailState.initial() {
    return ArticleDetailState(
      bookmarkMessage: '',
      isAddedToBookmark: false,
    );
  }

  @override
  List<Object> get props => [
    bookmarkMessage, 
    isAddedToBookmark
  ];
}
