import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:photogallery/helpers/app_constants.dart';
import 'package:photogallery/helpers/favorites_provider.dart';

import '../helpers/fake_local_storage_service.dart';
import '../helpers/sample_data.dart';

void main() {
  late FakeLocalStorageService storage;
  late FavoritesProvider provider;

  setUp(() {
    storage = FakeLocalStorageService();
    provider = FavoritesProvider(storage);
  });

  test('starts with no favorites', () {
    expect(provider.favorites, isEmpty);
    expect(provider.count, 0);
    expect(provider.isFavorite(1), isFalse);
  });

  test('restores the favorites that were saved earlier', () async {
    storage.store[AppConstants.favoritesStorageKey] = jsonEncode([
      sampleImage(id: 4).toMap(),
      sampleImage(id: 9).toMap(),
    ]);

    await provider.load();

    expect(provider.count, 2);
    expect(provider.isFavorite(4), isTrue);
    expect(provider.isFavorite(9), isTrue);
    expect(provider.favorites.first.id, 4);
  });

  test('ignores a corrupted saved value', () async {
    storage.store[AppConstants.favoritesStorageKey] = '{not json';

    await provider.load();

    expect(provider.favorites, isEmpty);
  });

  test('toggle adds the photo and writes it to storage', () async {
    await provider.toggle(sampleImage(id: 1));

    expect(provider.isFavorite(1), isTrue);
    expect(
      storage.store[AppConstants.favoritesStorageKey],
      contains('"id":1'),
    );
  });

  test('toggling twice removes the photo and clears it from storage', () async {
    await provider.toggle(sampleImage(id: 1));
    await provider.toggle(sampleImage(id: 1));

    expect(provider.isFavorite(1), isFalse);
    expect(storage.store[AppConstants.favoritesStorageKey], '[]');
  });

  test('new photos are kept at the top of the list', () async {
    await provider.toggle(sampleImage(id: 1));
    await provider.toggle(sampleImage(id: 2));

    expect(provider.favorites.first.id, 2);
    expect(provider.favorites.last.id, 1);
  });

  test('notifies listeners when the list changes', () async {
    var notifications = 0;
    provider.addListener(() => notifications++);

    await provider.toggle(sampleImage(id: 2));
    await provider.remove(2);

    expect(notifications, 2);
  });

  test('removing an unknown id leaves everything untouched', () async {
    var notifications = 0;
    provider.addListener(() => notifications++);

    await provider.remove(99);

    expect(notifications, 0);
    expect(provider.favorites, isEmpty);
  });
}
