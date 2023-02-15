import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/image_finder/domain/entities/coffee_image.dart';

import '../../../mocks/coffee_image_fixture.dart';

void main() {
  group('Coffee Image', () {
    test('Should parse from json', () {
      final sut = CoffeeImage.fromJson(CoffeeImageFixture.json);

      expect(sut.file, 'https://test.com');
      expect(sut.props, ['https://test.com']);
    });

    test('Should parse to json', () {
      final sut = CoffeeImageFixture.model.toJson();

      expect(sut['file'], 'https://test.com');
    });

    test('Should compare with same Coffee Image', () {
      final fromJson = CoffeeImage.fromJson(CoffeeImageFixture.json);
      const sut = CoffeeImage(file: 'https://test.com');

      expect(fromJson, equals(sut));
    });
  });
}
