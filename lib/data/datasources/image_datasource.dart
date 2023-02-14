import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:very_good_coffee_app/domain/entities/coffee_image.dart';

abstract class ImageDatasource {
  Future<CoffeeImage> getImage();
}

class ImageDatasourceImpl implements ImageDatasource {
  const ImageDatasourceImpl();

  @override
  Future<CoffeeImage> getImage() async {
    final response = await http
        .get(Uri.parse('https://coffee.alexflipnote.dev/random.json'));

    if (response.statusCode == 200) {
      return CoffeeImageExtensions.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to retrieve image');
    }
  }
}
