import 'package:dartz/dartz.dart';
import 'package:very_good_coffee_app/favorites/domain/repositories/local_image_repository.dart';
import 'package:very_good_coffee_app/image_finder/domain/entities/coffee_image.dart';

class GetLocalImages {
  const GetLocalImages(this.localImageRepository);

  final LocalImageRepository localImageRepository;

  Future<Either<String, List<CoffeeImage>>> call() {
    return localImageRepository.getLocalImages();
  }
}