import 'package:photogallery/services/platform_service/download_service/i_download_service.dart';

class FakeDownloadService implements IDownloadService {
  FakeDownloadService({this.savedPath = '/documents/photo.jpg', this.failure});

  final String savedPath;
  Object? failure;
  int callCount = 0;
  String? lastUrl;
  String? lastFileName;

  @override
  Future<String> download({
    required String url,
    required String fileName,
    void Function(double progress)? onProgress,
  }) async {
    callCount++;
    lastUrl = url;
    lastFileName = fileName;

    if (failure != null) {
      throw failure!;
    }

    onProgress?.call(0.4);
    onProgress?.call(1);
    return savedPath;
  }
}
