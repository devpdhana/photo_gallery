import '../../../data/image_data.dart';
import 'imagescreenmodel.dart';

class ImageScreenVM extends ImageScreenModel {
  ImageScreenVM(super.downloadService, super.fileOpener);

  Future<String?> download(ImageData image) async {
    if (downloading) return null;

    updateDownloading(true);
    updateProgress(0);
    updateErrorMessage('');

    try {
      final url = image.largeImageUrl.isNotEmpty
          ? image.largeImageUrl
          : image.webFormatUrl;

      final path = await downloadService.download(
        url: url,
        fileName: 'photo_${image.id}.jpg',
        onProgress: updateProgress,
      );

      updateProgress(1);
      return path;
    } catch (_) {
      updateErrorMessage('Download failed. Please try again.');
      return null;
    } finally {
      updateDownloading(false);
    }
  }

  Future<bool> openFile(String path) async {
    try {
      return await fileOpener.open(path);
    } catch (_) {
      return false;
    }
  }
}
