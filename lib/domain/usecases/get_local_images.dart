import 'package:dartz/dartz.dart';
import 'package:very_good_coffee_app/domain/entities/coffee_image.dart';
import 'package:very_good_coffee_app/domain/repositories/local_image_repository.dart';

class GetLocalImages {
  const GetLocalImages(this.localImageRepository);

  final LocalImageRepository localImageRepository;

  Future<Either<String, List<CoffeeImage>?>> call() {
    return localImageRepository.getLocalImages();
  }
}