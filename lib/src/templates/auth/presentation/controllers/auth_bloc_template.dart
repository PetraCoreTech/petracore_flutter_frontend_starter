import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String authBlocTemplate(ProjectConfig config) => '''
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterUser>(_register);
    on<Login>(_login);
    on<CheckEmail>(_checkEmail);
    on<VerifyEmail>(_verifyEmail);
    on<VerifyPhoneNumber>(_verifyPhoneNumber);
    on<RequestOtp>(_requestOtp);
    on<ResetPassword>(_resetPassword);
  }

  Future<void> _register(RegisterUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final data = SignUpDto(
      firstname: event.firstname,
      lastname: event.lastname,
      email: event.email,
      gender: event.gender,
      phoneNumber: event.phoneNumber,
      password: event.password,
      image: event.image,
      deviceToken: event.deviceToken,
      deviceType: event.deviceType,
    );
    
    final result = await signupUseCase.call(data);
    result.fold(
      (user) => emit(UserRegistered(user)),
      (error) => emit(AuthError(error)),
    );
  }

  Future<void> _login(Login event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final data = LoginDto(
      email: event.email,
      password: event.password,
      deviceToken: event.deviceToken,
      deviceType: event.deviceType,
    );
    
    final result = await loginUseCase.call(data);
    result.fold(
      (user) => emit(UserLoggedIn(user)),
      (error) => emit(AuthError(error)),
    );
  }

  Future<void> _checkEmail(CheckEmail event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final params = CheckUserDto(target: event.target);
    final result = await checkUserUseCase.call(params);
    result.fold(
      (response) => emit(UserConfirmed(response)),
      (error) => emit(AuthError(error)),
    );
  }

  Future<void> _verifyEmail(VerifyEmail event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final data = VerifyDto(target: event.email, value: event.value);
    final result = await verifyUserUseCase.call(data);
    result.fold(
      (response) => emit(EmailVerified(response)),
      (error) => emit(AuthError(error)),
    );
  }

  Future<void> _verifyPhoneNumber(
    VerifyPhoneNumber event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final data = VerifyDto(target: event.phoneNumber, value: event.value);
    final result = await verifyUserUseCase.call(data);
    result.fold(
      (response) => emit(PhoneNumberVerified(response)),
      (error) => emit(AuthError(error)),
    );
  }

  Future<void> _requestOtp(RequestOtp event, Emitter<AuthState> emit) async {
    if (event.load) emit(AuthLoading());
    final params = RequestOtpDto(target: event.target);
    final result = await requestOtpUseCase.call(params);
    result.fold(
      (response) => emit(AuthConfirmed(response)),
      (error) => emit(AuthError(error)),
    );
  }

  Future<void> _resetPassword(
    ResetPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final data = ResetPasswordDto(
      email: event.email,
      password: event.password,
      token: event.token,
    );
    final result = await resetPasswordUseCase.call(data);
    result.fold(
      (response) => emit(AuthConfirmed(response)),
      (error) => emit(AuthError(error)),
    );
  }
}
''';
