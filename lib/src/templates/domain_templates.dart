class DomainTemplates {
  static String get useCase => '''
import 'package:dartz/dartz.dart';

/// Base class for all use cases
abstract class UseCase<Type, Params> {
  Future<Either<String, Type>> call(Params params);
}

/// Use case with no parameters
abstract class NoParamsUseCase<Type> {
  Future<Either<String, Type>> call();
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
}
