import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/core/http_client/dio_client.dart';
import 'package:very_good_coffee_app/core/injectable/injectable.dart';
import 'package:very_good_coffee_app/core/storage/preferences_storage.dart';
import 'package:very_good_coffee_app/favorites/data/datasources/local_image_datasource.dart';
import 'package:very_good_coffee_app/favorites/domain/repositories/local_image_repository.dart';
import 'package:very_good_coffee_app/favorites/domain/usecases/get_local_images.dart';
import 'package:very_good_coffee_app/favorites/favorites.dart';
import 'package:very_good_coffee_app/image_finder/data/datasources/image_datasource.dart';
import 'package:very_good_coffee_app/image_finder/domain/repositories/image_repository.dart';
import 'package:very_good_coffee_app/image_finder/domain/usecases/get_image.dart';
import 'package:very_good_coffee_app/image_finder/domain/usecases/save_local_image.dart';
import 'package:very_good_coffee_app/image_finder/image_finder.dart';

void main() {
  group('Service locator', () {
    test('Check if services are registered', () {
      setupDependencies();
      expect(injectable.isRegistered<DioClient>(), isTrue);
      expect(injectable.isRegistered<PreferencesStorage>(), isTrue);
      expect(injectable.isRegistered<ImageDatasource>(), isTrue);
      expect(injectable.isRegistered<ImageRepository>(), isTrue);
      expect(injectable.isRegistered<GetImage>(), isTrue);
      expect(injectable.isRegistered<LocalImageDatasource>(), isTrue);
      expect(injectable.isRegistered<LocalImageRepository>(), isTrue);
      expect(injectable.isRegistered<SaveLocalImage>(), isTrue);
      expect(injectable.isRegistered<GetLocalImages>(), isTrue);
      expect(injectable.isRegistered<FavoritesBloc>(), isTrue);
      expect(injectable.isRegistered<ImageFinderBloc>(), isTrue);
    });
  });
}
