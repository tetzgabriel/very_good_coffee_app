import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/core/http_client/dio_client.dart';

import '../../injectable/injectable.dart';

class DioMock extends Mock implements Dio {}

void main() {
  setupTestServices();
  late Dio mockDio;

  setUp(() {
    mockDio = DioMock();
  });

  test('Get should return status code 200', () async {
    const url = 'https://httpbin.org/get';
    final httpClient = DioClient(mockDio);
    final mockResponse = Response<Map<String, dynamic>>(
      requestOptions: RequestOptions(),
      statusCode: 200,
    );

    when(
      () => mockDio.get<Map<String, dynamic>>(
        url,
        options: any(named: 'options'),
      ),
    ).thenAnswer((_) async => mockResponse);

    final response = await httpClient.get(url);

    expect(response.statusCode, 200);
  });
}
