import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/favorites/data/datasources/local_image_datasource.dart';
import 'package:very_good_coffee_app/favorites/data/repositories/local_image_repository_impl.dart';
import 'package:very_good_coffee_app/favorites/domain/repositories/local_image_repository.dart';

import '../../../mocks/coffee_image_fixture.dart';

class MockLocalImageDatasource extends Mock implements LocalImageDatasource {}

final MockLocalImageDatasource mockLocalImageDatasource =
    MockLocalImageDatasource();
final LocalImageRepository localImageRepository =
    LocalImageRepositoryImpl(mockLocalImageDatasource);

void main() {
  group('Get local images', () {
    test('Repository should return a list of Coffee Images', () async {
      when(mockLocalImageDatasource.getLocalImages)
          .thenAnswer((_) async => CoffeeImageFixture.list);

      final result = await localImageRepository.getLocalImages();
      verify(mockLocalImageDatasource.getLocalImages);
      expect(result.isRight(), true);
    });

    test('Repository should return an Error', () async {
      when(mockLocalImageDatasource.getLocalImages).thenThrow(Exception());

      final result = await localImageRepository.getLocalImages();
      verify(mockLocalImageDatasource.getLocalImages).called(1);
      expect(result.isLeft(), true);
    });
  });

  group('Save local image', () {
    test('Repository should save an image', () async {
      when(
        () => mockLocalImageDatasource.saveLocalImage(
          image: CoffeeImageFixture.model,
        ),
      ).thenAnswer((_) => Future(() => null));

      await localImageRepository.saveLocalImage(
        image: CoffeeImageFixture.model,
      );

      verify(
        () => mockLocalImageDatasource.saveLocalImage(
          image: CoffeeImageFixture.model,
        ),
      ).called(1);
    });

    test('Repository should return an Error', () async {
      when(
        () => mockLocalImageDatasource.saveLocalImage(
          image: CoffeeImageFixture.model,
        ),
      ).thenThrow(Exception());

      expect(
        () => localImageRepository.saveLocalImage(
          image: CoffeeImageFixture.model,
        ),
        throwsException,
      );
    });
  });
}
