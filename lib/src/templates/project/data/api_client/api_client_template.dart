import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String apiClientTemplate(ProjectConfig config) => '''
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/core/data/services/api_client/api_client_index.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

typedef Json = Map<String, dynamic>;

final baseOptions = BaseOptions(
  baseUrl: Env.apiBaseUrl,
  connectTimeout: Duration(milliseconds: Env.apiTimeout),
  receiveTimeout: Duration(milliseconds: Env.apiTimeout),
  sendTimeout: Duration(milliseconds: Env.apiTimeout),
);

final dio = Dio(baseOptions);

final apiClient = ApiClient(dio);

class ApiClient {
  ApiClient(this.dio) {
    if (kDebugMode) {
      dio.interceptors
        ..add(
          PrettyDioLogger(
            requestBody: true,
            requestHeader: true,
            responseHeader: true,
            responseBody: true,
            error: true,
            compact: true,
            maxWidth: 90,
          ),
        )
        ..add(ApiInterceptor(localAuthData));
    } else {
      dio.interceptors.add(ApiInterceptor(localAuthData));
    }
  }

  final Dio dio;

  /// Default query parameters for all requests
  Json get requiredParams => Json();

  final _interString = InterceptorString();

  /// Make an HTTP request with automatic token handling
  ///
  /// [path] - The API endpoint path
  /// [method] - HTTP method (GET, POST, PUT, PATCH, DELETE)
  /// [queryParams] - Query parameters for the request
  /// [headers] - Additional headers
  /// [reqToken] - Whether this request requires authentication token
  /// [data] - Request body data
  /// [cancelToken] - Token to cancel the request
  /// [onReceiveProgress] - Progress callback for downloads
  /// [onSendProgress] - Progress callback for uploads
  Future<Response<dynamic>> makeRequest(
    String path,
    RequestMethod method, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    bool reqToken = false,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    dynamic data,
  }) async {
    queryParams ??= requiredParams;
    headers ??= Json();

    // Mark request as requiring token
    if (reqToken) {
      headers[_interString.reqToken] = true;
    }

    final options = Options(headers: headers);

    return switch (method) {
      RequestMethod.post => dio.post(
          path,
          queryParameters: queryParams,
          data: data,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
        ),
      RequestMethod.get => dio.get(
          path,
          queryParameters: queryParams,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        ),
      RequestMethod.delete => dio.delete(
          path,
          queryParameters: queryParams,
          data: data,
          options: options,
          cancelToken: cancelToken,
        ),
      RequestMethod.put => dio.put(
          path,
          queryParameters: queryParams,
          data: data,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
        ),
      RequestMethod.patch => dio.patch(
          path,
          queryParameters: queryParams,
          data: data,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
        ),
    };
  }

  /// Convenience method for GET requests
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    bool reqToken = false,
    CancelToken? cancelToken,
  }) =>
      makeRequest(
        path,
        RequestMethod.get,
        queryParams: queryParams,
        headers: headers,
        reqToken: reqToken,
        cancelToken: cancelToken,
      );

  /// Convenience method for POST requests
  Future<Response<dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    bool reqToken = false,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
  }) =>
      makeRequest(
        path,
        RequestMethod.post,
        data: data,
        queryParams: queryParams,
        headers: headers,
        reqToken: reqToken,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );

  /// Convenience method for PUT requests
  Future<Response<dynamic>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    bool reqToken = false,
    CancelToken? cancelToken,
  }) =>
      makeRequest(
        path,
        RequestMethod.put,
        data: data,
        queryParams: queryParams,
        headers: headers,
        reqToken: reqToken,
        cancelToken: cancelToken,
      );

  /// Convenience method for PATCH requests
  Future<Response<dynamic>> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    bool reqToken = false,
    CancelToken? cancelToken,
  }) =>
      makeRequest(
        path,
        RequestMethod.patch,
        data: data,
        queryParams: queryParams,
        headers: headers,
        reqToken: reqToken,
        cancelToken: cancelToken,
      );

  /// Convenience method for DELETE requests
  Future<Response<dynamic>> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    bool reqToken = false,
    CancelToken? cancelToken,
  }) =>
      makeRequest(
        path,
        RequestMethod.delete,
        data: data,
        queryParams: queryParams,
        headers: headers,
        reqToken: reqToken,
        cancelToken: cancelToken,
      );
}
''';
