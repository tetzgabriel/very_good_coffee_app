import 'package:dartz/dartz.dart';
import 'package:very_good_coffee_app/domain/entities/coffee_image.dart';
import 'package:very_good_coffee_app/domain/repositories/local_image_repository.dart';

class SaveLocalImage {
  const SaveLocalImage(this.localImageRepository);

  final LocalImageRepository localImageRepository;

  Future<void> call({required CoffeeImage image}) {
    return localImageRepository.saveLocalImage(image: image);
  }
}