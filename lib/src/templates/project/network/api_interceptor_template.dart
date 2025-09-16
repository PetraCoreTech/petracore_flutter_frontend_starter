import '../../../generators/project_generator.dart';

String apiInterceptorTemplate(ProjectConfig config) => '''
import 'dart:async';
import 'package:dio/dio.dart';
import 'auth_data_source.dart';
import 'network_service.dart';
import 'request_method.dart';

part 'interceptor_strings.dart';

/// API interceptor for ${config.projectName}
/// Handles token injection and refresh automatically
class ApiInterceptor extends Interceptor {
  /// Constructor
  ApiInterceptor(this.dataSource);

  /// Auth data source for token management
  final AuthDataSource dataSource;

  final _interStr = InterceptorString();
  Completer<void>? _refreshCompleter;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final headers = options.headers;
    
    // Add token if required
    if (headers.containsKey(_interStr.reqToken)) {
      final token = await dataSource.token;
      final profile = await dataSource.profile;
      headers.remove(_interStr.reqToken);
      headers[_interStr.auth] = _interStr.authValue(token);
      
      // Add extra headers if needed (customize based on your API requirements)
      if (profile.isNotEmpty) {
        headers['X-User-Profile'] = profile;
      }
    }
    
    // Set default headers
    headers[_interStr.accept] = _interStr.acceptValue;
    headers[_interStr.contentType] = _interStr.acceptJson;
    
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Handle 401 Unauthorized - token refresh
    if (err.response?.statusCode == 401) {
      final isCompleted = _refreshCompleter?.isCompleted ?? false;
      
      try {
        if (_refreshCompleter == null || isCompleted) {
          _refreshCompleter = Completer<void>();
          await _refreshToken();
          _refreshCompleter?.complete();
        } else {
          await _refreshCompleter?.future;
        }
        
        final response = await _retryRequest(err.requestOptions);
        handler.resolve(response);
        return;
      } catch (e) {
        _refreshCompleter?.completeError(e);
        _refreshCompleter = null;
        
        // Clear tokens on refresh failure
        await dataSource.clearStorage();
        
        handler.next(err);
        return;
      }
    }

    super.onError(err, handler);
  }

  /// Refresh token implementation
  Future<void> _refreshToken() async {
    final refreshToken = await dataSource.refreshToken;
    
    if (refreshToken.isEmpty) {
      throw Exception('No refresh token available');
    }

    final requestBody = {
      'refresh_token': refreshToken,
    };

    final response = await networkService.makeRequest(
      '/auth/refresh', // Customize this endpoint
      RequestMethod.post,
      data: requestBody,
    );

    final data = response.data as Map<String, dynamic>;
    final newToken = data['access_token'] as String?;
    final newRefreshToken = data['refresh_token'] as String?;

    if (newToken != null) {
      await dataSource.setToken(newToken);
    }
    
    if (newRefreshToken != null) {
      await dataSource.setRefreshToken(newRefreshToken);
    }
  }

  /// Retry failed request with new token
  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    final method = requestOptions.method.toRequestMethod();
    
    return networkService.makeRequest(
      requestOptions.path,
      method,
      reqToken: true,
      data: requestOptions.data,
      queryParams: requestOptions.queryParameters,
    );
  }
}

/// Extension to convert string to RequestMethod
extension RequestMethodStringExt on String? {
  /// Convert HTTP method string to RequestMethod enum
  RequestMethod toRequestMethod() {
    return switch (this) {
      'GET' => RequestMethod.get,
      'POST' => RequestMethod.post,
      'DELETE' => RequestMethod.delete,
      'PUT' => RequestMethod.put,
      'PATCH' => RequestMethod.patch,
      'HEAD' => RequestMethod.get,
      'OPTIONS' => RequestMethod.get,
      String() => RequestMethod.get,
      null => RequestMethod.get,
    };
  }
}
''';
