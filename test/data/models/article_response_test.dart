import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:headline_news/data/models/article_model.dart';
import 'package:headline_news/data/models/article_response.dart';

import '../../json_reader.dart';

void main() {
  final tArticleModel = ArticleModel(
      author: "Ramdani Bur",
      title:
          "Media Vietnam Bahas Potensi Timnas Indonesia Menang 7-0 atas Thailand di Leg II Final Piala AFF 2020 - Bola Okezone",
      description:
          "Timnas Indonesia masih berpeluang juara Piala AFF 2020 meski kalah 0-4 dari Thailand di leg I final Piala AFF 2020.",
      url:
          "https://bola.okezone.com/read/2022/01/01/51/2525849/media-vietnam-bahas-potensi-timnas-indonesia-menang-7-0-atas-thailand-di-leg-ii-final-piala-aff-2020",
      urlToImage:
          "https://img.okezone.com/content/2022/01/01/51/2525849/media-vietnam-bahas-potensi-timnas-indonesia-menang-7-0-atas-thailand-di-leg-ii-final-piala-aff-2020-v3wX2YYZHs.jpg",
      publishedAt: DateTime.parse("2022-01-01T01:28:39Z"),
      content:
          "MEDIA Vietnam, Soha.vn, membahas potensi Timnas Indonesia menang 7-0 atas Thailand di leg II final Piala AFF 2020, Sabtu (1/1/2022) pukul 19.30 WIB. Mereka menulis artikel dengan judul Fans Indonesia… [+1977 chars]",);

  final tArticleResponseModel =
      ArticleResponse(
        totalResults: 38,
        articles: <ArticleModel>[tArticleModel],
    );
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/top_headlines.json'));
      // act
      final result = ArticleResponse.fromJson(jsonMap);
      // assert
      expect(result, tArticleResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tArticleResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "totalResults": 38,
        "articles": [
          {
            "author": "Ramdani Bur",
            "title": "Media Vietnam Bahas Potensi Timnas Indonesia Menang 7-0 atas Thailand di Leg II Final Piala AFF 2020 - Bola Okezone",
            "description": "Timnas Indonesia masih berpeluang juara Piala AFF 2020 meski kalah 0-4 dari Thailand di leg I final Piala AFF 2020.",
            "url": "https://bola.okezone.com/read/2022/01/01/51/2525849/media-vietnam-bahas-potensi-timnas-indonesia-menang-7-0-atas-thailand-di-leg-ii-final-piala-aff-2020",
            "urlToImage": "https://img.okezone.com/content/2022/01/01/51/2525849/media-vietnam-bahas-potensi-timnas-indonesia-menang-7-0-atas-thailand-di-leg-ii-final-piala-aff-2020-v3wX2YYZHs.jpg",
            "publishedAt": "2022-01-01T01:28:39.000Z",
            "content": "MEDIA Vietnam, Soha.vn, membahas potensi Timnas Indonesia menang 7-0 atas Thailand di leg II final Piala AFF 2020, Sabtu (1/1/2022) pukul 19.30 WIB. Mereka menulis artikel dengan judul Fans Indonesia… [+1977 chars]"
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
