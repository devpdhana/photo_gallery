import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../data/image_data.dart';
import '../services/platform_service/local_storage_service/i_local_storage_service.dart';
import 'app_constants.dart';

class FavoritesProvider extends ChangeNotifier {
  FavoritesProvider(this._storage);

  final ILocalStorageService _storage;
  final List<ImageData> _favorites = [];

  List<ImageData> get favorites => List.unmodifiable(_favorites);

  int get count => _favorites.length;

  bool isFavorite(int id) => _favorites.any((image) => image.id == id);

  Future<void> load() async {
    try {
      final raw = await _storage.getString(AppConstants.favoritesStorageKey);
      if (raw == null || raw.isEmpty) return;

      final decoded = jsonDecode(raw) as List<dynamic>;
      _favorites
        ..clear()
        ..addAll(
          decoded.map(
            (item) => ImageDataMapper.fromMap(item as Map<String, dynamic>),
          ),
        );
      notifyListeners();
    } catch (_) {
      _favorites.clear();
    }
  }

  Future<void> toggle(ImageData image) async {
    try {
      if (isFavorite(image.id)) {
        await remove(image.id);
      } else {
        _favorites.insert(0, image);
        notifyListeners();
        await _save();
      }
    } catch (_) {
      return;
    }
  }

  Future<void> remove(int id) async {
    try {
      final index = _favorites.indexWhere((image) => image.id == id);
      if (index == -1) return;

      _favorites.removeAt(index);
      notifyListeners();
      await _save();
    } catch (_) {
      return;
    }
  }

  Future<void> _save() async {
    final encoded = jsonEncode(
      _favorites.map((image) => image.toMap()).toList(),
    );
    await _storage.setString(AppConstants.favoritesStorageKey, encoded);
  }
}
