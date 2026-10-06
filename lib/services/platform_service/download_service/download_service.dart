import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../../../helpers/app_constants.dart';
import 'i_download_service.dart';

class DownloadService implements IDownloadService {
  @override
  Future<String> download({
    required String url,
    required String fileName,
    void Function(double progress)? onProgress,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final savePath = '${directory.path}${Platform.pathSeparator}$fileName';

      final dio = Dio(
        BaseOptions(
          connectTimeout: AppConstants.requestTimeout,
          receiveTimeout: AppConstants.downloadTimeout,
        ),
      );

      await dio.download(
        url,
        savePath,
        deleteOnError: true,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            onProgress?.call(received / total);
          }
        },
      );

      onProgress?.call(1);
      return savePath;
    } on Exception {
      rethrow;
    } catch (_) {
      throw Exception('Something went wrong. Please try again.');
    }
  }
}
