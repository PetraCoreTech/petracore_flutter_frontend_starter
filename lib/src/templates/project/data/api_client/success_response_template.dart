String successResponseTemplate() => '''
class SuccessResponse {
  SuccessResponse({
    this.success,
    this.message,
  });

  SuccessResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    message = json['message'] as String?;
  }

  bool? success;
  String? message;
}
''';
