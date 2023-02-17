import 'package:very_good_coffee_app/core/http_client/dio_client.dart';
import 'package:very_good_coffee_app/core/http_client/http_client.dart';
import 'package:very_good_coffee_app/image_finder/domain/entities/coffee_image.dart';

abstract class ImageDatasource {
  Future<CoffeeImage> getImage();
}

class ImageDatasourceImpl implements ImageDatasource {
  const ImageDatasourceImpl({required HttpClient<dynamic> http}) : _http = http;

  final HttpClient<dynamic> _http;

  @override
  Future<CoffeeImage> getImage() async {
    final response = await (_http as DioClient)
        .get('https://coffee.alexflipnote.dev/random.json');

    final imageResponse = response.data as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return CoffeeImageExtensions.fromJson(
        imageResponse,
      );
    } else {
      throw Exception('Failed to retrieve image');
    }
  }
}
