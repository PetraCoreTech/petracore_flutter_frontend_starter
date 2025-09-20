import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String repositoryTemplate(FeatureConfig config) => '''
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:${config.projectConfig.projectName}/core/core.dart';
import 'package:${config.projectConfig.projectName}/features/${config.featureName}/${config.featureName}_index.dart';

final ${config.camelCase}Repository = ${config.pascalCase}Repository(${config.camelCase}Service);

abstract class ${config.pascalCase}RepositoryInterface {
  Future<Either<${config.pascalCase}, ErrorResponse>> create${config.pascalCase}(Create${config.pascalCase}Dto data);

  Future<Either<SuccessResponse, ErrorResponse>> delete${config.pascalCase}(String id);
  
  Future<Either<List<${config.pascalCase}>, ErrorResponse>> get${config.pascalCase}s(${config.pascalCase}Params? params);
  
  Future<Either<${config.pascalCase}, ErrorResponse>> get${config.pascalCase}(String id);
  
  Future<Either<${config.pascalCase}, ErrorResponse>> update${config.pascalCase}(Update${config.pascalCase}Dto data);
}

class ${config.pascalCase}Repository implements ${config.pascalCase}RepositoryInterface {
  ${config.pascalCase}Repository(this.${config.camelCase}Service);
  final ${config.pascalCase}Service ${config.camelCase}Service;
  
  @override
  Future<Either<${config.pascalCase}, ErrorResponse>> create${config.pascalCase}(Create${config.pascalCase}Dto data) async {
    try {
      final response = await ${config.camelCase}Service.create${config.pascalCase}(data);
      final json = response.data as Json;
      final dataResponse = ${config.pascalCase}.fromJson(json);
      return Left(dataResponse);
    } on DioException catch (e) {
      final errorResponse = ApiError.handleError(e);
      return Right(errorResponse);
    } catch (e) {
      final error = ErrorResponse(message: e.toString());
      return Right(error);
    }
  }


  @override
  Future<Either<SuccessResponse, ErrorResponse>> delete${config.pascalCase}(String id) async {
    try {
      await ${config.camelCase}Service.delete${config.pascalCase}(id);
      final dataResponse = SuccessResponse(message: '${config.pascalCase} Deleted');
      return Left(dataResponse);
    } on DioException catch (e) {
      final errorResponse = ApiError.handleError(e);
      return Right(errorResponse);
    } catch (e) {
      final error = ErrorResponse(message: e.toString());
      return Right(error);
    }
  }
  
  @override
  Future<Either<List<${config.pascalCase}>, ErrorResponse>> get${config.pascalCase}s(${config.pascalCase}Params? params) async {
    try {
      final response =
          await ${config.camelCase}Service.get${config.pascalCase}(queryParams: params?.toJson());
      final json = response.data as List<dynamic>;
      final dataResponse =
          json.map((e) => ${config.pascalCase}.fromJson(e as Json)).toList();
      return Left(dataResponse);
    } on DioException catch (e) {
      final errorResponse = ApiError.handleError(e);
      return Right(errorResponse);
    } catch (e) {
      final error = ErrorResponse(message: e.toString());
      return Right(error);
    }
  }

  @override
  Future<Either<${config.pascalCase}, ErrorResponse>> get${config.pascalCase}(String id) async {
    try {
      final response = await ${config.camelCase}Service.get${config.pascalCase}(isSingle: true, id: id);
      final json = response.data as Json;
      final dataResponse = ${config.pascalCase}.fromJson(json);
      return Left(dataResponse);
    } on DioException catch (e) {
      final errorResponse = ApiError.handleError(e);
      return Right(errorResponse);
    } catch (e) {
      final error = ErrorResponse(message: e.toString());
      return Right(error);
    }
  }

  @override
  Future<Either<${config.pascalCase}, ErrorResponse>> update${config.pascalCase}(Update${config.pascalCase}Dto data) async {
    try {
      final response = await ${config.camelCase}Service.update${config.pascalCase}(data);
      final json = response.data as Json;
      final dataResponse = ${config.pascalCase}.fromJson(json);
      return Left(dataResponse);
    } on DioException catch (e) {
      final errorResponse = ApiError.handleError(e);
      return Right(errorResponse);
    } catch (e) {
      final error = ErrorResponse(message: e.toString());
      return Right(error);
    }
  }
}  
''';
