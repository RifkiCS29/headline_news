// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:headline_news/common/exception.dart';
import 'package:headline_news/data/datasources/article_remote_data_source.dart';
import 'package:headline_news/data/models/article_response.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'your_api_key';
  const BASE_URL = 'https://newsapi.org/v2/';
  const COUNTRY = 'id';
  const pageSize = 20;

  late ArticleRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ArticleRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('Get Top Headline Articles', () {
    final tArticleList = ArticleResponse.fromJson(
            json.decode(readJson('dummy_data/top_headlines.json')),)
        .articles;

    test('should return list of Article Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('${BASE_URL}top-headlines?country=$COUNTRY&apiKey=$API_KEY&pageSize=10')),)
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/top_headlines.json'), 200,                  
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  },),);
      // act
      final result = await dataSource.getTopHeadlineArticles();
      // assert
      expect(result, equals(tArticleList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('${BASE_URL}top-headlines?country=$COUNTRY&apiKey=$API_KEY&pageSize=10')),)
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopHeadlineArticles();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Headline Business Articles', () {
    final tArticleList =
        ArticleResponse.fromJson(json.decode(readJson('dummy_data/headline_business.json')))
            .articles;

    test('should return list of Articles when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('${BASE_URL}top-headlines?country=$COUNTRY&category=business&apiKey=$API_KEY&pageSize=20')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/headline_business.json'), 200,                   
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  },),);
      // act
      final result = await dataSource.getHeadlineBusinessArticles();
      // assert
      expect(result, tArticleList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('${BASE_URL}top-headlines?country=$COUNTRY&category=business&apiKey=$API_KEY&pageSize=20')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getHeadlineBusinessArticles();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Article Category', () {
    final tArticleList = ArticleResponse.fromJson(
            json.decode(readJson('dummy_data/article_category.json')),)
        .articles;
    const tCategory = 'business';

    test('should return list of Article Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('${BASE_URL}top-headlines?country=$COUNTRY&category=$tCategory&apiKey=$API_KEY&pageSize=30')),)
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/article_category.json'), 200,                   
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  },),);
      // act
      final result = await dataSource.getArticleCategory(tCategory);
      // assert
      expect(result, equals(tArticleList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('${BASE_URL}top-headlines?country=$COUNTRY&category=$tCategory&apiKey=$API_KEY&pageSize=30')),)
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getArticleCategory(tCategory);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Search Articles', () {
    final tSearchResult = ArticleResponse.fromJson(
            json.decode(readJson('dummy_data/search_article.json')),);
    const tQuery = 'bitcoin';
    const tPage = 1;

    test('should return list of Articles when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('${BASE_URL}everything?q=$tQuery&apiKey=$API_KEY&pageSize=$pageSize&page=$tPage')),)
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_article.json'), 200,                   
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  },),);
      // act
      final result = await dataSource.searchArticles(tQuery, tPage);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('${BASE_URL}everything?q=$tQuery&apiKey=$API_KEY&pageSize=$pageSize&page=$tPage')),)
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchArticles(tQuery, tPage);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
