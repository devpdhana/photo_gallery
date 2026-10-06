import 'package:flutter_test/flutter_test.dart';
import 'package:photogallery/pages/screens/home/homescreenmodel.dart';
import 'package:photogallery/pages/screens/home/homescreenvm.dart';

import '../../helpers/fake_image_service.dart';

void main() {
  late FakeImageService imageService;
  late HomeScreenVM vm;

  setUp(() {
    imageService = FakeImageService(total: 45);
    vm = HomeScreenVM(imageService);
  });

  tearDown(() => vm.dispose());

  group('loadFirstPage', () {
    test('starts in the loading state', () {
      expect(vm.status, ScreenStatus.loading);
      expect(vm.images, isEmpty);
    });

    test('loads the first page and marks the screen loaded', () async {
      await vm.loadFirstPage();

      expect(vm.status, ScreenStatus.loaded);
      expect(vm.images, hasLength(30));
      expect(vm.hasMore, isTrue);
      expect(vm.errorMessage, isEmpty);
      expect(imageService.requestedPages, [1]);
    });

    test('shows an empty result when the API has no matches', () async {
      imageService.total = 0;

      await vm.loadFirstPage();

      expect(vm.status, ScreenStatus.loaded);
      expect(vm.images, isEmpty);
      expect(vm.hasMore, isFalse);
    });

    test('moves to the error state when the request fails', () async {
      imageService.failure = Exception('No internet connection. Check your network.');

      await vm.loadFirstPage();

      expect(vm.status, ScreenStatus.error);
      expect(vm.errorMessage, 'No internet connection. Check your network.');
    });

    test('turns unexpected failures into a friendly message', () async {
      imageService.failure = StateError('boom');

      await vm.loadFirstPage();

      expect(vm.status, ScreenStatus.error);
      expect(vm.errorMessage, 'Something went wrong. Please try again.');
    });

    test('shows the photos again after a retry succeeds', () async {
      imageService.failure = Exception('Request failed with status 500.');
      await vm.loadFirstPage();
      expect(vm.status, ScreenStatus.error);

      imageService.failure = null;
      await vm.retry();

      expect(vm.status, ScreenStatus.loaded);
      expect(vm.images, hasLength(30));
      expect(imageService.requestedPages, [1, 1]);
    });
  });

  group('loadMore', () {
    test('appends the next page and stops when everything is loaded', () async {
      await vm.loadFirstPage();
      await vm.loadMore();

      expect(vm.images, hasLength(45));
      expect(vm.hasMore, isFalse);
      expect(imageService.requestedPages, [1, 2]);
    });

    test('ignores further pages once the list is complete', () async {
      await vm.loadFirstPage();
      await vm.loadMore();
      await vm.loadMore();

      expect(imageService.requestedPages, [1, 2]);
      expect(vm.images, hasLength(45));
    });

    test('only asks for one page when called twice in a row', () async {
      await vm.loadFirstPage();

      await Future.wait([vm.loadMore(), vm.loadMore()]);

      expect(imageService.requestedPages, [1, 2]);
      expect(vm.loadingMore, isFalse);
    });

    test('keeps the current photos when the next page fails', () async {
      await vm.loadFirstPage();

      imageService.failure = Exception('The request took too long.');
      await vm.loadMore();

      expect(vm.status, ScreenStatus.loaded);
      expect(vm.images, hasLength(30));
      expect(vm.loadMoreFailed, isTrue);
      expect(vm.loadingMore, isFalse);
    });

    test('clears the footer error after a successful retry', () async {
      await vm.loadFirstPage();
      imageService.failure = Exception('The request took too long.');
      await vm.loadMore();
      expect(vm.loadMoreFailed, isTrue);

      imageService.failure = null;
      await vm.loadMore();

      expect(vm.loadMoreFailed, isFalse);
      expect(vm.images, hasLength(45));
      expect(vm.hasMore, isFalse);
    });
  });

  group('search', () {
    test('resets to the first page of the new query', () async {
      await vm.loadFirstPage();

      await vm.search('cats');

      expect(vm.query, 'cats');
      expect(imageService.requestedQueries.last, 'cats');
      expect(imageService.requestedPages, [1, 1]);
      expect(vm.images, hasLength(30));
    });

    test('does not hit the API again for the same term', () async {
      await vm.search('cats');
      await vm.search('  cats  ');

      expect(imageService.requestedPages, [1]);
    });

    test('shows an empty state when nothing matches', () async {
      imageService.total = 0;

      await vm.search('zzzz');

      expect(vm.status, ScreenStatus.loaded);
      expect(vm.images, isEmpty);
      expect(vm.hasMore, isFalse);
    });

    test('keeps the current photos when a new search fails', () async {
      await vm.loadFirstPage();
      imageService.failure = Exception('No internet connection.');

      await vm.search('dogs');

      expect(vm.query, 'dogs');
      expect(vm.status, ScreenStatus.loaded);
      expect(vm.images, hasLength(30));
      expect(vm.errorMessage, 'No internet connection.');
      expect(imageService.requestedQueries, ['', 'dogs']);
    });
  });

  group('refresh', () {
    test('replaces the list with a fresh first page', () async {
      await vm.loadFirstPage();
      await vm.loadMore();
      expect(vm.images, hasLength(45));

      await vm.refresh();

      expect(imageService.requestedPages, [1, 2, 1]);
      expect(vm.images, hasLength(30));
      expect(vm.hasMore, isTrue);
      expect(vm.status, ScreenStatus.loaded);
    });

    test('does nothing while the first page is still loading', () async {
      await vm.refresh();

      expect(imageService.requestedPages, isEmpty);
    });

    test('keeps the photos when a refresh fails', () async {
      await vm.loadFirstPage();
      imageService.failure = Exception('No internet connection.');

      await vm.refresh();

      expect(vm.status, ScreenStatus.loaded);
      expect(vm.images, hasLength(30));
      expect(vm.errorMessage, 'No internet connection.');
    });
  });
}
