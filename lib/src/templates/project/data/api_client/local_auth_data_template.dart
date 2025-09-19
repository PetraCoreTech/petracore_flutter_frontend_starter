String localAuthDataTemplate() => '''
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final localAuthData = LocalAuthData();

class LocalAuthData {
  final _secureStorage = const FlutterSecureStorage();

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

  /// Set access token
  Future<void> setToken(String value) async {
    await _secureStorage.write(key: _tokenKey, value: value);
  }

  /// Set refresh token
  Future<void> setRefreshToken(String value) async {
    await _secureStorage.write(key: _refreshTokenKey, value: value);
  }

  /// Clear all stored data
  void clearStorage() => _secureStorage.deleteAll();

  // Storage keys
  static const String _tokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
}
''';
