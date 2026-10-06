// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'image_data.dart';

class ImageDataMapper extends ClassMapperBase<ImageData> {
  ImageDataMapper._();

  static ImageDataMapper? _instance;
  static ImageDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageDataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ImageData';

  static int _$id(ImageData v) => v.id;
  static const Field<ImageData, int> _f$id = Field('id', _$id);
  static String _$pageUrl(ImageData v) => v.pageUrl;
  static const Field<ImageData, String> _f$pageUrl = Field(
    'pageUrl',
    _$pageUrl,
    key: r'pageURL',
  );
  static String _$type(ImageData v) => v.type;
  static const Field<ImageData, String> _f$type = Field('type', _$type);
  static String _$tags(ImageData v) => v.tags;
  static const Field<ImageData, String> _f$tags = Field('tags', _$tags);
  static String _$previewUrl(ImageData v) => v.previewUrl;
  static const Field<ImageData, String> _f$previewUrl = Field(
    'previewUrl',
    _$previewUrl,
    key: r'previewURL',
  );
  static String _$webFormatUrl(ImageData v) => v.webFormatUrl;
  static const Field<ImageData, String> _f$webFormatUrl = Field(
    'webFormatUrl',
    _$webFormatUrl,
    key: r'webformatURL',
  );
  static String _$largeImageUrl(ImageData v) => v.largeImageUrl;
  static const Field<ImageData, String> _f$largeImageUrl = Field(
    'largeImageUrl',
    _$largeImageUrl,
    key: r'largeImageURL',
  );
  static int _$imageWidth(ImageData v) => v.imageWidth;
  static const Field<ImageData, int> _f$imageWidth = Field(
    'imageWidth',
    _$imageWidth,
  );
  static int _$imageHeight(ImageData v) => v.imageHeight;
  static const Field<ImageData, int> _f$imageHeight = Field(
    'imageHeight',
    _$imageHeight,
  );
  static int _$views(ImageData v) => v.views;
  static const Field<ImageData, int> _f$views = Field('views', _$views);
  static int _$downloads(ImageData v) => v.downloads;
  static const Field<ImageData, int> _f$downloads = Field(
    'downloads',
    _$downloads,
  );
  static int _$likes(ImageData v) => v.likes;
  static const Field<ImageData, int> _f$likes = Field('likes', _$likes);
  static int _$comments(ImageData v) => v.comments;
  static const Field<ImageData, int> _f$comments = Field(
    'comments',
    _$comments,
  );
  static String _$user(ImageData v) => v.user;
  static const Field<ImageData, String> _f$user = Field('user', _$user);
  static String _$userImageUrl(ImageData v) => v.userImageUrl;
  static const Field<ImageData, String> _f$userImageUrl = Field(
    'userImageUrl',
    _$userImageUrl,
    key: r'userImageURL',
  );

  @override
  final MappableFields<ImageData> fields = const {
    #id: _f$id,
    #pageUrl: _f$pageUrl,
    #type: _f$type,
    #tags: _f$tags,
    #previewUrl: _f$previewUrl,
    #webFormatUrl: _f$webFormatUrl,
    #largeImageUrl: _f$largeImageUrl,
    #imageWidth: _f$imageWidth,
    #imageHeight: _f$imageHeight,
    #views: _f$views,
    #downloads: _f$downloads,
    #likes: _f$likes,
    #comments: _f$comments,
    #user: _f$user,
    #userImageUrl: _f$userImageUrl,
  };

