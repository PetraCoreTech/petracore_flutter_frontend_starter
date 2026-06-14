import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String businessStatusParserTemplate(ProjectConfig config) => '''
import 'package:json_annotation/json_annotation.dart';
import 'package:${config.packageName}/features/map/data/enums/business_status.dart';

class BusinessStatusConverter implements JsonConverter<BusinessStatus?, String?> {
  const BusinessStatusConverter();

  @override
  BusinessStatus? fromJson(String? status) => status?.fromJsonString();

  @override
  String? toJson(BusinessStatus? object) => object?.toJsonString();
}
''';
