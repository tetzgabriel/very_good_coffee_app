import 'package:get_it/get_it.dart';
import 'package:very_good_coffee_app/data/datasources/image_datasource.dart';
import 'package:very_good_coffee_app/data/repositories/image_repository_impl.dart';
import 'package:very_good_coffee_app/domain/repositories/image_repository.dart';
import 'package:very_good_coffee_app/domain/usecases/get_image.dart';

final injectable = GetIt.instance;

void setupDependencies() {
  injectable..registerFactory<ImageDatasource>(ImageDatasourceImpl.new)
    ..registerFactory<ImageRepository>(
          () => ImageRepositoryImpl(injectable.get<ImageDatasource>()),
    )
      ..registerFactory<GetImage>(() => GetImage(injectable.get<ImageRepository>()));
}

