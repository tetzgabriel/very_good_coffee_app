import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/favorites/data/datasources/local_image_datasource.dart';
import 'package:very_good_coffee_app/image_finder/domain/entities/coffee_image.dart';

import '../../../app/core/mock_preferences_storage.dart';
import '../../../mocks/coffee_image_fixture.dart';

void main() {
  final preferencesStorage = MockPreferencesStorage();
  final LocalImageDatasource localImageDatasource = LocalImageDatasourceImpl(
    preferencesStorage: preferencesStorage,
  );

  test('LocalImageDatasource should return list of coffeeImages', () async {
    when(preferencesStorage.init).thenAnswer((_) => Future(() => null));

    when(() => preferencesStorage.getStringList('coffee_images')).thenAnswer(
      (_) =>
          ['{"file":"https://coffee.alexflipnote.dev/i2qIDQ5lGMo_coffee.png"}'],
    );

    final result = await localImageDatasource.getLocalImages();
    expect(result, isA<List<CoffeeImage>>());
  });

  test('LocalImageDatasource should return empty list', () async {
    when(preferencesStorage.init).thenAnswer((_) => Future(() => null));

    when(() => preferencesStorage.getStringList('coffee_images')).thenAnswer(
      (_) => null,
    );

    final result = await localImageDatasource.getLocalImages();
    expect(result, isEmpty);
  });

  test('LocalImageDatasource should save image in null storage', () async {
    final initialList = <CoffeeImage>[CoffeeImageFixture.model];

    final listToSave =
        initialList.map((item) => jsonEncode(item.toJson())).toList();

    when(preferencesStorage.init).thenAnswer((_) => Future(() => null));

    when(() => preferencesStorage.getStringList('coffee_images')).thenAnswer(
      (_) => null,
    );

    when(() => preferencesStorage.setStringList('coffee_images', listToSave))
        .thenAnswer(
      (_) => Future(() => null),
    );

    await localImageDatasource.saveLocalImage(
      image: CoffeeImageFixture.model,
    );
    verify(() => preferencesStorage.setStringList('coffee_images', listToSave))
        .called(1);
  });

  test('LocalImageDatasource should save image in populated storage', () async {
    final initialList = <CoffeeImage>[
      CoffeeImageFixture.model,
      CoffeeImageFixture.model
    ];

    final listToSave =
        initialList.map((item) => jsonEncode(item.toJson())).toList();

    when(preferencesStorage.init).thenAnswer((_) => Future(() => null));

    when(() => preferencesStorage.getStringList('coffee_images')).thenAnswer(
      (_) =>
          ['{"file":"https://test.com"}'],
    );

    when(() => preferencesStorage.setStringList('coffee_images', listToSave))
        .thenAnswer(
      (_) => Future(() => null),
    );

    await localImageDatasource.saveLocalImage(
      image: CoffeeImageFixture.model,
    );

    verify(() => preferencesStorage.setStringList('coffee_images', listToSave))
        .called(1);
  });

  // test('Image datasource should return error', () async {
  //   final mockSuccessResponse = Response(
  //     requestOptions: RequestOptions(),
  //     data: CoffeeImageFixture.json,
  //     statusCode: 500,
  //   );
  //
  //   when(() => httpClient.get('https://coffee.alexflipnote.dev/random.json'))
  //       .thenAnswer((invocation) async => mockSuccessResponse);
  //
  //   expect(imageDatasource.getImage, throwsException);
  // });
}
