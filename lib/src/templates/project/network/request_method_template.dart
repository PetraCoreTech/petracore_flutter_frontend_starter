import '../../../generators/project_generator.dart';

String requestMethodTemplate(ProjectConfig config) => '''
/// HTTP request method enumeration for ${config.projectName}
enum RequestMethod {
  /// GET request
  get,

  /// POST request
  post,

  /// PUT request
  put,

  /// PATCH request
  patch,

  /// DELETE request
  delete,
}
''';
