import 'package:dio/dio.dart';
import 'package:very_good_coffee_app/core/http_client/http_client.dart';

class DioClient implements HttpClient<Response<dynamic>> {
  const DioClient(this.dio);

  final Dio dio;

  @override
  Future<Response<dynamic>> get(String path) async {
    final result = await dio.get<Map<String, dynamic>>(
      path,
    );
    return result;
  }
}
