// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'api_response.dart';

class ApiResponseMapper extends ClassMapperBase<ApiResponse> {
  ApiResponseMapper._();

  static ApiResponseMapper? _instance;
  static ApiResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ApiResponseMapper._());
      ImageDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ApiResponse';

  static int _$total(ApiResponse v) => v.total;
  static const Field<ApiResponse, int> _f$total = Field('total', _$total);
  static int _$totalHits(ApiResponse v) => v.totalHits;
  static const Field<ApiResponse, int> _f$totalHits = Field(
    'totalHits',
    _$totalHits,
  );
  static List<ImageData> _$hits(ApiResponse v) => v.hits;
  static const Field<ApiResponse, List<ImageData>> _f$hits = Field(
    'hits',
    _$hits,
  );

  @override
  final MappableFields<ApiResponse> fields = const {
    #total: _f$total,
    #totalHits: _f$totalHits,
    #hits: _f$hits,
  };

  static ApiResponse _instantiate(DecodingData data) {
    return ApiResponse(
      total: data.dec(_f$total),
      totalHits: data.dec(_f$totalHits),
      hits: data.dec(_f$hits),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ApiResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ApiResponse>(map);
  }

  static ApiResponse fromJson(String json) {
    return ensureInitialized().decodeJson<ApiResponse>(json);
  }
}

mixin ApiResponseMappable {
  String toJson() {
    return ApiResponseMapper.ensureInitialized().encodeJson<ApiResponse>(
      this as ApiResponse,
    );
  }

  Map<String, dynamic> toMap() {
    return ApiResponseMapper.ensureInitialized().encodeMap<ApiResponse>(
      this as ApiResponse,
    );
  }

  ApiResponseCopyWith<ApiResponse, ApiResponse, ApiResponse> get copyWith =>
      _ApiResponseCopyWithImpl<ApiResponse, ApiResponse>(
        this as ApiResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ApiResponseMapper.ensureInitialized().stringifyValue(
      this as ApiResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return ApiResponseMapper.ensureInitialized().equalsValue(
      this as ApiResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return ApiResponseMapper.ensureInitialized().hashValue(this as ApiResponse);
  }
}

extension ApiResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ApiResponse, $Out> {
  ApiResponseCopyWith<$R, ApiResponse, $Out> get $asApiResponse =>
      $base.as((v, t, t2) => _ApiResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ApiResponseCopyWith<$R, $In extends ApiResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, ImageData, ImageDataCopyWith<$R, ImageData, ImageData>>
  get hits;
  $R call({int? total, int? totalHits, List<ImageData>? hits});
  ApiResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ApiResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ApiResponse, $Out>
    implements ApiResponseCopyWith<$R, ApiResponse, $Out> {
  _ApiResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ApiResponse> $mapper =
      ApiResponseMapper.ensureInitialized();
  @override
  ListCopyWith<$R, ImageData, ImageDataCopyWith<$R, ImageData, ImageData>>
  get hits => ListCopyWith(
    $value.hits,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(hits: v),
  );
  @override
  $R call({int? total, int? totalHits, List<ImageData>? hits}) => $apply(
    FieldCopyWithData({
      if (total != null) #total: total,
      if (totalHits != null) #totalHits: totalHits,
      if (hits != null) #hits: hits,
    }),
  );
  @override
  ApiResponse $make(CopyWithData data) => ApiResponse(
    total: data.get(#total, or: $value.total),
    totalHits: data.get(#totalHits, or: $value.totalHits),
    hits: data.get(#hits, or: $value.hits),
  );

  @override
  ApiResponseCopyWith<$R2, ApiResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ApiResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

