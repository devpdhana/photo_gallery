import 'package:flutter_test/flutter_test.dart';
import 'package:photogallery/data/image_data.dart';
import 'package:photogallery/pages/screens/image/imagescreenvm.dart';

import '../../helpers/fake_download_service.dart';
import '../../helpers/fake_file_opener.dart';
import '../../helpers/sample_data.dart';

void main() {
  late FakeDownloadService downloader;
  late FakeFileOpenerService fileOpener;
  late ImageScreenVM vm;
  late ImageData image;

  setUp(() {
    downloader = FakeDownloadService(savedPath: '/documents/photo_7.jpg');
    fileOpener = FakeFileOpenerService();
    vm = ImageScreenVM(downloader, fileOpener);
    image = sampleImage(id: 7);
  });

  tearDown(() => vm.dispose());

  group('download', () {
    test('returns the saved path and finishes the progress', () async {
      final path = await vm.download(image);

      expect(path, '/documents/photo_7.jpg');
      expect(vm.downloading, isFalse);
      expect(vm.progress, 1);
      expect(vm.errorMessage.isNotEmpty, isFalse);
      expect(downloader.lastFileName, 'photo_7.jpg');
      expect(downloader.callCount, 1);
    });

    test('asks for the large version of the photo', () async {
      await vm.download(image);

      expect(downloader.lastUrl, image.largeImageUrl);
    });

    test('reports download failures as a message', () async {
      downloader.failure = Exception('The disk is full.');

      final path = await vm.download(image);

      expect(path, isNull);
      expect(vm.errorMessage.isNotEmpty, isTrue);
      expect(vm.errorMessage, 'Download failed. Please try again.');
      expect(vm.downloading, isFalse);
      expect(vm.progress, 0);
    });

    test('falls back to a friendly message for unexpected errors', () async {
      downloader.failure = StateError('disk on fire');

      final path = await vm.download(image);

      expect(path, isNull);
      expect(vm.errorMessage, 'Download failed. Please try again.');
      expect(vm.downloading, isFalse);
    });

    test('notifies listeners while the download runs', () async {
      var notifications = 0;
      vm.addListener(() => notifications++);

      await vm.download(image);

      expect(notifications, greaterThanOrEqualTo(3));
    });

    test('ignores a second download while one is running', () async {
      final first = vm.download(image);
      final second = vm.download(image);

      expect(await second, isNull);
      expect(await first, '/documents/photo_7.jpg');
      expect(downloader.callCount, 1);
    });
  });

  group('openFile', () {
    test('hands the saved path to the file opener', () async {
      final opened = await vm.openFile('/documents/photo_7.jpg');

      expect(opened, isTrue);
      expect(fileOpener.lastPath, '/documents/photo_7.jpg');
      expect(fileOpener.callCount, 1);
    });

    test('reports when no app could open the file', () async {
      fileOpener.succeeds = false;

      final opened = await vm.openFile('/documents/photo_7.jpg');

      expect(opened, isFalse);
      expect(vm.errorMessage.isNotEmpty, isFalse);
    });
  });
}
