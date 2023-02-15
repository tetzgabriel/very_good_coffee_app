import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/image_finder/data/datasources/image_datasource.dart';
import 'package:very_good_coffee_app/image_finder/domain/entities/coffee_image.dart';

import '../../../app/http_client/mock_dio_client.dart';
import '../../../mocks/coffee_image_fixture.dart';

void main() {
  final httpClient = MockDioClient();
  final ImageDatasource imageDatasource = ImageDatasourceImpl(http: httpClient);

  test('Image datasource should return coffeeImage', () async {
    final mockSuccessResponse = Response(
      requestOptions: RequestOptions(),
      data: CoffeeImageFixture.json,
      statusCode: 200,
    );

    when(() => httpClient.get('https://coffee.alexflipnote.dev/random.json'))
        .thenAnswer((invocation) async => mockSuccessResponse);

    final result = await imageDatasource.getImage();
    expect(result, isA<CoffeeImage>());
  });

  test('Image datasource should return error', () async {
    final mockSuccessResponse = Response(
      requestOptions: RequestOptions(),
      data: CoffeeImageFixture.json,
      statusCode: 500,
    );

    when(() => httpClient.get('https://coffee.alexflipnote.dev/random.json'))
        .thenAnswer((invocation) async => mockSuccessResponse);

    expect(imageDatasource.getImage, throwsException);
  });
}
