String successResponseTemplate() => '''
class SuccessResponse {
  SuccessResponse({
    this.success,
    this.message,
  });

  SuccessResponse.fromJson(Json json) {
    success = json['success'] as bool?;
    message = json['message'] as String?;
  }

  bool? success;
  String? message;
}
''';
