import '../../../generators/project_generator.dart';

String successResponseTemplate(ProjectConfig config) => '''
import 'package:equatable/equatable.dart';

/// Success response model for ${config.projectName} API
class SuccessResponse<T> extends Equatable {
  const SuccessResponse({
    required this.message,
    required this.statusCode,
    required this.data,
    this.meta,
  });

  /// Create success response from JSON
  factory SuccessResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return SuccessResponse<T>(
      message: json['message'] as String? ?? 'Success',
      statusCode: json['status_code'] as int? ?? 200,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      meta: json['meta'] as Map<String, dynamic>?,
    );
  }

  /// Create success response with list data
  factory SuccessResponse.fromJsonList(
    Map<String, dynamic> json,
    T Function(List<dynamic>) fromJsonT,
  ) {
    return SuccessResponse<T>(
      message: json['message'] as String? ?? 'Success',
      statusCode: json['status_code'] as int? ?? 200,
      data: json['data'] != null ? fromJsonT(json['data'] as List<dynamic>) : null,
      meta: json['meta'] as Map<String, dynamic>?,
    );
  }

  /// Success message
  final String message;

  /// HTTP status code
  final int statusCode;

  /// Response data
  final T? data;

  /// Additional metadata (pagination, etc.)
  final Map<String, dynamic>? meta;

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status_code': statusCode,
      'data': data,
      'meta': meta,
    };
  }

  /// Check if response has data
  bool get hasData => data != null;

  /// Get pagination info from meta
  Map<String, dynamic>? get pagination => meta?['pagination'] as Map<String, dynamic>?;

  /// Check if there are more pages
  bool get hasNextPage {
    final paging = pagination;
    if (paging == null) return false;
    
    final currentPage = paging['current_page'] as int? ?? 1;
    final totalPages = paging['total_pages'] as int? ?? 1;
    
    return currentPage < totalPages;
  }

  /// Get current page number
  int get currentPage => pagination?['current_page'] as int? ?? 1;

  /// Get total pages
  int get totalPages => pagination?['total_pages'] as int? ?? 1;

  /// Get total items count
  int get totalItems => pagination?['total'] as int? ?? 0;

  @override
  List<Object?> get props => [message, statusCode, data, meta];

  @override
  String toString() {
    return 'SuccessResponse(message: \$message, statusCode: \$statusCode, data: \$data)';
  }
}
''';
