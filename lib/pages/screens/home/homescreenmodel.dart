import 'package:flutter/foundation.dart';

import '../../../data/image_data.dart';
import '../../../services/api_service/image_service/i_image_service.dart';

enum ScreenStatus { loading, loaded, error }

class HomeScreenModel extends ChangeNotifier {
  HomeScreenModel(this.imageService);

  final IImageService imageService;

  ScreenStatus status = ScreenStatus.loading;
  List<ImageData> images = [];
  String errorMessage = '';
  String query = '';
  int page = 0;
  bool hasMore = true;
  bool loadingMore = false;
  bool loadMoreFailed = false;

  void updateStatus(ScreenStatus value) {
    status = value;
    notifyListeners();
  }

  void updateImages(List<ImageData> value) {
    images = value;
    notifyListeners();
  }

  void updateErrorMessage(String value) {
    errorMessage = value;
    notifyListeners();
  }

  void updateQuery(String value) {
    query = value;
    notifyListeners();
  }

  void updatePage(int value) {
    page = value;
    notifyListeners();
  }

  void updateHasMore(bool value) {
    hasMore = value;
    notifyListeners();
  }

  void updateLoadingMore(bool value) {
    loadingMore = value;
    notifyListeners();
  }

  void updateLoadMoreFailed(bool value) {
    loadMoreFailed = value;
    notifyListeners();
  }
}
