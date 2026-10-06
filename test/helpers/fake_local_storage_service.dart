import 'package:photogallery/services/platform_service/local_storage_service/i_local_storage_service.dart';

class FakeLocalStorageService implements ILocalStorageService {
  final Map<String, String> store = {};

  @override
  Future<String?> getString(String key) async => store[key];

  @override
  Future<void> setString(String key, String value) async {
    store[key] = value;
  }

  @override
  Future<void> remove(String key) async {
    store.remove(key);
  }
}
