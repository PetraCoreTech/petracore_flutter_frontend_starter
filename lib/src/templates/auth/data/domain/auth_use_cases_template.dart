import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String authUseCasesTemplate(ProjectConfig config) => '''
import 'package:dartz/dartz.dart';
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';


/* Signup Use Case */
final signupUseCase = SignupUseCase();

class SignupUseCase extends UseCase<User, SignupDto> {
  @override
  Future<Either<User, ErrorResponse>> call(SignupDto params) async {
    final res = await authRepository.signup(params);
    return res.fold(Left.new, Right.new);
  }
}

/* Login Use case */
final loginUseCase = LoginUseCase();

class LoginUseCase extends UseCase<User, LoginDto> {
  @override
  Future<Either<User, ErrorResponse>> call(LoginDto params) async {
    final res = await authRepository.login(params);
    return res.fold(Left.new, Right.new);
  }
}

/* Reset Password Use Case */
final resetPasswordUseCase = ResetPasswordUseCase();

class ResetPasswordUseCase
    extends UseCase<SuccessResponse, ResetPasswordDto> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(
    ResetPasswordDto params,
  ) async {
    final res = await authRepository.resetPassword(params);
    return res.fold(Left.new, Right.new);
  }
}

/* Check User Use Case */
final checkUserUseCase = CheckUserUseCase();

class CheckUserUseCase extends UseCase<SuccessResponse, CheckUserDto> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(
    CheckUserDto params,
  ) async {
    final res = await authRepository.checkUser(params);
    return res.fold(Left.new, Right.new);
  }
}

/* Verify User Use Case */
final verifyUserUseCase = VerifyUserUseCase();

class VerifyUserUseCase extends UseCase<SuccessResponse, VerifyDto> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(VerifyDto params) async {
    final res = await authRepository.verifyUser(params);
    return res.fold(Left.new, Right.new);
  }
}

/* Request Otp Use Case */
final requestOtpUseCase = RequestOtpUseCase();

class RequestOtpUseCase extends UseCase<SuccessResponse, RequestOtpDto> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(RequestOtpDto params) async {
    final res = await authRepository.requestOtp(params);
    return res.fold(Left.new, Right.new);
  }
}
''';
