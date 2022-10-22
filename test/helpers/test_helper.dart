import 'package:headline_news/common/network_info.dart';
import 'package:headline_news/data/datasources/article_local_data_source.dart';
import 'package:headline_news/data/datasources/article_remote_data_source.dart';
import 'package:headline_news/data/datasources/db/database_helper.dart';
import 'package:headline_news/domain/repositories/article_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  ArticleRepository,
  ArticleRemoteDataSource,
  ArticleLocalDataSource,
  NetworkInfo,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
],)
void main() {}