String authBlocEventTemplate() => '''
part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class RegisterUser extends AuthEvent {
  RegisterUser({
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.password,
    this.gender,
    this.phoneNumber,
    this.image,
    this.deviceToken,
    this.deviceType,
  });
  
  final String email;
  final String firstname;
  final String lastname;
  final String password;
  final String? gender;
  final String? phoneNumber;
  final String? image;
  final String? deviceType;
  final String? deviceToken;
}

final class Login extends AuthEvent {
  Login({
    required this.email,
    required this.password,
    this.deviceToken,
    this.deviceType,
  });
  
  final String email;
  final String password;
  final String? deviceType;
  final String? deviceToken;
}

final class CheckEmail extends AuthEvent {
  CheckEmail(this.target);
  final String target;
}

final class VerifyEmail extends AuthEvent {
  VerifyEmail({required this.email, required this.value});
  final String email;
  final String value;
}

final class VerifyPhoneNumber extends AuthEvent {
  VerifyPhoneNumber({required this.phoneNumber, required this.value});
  final String phoneNumber;
  final String value;
}

final class RequestOtp extends AuthEvent {
  RequestOtp({required this.target, required this.load});
  final String target;
  final bool load;
}

final class ResetPassword extends AuthEvent {
  ResetPassword({
    required this.email,
    required this.password,
    this.token,
  });
  
  final String email;
  final String password;
  final String? token;
}
''';
