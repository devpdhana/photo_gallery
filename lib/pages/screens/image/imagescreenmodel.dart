import 'package:flutter/foundation.dart';

import '../../../services/platform_service/download_service/i_download_service.dart';
import '../../../services/platform_service/file_opener_service/i_file_opener_service.dart';

class ImageScreenModel extends ChangeNotifier {
  ImageScreenModel(this.downloadService, this.fileOpener);

  final IDownloadService downloadService;
  final IFileOpenerService fileOpener;

  bool downloading = false;
  double progress = 0;
  String errorMessage = '';

  void updateDownloading(bool value) {
    downloading = value;
    notifyListeners();
  }

  void updateProgress(double value) {
    progress = value;
    notifyListeners();
  }

  void updateErrorMessage(String value) {
    errorMessage = value;
    notifyListeners();
  }
}
