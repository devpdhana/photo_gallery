import 'package:flutter/foundation.dart';

import '../../../helpers/favorites_provider.dart';

class FavoritesScreenModel extends ChangeNotifier {
  FavoritesScreenModel(this.favorites);

  FavoritesProvider favorites;

  void updateFavorites(FavoritesProvider value) {
    favorites = value;
    notifyListeners();
  }
}
