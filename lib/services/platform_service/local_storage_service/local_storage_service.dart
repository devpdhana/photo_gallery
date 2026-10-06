import 'package:shared_preferences/shared_preferences.dart';

import 'i_local_storage_service.dart';

class LocalStorageService implements ILocalStorageService {
  @override
  Future<String?> getString(String key) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      return preferences.getString(key);
    } on Exception {
      rethrow;
    } catch (_) {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  @override
  Future<void> setString(String key, String value) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString(key, value);
    } on Exception {
      rethrow;
    } catch (_) {
      throw Exception('Something went wrong. Please try again.');
    }
  }

  @override
  Future<void> remove(String key) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      await preferences.remove(key);
    } on Exception {
      rethrow;
    } catch (_) {
      throw Exception('Something went wrong. Please try again.');
    }
  }
}
