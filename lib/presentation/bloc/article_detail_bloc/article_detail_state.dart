part of 'article_detail_bloc.dart';

class ArticleDetailState extends Equatable {
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  ArticleDetailState({
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  ArticleDetailState copyWith({
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return ArticleDetailState(
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  factory ArticleDetailState.initial() {
    return ArticleDetailState(
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }

  @override
  List<Object> get props => [
    watchlistMessage, 
    isAddedToWatchlist
  ];
}
