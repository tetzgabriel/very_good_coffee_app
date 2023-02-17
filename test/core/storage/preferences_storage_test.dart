import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:very_good_coffee_app/core/storage/preferences_storage.dart';

void main() {
  late PreferencesStorageImpl sut;

  const fakeStringKey = 'fakeStringKey';
  const fakeStringListValue = ['fakeStringValue'];

  setUp(() {
    sut = PreferencesStorageImpl();
    SharedPreferences.setMockInitialValues({
      fakeStringKey: fakeStringListValue,
    });
  });

  group('String tests -', () {
    test('Should return correct fake value when get string', () async {
      await sut.init();

      expect(sut.getStringList(fakeStringKey), fakeStringListValue);
    });

    test('Should write correct value when set string', () async {
      await sut.init();

      const anotherFakeListValue = ['anotherFakeValue'];

      await sut.setStringList(fakeStringKey, anotherFakeListValue);

      expect(sut.getStringList(fakeStringKey), anotherFakeListValue);
    });

    test('should throw assertion if init was not called on setString', () {
      expect(
        () => sut.setStringList(fakeStringKey, fakeStringListValue),
        throwsAssertionError,
      );
    });

    test('should throw assertion if init was not called on getString', () {
      expect(() => sut.getStringList(fakeStringKey), throwsAssertionError);
    });
  });
}
