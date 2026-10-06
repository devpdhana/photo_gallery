# Photo Gallery

A Flutter image gallery app built using the [Pixabay API](https://pixabay.com/api/docs/).

The app allows users to browse and search photos, open a photo to view its details, download images, and save photos as favourites. Favourites are stored locally, so they remain available even after restarting the app.

## Features

* Responsive photo grid that adjusts based on screen size
* Infinite scrolling with a load-more option
* Pull-to-refresh
* Search photos using Pixabay
* Photo details including description, photographer, resolution, and stats
* Download photos with download progress
* Option to open the downloaded file after the download is completed
* Add/remove photos from favourites
* Favourites are saved locally and remain available after restarting the app
* Loading, empty, and error states with retry options
* Light and dark theme based on the system setting
* Image caching and limited image decoding size for smoother scrolling

## Setup

### Requirements

* Flutter 3.32+
* Dart 3.8+

Install the dependencies:

```bash
flutter pub get
```

Run the application using:

```bash
flutter run --dart-define-from-file=.env
```

### Pixabay API Key

The application requires a Pixabay API key.

You can create a free API key from:

https://pixabay.com/api/docs/

Add the API key to the `.env` file and run the application using the command mentioned above.

If you don't want to use the `.env` file, you can also add the key to `_localApiKey` in:

```text
lib/helpers/app_constants.dart
```

If no API key is provided, the application will not crash. Instead, it will show an error message explaining that the API key is missing.

### Code Generation

If any files inside `lib/data/` are modified, run the following command to regenerate the mappers:

```bash
dart run build_runner build
```

## Project Structure

```text
lib/
├── main.dart
├── app.dart
├── data/
│   ├── api_response.dart
│   └── image_data.dart
├── services/
│   ├── api_service/
│   │   └── image_service/
│   │       ├── i_image_service.dart
│   │       └── image_service.dart
│   └── platform_service/
│       ├── local_storage_service/
│       ├── download_service/
│       └── file_opener_service/
├── helpers/
│   ├── app_constants.dart
│   ├── extensions.dart
│   └── favorites_provider.dart
└── pages/
    ├── reusables/
    └── screens/
        ├── home/
        ├── image/
        └── favorites/
```

## Architecture

The application follows an MVVM-based structure.

### View

The view is mainly responsible for displaying the UI.

It doesn't directly communicate with the services. User actions are passed to the ViewModel, and the view reads the current state from it.

For example:

```text
vm.status
vm.images
vm.errorMessage
```

### Model

The model holds the state of each screen.

It extends `ChangeNotifier` and contains values such as:

* Loading status
* Image list
* Error messages
* Pagination information

The model also contains update methods such as `updateStatus()` and `updateImages()`. These update the state and call `notifyListeners()`.

### ViewModel

The ViewModel contains the actual screen logic.

It calls the required services, processes the response, and updates the model state.

The ViewModels also handle errors and convert them into messages that can be shown to the user.

The ViewModels are also covered by unit tests.

## State Management

The project uses **Provider** for state management.

Each screen provides its own ViewModel using `ChangeNotifierProvider`.

`FavoritesProvider` is provided at the application level because the favourites list is shared between the home screen, detail screen, and favourites screen.

## Dependency Injection

The project uses **get_it** for dependency injection.

All service registrations are handled in:

```text
setupServiceLocator()
```

inside `main.dart`.

Services are passed through constructors, which also makes it easier to replace them with fake implementations during testing.

## Services

Services are separated from the UI and ViewModels.

### Image Service

The image service communicates with Pixabay using Dio and handles the API requests.

### Local Storage Service

`shared_preferences` is used to store the favourites locally.

### Download Service

Dio is used to download images and track the download progress.

### File Opener Service

`open_filex` is used to open a downloaded image using an application available on the device.

Each service has an interface and an implementation so that the implementation can be replaced easily when required.

## Data Mapping

The project uses **dart_mappable** instead of manually writing `fromJson()` and `toJson()` methods.

The models in `lib/data/` use `@MappableClass()`, and the mapper files are generated using `build_runner`.

Favourites are converted to maps before storing them locally and converted back into `ImageData` objects when they are loaded.

## Tests

Run the tests using:

```bash
flutter test
```

There are **43 tests** covering areas such as:

* ViewModel logic
* Pagination
* Search
* Pull-to-refresh
* Error handling
* Download progress
* File opening
* Favourite handling
* FavoritesProvider
* Reusable widgets

Fake services used for testing are available under:

```text
test/helpers/
```

## Assumptions and Limitations

* Pixabay provides the photo tags as part of the response, so the `tags` value is used as the photo description on the detail screen.
* Downloaded files are stored in the application's private documents directory.
* Because of this, the downloaded files may not appear directly in the device gallery.
* The downloaded file can be opened using the system viewer through the **OPEN FILE** action.
* If the device doesn't have a suitable application to open the file, the app displays an appropriate message.
* The hero animation between the grid and detail screen and pull-to-refresh were implemented from the bonus requirements.
* Masonry layout, category filters, sharing, and saving directly to the system gallery were not implemented.
* Screenshots/screen recording are included separately with the submission.