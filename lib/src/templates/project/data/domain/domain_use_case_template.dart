import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String domainUseCaseTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';
import 'package:dartz/dartz.dart';

/// Base class for all use cases
abstract class UseCase<Type, Params> {
  Future<Either<Type, ErrorResponse>> call(Params params);
  
  Stream<Type> stream(Params params) async* {}
}

/// Use case with no parameters
abstract class NoParamsUseCase<Type> {
  Future<Either<Type, NoParams>> call();
}

/// Parameters base class
abstract class Params {
  const Params();
}

/// No parameters class
class NoParams extends Params {
  const NoParams();
}
''';
