import 'package:dart_mappable/dart_mappable.dart';

part 'image_data.mapper.dart';

@MappableClass()
class ImageData with ImageDataMappable {
  const ImageData({
    required this.id,
    @MappableField(key: 'pageURL') required this.pageUrl,
    required this.type,
    required this.tags,
    @MappableField(key: 'previewURL') required this.previewUrl,
    @MappableField(key: 'webformatURL') required this.webFormatUrl,
    @MappableField(key: 'largeImageURL') required this.largeImageUrl,
    required this.imageWidth,
    required this.imageHeight,
    required this.views,
    required this.downloads,
    required this.likes,
    required this.comments,
    required this.user,
    @MappableField(key: 'userImageURL') required this.userImageUrl,
  });

  final int id;
  final String pageUrl;
  final String type;
  final String tags;
  final String previewUrl;
  final String webFormatUrl;
  final String largeImageUrl;
  final int imageWidth;
  final int imageHeight;
  final int views;
  final int downloads;
  final int likes;
  final int comments;
  final String user;
  final String userImageUrl;

  String get description => tags.isEmpty ? 'No description available.' : tags;
}
