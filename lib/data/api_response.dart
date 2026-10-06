import 'package:dart_mappable/dart_mappable.dart';

import 'image_data.dart';

part 'api_response.mapper.dart';

@MappableClass()
class ApiResponse with ApiResponseMappable {
  const ApiResponse({
    required this.total,
    required this.totalHits,
    required this.hits,
  });

  final int total;
  final int totalHits;
  final List<ImageData> hits;

  bool get isEmpty => hits.isEmpty;
}
