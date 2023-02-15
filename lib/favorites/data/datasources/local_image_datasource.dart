import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:very_good_coffee_app/image_finder/domain/entities/coffee_image.dart';

abstract class LocalImageDatasource {
  Future<List<CoffeeImage>> getLocalImages();

  Future<void> saveLocalImage({required CoffeeImage image});
}

class LocalImageDatasourceImpl implements LocalImageDatasource {
  const LocalImageDatasourceImpl();

  @override
  Future<List<CoffeeImage>> getLocalImages() async {
    final prefs = await SharedPreferences.getInstance();
    final savedImages = prefs.getStringList('coffee_images');

    if (savedImages != null) {
      final savedImagesToList = savedImages
          .map(
            (item) =>
                CoffeeImage.fromJson(json.decode(item) as Map<String, dynamic>),
          )
          .toList();

      return savedImagesToList;
    }

    return [];
  }

  @override
  Future<void> saveLocalImage({required CoffeeImage image}) async {
    final prefs = await SharedPreferences.getInstance();
    final savedImages = prefs.getStringList('coffee_images');

    if (savedImages != null) {
      final savedImagesToList = savedImages
          .map(
            (item) =>
                CoffeeImage.fromJson(json.decode(item) as Map<String, dynamic>),
          )
          .toList();

      savedImagesToList.add(image);

      final listToSave =
          savedImagesToList.map((item) => jsonEncode(item.toJson())).toList();

      await prefs.setStringList('coffee_images', listToSave);
    } else {
      final initialList = <CoffeeImage>[];
      initialList.add(image);

      final listToSave =
          initialList.map((item) => jsonEncode(item.toJson())).toList();

      await prefs.setStringList(
        'coffee_images',
        listToSave,
      );
    }
  }
}
