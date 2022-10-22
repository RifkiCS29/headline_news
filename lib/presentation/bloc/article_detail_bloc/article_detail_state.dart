part of 'article_detail_bloc.dart';

class ArticleDetailState extends Equatable {
  final String bookmarkMessage;
  final bool isAddedToBookmark;

  const ArticleDetailState({
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
    return const ArticleDetailState(
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
