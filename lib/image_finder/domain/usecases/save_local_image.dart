import 'package:very_good_coffee_app/favorites/domain/repositories/local_image_repository.dart';
import 'package:very_good_coffee_app/image_finder/domain/entities/coffee_image.dart';

class SaveLocalImage {
  const SaveLocalImage(this.localImageRepository);

  final LocalImageRepository localImageRepository;

  Future<void> call({required CoffeeImage image}) {
    return localImageRepository.saveLocalImage(image: image);
  }
}
