import '../../../generators/project_generator.dart';

String authDataSourceTemplate(ProjectConfig config) => '''
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Global instance of AuthDataSource for ${config.projectName}
final authDataSource = AuthDataSource();

/// Auth data source for secure token storage and management
class AuthDataSource {
  final _secureStorage = const FlutterSecureStorage();

  /// Get secure storage instance
  FlutterSecureStorage get storage => _secureStorage;

  /// Get access token
  Future<String> get token async {
    final res = await _secureStorage.read(key: _tokenKey);
    return res ?? '';
  }

  /// Get refresh token
  Future<String> get refreshToken async {
    final res = await _secureStorage.read(key: _refreshTokenKey);
    return res ?? '';
  }

  /// Get user profile data
  Future<String> get profile async {
    final res = await _secureStorage.read(key: _profileKey);
    return res ?? '';
  }

  /// Set access token
  Future<void> setToken(String value) async {
    await _secureStorage.write(key: _tokenKey, value: value);
  }

  /// Set refresh token
  Future<void> setRefreshToken(String value) async {
    await _secureStorage.write(key: _refreshTokenKey, value: value);
  }

  /// Set user profile data
  Future<void> setProfile(String value) async {
    await _secureStorage.write(key: _profileKey, value: value);
  }

  /// Clear all stored data
  void clearStorage() => _secureStorage.deleteAll();

  /// Check if user is authenticated
  Future<bool> get isAuthenticated async {
    final token = await this.token;
    return token.isNotEmpty;
  }

  // Storage keys
  static const String _tokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _profileKey = 'profile';
}
''';
