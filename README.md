# Photo Gallery

A Flutter image gallery on top of the [Pixabay API](https://pixabay.com/api/docs/). It loads
photos into an infinite scrolling grid, opens any photo into a detail screen where you can read
about it and download it, and keeps a favourites list that survives app restarts.

## What it does

- Grid of photos that gets wider or narrower depending on the screen
- Infinite scroll with a "load more" footer, plus pull to refresh
- Search anything on Pixabay
- Detail screen with the description, the photographer, the resolution and the stats
- Download with a progress bar, and when it's done the snackbar has an "OPEN FILE" action
- Favourites stored on the phone and shared across all screens
- Loading, empty and error states on every screen, with a retry
- Light and dark theme follow the system setting
- Images are cached and decoded at a limited size so scrolling stays smooth

## Setup

You'll need Flutter 3.32+ (Dart 3.8).

```bash
flutter pub get
flutter run --dart-define-from-file=.env
```

A key is free and takes a minute to create on https://pixabay.com/api/docs/. If you don't want
to pass it on every run, paste it into `_localApiKey` in `lib/helpers/app_constants.dart`
instead. With no key at all the app doesn't crash, it shows an error screen that tells you
what's missing.

After editing anything under `lib/data/`, rebuild the mappers:

```bash
dart run build_runner build
```

## Project structure

```
lib/
├── main.dart                  # entry point, all get_it registrations (setupServiceLocator)
├── app.dart                   # MaterialApp, theme, root provider
├── data/                      # dart_mappable data classes
│   ├── api_response.dart      # wrapper for the Pixabay response
│   └── image_data.dart        # one photo, mapper generated next to it as *.mapper.dart
├── services/
│   ├── api_service/
│   │   └── image_service/     # IImageService + ImageService
│   └── platform_service/      # one folder per service: i_<name>.dart and <name>.dart
│       ├── local_storage_service/   # shared_preferences
│       ├── download_service/        # Dio download with progress
│       └── file_opener_service/     # open_filex
├── helpers/
│   ├── app_constants.dart     # base url, api key, page size, storage keys
│   ├── extensions.dart        # context and int extension methods
│   └── favorites_provider.dart   # favourites state for the whole app, saved locally
└── pages/
    ├── reusables/             # widgets used on more than one screen
    └── screens/
        ├── home/      homescreenview.dart / homescreenvm.dart / homescreenmodel.dart
        ├── image/     imagescreenview.dart / imagescreenvm.dart / imagescreenmodel.dart
        └── favorites/ favoritesscreenview.dart / favoritesscreenvm.dart / favoritesscreenmodel.dart
```

## How it's built

Pretty standard MVVM:

- **View** (`*view.dart`) only renders. It doesn't know the services exist. When the user does
  something it calls a method on the view model, and it reads state straight off it, for example
  `vm.status`, `vm.images`, `vm.errorMessage`. No getters in the way, those fields are inherited
  from the model.
- **Model** (`*model.dart`) is a ChangeNotifier that owns the screen state: a handful of public
  variables like status, images, errorMessage and the pagination flags. Each variable has an
  update function next to it, `updateStatus`, `updateImages` and so on, and all that function
  does is write the value and call `notifyListeners()`.
- **ViewModel** (`*vm.dart`) extends its model, so it gets the state, the update functions and
  the services the model received in its constructor. The class itself is just methods: they
  call a service and feed the result into the update functions. Every public method sits in a
  try/catch, whatever goes wrong gets turned into a readable message and stored on the model
  instead of blowing up the widget tree. The view models are the part that's unit tested.

For state the app uses provider. Every screen wraps its view model in a ChangeNotifierProvider,
and FavoritesProvider is provided once at the root so the tiles, the detail screen and the
favourites screen all watch the same list.

Dependency injection is plain get_it and all of it lives in `setupServiceLocator()` in
`main.dart`. Services are registered there, the models take their services through the
constructor and the view model inherits them by extending the model. Swapping one
implementation, a fake image service in the tests for example, is a one line change.

Services are grouped in two folders, and every service gets its own folder with an interface
(`i_<name>.dart`) and the implementation (`<name>.dart`):

- `api_service/image_service` talks to Pixabay with Dio.
- `platform_service` covers the device side: `local_storage_service` for shared_preferences,
  `download_service` for the Dio download with progress, `file_opener_service` for open_filex.

The service classes hold no state, only methods, so the Dio instance or the SharedPreferences
object is created inside the method that needs it. Every service method is wrapped in a
try/catch and there are no custom exception classes anywhere. A DioException or an Exception
with a readable message simply travels up to the view model that called it, anything else gets
wrapped in a plain Exception on the way out. HomeScreenVM is the one that turns a DioException
into the message you actually see (no internet, timeout, bad API key, and so on),
ImageScreenVM just shows a short "download failed" message.

Instead of handwritten `fromJson`/`toJson` I went with dart_mappable. The classes in
`lib/data/` carry a `@MappableClass()` annotation and `dart run build_runner build` generates
the mappers. Favourites are written with `image.toMap()` and read back with
`ImageDataMapper.fromMap(...)`, so everything stays on the device.

## Tests

```bash
flutter test
```

43 tests in total. They cover the view models (paging, search, refresh, the error paths,
download progress, opening a file, favourites mirroring), the favourites provider and a few of
the reusable widgets. The fakes they use live in `test/helpers/`.

## Assumptions and limitations

- Pixabay sends the description of a photo as its `tags`, that's what the detail screen shows
  under "Description".
- Downloads go to the app's private documents directory. That needs no storage permission on
  Android 10+ or iOS, but you won't find the file in the gallery app afterwards.
- Opening a finished download uses the system viewer through the snackbar's "OPEN FILE" action.
  If nothing on the phone can open it, the app just says so.
- From the bonus list: the hero animation between grid and detail and pull to refresh are in.
  Masonry layout, category filters, sharing and saving to the system gallery are not.
- Screenshots / recording still to be attached to the submission.
