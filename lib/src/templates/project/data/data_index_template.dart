String dataIndexTemplate() => '''
export 'models/models.dart';
export 'services/api_client/api_client.dart';
export 'domain/use_case.dart';
export 'enums/request_method.dart';
export 'local/local_auth_data.dart';
export 'models/base_model.dart';
export 'models/error_response.dart';
export 'models/success_response.dart';
export 'utils/env_config.dart';
''';
