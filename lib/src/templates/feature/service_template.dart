import '../../generators/feature_generator.dart';

String serviceTemplate(FeatureConfig config) => '''
import 'package:dio/dio.dart';
import 'dto/dto.dart';

class ${config.pascalCase}Service {
  final Dio dio;
  
  ${config.pascalCase}Service(this.dio);
  
  Future<List<${config.pascalCase}Dto>> get${config.pascalCase}List() async {
    try {
      final response = await dio.get('/${config.featureName}');
      final List<dynamic> data = response.data;
      return data.map((json) => ${config.pascalCase}Dto.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch ${config.featureName} list: \$e');
    }
  }
  
  Future<${config.pascalCase}Dto> get${config.pascalCase}ById(String id) async {
    try {
      final response = await dio.get('/${config.featureName}/\$id');
      return ${config.pascalCase}Dto.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch ${config.featureName}: \$e');
    }
  }
  
  Future<${config.pascalCase}Dto> create${config.pascalCase}(${config.pascalCase}Dto dto) async {
    try {
      final response = await dio.post(
        '/${config.featureName}',
        data: dto.toJson(),
      );
      return ${config.pascalCase}Dto.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create ${config.featureName}: \$e');
    }
  }
  
  Future<${config.pascalCase}Dto> update${config.pascalCase}(String id, ${config.pascalCase}Dto dto) async {
    try {
      final response = await dio.put(
        '/${config.featureName}/\$id',
        data: dto.toJson(),
      );
      return ${config.pascalCase}Dto.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update ${config.featureName}: \$e');
    }
  }
  
  Future<bool> delete${config.pascalCase}(String id) async {
    try {
      await dio.delete('/${config.featureName}/\$id');
      return true;
    } catch (e) {
      throw Exception('Failed to delete ${config.featureName}: \$e');
    }
  }
}
''';
