import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String serviceTemplate(ProjectConfig project, FeatureConfig config) => '''
import 'package:dio/dio.dart';
import 'package:${project.projectName}/core/core.dart';
import 'package:${project.projectName}/features/${config.featureName}/${config.featureName}_index.dart';

final ${config.camelCase}Service = ${config.pascalCase}Service(apiClient);

abstract class ${config.pascalCase}Interface {
  Future<Response<dynamic>> create${config.pascalCase}(Create${config.pascalCase}Dto data);

  Future<Response<dynamic>> delete${config.pascalCase}(String id);

  Future<Response<dynamic>> get${config.pascalCase}();

  Future<Response<dynamic>> update${config.pascalCase}(
    Update${config.pascalCase}Dto data,
  );
}

class ${config.pascalCase}Service implements ${config.pascalCase}ServiceInterface {
  ${config.pascalCase}Service(this.apiClient);
  final ApiClient apiClient;

  @override
  Future<Response> create${config.pascalCase}(Create${config.pascalCase}Dto data) async {
    final response = await apiClient.post(
      '/${config.featureName}',
      data: data.toJson(),
      reqToken: true,
    );
    return response;
  }

  @override
  Future<Response> delete${config.pascalCase}(String id) async {
    final response = await apiClient.delete(
      '/${config.featureName}/\$id',
      reqToken: true,
    );
    return response;
  }

  @override
  Future<Response> get${config.pascalCase}({
    bool isSingle = false,
    String? id,
    Json? queryParams,
  }) async {
    final pathParam = isSingle ? '/\$id' : '';
    final response = await apiClient.get(
      '/${config.featureName}\$pathParam',
      reqToken: true,
      queryParams: queryParams,
    );
    return response;
  }

  @override
  Future<Response> update${config.pascalCase}(
    Update${config.pascalCase}Dto data,
  ) async {
    final response = await apiClient.put(
      '/${config.featureName}/\${data.id}',
      data: data.toJson(),
      reqToken: true,
    );
    return response;
  }
''';
