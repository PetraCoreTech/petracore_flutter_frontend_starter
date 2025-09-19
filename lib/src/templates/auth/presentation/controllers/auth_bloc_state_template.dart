String authBlocStateTemplate() => '''
part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class UserLoggedIn extends AuthState {
  UserLoggedIn(this.user);
  final User user;
}

final class UserRegistered extends AuthState {
  UserRegistered(this.user);
  final User user;
}

final class AuthError extends AuthState {
  AuthError(this.error);
  final ErrorResponse error;
}

final class AuthConfirmed extends AuthState {
  AuthConfirmed(this.response);
  final SuccessResponse response;
}

final class UserConfirmed extends AuthState {
  UserConfirmed(this.response);
  final SuccessResponse response;
}

final class EmailVerified extends AuthState {
  EmailVerified(this.response);
  final SuccessResponse response;
}

final class PhoneNumberVerified extends AuthState {
  PhoneNumberVerified(this.response);
  final SuccessResponse response;
}
''';
