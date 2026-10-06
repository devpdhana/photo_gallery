import 'favoritesscreenmodel.dart';

class FavoritesScreenVM extends FavoritesScreenModel {
  FavoritesScreenVM(super.favorites) {
    favorites.addListener(_handleFavoritesChanged);
  }

  Future<void> remove(int id) async {
    try {
      await favorites.remove(id);
    } catch (_) {
      return;
    }
  }

  void _handleFavoritesChanged() => notifyListeners();

  @override
  void dispose() {
    favorites.removeListener(_handleFavoritesChanged);
    super.dispose();
  }
}
