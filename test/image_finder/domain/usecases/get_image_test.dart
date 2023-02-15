import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/image_finder/domain/repositories/image_repository.dart';
import 'package:very_good_coffee_app/image_finder/domain/usecases/get_image.dart';

import '../../../mocks/coffee_image_fixture.dart';

class MockImageRepository extends Mock implements ImageRepository {}

final MockImageRepository mockImageRepository = MockImageRepository();
final GetImage usecase = GetImage(mockImageRepository);

void main() {
  test('Use case should call repository and return a Coffee Image', () async {
    when(mockImageRepository.getImage)
        .thenAnswer((_) async => Right(CoffeeImageFixture.model));

    final result = await usecase.call();

    verify(mockImageRepository.getImage).called(1);
    expect(result.isRight(), true);
  });
}
