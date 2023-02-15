import 'package:dartz/dartz.dart';
import 'package:very_good_coffee_app/image_finder/domain/entities/coffee_image.dart';

import 'package:very_good_coffee_app/image_finder/domain/repositories/image_repository.dart';

class GetImage {
  const GetImage(this.imageRepository);

  final ImageRepository imageRepository;

  Future<Either<String, CoffeeImage>> call() {
    return imageRepository.getImage();
  }
}