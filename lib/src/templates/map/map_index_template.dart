import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mapIndexTemplate(ProjectConfig config) => '''
export 'data/enums/business_status.dart';
export 'data/helpers/location_helper.dart';
export 'data/models/user_location_model.dart';
export 'data/models/nearby_place_model.dart';
export 'data/parsers/business_status_parser.dart';
export 'data/parsers/location_parser.dart';
export 'data/remote/dtos/place_params.dart';
export 'data/remote/location_repository.dart';
export 'data/remote/location_service.dart';
export 'data/use_cases/map_use_cases.dart';
''';
