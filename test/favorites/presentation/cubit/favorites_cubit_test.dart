import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/favorites/presentation/cubit/favorites_cubit.dart';

import '../../../injectable/injectable.dart';
import '../../../mocks/coffee_image_fixture.dart';
import '../../../mocks/mock_get_local_images.dart';

void main() {
  setupTestServices();

  final mockGetLocalImages = MockGetLocalImages();

  late FavoritesCubit sut;

  setUp(() {
    sut = FavoritesCubit(
      getLocalImages: mockGetLocalImages,
    );

    when(mockGetLocalImages.call).thenAnswer(
      (_) async => Right(
        CoffeeImageFixture.list,
      ),
    );
  });

  blocTest(
    'Emits FavoritesStateLoaded when GetLocalImages succeeds',
    build: () => sut,
    act: (controller) => sut.getLocalImages(),
    expect: () => [
      const FavoritesStateLoading(),
      FavoritesStateLoaded(images: CoffeeImageFixture.list)
    ],
    verify: (_) {
      verify(mockGetLocalImages.call).called(1);
    },
  );

  blocTest(
    'Emits FavoritesStateError when GetLocalImages fails',
    build: () {
      when(mockGetLocalImages.call).thenAnswer(
        (_) async => const Left(
          'failure',
        ),
      );

      return sut;
    },
    act: (controller) => sut.getLocalImages(),
    expect: () => [
      const FavoritesStateLoading(),
      const FavoritesStateError(error: 'failure')
    ],
    verify: (_) {
      verify(mockGetLocalImages.call).called(1);
    },
  );
}
