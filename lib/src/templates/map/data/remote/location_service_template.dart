import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String locationServiceTemplate(ProjectConfig config) => '''
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:${config.packageName}/core/core.dart';

final locationService = LocationService();

class LocationService {
  LocationService() {
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(requestBody: true));
    }
  }

  String get apiKey => dotenv.env['google_api_key']!;
  final dio = Dio(BaseOptions(baseUrl: 'https://maps.googleapis.com'));

  Future<Response<dynamic>> getNearbyPlaces({Map<String, dynamic>? queryParams}) async {
    queryParams ??= <String, dynamic>{};
    queryParams['key'] = apiKey;
    final response = await dio.get<dynamic>(
      '/maps/api/place/nearbysearch/json',
      queryParameters: queryParams,
    );
    return response;
  }
}
''';
