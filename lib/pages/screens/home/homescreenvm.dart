import 'package:dio/dio.dart';

import '../../../helpers/app_constants.dart';
import 'homescreenmodel.dart';

class HomeScreenVM extends HomeScreenModel {
  HomeScreenVM(super.imageService);

  Future<void> loadFirstPage() async {
    try {
      if (images.isEmpty) {
        updateStatus(ScreenStatus.loading);
        updateErrorMessage('');
      }
      await _fetchPage(1, replace: true);
    } catch (error) {
      _handleError(_friendlyMessage(error), fromLoadMore: false);
    }
  }

  Future<void> refresh() async {
    try {
      if (status == ScreenStatus.loading || images.isEmpty) return;
      await _fetchPage(1, replace: true);
    } catch (error) {
      _handleError(_friendlyMessage(error), fromLoadMore: false);
    }
  }

  Future<void> loadMore() async {
    if (loadingMore || status == ScreenStatus.loading || !hasMore) return;

    updateLoadingMore(true);
    updateLoadMoreFailed(false);

    try {
      await _fetchPage(page + 1, replace: false);
    } catch (error) {
      _handleError(_friendlyMessage(error), fromLoadMore: true);
    } finally {
      updateLoadingMore(false);
    }
  }

  Future<void> search(String value) async {
    try {
      final trimmed = value.trim();
      if (trimmed == query) return;
      updateQuery(trimmed);
      await loadFirstPage();
    } catch (error) {
      _handleError(_friendlyMessage(error), fromLoadMore: false);
    }
  }

  Future<void> retry() async {
    try {
      await loadFirstPage();
    } catch (error) {
      _handleError(_friendlyMessage(error), fromLoadMore: false);
    }
  }

  Future<void> _fetchPage(int pageNumber, {required bool replace}) async {
    final response = await imageService.fetchImages(
      page: pageNumber,
      query: query,
      perPage: AppConstants.perPage,
    );

    if (replace) {
      updateImages(response.hits);
    } else {
      updateImages([...images, ...response.hits]);
    }
    updatePage(pageNumber);
    updateHasMore(images.length < response.total);
    updateLoadMoreFailed(false);
    updateErrorMessage('');
    updateStatus(ScreenStatus.loaded);
  }

  void _handleError(String message, {required bool fromLoadMore}) {
    updateErrorMessage(message);
    if (images.isEmpty) {
      updateStatus(ScreenStatus.error);
    } else if (fromLoadMore) {
      updateLoadMoreFailed(true);
    }
  }

  String _friendlyMessage(Object error) {
    if (error is DioException) return _messageFor(error);
    if (error is Exception) {
      return error.toString().replaceFirst('Exception: ', '');
    }
    return 'Something went wrong. Please try again.';
  }

  String _messageFor(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return 'The request took too long. Please try again.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Check your network and try again.';
      case DioExceptionType.badCertificate:
        return 'Secure connection to Pixabay failed.';
      case DioExceptionType.badResponse:
        final status = error.response?.statusCode;
        if (status == 400 || status == 403) {
          return 'Pixabay rejected the request. Check that your API key in '
              'app_constants.dart is valid.';
        }
        return status == null
            ? 'Request failed. Please try again.'
            : 'Request failed with status $status. Please try again.';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.unknown:
        return 'No internet connection. Check your network and try again.';
    }
  }
}
