import 'dart:convert';
import 'package:very_good_coffee_app/app/core/preferences_storage.dart';
import 'package:very_good_coffee_app/image_finder/domain/entities/coffee_image.dart';

abstract class LocalImageDatasource {
  Future<List<CoffeeImage>> getLocalImages();

  Future<void> saveLocalImage({required CoffeeImage image});
}

class LocalImageDatasourceImpl implements LocalImageDatasource {
  const LocalImageDatasourceImpl({
    required PreferencesStorage preferencesStorage,
  }) : _preferencesStorage = preferencesStorage;

  final PreferencesStorage _preferencesStorage;

  @override
  Future<List<CoffeeImage>> getLocalImages() async {
    await _preferencesStorage.init();
    final savedImages = _preferencesStorage.getStringList('coffee_images');

    if (savedImages != null) {
      return preferencesListToList(savedImages);
    }

    return [];
  }

  @override
  Future<void> saveLocalImage({required CoffeeImage image}) async {
    await _preferencesStorage.init();
    final savedImages = _preferencesStorage.getStringList('coffee_images');

    if (savedImages != null) {
      final savedImagesToList = savedImages
          .map(
            (item) =>
                CoffeeImage.fromJson(json.decode(item) as Map<String, dynamic>),
          )
          .toList()
        ..add(image);

      final listToSave =
          savedImagesToList.map((item) => jsonEncode(item.toJson())).toList();

      await _preferencesStorage.setStringList('coffee_images', listToSave);
    } else {
      final initialList = <CoffeeImage>[image];

      final listToSave =
          initialList.map((item) => jsonEncode(item.toJson())).toList();

      await _preferencesStorage.setStringList(
        'coffee_images',
        listToSave,
      );
    }
  }

  List<CoffeeImage> preferencesListToList(List<String> savedImages) {
    final savedImagesToList = savedImages
        .map(
          (item) =>
              CoffeeImage.fromJson(json.decode(item) as Map<String, dynamic>),
        )
        .toList();
    return savedImagesToList;
  }
}
