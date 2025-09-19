String errorResponseTemplate() => '''
class ErrorResponse implements Exception {
  ErrorResponse({this.message, this.status});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    String? res;
    if (json.containsKey(_msgKey)) {
      res = json[_msgKey] as String?;
    } else if (json.containsKey(_errMsgKey)) {
      res = json[_errMsgKey] as String?;
    } else if (json.containsKey(_errsKey)) {
      final errors = json[_errsKey] as List<dynamic>;
      if (errors.isNotEmpty) {
        final error = errors.first as Json;
        final message = error['detail'] as String?;
        res = message;
      }
    } else {
      res = json[_errKey] as String?;
    }
    final input = res?.toLowerCase().capitalize();
    final status = json['status'] as ResponseStatus?;
    return ErrorResponse(message: input, status: status);
  }

  String? message;

  static const String _msgKey = 'message';

  static const String _errKey = 'error';

  static const String _errsKey = 'errors';

  static const String _errMsgKey = 'error_message';

  final ResponseStatus? status;
  
  Map<String, dynamic> json() {
    final map = <String, dynamic>{};
    map[_msgKey] = message;
    return map;
  }
}
''';
