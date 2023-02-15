import 'package:dartz/dartz.dart';
import 'package:very_good_coffee_app/image_finder/data/datasources/image_datasource.dart';
import 'package:very_good_coffee_app/image_finder/domain/entities/coffee_image.dart';
import 'package:very_good_coffee_app/image_finder/domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  const ImageRepositoryImpl(this.imageDataSource);

  final ImageDatasource imageDataSource;

  @override
  Future<Either<String, CoffeeImage>> getImage() async {
    try {
      final result = await imageDataSource.getImage();
      return Right(result);
    } catch(_) {
      return const Left('Error');
    }
  }
}
