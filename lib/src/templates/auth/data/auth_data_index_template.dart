String authDataIndexTemplate() => '''
export 'models/auth_history_model.dart';
export 'models/user_model.dart';
export 'remote/dto/auth_dtos.dart';
export 'remote/auth_repository.dart';
export 'remote/auth_service.dart';
export 'domain/auth_use_cases.dart';
''';
