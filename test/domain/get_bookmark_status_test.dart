import 'package:flutter_test/flutter_test.dart';
import 'package:headline_news/domain/usecases/get_bookmark_status.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetBookmarkStatus usecase;
  late MockArticleRepository mockArticleRepository;

  setUp(() {
    mockArticleRepository = MockArticleRepository();
    usecase = GetBookmarkStatus(mockArticleRepository);
  });

  test('should get Bookmark status from repository', () async {
    // arrange
    when(mockArticleRepository.isAddedToBookmarkArticle('url'))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute('url');
    // assert
    expect(result, true);
  });
}