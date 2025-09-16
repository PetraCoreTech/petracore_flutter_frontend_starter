import '../../../generators/project_generator.dart';

String exampleApiServiceTemplate(ProjectConfig config) => '''
import 'package:dio/dio.dart';
import 'network_service.dart';
import 'request_method.dart';

/// Example API service demonstrating how to use the network layer for ${config.projectName}
/// This shows patterns for different types of API calls with token authentication
class ExampleApiService {
  const ExampleApiService();

  /// Login user - Public endpoint (no token required)
  Future<Response<dynamic>> login({
    required String email,
    required String password,
  }) async {
    return networkService.makeRequest(
      '/auth/login',
      RequestMethod.post,
      data: {
        'email': email,
        'password': password,
      },
      reqToken: false, // Public endpoint
    );
  }

  /// Get user profile - Protected endpoint (token required)
  Future<Response<dynamic>> getUserProfile() async {
    return networkService.makeRequest(
      '/user/profile',
      RequestMethod.get,
      reqToken: true, // Requires authentication token
    );
  }

  /// Update user profile - Protected endpoint with data
  Future<Response<dynamic>> updateUserProfile({
    required String name,
    required String email,
  }) async {
    return networkService.makeRequest(
      '/user/profile',
      RequestMethod.put,
      data: {
        'name': name,
        'email': email,
      },
      reqToken: true, // Requires authentication token
    );
  }

  /// Get posts with pagination - Protected endpoint with query parameters
  Future<Response<dynamic>> getPosts({
    int page = 1,
    int limit = 20,
    String? search,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
    };

    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }

    return networkService.makeRequest(
      '/posts',
      RequestMethod.get,
      queryParams: queryParams,
      reqToken: true,
    );
  }

  /// Upload file with progress - Protected endpoint with file upload
  Future<Response<dynamic>> uploadFile({
    required String filePath,
    required String fileName,
    void Function(int, int)? onProgress,
  }) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: fileName),
    });

    return networkService.makeRequest(
      '/upload',
      RequestMethod.post,
      data: formData,
      reqToken: true,
      onSendProgress: onProgress,
    );
  }

  /// Delete post - Protected endpoint with path parameter
  Future<Response<dynamic>> deletePost(int postId) async {
    return networkService.makeRequest(
      '/posts/\$postId',
      RequestMethod.delete,
      reqToken: true,
    );
  }

  /// Refresh token - Special endpoint for token refresh
  Future<Response<dynamic>> refreshToken(String refreshToken) async {
    return networkService.makeRequest(
      '/auth/refresh',
      RequestMethod.post,
      data: {
        'refresh_token': refreshToken,
      },
      reqToken: false, // Don't add token header for refresh endpoint
    );
  }

  /// Logout - Protected endpoint
  Future<Response<dynamic>> logout() async {
    return networkService.makeRequest(
      '/auth/logout',
      RequestMethod.post,
      reqToken: true,
    );
  }
}

/// Global instance of the API service
final exampleApiService = ExampleApiService();

/*
Usage Examples:

1. Login:
   final response = await exampleApiService.login(
     email: 'user@example.com',
     password: 'password123',
   );

2. Get user profile (automatically adds auth token):
   final response = await exampleApiService.getUserProfile();

3. Get paginated posts with search:
   final response = await exampleApiService.getPosts(
     page: 1,
     limit: 10,
     search: 'flutter',
   );

4. Upload file with progress:
   final response = await exampleApiService.uploadFile(
     filePath: '/path/to/file.jpg',
     fileName: 'profile.jpg',
     onProgress: (sent, total) {
       print('Upload progress: \${(sent / total * 100).toStringAsFixed(2)}%');
     },
   );

5. The network service automatically:
   - Adds authentication token when reqToken: true
   - Handles token refresh on 401 errors
   - Retries failed requests after token refresh
   - Logs requests/responses in debug mode
   - Manages timeout and error handling

6. Token management is handled by AuthDataSource:
   - Tokens are stored securely using FlutterSecureStorage
   - Access and refresh tokens are managed automatically
   - Clear all data on logout: authDataSource.clearStorage()
*/
''';
