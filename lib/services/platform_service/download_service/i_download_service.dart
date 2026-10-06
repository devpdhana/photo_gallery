abstract class IDownloadService {
  Future<String> download({
    required String url,
    required String fileName,
    void Function(double progress)? onProgress,
  });
}
