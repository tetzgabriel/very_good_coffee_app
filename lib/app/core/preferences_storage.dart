import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesStorage {
  Future<void> init();
  Future<void> setStringList(String key, List<String> value);
  List<String>? getStringList(String key);
}

class PreferencesStorageImpl implements PreferencesStorage {
  SharedPreferences? _sharedPreferences;

  @override
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    _verifyInitAssert();
    await _sharedPreferences!.setStringList(key, value);
  }

  @override
  List<String>? getStringList(String key) {
    _verifyInitAssert();
    return _sharedPreferences!.getStringList(key);
  }

  void _verifyInitAssert() {
    assert(_sharedPreferences != null, 'init() was not called');
  }
}
