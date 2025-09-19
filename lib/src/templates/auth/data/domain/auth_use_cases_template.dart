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

/* Forgot Password Use Case */
final forgotPasswordUseCase = ForgotPasswordUseCase();

class ForgotPasswordUseCase
    extends UseCase<SuccessResponse, ResetPasswordDto> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(
    ResetPasswordDto params,
  ) async {
    final res = await authRepository.forgotPassword(params);
    return res.fold(Left.new, Right.new);
  }
}

/* Check User Use Case */
final checkUserUseCase = CheckUserUseCase();

class CheckUserUseCase extends UseCase<SuccessResponse, String> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(
    String params,
  ) async {
    final res = await authRepository.checkUser(params);
    return res.fold(Left.new, Right.new);
  }
}

/* Verify Email Use Case */
final verifyEmailUseCase = VerifyEmailUseCase();

class VerifyEmailUseCase extends UseCase<SuccessResponse, VerifyDto> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(VerifyDto params) async {
    final res = await authRepository.verifyEmail(params);
    return res.fold(Left.new, Right.new);
  }
}

/* Request Otp Use Case */
final requestOtpUseCase = RequestOtpUseCase();

class RequestOtpUseCase extends UseCase<SuccessResponse, String> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(String params) async {
    final res = await authRepository.requestOtp(params);
    return res.fold(Left.new, Right.new);
  }
}
''';
