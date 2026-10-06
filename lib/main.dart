import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app.dart';
import 'helpers/favorites_provider.dart';
import 'pages/screens/favorites/favoritesscreenvm.dart';
import 'pages/screens/home/homescreenvm.dart';
import 'pages/screens/image/imagescreenvm.dart';
import 'services/api_service/image_service/i_image_service.dart';
import 'services/api_service/image_service/image_service.dart';
import 'services/platform_service/download_service/download_service.dart';
import 'services/platform_service/download_service/i_download_service.dart';
import 'services/platform_service/file_opener_service/file_opener_service.dart';
import 'services/platform_service/file_opener_service/i_file_opener_service.dart';
import 'services/platform_service/local_storage_service/i_local_storage_service.dart';
import 'services/platform_service/local_storage_service/local_storage_service.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<ILocalStorageService>(LocalStorageService.new);
  getIt.registerLazySingleton<IImageService>(ImageService.new);
  getIt.registerLazySingleton<IDownloadService>(DownloadService.new);
  getIt.registerLazySingleton<IFileOpenerService>(FileOpenerService.new);

  getIt.registerLazySingleton<FavoritesProvider>(
    () => FavoritesProvider(getIt<ILocalStorageService>()),
  );

  getIt.registerFactory<HomeScreenVM>(
    () => HomeScreenVM(getIt<IImageService>()),
  );

  getIt.registerFactory<ImageScreenVM>(
    () => ImageScreenVM(
      getIt<IDownloadService>(),
      getIt<IFileOpenerService>(),
    ),
  );

  getIt.registerFactory<FavoritesScreenVM>(
    () => FavoritesScreenVM(getIt<FavoritesProvider>()),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();
  await getIt<FavoritesProvider>().load();

  runApp(const PhotoGalleryApp());
}
