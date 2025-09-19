import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String useCasesTemplate(FeatureConfig config) => '''
import 'package:dartz/dartz.dart';
import 'package:${config.projectConfig.projectName}/core/core.dart';
import 'package:${config.projectConfig.projectName}/features/${config.featureName}/${config.featureName}_index.dart';

/* Create ${config.pascalCase} Use Case */
final create${config.pascalCase}UseCase = Create${config.pascalCase}UseCase();

class Create${config.pascalCase}UseCase extends UseCase<${config.pascalCase}, Create${config.pascalCase}Dto> {
  @override
  Future<Either<${config.pascalCase}, ErrorResponse>> call(Create${config.pascalCase}Dto params) async {
    final res = await ${config.camelCase}Repository.create${config.pascalCase}(params);
    return res.fold(Left.new, Right.new);
  }
}


/* Delete ${config.pascalCase} Use Case */
final delete${config.pascalCase}UseCase = Delete${config.pascalCase}UseCase();

class Delete${config.pascalCase}UseCase extends UseCase<SuccessResponse, String> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(String params) async {
    final res = await ${config.camelCase}Repository.delete${config.pascalCase}(params);
    return res.fold(Left.new, Right.new);
  }
}

/* Multiple ${config.pascalCase} Use Case */
final multiple${config.pascalCase}UseCase = Multiple${config.pascalCase}UseCase();

class Multiple${config.pascalCase}UseCase extends UseCase<List<${config.pascalCase}>, ${config.pascalCase}Params> {
  @override
  Future<Either<List<${config.pascalCase}>, ErrorResponse>> call(
    ${config.pascalCase}Params? params,
  ) async {
    final res = await ${config.camelCase}Repository.get${config.pascalCase}s(params);
    return res.fold(Left.new, Right.new);
  }
}

/* Single ${config.pascalCase} Use Case */
final single${config.pascalCase}UseCase = Single${config.pascalCase}UseCase();

class Single${config.pascalCase}UseCase extends UseCase<${config.pascalCase}, String> {
  @override
  Future<Either<${config.pascalCase}, ErrorResponse>> call(String params) async {
    final res = await ${config.camelCase}Repository.get${config.pascalCase}(params);
    return res.fold(Left.new, Right.new);
  }
}

/* Update ${config.pascalCase} Use Case */
final update${config.pascalCase}UseCase = Update${config.pascalCase}UseCase();

class Update${config.pascalCase}UseCase extends UseCase<${config.pascalCase}, Update${config.pascalCase}Dto> {
  @override
  Future<Either<${config.pascalCase}, ErrorResponse>> call(Update${config.pascalCase}Dto params) async {
    final res = await ${config.camelCase}Repository.update${config.pascalCase}(params);
    return res.fold(Left.new, Right.new);
  }
}
''';
