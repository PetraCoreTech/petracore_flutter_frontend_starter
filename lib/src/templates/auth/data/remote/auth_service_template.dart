import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String authServiceTemplate(ProjectConfig config) => '''
import 'package:dio/dio.dart';
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

final authService = AuthService(apiClient);

abstract class AuthServicesInterface {
  Future<Response<dynamic>> checkUser(CheckUserDto target);

  Future<Response<dynamic>> resetPassword(ResetPasswordDto data);

  Future<Response<dynamic>> login(LoginDto data);

  Future<Response<dynamic>> requestOtp(RequestOtpDto target);

  Future<Response<dynamic>> signup(SignupDto data);

  Future<Response<dynamic>> verifyUser(VerifyDto data);

}

class AuthService extends AuthServicesInterface{
  const AuthService(this.apiClient);
  final ApiClient apiClient;
  
  @override
  Future<Response> checkUser(CheckUserDto data) async {
    return await apiClient.post(
      '/auth/check_user',
      data: data.toJson(),
    );
  }
  
  @override
  Future<Response> resetPassword(ResetPasswordDto data) async {
    return await apiClient.post(
      '/auth/reset_password',
      data: data.toJson(),
    );
  }
  
  @override
  Future<Response> login(LoginDto data) async {
    return await apiClient.post(
      '/auth/login',
      data: data.toJson(),
    );
  }
  
  @override
  Future<Response> requestOtp(RequestOtpDto data) async {
    return await apiClient.post(
      '/auth/request-otp',
      data: data.toJson(),
    );
  }
  
  @override
  Future<Response> signup(SignUpDto data) async {
    return await apiClient.post(
      '/auth/register',
      data: data.toJson(),
    );
  }

  @override
  Future<Response> verifyUser(VerifyDto data) async {
    return await apiClient.post(
      '/auth/verify',
      data: data.toJson(),
    );
  }
}
''';
