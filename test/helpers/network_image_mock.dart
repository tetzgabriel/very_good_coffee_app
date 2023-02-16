import 'dart:async';
import 'dart:io';
import 'package:mocktail/mocktail.dart';

T mockNetworkImage<T>(
    T Function() body, {
      List<int> imageBytes = _transparentImage,
    }) {
  return HttpOverrides.runZoned(
    body,
    createHttpClient: (_) => _createHttpClient(imageBytes),
  );
}

class _MockHttpClient extends Mock implements HttpClient {
  _MockHttpClient() {
    registerFallbackValue((List<int> _) {});
    registerFallbackValue(Uri());
  }
}

class _MockHttpClientRequest extends Mock implements HttpClientRequest {}

class _MockHttpClientResponse extends Mock implements HttpClientResponse {}

class _MockHttpHeaders extends Mock implements HttpHeaders {}

HttpClient _createHttpClient(List<int> imageBytes) {
  final client = _MockHttpClient();
  final request = _MockHttpClientRequest();
  final response = _MockHttpClientResponse();
  final headers = _MockHttpHeaders();

  when(request.close).thenAnswer((_) async => response);
  when(() => response.compressionState).thenReturn(
    HttpClientResponseCompressionState.notCompressed,
  );
  when(() => response.statusCode).thenReturn(HttpStatus.ok);
  when(() => response.contentLength).thenReturn(imageBytes.length);
  when(() => request.headers).thenReturn(headers);
  when(() => client.getUrl(any())).thenAnswer((_) async => request);
  when(
        () => response.listen(
      any(),
      onDone: any(named: 'onDone'),
      onError: any(named: 'onError'),
      cancelOnError: any(named: 'cancelOnError'),
    ),
  ).thenAnswer((invocation) {
    final onData =
    invocation.positionalArguments.first as void Function(List<int>);
    return Stream<List<int>>.fromIterable([imageBytes]).listen(onData);
  });
  return client;
}

const List<int> _transparentImage = [
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE
];
