import '../../../generators/project_generator.dart';

String errorResponseTemplate(ProjectConfig config) => '''
import 'package:equatable/equatable.dart';

/// Error response model for ${config.projectName} API
class ErrorResponse extends Equatable {
  const ErrorResponse({
    required this.message,
    required this.statusCode,
    this.errors,
    this.data,
  });

  /// Create error response from JSON
  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      message: json['message'] as String? ?? 'Unknown error occurred',
      statusCode: json['status_code'] as int? ?? 500,
      errors: json['errors'] as Map<String, dynamic>?,
      data: json['data'],
    );
  }

  /// Error message
  final String message;

  /// HTTP status code
  final int statusCode;

  /// Field-specific errors (for validation errors)
  final Map<String, dynamic>? errors;

  /// Additional error data
  final dynamic data;

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status_code': statusCode,
      'errors': errors,
      'data': data,
    };
  }

  /// Check if this is a validation error
  bool get isValidationError => errors != null && errors!.isNotEmpty;

  /// Check if this is a network error
  bool get isNetworkError => statusCode >= 500;

  /// Check if this is an authentication error
  bool get isAuthError => statusCode == 401 || statusCode == 403;

  /// Check if this is a not found error
  bool get isNotFoundError => statusCode == 404;

  @override
  List<Object?> get props => [message, statusCode, errors, data];

  @override
  String toString() {
    return 'ErrorResponse(message: \$message, statusCode: \$statusCode, errors: \$errors)';
  }
}
''';
