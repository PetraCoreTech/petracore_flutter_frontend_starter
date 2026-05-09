import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String repositoryTemplate(FeatureConfig config) => '''
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:${config.projectConfig.projectName}/core/core.dart';
import 'package:${config.projectConfig.projectName}/features/${config.featureName}/${config.featureName}_index.dart';

final ${config.camelEntity}Repository = ${config.pascalEntity}Repository(${config.camelEntity}Service);

abstract class ${config.pascalEntity}RepositoryInterface {
  Future<Either<${config.pascalEntity}, ErrorResponse>> create${config.pascalEntity}(Create${config.pascalEntity}Dto data);

  Future<Either<SuccessResponse, ErrorResponse>> delete${config.pascalEntity}(String id);
  
  Future<Either<List<${config.pascalEntity}>, ErrorResponse>> get${config.pascalEntity}s(${config.pascalEntity}Params? params);
  
  Future<Either<${config.pascalEntity}, ErrorResponse>> get${config.pascalEntity}(String id);
  
  Future<Either<${config.pascalEntity}, ErrorResponse>> update${config.pascalEntity}(Update${config.pascalEntity}Dto data);
}

class ${config.pascalEntity}Repository implements ${config.pascalEntity}RepositoryInterface {
  ${config.pascalEntity}Repository(this.${config.camelEntity}Service);
  final ${config.pascalEntity}Service ${config.camelEntity}Service;
  
  @override
  Future<Either<${config.pascalEntity}, ErrorResponse>> create${config.pascalEntity}(Create${config.pascalEntity}Dto data) async {
    try {
      final response = await ${config.camelEntity}Service.create${config.pascalEntity}(data);
      final json = response.data as Json;
      final dataResponse = ${config.pascalEntity}.fromJson(json);
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
  Future<Either<SuccessResponse, ErrorResponse>> delete${config.pascalEntity}(String id) async {
    try {
      await ${config.camelEntity}Service.delete${config.pascalEntity}(id);
      final dataResponse = SuccessResponse(message: '${config.pascalEntity} Deleted');
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
  Future<Either<List<${config.pascalEntity}>, ErrorResponse>> get${config.pascalEntity}s(${config.pascalEntity}Params? params) async {
    try {
      final response =
          await ${config.camelEntity}Service.get${config.pascalEntity}(queryParams: params?.toJson());
      final json = response.data as List<dynamic>;
      final dataResponse =
          json.map((e) => ${config.pascalEntity}.fromJson(e as Json)).toList();
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
  Future<Either<${config.pascalEntity}, ErrorResponse>> get${config.pascalEntity}(String id) async {
    try {
      final response = await ${config.camelEntity}Service.get${config.pascalEntity}(isSingle: true, id: id);
      final json = response.data as Json;
      final dataResponse = ${config.pascalEntity}.fromJson(json);
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
  Future<Either<${config.pascalEntity}, ErrorResponse>> update${config.pascalEntity}(Update${config.pascalEntity}Dto data) async {
    try {
      final response = await ${config.camelEntity}Service.update${config.pascalEntity}(data);
      final json = response.data as Json;
      final dataResponse = ${config.pascalEntity}.fromJson(json);
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
