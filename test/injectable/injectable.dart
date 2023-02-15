import 'package:get_it/get_it.dart';
import 'package:very_good_coffee_app/favorites/domain/usecases/get_local_images.dart';
import 'package:very_good_coffee_app/image_finder/domain/usecases/get_image.dart';
import 'package:very_good_coffee_app/image_finder/domain/usecases/save_local_image.dart';

import '../mocks/mock_get_image.dart';
import '../mocks/mock_get_local_images.dart';
import '../mocks/mock_save_local_image.dart';

final injectable = GetIt.instance;

void setupTestServices() {
  injectable
    ..registerFactory<GetImage>(MockGetImage.new)
    ..registerFactory<SaveLocalImage>(MockSaveLocalImage.new)
    ..registerFactory<GetLocalImages>(MockGetLocalImages.new);
}