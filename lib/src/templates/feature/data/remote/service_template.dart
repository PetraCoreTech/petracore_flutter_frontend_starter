import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String serviceTemplate(ProjectConfig project, FeatureConfig config) => '''
import 'package:dio/dio.dart';
import 'package:${project.projectName}/core/core.dart';
import 'package:${project.projectName}/features/${config.featureName}/${config.featureName}_index.dart';

final ${config.camelEntity}Service = ${config.pascalEntity}Service(apiClient);

abstract class ${config.pascalEntity}ServiceInterface {
  Future<Response<dynamic>> create${config.pascalEntity}(Create${config.pascalEntity}Dto data);

  Future<Response<dynamic>> delete${config.pascalEntity}(String id);

  Future<Response<dynamic>> get${config.pascalEntity}();

  Future<Response<dynamic>> update${config.pascalEntity}(
    Update${config.pascalEntity}Dto data,
  );
}

class ${config.pascalEntity}Service implements ${config.pascalEntity}ServiceInterface {
  ${config.pascalEntity}Service(this.apiClient);
  final ApiClient apiClient;

  @override
  Future<Response> create${config.pascalEntity}(Create${config.pascalEntity}Dto data) async {
    final response = await apiClient.post(
      '/${config.entityName}',
      data: data.toJson(),
      reqToken: true,
    );
    return response;
  }

  @override
  Future<Response> delete${config.pascalEntity}(String id) async {
    final response = await apiClient.delete(
      '/${config.entityName}/\$id',
      reqToken: true,
    );
    return response;
  }

  @override
  Future<Response> get${config.pascalEntity}({
    bool isSingle = false,
    String? id,
    Json? queryParams,
  }) async {
    final pathParam = isSingle ? '/\$id' : '';
    final response = await apiClient.get(
      '/${config.entityName}\$pathParam',
      reqToken: true,
      queryParams: queryParams,
    );
    return response;
  }

  @override
  Future<Response> update${config.pascalEntity}(
    Update${config.pascalEntity}Dto data,
  ) async {
    final response = await apiClient.put(
      '/${config.entityName}/\${data.id}',
      data: data.toJson(),
      reqToken: true,
    );
    return response;
  }
}  
''';
