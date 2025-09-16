import '../../generators/feature_generator.dart';

String repositoryTemplate(FeatureConfig config) => '''
import 'package:dartz/dartz.dart';
import '../models/models.dart';

abstract class ${config.pascalCase}Repository {
  Future<Either<String, List<${config.pascalCase}Model>>> get${config.pascalCase}List();
  Future<Either<String, ${config.pascalCase}Model>> get${config.pascalCase}ById(String id);
  Future<Either<String, ${config.pascalCase}Model>> create${config.pascalCase}(${config.pascalCase}Model model);
  Future<Either<String, ${config.pascalCase}Model>> update${config.pascalCase}(${config.pascalCase}Model model);
  Future<Either<String, bool>> delete${config.pascalCase}(String id);
}

class ${config.pascalCase}RepositoryImpl implements ${config.pascalCase}Repository {
  // Add your data sources here (API, local storage, etc.)
  
  @override
  Future<Either<String, List<${config.pascalCase}Model>>> get${config.pascalCase}List() async {
    try {
      // TODO: Implement API call or data fetching logic
      final List<${config.pascalCase}Model> items = [];
      return Right(items);
    } catch (e) {
      return Left('Failed to fetch ${config.featureName} list: \$e');
    }
  }

  @override
  Future<Either<String, ${config.pascalCase}Model>> get${config.pascalCase}ById(String id) async {
    try {
      // TODO: Implement get by ID logic
      throw UnimplementedError('get${config.pascalCase}ById not implemented');
    } catch (e) {
      return Left('Failed to fetch ${config.featureName}: \$e');
    }
  }

  @override
  Future<Either<String, ${config.pascalCase}Model>> create${config.pascalCase}(${config.pascalCase}Model model) async {
    try {
      // TODO: Implement create logic
      return Right(model);
    } catch (e) {
      return Left('Failed to create ${config.featureName}: \$e');
    }
  }

  @override
  Future<Either<String, ${config.pascalCase}Model>> update${config.pascalCase}(${config.pascalCase}Model model) async {
    try {
      // TODO: Implement update logic
      return Right(model);
    } catch (e) {
      return Left('Failed to update ${config.featureName}: \$e');
    }
  }

  @override
  Future<Either<String, bool>> delete${config.pascalCase}(String id) async {
    try {
      // TODO: Implement delete logic
      return const Right(true);
    } catch (e) {
      return Left('Failed to delete ${config.featureName}: \$e');
    }
  }
}
''';
