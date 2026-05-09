import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String useCasesTemplate(FeatureConfig config) => '''
import 'package:dartz/dartz.dart';
import 'package:${config.projectConfig.projectName}/core/core.dart';
import 'package:${config.projectConfig.projectName}/features/${config.featureName}/${config.featureName}_index.dart';

/* Create ${config.pascalEntity} Use Case */
final create${config.pascalEntity}UseCase = Create${config.pascalEntity}UseCase();

class Create${config.pascalEntity}UseCase extends UseCase<${config.pascalEntity}, Create${config.pascalEntity}Dto> {
  @override
  Future<Either<${config.pascalEntity}, ErrorResponse>> call(Create${config.pascalEntity}Dto params) async {
    final res = await ${config.camelEntity}Repository.create${config.pascalEntity}(params);
    return res.fold(Left.new, Right.new);
  }
}


/* Delete ${config.pascalEntity} Use Case */
final delete${config.pascalEntity}UseCase = Delete${config.pascalEntity}UseCase();

class Delete${config.pascalEntity}UseCase extends UseCase<SuccessResponse, String> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(String params) async {
    final res = await ${config.camelEntity}Repository.delete${config.pascalEntity}(params);
    return res.fold(Left.new, Right.new);
  }
}

/* Multiple ${config.pascalEntity} Use Case */
final multiple${config.pascalEntity}UseCase = Multiple${config.pascalEntity}UseCase();

class Multiple${config.pascalEntity}UseCase extends UseCase<List<${config.pascalEntity}>, ${config.pascalEntity}Params> {
  @override
  Future<Either<List<${config.pascalEntity}>, ErrorResponse>> call(
    ${config.pascalEntity}Params? params,
  ) async {
    final res = await ${config.camelEntity}Repository.get${config.pascalEntity}s(params);
    return res.fold(Left.new, Right.new);
  }
}

/* Single ${config.pascalEntity} Use Case */
final single${config.pascalEntity}UseCase = Single${config.pascalEntity}UseCase();

class Single${config.pascalEntity}UseCase extends UseCase<${config.pascalEntity}, String> {
  @override
  Future<Either<${config.pascalEntity}, ErrorResponse>> call(String params) async {
    final res = await ${config.camelEntity}Repository.get${config.pascalEntity}(params);
    return res.fold(Left.new, Right.new);
  }
}

/* Update ${config.pascalEntity} Use Case */
final update${config.pascalEntity}UseCase = Update${config.pascalEntity}UseCase();

class Update${config.pascalEntity}UseCase extends UseCase<${config.pascalEntity}, Update${config.pascalEntity}Dto> {
  @override
  Future<Either<${config.pascalEntity}, ErrorResponse>> call(Update${config.pascalEntity}Dto params) async {
    final res = await ${config.camelEntity}Repository.update${config.pascalEntity}(params);
    return res.fold(Left.new, Right.new);
  }
}
''';
