import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/image_finder/data/datasources/image_datasource.dart';
import 'package:very_good_coffee_app/image_finder/data/repositories/image_repository_impl.dart';
import 'package:very_good_coffee_app/image_finder/domain/repositories/image_repository.dart';

import '../../../mocks/coffee_image_fixture.dart';

class MockImageDatasource extends Mock implements ImageDatasource {}

final MockImageDatasource mockImageDatasource = MockImageDatasource();
final ImageRepository imageRepository =
    ImageRepositoryImpl(mockImageDatasource);

void main() {
  test('Repository should return a CoffeeImage', () async {
    when(mockImageDatasource.getImage)
        .thenAnswer((_) async => CoffeeImageFixture.model);

    final result = await imageRepository.getImage();
    verify(mockImageDatasource.getImage).called(1);
    expect(result.isRight(), true);
  });

  test('Repository should return an Error', () async {
    when(mockImageDatasource.getImage).thenThrow(Exception());

    final result = await imageRepository.getImage();
    verify(mockImageDatasource.getImage).called(1);
    expect(result.isLeft(), true);
  });
}
