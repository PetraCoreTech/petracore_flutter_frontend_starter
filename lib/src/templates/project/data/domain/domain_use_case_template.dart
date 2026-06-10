import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String domainUseCaseTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';
import 'package:dartz/dartz.dart';

/// Base class for all use cases
abstract class UseCase<T, P> {
  Future<Either<T, ErrorResponse>> call(P params);

  Stream<T> stream(P params) async* {}
}

/// Use case with no parameters
abstract class NoParamsUseCase<T> {
  Future<Either<T, NoParams>> call();
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
