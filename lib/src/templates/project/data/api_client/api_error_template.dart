import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String apiErrorTemplate(ProjectConfig config) => '''
import 'package:dio/dio.dart';
import 'package:${config.projectName}/core/core.dart';

///
class ApiError {
  ApiError._();

  ///
  static ErrorResponse handleError(Object error) {
    try {
      if (error is! DioException) {
        return ErrorResponse(message: 'Unknown Error');
      }

      final dioError = error;
      final type = dioError.type;
      final response = dioError.response;

      switch (type) {
        case DioExceptionType.cancel:
          return ErrorResponse(message: 'Request Cancelled');

        case DioExceptionType.connectionTimeout:
          return ErrorResponse(message: 'Connection time out!');

        case DioExceptionType.sendTimeout:
          return ErrorResponse(message: 'Timeout error');

        case DioExceptionType.receiveTimeout:
          return ErrorResponse(message: 'Timeout error');

        case DioExceptionType.connectionError:
          return ErrorResponse(message: 'No internet connection');

        case DioExceptionType.unknown:
          return ErrorResponse(message: 'Unknown error');

        case DioExceptionType.badCertificate:
          return ErrorResponse(message: 'Bad certificate');

        case DioExceptionType.badResponse:
          if (response == null || response.data == null) {
            return ErrorResponse(message: 'Unknown error');
          }
          final data = response.data as Json;
          data['status'] = response.statusCode?.toStatusCode();
          return ErrorResponse.fromJson(data);
      }
    } catch (_) {
      return ErrorResponse(message: 'Error when processing response');
    }
  }
}

///
extension StatusCodeIntExt on int {
  ///
  ResponseStatus toStatusCode() {
    return switch (this) {
      400 => ResponseStatus.http400,
      401 => ResponseStatus.http401,
      402 => ResponseStatus.http402,
      403 => ResponseStatus.http403,
      404 => ResponseStatus.http404,
      int() => ResponseStatus.http500,
    };
  }
}
''';
