String interceptorStringsTemplate() => '''
part of 'api_interceptor.dart';

/// String constants for HTTP headers and values
class InterceptorString {
  /// Header key to indicate that a request requires authentication token
  final reqToken = 'requires_token';
  
  // Header keys
  final auth = 'Authorization';
  final accept = 'Accept';
  final contentType = 'content-type';
  
  // Header values
  /// Authorization header value with Token token
  String authValue(String token) => 'Token \$token';
  
  /// Accept header value for JSON responses
  String get acceptValue => 'application/json';
  
  /// Content-Type for JSON requests
  final acceptJson = 'application/json';
  
  /// Content-Type for multipart form data
  final multiForm = 'multipart/form-data';
}
''';
