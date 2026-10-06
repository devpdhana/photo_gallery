import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helpers/app_constants.dart';
import 'helpers/favorites_provider.dart';
import 'main.dart';
import 'pages/screens/home/homescreenview.dart';

class PhotoGalleryApp extends StatelessWidget {
  const PhotoGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoritesProvider>.value(
      value: getIt<FavoritesProvider>(),
      child: MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF3D6BF3),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF3D6BF3),
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: const HomeScreenView(),
      ),
    );
  }
}
