import 'package:get_it/get_it.dart';
import 'package:very_good_coffee_app/favorites/domain/usecases/get_local_images.dart';
import 'package:very_good_coffee_app/favorites/favorites.dart';
import 'package:very_good_coffee_app/image_finder/domain/usecases/get_image.dart';
import 'package:very_good_coffee_app/image_finder/domain/usecases/save_local_image.dart';
import 'package:very_good_coffee_app/image_finder/image_finder.dart';

import '../mocks/mock_favorites_bloc.dart';
import '../mocks/mock_get_image.dart';
import '../mocks/mock_get_local_images.dart';
import '../mocks/mock_image_finder_cubit.dart';
import '../mocks/mock_save_local_image.dart';

final injectable = GetIt.instance;

void setupTestServices() {
  injectable
    ..registerSingleton<GetImage>(MockGetImage())
    ..registerSingleton<SaveLocalImage>(MockSaveLocalImage())
    ..registerSingleton<GetLocalImages>(MockGetLocalImages())
    ..registerSingleton<FavoritesBloc>(MockFavoritesBloc())
    ..registerSingleton<ImageFinderBloc>(MockImageFinderBloc());
}
