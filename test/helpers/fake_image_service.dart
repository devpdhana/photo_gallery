import 'package:photogallery/data/api_response.dart';
import 'package:photogallery/services/api_service/image_service/i_image_service.dart';

import 'sample_data.dart';

class FakeImageService implements IImageService {
  FakeImageService({this.total = 60});

  int total;
  Object? failure;
  final List<int> requestedPages = [];
  final List<String> requestedQueries = [];

  @override
  Future<ApiResponse> fetchImages({
    required int page,
    required String query,
    required int perPage,
  }) async {
    requestedPages.add(page);
    requestedQueries.add(query);

    if (failure != null) {
      throw failure!;
    }

    final start = (page - 1) * perPage;
    if (start >= total) {
      return ApiResponse(total: total, totalHits: total, hits: const []);
    }

    final remaining = total - start;
    final count = remaining < perPage ? remaining : perPage;
    final hits = List.generate(
      count,
      (index) => sampleImage(id: start + index + 1),
    );

    return ApiResponse(total: total, totalHits: total, hits: hits);
  }
}
