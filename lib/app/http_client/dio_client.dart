import 'package:dio/dio.dart';
import 'package:very_good_coffee_app/app/http_client/http_client.dart';

class DioClient implements HttpClient<Response> {
  const DioClient(this.dio);

  final Dio dio;

  @override
  Future<Response> get(String path) async {
    final result = await dio.get(
      path,
    );
    return result;
  }
}