  static ImageData _instantiate(DecodingData data) {
    return ImageData(
      id: data.dec(_f$id),
      pageUrl: data.dec(_f$pageUrl),
      type: data.dec(_f$type),
      tags: data.dec(_f$tags),
      previewUrl: data.dec(_f$previewUrl),
      webFormatUrl: data.dec(_f$webFormatUrl),
      largeImageUrl: data.dec(_f$largeImageUrl),
      imageWidth: data.dec(_f$imageWidth),
      imageHeight: data.dec(_f$imageHeight),
      views: data.dec(_f$views),
      downloads: data.dec(_f$downloads),
      likes: data.dec(_f$likes),
      comments: data.dec(_f$comments),
      user: data.dec(_f$user),
      userImageUrl: data.dec(_f$userImageUrl),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ImageData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ImageData>(map);
  }

  static ImageData fromJson(String json) {
    return ensureInitialized().decodeJson<ImageData>(json);
  }
}

mixin ImageDataMappable {
  String toJson() {
    return ImageDataMapper.ensureInitialized().encodeJson<ImageData>(
      this as ImageData,
    );
  }

  Map<String, dynamic> toMap() {
    return ImageDataMapper.ensureInitialized().encodeMap<ImageData>(
      this as ImageData,
    );
  }

  ImageDataCopyWith<ImageData, ImageData, ImageData> get copyWith =>
      _ImageDataCopyWithImpl<ImageData, ImageData>(
        this as ImageData,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ImageDataMapper.ensureInitialized().stringifyValue(
      this as ImageData,
    );
  }

  @override
  bool operator ==(Object other) {
    return ImageDataMapper.ensureInitialized().equalsValue(
      this as ImageData,
      other,
    );
  }

  @override
  int get hashCode {
    return ImageDataMapper.ensureInitialized().hashValue(this as ImageData);
  }
}

extension ImageDataValueCopy<$R, $Out> on ObjectCopyWith<$R, ImageData, $Out> {
  ImageDataCopyWith<$R, ImageData, $Out> get $asImageData =>
      $base.as((v, t, t2) => _ImageDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ImageDataCopyWith<$R, $In extends ImageData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? id,
    String? pageUrl,
    String? type,
    String? tags,
    String? previewUrl,
    String? webFormatUrl,
    String? largeImageUrl,
    int? imageWidth,
    int? imageHeight,
    int? views,
    int? downloads,
    int? likes,
    int? comments,
    String? user,
    String? userImageUrl,
  });
  ImageDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ImageDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ImageData, $Out>
    implements ImageDataCopyWith<$R, ImageData, $Out> {
  _ImageDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ImageData> $mapper =
      ImageDataMapper.ensureInitialized();
  @override
  $R call({
    int? id,
    String? pageUrl,
    String? type,
    String? tags,
    String? previewUrl,
    String? webFormatUrl,
    String? largeImageUrl,
    int? imageWidth,
    int? imageHeight,
    int? views,
    int? downloads,
    int? likes,
    int? comments,
    String? user,
    String? userImageUrl,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (pageUrl != null) #pageUrl: pageUrl,
      if (type != null) #type: type,
      if (tags != null) #tags: tags,
      if (previewUrl != null) #previewUrl: previewUrl,
      if (webFormatUrl != null) #webFormatUrl: webFormatUrl,
      if (largeImageUrl != null) #largeImageUrl: largeImageUrl,
      if (imageWidth != null) #imageWidth: imageWidth,
      if (imageHeight != null) #imageHeight: imageHeight,
      if (views != null) #views: views,
      if (downloads != null) #downloads: downloads,
      if (likes != null) #likes: likes,
      if (comments != null) #comments: comments,
      if (user != null) #user: user,
      if (userImageUrl != null) #userImageUrl: userImageUrl,
    }),
  );
  @override
  ImageData $make(CopyWithData data) => ImageData(
    id: data.get(#id, or: $value.id),
    pageUrl: data.get(#pageUrl, or: $value.pageUrl),
    type: data.get(#type, or: $value.type),
    tags: data.get(#tags, or: $value.tags),
    previewUrl: data.get(#previewUrl, or: $value.previewUrl),
    webFormatUrl: data.get(#webFormatUrl, or: $value.webFormatUrl),
    largeImageUrl: data.get(#largeImageUrl, or: $value.largeImageUrl),
    imageWidth: data.get(#imageWidth, or: $value.imageWidth),
    imageHeight: data.get(#imageHeight, or: $value.imageHeight),
    views: data.get(#views, or: $value.views),
    downloads: data.get(#downloads, or: $value.downloads),
    likes: data.get(#likes, or: $value.likes),
    comments: data.get(#comments, or: $value.comments),
    user: data.get(#user, or: $value.user),
    userImageUrl: data.get(#userImageUrl, or: $value.userImageUrl),
  );

  @override
  ImageDataCopyWith<$R2, ImageData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ImageDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

