import '../../../generators/project_generator.dart';

String networkIndexTemplate(ProjectConfig config) => '''
// Network layer exports for ${config.projectName}

// Core network service
export 'network_service.dart';

// Authentication
export 'auth_data_source.dart';

// HTTP interceptors
export 'api_interceptor.dart';

// Models and enums
export 'request_method.dart';
export 'error_response.dart';
export 'success_response.dart';
''';
