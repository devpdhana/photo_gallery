class AppConstants {
  AppConstants._();

  static const String appName = 'Photo Gallery';

  static const String _localApiKey = '';
  static const String apiKey = String.fromEnvironment(
    'PIXABAY_API_KEY',
    defaultValue: _localApiKey,
  );

  static const String missingKeyMessage =
      'No Pixabay API key found. Paste your key in app_constants.dart '
      'or run with --dart-define=PIXABAY_API_KEY=your_key.';

  static const String baseUrl = 'https://pixabay.com/api/';
  static const int perPage = 30;
  static const Duration requestTimeout = Duration(seconds: 20);
  static const Duration downloadTimeout = Duration(minutes: 2);

  static const String favoritesStorageKey = 'favorite_images';
}
