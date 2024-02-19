import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static SharedPrefsHelper? instance;
  late SharedPreferences _preferences;

  factory SharedPrefsHelper() {
    instance ??= SharedPrefsHelper._();
    return instance!;
  }

  SharedPrefsHelper._();

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _preferences.getBool(key) ?? defaultValue;
  }

  Future<void> setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  // Method to remove a value from SharedPreferences

  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }

  // Method to clear all values from SharedPreferences

  Future<void> clear() async {
    await _preferences.clear();
  }
}
