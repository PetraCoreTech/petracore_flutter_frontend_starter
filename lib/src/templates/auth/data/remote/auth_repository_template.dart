import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String authRepositoryTemplate(ProjectConfig config) => '''
import 'package:dartz/dartz.dart';
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/features/shared/data/type_def.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

final authRepository = AuthRepository(authService);

abstract class AuthRepositoryInterface {
  Future<Either<User, ErrorResponse>> signup(SignUpDto data);
  Future<Either<User, ErrorResponse>> login(LoginDto data);
  Future<Either<SuccessResponse, ErrorResponse>> checkUser(CheckUserDto data);
  Future<Either<SuccessResponse, ErrorResponse>> verifyUser(VerifyDto data);
  Future<Either<SuccessResponse, ErrorResponse>> requestOtp(RequestOtpDto data);
  Future<Either<SuccessResponse, ErrorResponse>> resetPassword(ResetPasswordDto data);
}

class AuthRepository implements AuthRepositoryInterface {
  AuthRepository(this.authService);
  final AuthService authService;

  @override
  Future<Either<User, ErrorResponse>> login(LoginDto data) async {
    try {
      final response = await authService.login(data);
      final decoded = response.data as Json;
      final user = User.fromJson(decoded);
      
      await _authDataSource.setToken(decoded['token'] as String);
      // await _authDataSource.setRefreshToken(decoded['refresh_token'] as String);
      return Left(user);
    } on DioException catch (e) {
      final errorResponse = ApiError.handleError(e);
      return Right(errorResponse);
    } catch (e) {
      final error = ErrorResponse(message: e.toString());
      return Right(error);
    }
  }

  @override
  Future<Either<User, ErrorResponse>> signup(SignUpDto data) async {
    try {
      final response = await authService.signup(data);
      final decoded = response.data as Json;
      final user = User.fromJson(decoded);
      
      await _authDataSource.setToken(decoded['token'] as String);
      // await _authDataSource.setRefreshToken(decoded['refresh_token'] as String);
      return Left(user);
    } on DioException catch (e) {
      final errorResponse = ApiError.handleError(e);
      return Right(errorResponse);
    } catch (e) {
      final error = ErrorResponse(message: e.toString());
      return Right(error);
    }
  }

  @override
  Future<Either<SuccessResponse, ErrorResponse>> checkUser(CheckUserDto data) async {
    try {
      final response = await authService.checkUser(data);
      final decoded = response.data as Json;
      final userExists = decoded['exist'] as bool;
      
      return Left(
        SuccessResponse(
          message: userExists ? 'User exists' : 'User does not exist',
          success: userExists,
        ),
      );
    } on DioException catch (e) {
      final errorResponse = ApiError.handleError(e);
      return Right(errorResponse);
    } catch (e) {
      final error = ErrorResponse(message: e.toString());
      return Right(error);
    }
  }

  @override
  Future<Either<SuccessResponse, ErrorResponse>> requestOtp(RequestOtpDto data) async {
    try {
      final response = await authService.requestOtp(data);
      final decoded = response.data as Json;
      final dataResponse = SuccessResponse.fromJson(decoded);
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
  Future<Either<SuccessResponse, ErrorResponse>> verifyUser(VerifyDto data) async {
    try {
      final response = await authService.verifyUser(data);
      final decoded = response.data as Json;
      final dataResponse = SuccessResponse.fromJson(decoded);
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
  Future<Either<SuccessResponse, ErrorResponse>> resetPassword(ResetPasswordDto data) async {
    try {
      await authService.resetPassword(data);
      final response = SuccessResponse(message: 'Password changed successfully');
      return Left(response);
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
