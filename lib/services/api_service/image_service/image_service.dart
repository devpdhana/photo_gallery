import 'package:dio/dio.dart';

import '../../../data/api_response.dart';
import '../../../helpers/app_constants.dart';
import 'i_image_service.dart';

class ImageService implements IImageService {
  @override
  Future<ApiResponse> fetchImages({
    required int page,
    required String query,
    required int perPage,
  }) async {
    try {
      if (AppConstants.apiKey.isEmpty) {
        throw Exception(AppConstants.missingKeyMessage);
      }

      final parameters = <String, dynamic>{
        'key': AppConstants.apiKey,
        'page': page,
        'per_page': perPage,
        'image_type': 'photo',
        'safesearch': 'true',
      };
      if (query.isNotEmpty) {
        parameters['q'] = query;
      }

      final dio = Dio(
        BaseOptions(
          connectTimeout: AppConstants.requestTimeout,
          receiveTimeout: AppConstants.requestTimeout,
          responseType: ResponseType.json,
        ),
      );

      final response = await dio.get<dynamic>(
        AppConstants.baseUrl,
        queryParameters: parameters,
      );

      final data = response.data;
      if (data is Map<String, dynamic>) {
        return ApiResponseMapper.fromMap(data);
      }
      throw Exception('Pixabay sent an unexpected response.');
    } on Exception {
      rethrow;
    } catch (_) {
      throw Exception('Something went wrong. Please try again.');
    }
  }
}
