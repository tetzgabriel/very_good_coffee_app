import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/image_finder/image_finder.dart';

import '../../../injectable/injectable.dart';
import '../../../mocks/coffee_image_fixture.dart';
import '../../../mocks/mock_get_image.dart';
import '../../../mocks/mock_save_local_image.dart';

void main() {
  setupTestServices();

  final mockGetImage = MockGetImage();
  final mockSaveLocalImage = MockSaveLocalImage();

  late ImageFinderBloc sut;

  setUp(() {
    sut = ImageFinderBloc(
      getImage: mockGetImage,
      saveLocalImage: mockSaveLocalImage,
    );

    when(mockGetImage.call).thenAnswer(
      (_) async => Right(
        CoffeeImageFixture.model,
      ),
    );

    when(() => mockSaveLocalImage.call(image: CoffeeImageFixture.model))
        .thenAnswer(
      (_) => Future<void>(() => null),
    );
  });

  blocTest<ImageFinderBloc, ImageFinderState>(
    'Emits ImageFinderStateLoaded when GetImage succeeds',
    build: () => sut,
    act: (controller) => sut..add(const GetImageEvent()),
    expect: () => [
      const ImageFinderStateLoading(),
      ImageFinderStateLoaded(image: CoffeeImageFixture.model)
    ],
    verify: (_) {
      verify(mockGetImage.call).called(1);
    },
  );

  blocTest<ImageFinderBloc, ImageFinderState>(
    'Emits ImageFinderStateError when GetImage fails',
    build: () {
      when(mockGetImage.call).thenAnswer(
        (_) async => const Left(
          'failure',
        ),
      );

      return sut;
    },
    act: (controller) => sut.add(const GetImageEvent()),
    expect: () => [
      const ImageFinderStateLoading(),
      const ImageFinderStateError(error: 'failure')
    ],
    verify: (_) {
      verify(mockGetImage.call).called(1);
    },
  );

  blocTest<ImageFinderBloc, ImageFinderState>(
    'Calls usecase when saveLocalImage is called',
    build: () => sut,
    act: (controller) => sut.add(SaveLocalImageEvent(CoffeeImageFixture.model)),
    expect: () => <ImageFinderState>[],
    verify: (_) {
      verify(() => mockSaveLocalImage.call(image: CoffeeImageFixture.model))
          .called(1);
    },
  );
}
