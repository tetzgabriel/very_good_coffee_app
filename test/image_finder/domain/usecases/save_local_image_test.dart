import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/favorites/domain/repositories/local_image_repository.dart';
import 'package:very_good_coffee_app/image_finder/domain/usecases/save_local_image.dart';

import '../../../mocks/coffee_image_fixture.dart';

class MockLocalImageRepository extends Mock implements LocalImageRepository {}

final MockLocalImageRepository mockLocalImageRepository =
    MockLocalImageRepository();
final SaveLocalImage usecase = SaveLocalImage(mockLocalImageRepository);

void main() {
  test('Use case should call repository', () async {
    when(
      () => mockLocalImageRepository.saveLocalImage(
        image: CoffeeImageFixture.model,
      ),
    ).thenAnswer((_) => Future(() => null));

    await usecase.call(image: CoffeeImageFixture.model);

    verify(
      () => mockLocalImageRepository.saveLocalImage(
        image: CoffeeImageFixture.model,
      ),
    ).called(1);
  });

  test('Use case should return void', () async {
    when(
      () => mockLocalImageRepository.saveLocalImage(
        image: CoffeeImageFixture.model,
      ),
    ).thenAnswer((_) => Future(() => null));

    await usecase.call(image: CoffeeImageFixture.model);

    expect(
      () async => usecase.call(image: CoffeeImageFixture.model),
      isA<void>(),
    );
  });
}
