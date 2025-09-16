
import '../../generators/feature_generator.dart';

String getUseCaseTemplate(FeatureConfig config) => '''
import 'package:dartz/dartz.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

class Get${config.pascalCase}UseCase {
  final ${config.pascalCase}Repository repository;

  const Get${config.pascalCase}UseCase(this.repository);

  Future<Either<String, List<${config.pascalCase}Model>>> call() async {
    return await repository.get${config.pascalCase}List();
  }
}

class Get${config.pascalCase}ByIdUseCase {
  final ${config.pascalCase}Repository repository;

  const Get${config.pascalCase}ByIdUseCase(this.repository);

  Future<Either<String, ${config.pascalCase}Model>> call(String id) async {
    return await repository.get${config.pascalCase}ById(id);
  }
}
''';
