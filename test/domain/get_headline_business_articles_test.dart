import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/domain/usecases/get_headline_business_articles.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetHeadlineBusinessArticles usecase;
  late MockArticleRepository mockArticleRpository;

  setUp(() {
    mockArticleRpository = MockArticleRepository();
    usecase = GetHeadlineBusinessArticles(mockArticleRpository);
  });

  final tArticles = <Article>[];

  group('Get Headline Business Articles Tests', () {
    group('execute', () {
      test(
          'should get list of Articles from the repository when execute function is called',
          () async {
        // arrange
        when(mockArticleRpository.getHeadlineBusinessArticles())
            .thenAnswer((_) async => Right(tArticles));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tArticles));
      });
    });
  });
}