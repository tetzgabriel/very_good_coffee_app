import 'package:very_good_coffee_app/image_finder/domain/entities/coffee_image.dart';

class CoffeeImageFixture {
  static CoffeeImage model = CoffeeImage(file: 'https://test.com');
  static Map<String, dynamic> json = {
    'file': 'https://test.com'
  };
}