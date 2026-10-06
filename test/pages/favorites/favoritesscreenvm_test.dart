import 'package:flutter_test/flutter_test.dart';
import 'package:photogallery/helpers/app_constants.dart';
import 'package:photogallery/helpers/favorites_provider.dart';
import 'package:photogallery/pages/screens/favorites/favoritesscreenvm.dart';

import '../../helpers/fake_local_storage_service.dart';
import '../../helpers/sample_data.dart';

void main() {
  late FakeLocalStorageService storage;
  late FavoritesProvider provider;
  late FavoritesScreenVM vm;

  setUp(() {
    storage = FakeLocalStorageService();
    provider = FavoritesProvider(storage);
    vm = FavoritesScreenVM(provider);
  });

  tearDown(() => vm.dispose());

  test('starts empty when nothing has been saved', () {
    expect(vm.favorites.favorites.isEmpty, isTrue);
    expect(vm.favorites.count, 0);
    expect(vm.favorites.favorites, isEmpty);
  });

  test('mirrors photos added to the global favorites state', () async {
    await provider.toggle(sampleImage(id: 10));
    await provider.toggle(sampleImage(id: 11));

    expect(vm.favorites.count, 2);
    expect(vm.favorites.favorites.first.id, 11);
    expect(vm.favorites.favorites.isEmpty, isFalse);
  });

  test('drops a photo that was unfavorited globally', () async {
    await provider.toggle(sampleImage(id: 10));
    expect(vm.favorites.count, 1);

    await provider.toggle(sampleImage(id: 10));

    expect(vm.favorites.favorites.isEmpty, isTrue);
  });

  test('remove deletes the photo from storage too', () async {
    await provider.toggle(sampleImage(id: 5));
    expect(vm.favorites.count, 1);

    await vm.remove(5);

    expect(vm.favorites.favorites.isEmpty, isTrue);
    expect(storage.store[AppConstants.favoritesStorageKey], '[]');
  });

  test('ignores removal of a photo that is not in the list', () async {
    await provider.toggle(sampleImage(id: 5));

    await vm.remove(99);

    expect(vm.favorites.count, 1);
  });

  test('stops reacting to favorites once disposed', () async {
    final shortLived = FavoritesScreenVM(provider);
    var notifications = 0;
    shortLived.addListener(() => notifications++);

    shortLived.dispose();
    await provider.toggle(sampleImage(id: 3));

    expect(notifications, 0);
  });
}
