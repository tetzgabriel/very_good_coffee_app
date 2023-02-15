import 'package:dartz/dartz.dart';
import 'package:very_good_coffee_app/image_finder/domain/entities/coffee_image.dart';

abstract class ImageRepository {
  Future<Either<String, CoffeeImage>> getImage();
}
