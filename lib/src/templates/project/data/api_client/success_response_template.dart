String successResponseTemplate() => '''
class SuccessResponse {
  SuccessResponse({
    required this.message,
    this.success,
  });

  SuccessResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    message = (json['message'] as String?) ?? 'Action confirmed';
  }

  bool? success;
  late String message;
}
''';
