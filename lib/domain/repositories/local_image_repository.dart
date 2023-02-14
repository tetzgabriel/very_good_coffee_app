import 'package:dartz/dartz.dart';
import 'package:very_good_coffee_app/domain/entities/coffee_image.dart';

abstract class LocalImageRepository {
  Future<Either<String, List<CoffeeImage>?>> getLocalImages();
  Future<void> saveLocalImage({required CoffeeImage image});
}