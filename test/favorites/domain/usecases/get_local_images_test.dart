import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/favorites/domain/repositories/local_image_repository.dart';
import 'package:very_good_coffee_app/favorites/domain/usecases/get_local_images.dart';

import '../../../mocks/coffee_image_fixture.dart';

class MockLocalImageRepository extends Mock implements LocalImageRepository {}

final MockLocalImageRepository mockLocalImageRepository =
    MockLocalImageRepository();
final GetLocalImages usecase = GetLocalImages(mockLocalImageRepository);

void main() {
  test('Use case should call repository and return a list of Coffee Images',
      () async {
    when(mockLocalImageRepository.getLocalImages)
        .thenAnswer((_) async => Right(CoffeeImageFixture.list));

    final result = await usecase.call();

    verify(mockLocalImageRepository.getLocalImages).called(1);
    expect(result.isRight(), true);
  });
}
