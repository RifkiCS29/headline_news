import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:headline_news/data/datasources/article_remote_data_source.dart';
import 'package:headline_news/data/repositories/article_repository_impl.dart';
import 'package:headline_news/domain/repositories/article_repository.dart';
import 'package:headline_news/domain/usecases/get_article_category.dart';
import 'package:headline_news/domain/usecases/get_bookmark_articles.dart';
import 'package:headline_news/domain/usecases/get_bookmark_status.dart';
import 'package:headline_news/domain/usecases/get_headline_business_articles.dart';
import 'package:headline_news/domain/usecases/get_top_headline_articles.dart';
import 'package:headline_news/domain/usecases/remove_bookmark_article.dart';
import 'package:headline_news/domain/usecases/save_bookmark_article.dart';
import 'common/http_ssl_pinning.dart';
import 'common/network_info.dart';
import 'data/datasources/article_local_data_source.dart';
import 'data/datasources/db/database_helper.dart';
import 'domain/usecases/search_articles.dart';
import 'presentation/bloc/article_category_bloc/article_category_bloc.dart';
import 'presentation/bloc/article_detail_bloc/article_detail_bloc.dart';
import 'presentation/bloc/article_list_bloc/article_list_bloc.dart';
import 'presentation/bloc/bookmark_article_bloc/bookmark_article_bloc.dart';
import 'presentation/bloc/search_article_bloc/search_article_bloc.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(
    () => ArticleTopHeadlineListBloc(
      locator(),
    )
  );
  locator.registerFactory(
    () => ArticleHeadlineBusinessListBloc(
      locator(),
    )
  );
  locator.registerFactory(
    () => ArticleCategoryBloc(
      locator(),
    )
  );
  locator.registerFactory(
    () => SearchArticleBloc(
      locator(),
    )
  );
  locator.registerFactory(
    () => BookmarkArticleBloc(
      locator(),
    )
  );
  locator.registerFactory(
    () => ArticleDetailBloc(
      getBookmarkStatus: locator(),
      saveBookmarkArticle: locator(),
      removeBookmarkArticle: locator(),
    )
  );

  //usecase
  locator.registerLazySingleton(() => GetTopHeadlineArticles(locator()));
  locator.registerLazySingleton(() => GetHeadlineBusinessArticles(locator()));
  locator.registerLazySingleton(() => GetArticleCategory(locator()));
  locator.registerLazySingleton(() => SearchArticles(locator()));
  locator.registerLazySingleton(() => GetBookmarkArticles(locator()));
  locator.registerLazySingleton(() => GetBookmarkStatus(locator()));
  locator.registerLazySingleton(() => SaveBookmarkArticle(locator()));
  locator.registerLazySingleton(() => RemoveBookmarkArticle(locator()));

  //repository
  locator.registerLazySingleton<ArticleRepository>(
    () => ArticleRepositoryImpl(
      remoteDataSource: locator(), 
      localDataSource: locator(), 
      networkInfo: locator()
    ),
  );

  //data source
  locator.registerLazySingleton<ArticleRemoteDataSource>(
    () => ArticleRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<ArticleLocalDataSource>(
    () => ArticleLocalDataSourceImpl(databaseHelper: locator()),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
  locator.registerLazySingleton(() => DataConnectionChecker());
}