import 'package:photogallery/data/api_response.dart';
import 'package:photogallery/data/image_data.dart';

ImageData sampleImage({int id = 1, String tags = 'nature, forest'}) {
  return ImageData(
    id: id,
    pageUrl: 'https://example.com/photo/$id',
    type: 'photo',
    tags: tags,
    previewUrl: 'https://example.com/preview/$id.jpg',
    webFormatUrl: 'https://example.com/web/$id.jpg',
    largeImageUrl: 'https://example.com/large/$id.jpg',
    imageWidth: 1280,
    imageHeight: 853,
    views: 1234,
    downloads: 567,
    likes: 89,
    comments: 12,
    user: 'tester',
    userImageUrl: 'https://example.com/avatar/$id.png',
  );
}

ApiResponse sampleResponse({int total = 1, List<ImageData>? hits}) {
  return ApiResponse(
    total: total,
    totalHits: total,
    hits: hits ?? [sampleImage()],
  );
}
