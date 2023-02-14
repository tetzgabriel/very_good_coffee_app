import 'package:dartz/dartz.dart';
import 'package:very_good_coffee_app/data/datasources/local_image_datasource.dart';
import 'package:very_good_coffee_app/domain/entities/coffee_image.dart';
import 'package:very_good_coffee_app/domain/repositories/local_image_repository.dart';

class LocalImageRepositoryImpl implements LocalImageRepository {
  const LocalImageRepositoryImpl(this.localImageDataSource);

  final LocalImageDatasource localImageDataSource;

  @override
  Future<Either<String, List<CoffeeImage>?>> getLocalImages() async {
    try {
      final result = await localImageDataSource.getLocalImages();
      return Right(result);
    } catch(_) {
      return const Left('Error');
    }
  }

  @override
  Future<void> saveLocalImage({required CoffeeImage image}) async {
    try {
      await localImageDataSource.saveLocalImage(image: image);
    } catch(_) {
      print("error");
    }
  }
}