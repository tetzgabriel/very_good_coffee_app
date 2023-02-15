import 'package:very_good_coffee_app/image_finder/domain/entities/coffee_image.dart';

class CoffeeImageFixture {
  static CoffeeImage model = const CoffeeImage(file: 'https://test.com');
  static Map<String, dynamic> json = {
    'file': 'https://test.com'
  };
  static List<CoffeeImage> list = [
    CoffeeImageFixture.model,
    CoffeeImageFixture.model
  ];
}