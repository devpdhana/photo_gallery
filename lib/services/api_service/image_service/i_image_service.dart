import '../../../data/api_response.dart';

abstract class IImageService {
  Future<ApiResponse> fetchImages({
    required int page,
    required String query,
    required int perPage,
  });
}
