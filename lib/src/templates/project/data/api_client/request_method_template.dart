String requestMethodTemplate() => '''
enum RequestMethod {get, post, put, patch, delete}

enum ResponseStatus {
  http200,
  http201,
  http400,
  http401,
  http402,
  http403,
  http404,
  http500,
  serverError,
  timeout,
}
''';
