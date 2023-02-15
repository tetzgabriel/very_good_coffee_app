import 'package:get_it/get_it.dart';
import 'package:very_good_coffee_app/favorites/data/datasources/local_image_datasource.dart';
import 'package:very_good_coffee_app/favorites/data/repositories/local_image_repository_impl.dart';
import 'package:very_good_coffee_app/favorites/domain/repositories/local_image_repository.dart';
import 'package:very_good_coffee_app/favorites/domain/usecases/get_local_images.dart';
import 'package:very_good_coffee_app/image_finder/data/datasources/image_datasource.dart';
import 'package:very_good_coffee_app/image_finder/data/repositories/image_repository_impl.dart';
import 'package:very_good_coffee_app/image_finder/domain/repositories/image_repository.dart';
import 'package:very_good_coffee_app/image_finder/domain/usecases/get_image.dart';
import 'package:very_good_coffee_app/image_finder/domain/usecases/save_local_image.dart';
import 'package:very_good_coffee_app/image_finder/presentation/cubit/image_finder_cubit.dart';

final injectable = GetIt.instance;

void setupDependencies() {
  injectable
    ..registerFactory<ImageDatasource>(ImageDatasourceImpl.new)
    ..registerFactory<ImageRepository>(
      () => ImageRepositoryImpl(injectable.get<ImageDatasource>()),
    )
    ..registerFactory<GetImage>(
      () => GetImage(injectable.get<ImageRepository>()),
    )
    ..registerFactory<LocalImageDatasource>(LocalImageDatasourceImpl.new)
    ..registerFactory<LocalImageRepository>(
          () => LocalImageRepositoryImpl(injectable.get<LocalImageDatasource>()),
    )
    ..registerFactory<SaveLocalImage>(
      () => SaveLocalImage(injectable.get<LocalImageRepository>()),
    )
    ..registerFactory<GetLocalImages>(
          () => GetLocalImages(injectable.get<LocalImageRepository>()),
    )
    ..registerSingleton(ImageFinderCubit())

    ;
}
