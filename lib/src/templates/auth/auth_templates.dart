import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

class AuthTemplates {
  final ProjectConfig config;

  AuthTemplates(this.config);

  // Auth DTOs
  String get loginDto => '''
import '../../../shared/data/type_def.dart';

class LoginDto {
  const LoginDto({
    required this.email,
    required this.password,
    this.deviceToken,
    this.deviceType,
  });
  
  final String email;
  final String password;
  final String? deviceType;
  final String? deviceToken;

  Json toJson() {
    final json = Json();
    json['email'] = email;
    json['password'] = password;
    if (deviceToken != null) json['device_token'] = deviceToken;
    if (deviceType != null) json['device_type'] = deviceType;
    return json;
  }
}
''';

  String get signUpDto => '''
import '../../../shared/data/type_def.dart';

class SignUpDto {
  const SignUpDto({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    this.gender,
    this.deviceToken,
    this.deviceType,
    this.phoneNumber,
    this.image,
  });
  
  final String firstname;
  final String lastname;
  final String email;
  final String? gender;
  final String password;
  final String? deviceType;
  final String? deviceToken;
  final String? image;
  final String? phoneNumber;

  Json toJson() {
    final json = Json();
    json['lastname'] = lastname;
    json['firstname'] = firstname;
    json['email'] = email;
    json['password'] = password;
    if (gender != null) json['gender'] = gender;
    if (image != null) json['image'] = image;
    if (phoneNumber != null) json['phone'] = phoneNumber;
    if (deviceToken != null) json['device_token'] = deviceToken;
    if (deviceType != null) json['device_type'] = deviceType;
    return json;
  }
}
''';

  String get checkUserDto => '''
import '../../../shared/data/type_def.dart';

class CheckUserDto {
  const CheckUserDto({required this.target});
  
  final String target;

  Json toJson() {
    final json = Json();
    json['target'] = target;
    return json;
  }
}
''';

  String get verifyDto => '''
import '../../../shared/data/type_def.dart';

class VerifyDto {
  const VerifyDto({required this.target, required this.value});
  
  final String target;
  final String value;

  Json toJson() {
    final json = Json();
    json['target'] = target;
    json['value'] = value;
    return json;
  }
}
''';

  String get requestOtpDto => '''
import '../../../shared/data/type_def.dart';
import '../enums/auth_enums.dart';

class RequestOtpDto {
  const RequestOtpDto({required this.target, required this.type});
  
  final String target;
  final RequestOtpType type;

  Json toJson() {
    final json = Json();
    json['target'] = target;
    json['type'] = type.name;
    return json;
  }
}
''';

  String get resetPasswordDto => '''
import '../../../shared/data/type_def.dart';

class ResetPasswordDto {
  const ResetPasswordDto({
    required this.email,
    required this.password,
    required this.token,
  });
  
  final String email;
  final String password;
  final String token;

  Json toJson() {
    final json = Json();
    json['email'] = email;
    json['password'] = password;
    json['token'] = token;
    return json;
  }
}
''';

  // Auth Models
  String get userModel => '''
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  const User({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    this.avatar,
    this.phoneNumber,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String email;
  @JsonKey(name: 'first_name')
  final String firstname;
  @JsonKey(name: 'last_name')
  final String lastname;
  final String? avatar;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
   
  factory User.fromJson(Map<String, dynamic> json) => _\$UserFromJson(json);
  
  Map<String, dynamic> toJson() => _\$UserToJson(this);
}
''';

  // Auth Enums
  String get authEnums => '''
enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error
}

enum RequestOtpType {
  email,
  phone,
  forgotPassword
}

extension RequestOtpTypeX on RequestOtpType {
  String get name {
    switch (this) {
      case RequestOtpType.email:
        return 'email';
      case RequestOtpType.phone:
        return 'phone';
      case RequestOtpType.forgotPassword:
        return 'forgot_password';
    }
  }
}
''';

  // Auth Repository
  String get authRepository => '''
import 'package:dartz/dartz.dart';
import '../../../core/core.dart';
import '../../../shared/data/type_def.dart';
import '../models/models.dart';
import 'dtos/dtos.dart';
import 'auth_service.dart';

abstract class AuthRepositoryInterface {
  Future<Either<User, ErrorResponse>> signup(SignUpDto data);
  Future<Either<User, ErrorResponse>> login(LoginDto data);
  Future<Either<SuccessResponse, ErrorResponse>> checkUser(CheckUserDto data);
  Future<Either<SuccessResponse, ErrorResponse>> verifyUser(VerifyDto data);
  Future<Either<SuccessResponse, ErrorResponse>> requestOtp(RequestOtpDto data);
  Future<Either<SuccessResponse, ErrorResponse>> resetPassword(ResetPasswordDto data);
}

class AuthRepository implements AuthRepositoryInterface {
  final AuthService _authService;
  final AuthDataSource _authDataSource;

  const AuthRepository({
    required AuthService authService,
    required AuthDataSource authDataSource,
  }) : _authService = authService, _authDataSource = authDataSource;

  @override
  Future<Either<User, ErrorResponse>> login(LoginDto data) async {
    try {
      final response = await _authService.login(data);
      final decoded = response.data as Json;
      final user = User.fromJson(decoded);
      
      // Store tokens
      await _authDataSource.setToken(decoded['access_token'] as String);
      await _authDataSource.setRefreshToken(decoded['refresh_token'] as String);
      
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
      final response = await _authService.register(data);
      final decoded = response.data as Json;
      final user = User.fromJson(decoded);
      
      // Store tokens
      await _authDataSource.setToken(decoded['access_token'] as String);
      await _authDataSource.setRefreshToken(decoded['refresh_token'] as String);
      
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
      final response = await _authService.checkUser(data);
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
      final response = await _authService.requestOtp(data);
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
      final response = await _authService.verifyUser(data);
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
      await _authService.resetPassword(data);
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

  // Auth Service
  String get authService => '''
import 'package:dio/dio.dart';
import '../../../core/core.dart';
import 'dtos/dtos.dart';

class AuthService {
  final NetworkService _networkService;

  const AuthService({required NetworkService networkService})
      : _networkService = networkService;

  Future<Response> login(LoginDto data) async {
    return await _networkService.request(
      endpoint: '/auth/login',
      method: RequestMethod.post,
      data: data.toJson(),
      requiresToken: false,
    );
  }

  Future<Response> register(SignUpDto data) async {
    return await _networkService.request(
      endpoint: '/auth/register',
      method: RequestMethod.post,
      data: data.toJson(),
      requiresToken: false,
    );
  }

  Future<Response> checkUser(CheckUserDto data) async {
    return await _networkService.request(
      endpoint: '/auth/check-user',
      method: RequestMethod.post,
      data: data.toJson(),
      requiresToken: false,
    );
  }

  Future<Response> verifyUser(VerifyDto data) async {
    return await _networkService.request(
      endpoint: '/auth/verify',
      method: RequestMethod.post,
      data: data.toJson(),
      requiresToken: false,
    );
  }

  Future<Response> requestOtp(RequestOtpDto data) async {
    return await _networkService.request(
      endpoint: '/auth/request-otp',
      method: RequestMethod.post,
      data: data.toJson(),
      requiresToken: false,
    );
  }

  Future<Response> resetPassword(ResetPasswordDto data) async {
    return await _networkService.request(
      endpoint: '/auth/reset-password',
      method: RequestMethod.post,
      data: data.toJson(),
      requiresToken: false,
    );
  }
}
''';

  // Auth Use Cases
  String get authUseCases => '''
import 'package:dartz/dartz.dart';
import '../../../core/core.dart';
import '../models/models.dart';
import '../remote/auth_repository.dart';
import '../remote/dtos/dtos.dart';

class LoginUseCase extends UseCase<User, LoginDto> {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<User, ErrorResponse>> call(LoginDto params) async {
    return await _repository.login(params);
  }
}

class SignupUseCase extends UseCase<User, SignUpDto> {
  final AuthRepository _repository;

  SignupUseCase(this._repository);

  @override
  Future<Either<User, ErrorResponse>> call(SignUpDto params) async {
    return await _repository.signup(params);
  }
}

class CheckUserUseCase extends UseCase<SuccessResponse, CheckUserDto> {
  final AuthRepository _repository;

  CheckUserUseCase(this._repository);

  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(CheckUserDto params) async {
    return await _repository.checkUser(params);
  }
}

class VerifyUserUseCase extends UseCase<SuccessResponse, VerifyDto> {
  final AuthRepository _repository;

  VerifyUserUseCase(this._repository);

  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(VerifyDto params) async {
    return await _repository.verifyUser(params);
  }
}

class RequestOtpUseCase extends UseCase<SuccessResponse, RequestOtpDto> {
  final AuthRepository _repository;

  RequestOtpUseCase(this._repository);

  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(RequestOtpDto params) async {
    return await _repository.requestOtp(params);
  }
}

class ResetPasswordUseCase extends UseCase<SuccessResponse, ResetPasswordDto> {
  final AuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(ResetPasswordDto params) async {
    return await _repository.resetPassword(params);
  }
}
''';

  // Auth Bloc Events
  String get authBlocEvents => '''
part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class RegisterUser extends AuthEvent {
  RegisterUser({
    required this.email,
    required this.fullName,
    required this.password,
    this.gender,
    this.phoneNumber,
    this.image,
    this.deviceToken,
    this.deviceType,
  });
  
  final String email;
  final String fullName;
  final String? gender;
  final String? phoneNumber;
  final String? image;
  final String password;
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
  RequestOtp({required this.target, required this.type, required this.load});
  final String target;
  final RequestOtpType type;
  final bool load;
}

final class ResetPassword extends AuthEvent {
  ResetPassword({
    required this.email,
    required this.password,
    required this.token,
  });
  
  final String email;
  final String password;
  final String token;
}

final class LogoutUser extends AuthEvent {}
''';

  // Auth Bloc States
  String get authBlocStates => '''
part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class LogoutConfirmed extends AuthState {}

final class UserLoggedIn extends AuthState {
  UserLoggedIn(this.user);
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

final class UserRegistered extends AuthState {
  UserRegistered(this.user);
  final User user;
}
''';

  // Auth Bloc
  String get authBloc => '''
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/core.dart';
import '../../data/data.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final SignupUseCase _signupUseCase;
  final CheckUserUseCase _checkUserUseCase;
  final VerifyUserUseCase _verifyUserUseCase;
  final RequestOtpUseCase _requestOtpUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required SignupUseCase signupUseCase,
    required CheckUserUseCase checkUserUseCase,
    required VerifyUserUseCase verifyUserUseCase,
    required RequestOtpUseCase requestOtpUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
  })  : _loginUseCase = loginUseCase,
        _signupUseCase = signupUseCase,
        _checkUserUseCase = checkUserUseCase,
        _verifyUserUseCase = verifyUserUseCase,
        _requestOtpUseCase = requestOtpUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        super(AuthInitial()) {
    on<RegisterUser>(_register);
    on<Login>(_login);
    on<CheckEmail>(_checkEmail);
    on<VerifyEmail>(_verifyEmail);
    on<VerifyPhoneNumber>(_verifyPhoneNumber);
    on<RequestOtp>(_requestOtp);
    on<ResetPassword>(_resetPassword);
    on<LogoutUser>(_logout);
  }

  Future<void> _register(RegisterUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final data = SignUpDto(
      fullName: event.fullName,
      email: event.email,
      gender: event.gender,
      phoneNumber: event.phoneNumber,
      password: event.password,
      image: event.image,
      deviceToken: event.deviceToken,
      deviceType: event.deviceType,
    );
    
    final result = await _signupUseCase.call(data);
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
    
    final result = await _loginUseCase.call(data);
    result.fold(
      (user) => emit(UserLoggedIn(user)),
      (error) => emit(AuthError(error)),
    );
  }

  Future<void> _checkEmail(CheckEmail event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final params = CheckUserDto(target: event.target);
    final result = await _checkUserUseCase.call(params);
    result.fold(
      (response) => emit(UserConfirmed(response)),
      (error) => emit(AuthError(error)),
    );
  }

  Future<void> _verifyEmail(VerifyEmail event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final data = VerifyDto(target: event.email, value: event.value);
    final result = await _verifyUserUseCase.call(data);
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
    final result = await _verifyUserUseCase.call(data);
    result.fold(
      (response) => emit(PhoneNumberVerified(response)),
      (error) => emit(AuthError(error)),
    );
  }

  Future<void> _requestOtp(RequestOtp event, Emitter<AuthState> emit) async {
    if (event.load) emit(AuthLoading());
    final params = RequestOtpDto(target: event.target, type: event.type);
    final result = await _requestOtpUseCase.call(params);
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
    final result = await _resetPasswordUseCase.call(data);
    result.fold(
      (response) => emit(AuthConfirmed(response)),
      (error) => emit(AuthError(error)),
    );
  }

  Future<void> _logout(LogoutUser event, Emitter<AuthState> emit) async {
    // Clear tokens and logout logic
    emit(LogoutConfirmed());
  }
}
''';

  // Login Screen
  String get loginScreen => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../../../../core/validators/input_field_validator.dart';
import '../../../../navigation/navigation.dart';
import '../controllers/controllers.dart';
import '../helpers/helpers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController controller;

  @override
  void initState() {
    super.initState();
    controller = LoginController(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is UserLoggedIn) {
          // Navigate to home or profile selection
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: BaseScaffold(
        title: 'Login',
        isLoading: context.watch<AuthBloc>().state is AuthLoading,
        body: Form(
          key: controller.formKey,
          child: Column(
            children: [
              BaseTextField(
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: InputFieldValidator.email,
                controller: controller.email,
              ),
              const SizedBox(height: 16),
              BaseTextField(
                label: 'Password',
                obscureText: true,
                validator: InputFieldValidator.password,
                controller: controller.password,
              ),
              const SizedBox(height: 24),
              AppButton(
                text: 'Login',
                onPressed: controller.login,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/forgot-password'),
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''';

  // Signup Screen
  String get signupScreen => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../../../../core/validators/input_field_validator.dart';
import '../../../../navigation/navigation.dart';
import '../controllers/controllers.dart';
import '../helpers/helpers.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late SignupController controller;

  @override
  void initState() {
    super.initState();
    controller = SignupController(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is UserRegistered) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account created successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      child: BaseScaffold(
        title: 'Sign Up',
        isLoading: context.watch<AuthBloc>().state is AuthLoading,
        body: Form(
          key: controller.formKey,
          child: Column(
            children: [
              BaseTextField(
                label: 'Full Name',
                keyboardType: TextInputType.name,
                validator: InputFieldValidator.name,
                controller: controller.fullName,
              ),
              const SizedBox(height: 16),
              BaseTextField(
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: InputFieldValidator.email,
                controller: controller.email,
              ),
              const SizedBox(height: 16),
              BaseTextField(
                label: 'Password',
                obscureText: true,
                validator: InputFieldValidator.password,
                controller: controller.password,
              ),
              const SizedBox(height: 24),
              AppButton(
                text: 'Sign Up',
                onPressed: controller.signup,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''';

  // Controllers
  String get loginController => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/controllers.dart';

class LoginController {
  LoginController(this.context);
  final BuildContext context;

  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void login() {
    if (formKey.currentState!.validate()) {
      final event = Login(
        email: email.text,
        password: password.text,
      );
      context.read<AuthBloc>().add(event);
    }
  }

  void dispose() {
    email.dispose();
    password.dispose();
  }
}
''';

  String get signupController => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/controllers.dart';

class SignupController {
  SignupController(this.context);
  final BuildContext context;

  final fullName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void signup() {
    if (formKey.currentState!.validate()) {
      final event = RegisterUser(
        email: email.text,
        fullName: fullName.text,
        password: password.text,
      );
      context.read<AuthBloc>().add(event);
    }
  }

  void dispose() {
    fullName.dispose();
    email.dispose();
    password.dispose();
  }
}
''';

  // Index files
  String get authIndex => '''
library auth;

// Data layer
export 'data/data.dart';

// Presentation layer  
export 'presentation/presentation.dart';
''';

  String get authDataIndex => '''
library auth_data;

// Models
export 'models/models.dart';

// DTOs
export 'remote/dtos/dtos.dart';

// Repository
export 'remote/auth_repository.dart';
export 'remote/auth_service.dart';

// Use cases
export 'use_case/auth_use_cases.dart';

// Enums
export 'enums/auth_enums.dart';
''';

  String get authPresentationIndex => '''
library auth_presentation;

// Screens
export 'screens/screens.dart';

// Controllers
export 'controllers/controllers.dart';

// Helpers
export 'helpers/helpers.dart';
''';

  String get authDtosIndex => '''
library auth_dtos;

export 'check_user_dto.dart';
export 'login_dto.dart';
export 'request_otp_dto.dart';
export 'reset_password_dto.dart';
export 'sign_up_dto.dart';
export 'verify_dto.dart';
''';

  String get authModelsIndex => '''
library auth_models;

export 'user_model.dart';
''';

  String get authScreensIndex => '''
library auth_screens;

// Auth screens
export 'login/login_screen.dart';
export 'signup/signup_screen.dart';

// Password recovery screens
export 'password_recovery/forgot_password_screen.dart';
export 'password_recovery/reset_password_screen.dart';

// OTP screens
export 'otp/request_otp_screen.dart';
export 'otp/verify_otp_screen.dart';

// Onboarding screens
export 'onboarding/splash_screen.dart';
export 'onboarding/welcome_screen.dart';
export 'onboarding/get_started_screen.dart';
''';

  String get authControllersIndex => '''
library auth_controllers;

export 'blocs/auth_bloc/auth_bloc.dart';
''';

  String get authHelpersIndex => '''
library auth_helpers;

export 'login_controller.dart';
export 'signup_controller.dart';
export 'get_started_controller.dart';
export 'request_otp_controller.dart';
export 'verify_otp_controller.dart';
export 'forgot_password_controller.dart';
export 'reset_password_controller.dart';
''';

  // Splash Screen
  String get splashScreen => '''
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../navigation/navigation.dart';
import '../../data/data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Initialize any required services here
      Timer(const Duration(milliseconds: 2000), _navigate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo or Brand
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.flutter_dash,
                size: 64,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '${config.className}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Welcome to your app',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigate() async {
    // Check if user is already logged in
    final authDataSource = AuthDataSource();
    final token = await authDataSource.getToken();
    
    if (mounted) {
      if (token != null && token.isNotEmpty) {
        // User is logged in, navigate to main app
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // User is not logged in, navigate to welcome/onboarding
        Navigator.of(context).pushReplacementNamed('/welcome');
      }
    }
  }
}
''';

  // Welcome Screen
  String get welcomeScreen => '''
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../navigation/navigation.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    
    return BaseScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 48),
              // App Logo/Brand
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.flutter_dash,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              // Welcome Image/Illustration
              Container(
                height: size.height * 0.35,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.phone_android,
                  size: 120,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 32),
              // Welcome Text
              Text(
                'Welcome to ${config.className}!',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Your journey starts here. Sign up or log in to get started and explore amazing features.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // Get Started Button
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: 'Get Started',
                  onPressed: () {
                    Navigator.of(context).pushNamed('/get-started');
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Terms and Privacy
              RichText(
                text: TextSpan(
                  text: 'By continuing, you agree to our ',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms of Use',
                      style: TextStyle(
                        color: theme.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to terms
                          _showDialog(context, 'Terms of Use', 
                              'Terms of Use content goes here.');
                        },
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: theme.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to privacy policy
                          _showDialog(context, 'Privacy Policy', 
                              'Privacy Policy content goes here.');
                        },
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
''';

  // Get Started Screen (Email entry)
  String get getStartedScreen => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/validators/input_field_validator.dart';
import '../../../../navigation/navigation.dart';
import '../controllers/controllers.dart';
import '../helpers/helpers.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  late GetStartedController controller;

  @override
  void initState() {
    super.initState();
    controller = GetStartedController(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is UserConfirmed) {
          // User exists, go to login
          Navigator.of(context).pushNamed('/login');
        } else if (state is AuthConfirmed) {
          // User doesn't exist or needs verification, go to signup
          Navigator.of(context).pushNamed('/signup');
        }
      },
      child: BaseScaffold(
        title: 'Get Started',
        isLoading: context.watch<AuthBloc>().state is AuthLoading,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text(
                'Get Started',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your email address to continue',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              Form(
                key: controller.formKey,
                child: BaseTextField(
                  label: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  validator: InputFieldValidator.email,
                  controller: controller.email,
                  onFieldSubmitted: (value) => controller.checkUser(),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: 'Continue',
                  onPressed: controller.checkUser,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''';

  // Get Started Controller
  String get getStartedController => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/controllers.dart';

class GetStartedController {
  GetStartedController(this.context);
  final BuildContext context;

  final email = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void checkUser() {
    if (formKey.currentState!.validate()) {
      final event = CheckEmail(email.text);
      context.read<AuthBloc>().add(event);
    }
  }

  void dispose() {
    email.dispose();
  }
}
''';

  // Request OTP Screen
  String get requestOtpScreen => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../../../../navigation/navigation.dart';
import '../../data/enums/auth_enums.dart';
import '../controllers/controllers.dart';
import '../helpers/helpers.dart';

class RequestOtpScreen extends StatefulWidget {
  const RequestOtpScreen({super.key, required this.target, this.type = RequestOtpType.email});
  
  final String target; // Email or phone number
  final RequestOtpType type; // Type of OTP requested (email, phone, forgot password)

  @override
  State<RequestOtpScreen> createState() => _RequestOtpScreenState();
}

class _RequestOtpScreenState extends State<RequestOtpScreen> {
  late RequestOtpController controller;

  @override
  void initState() {
    super.initState();
    controller = RequestOtpController(context, widget.target, widget.type);
    // Automatically request OTP when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.requestOtp();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is AuthConfirmed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.response.message),
              backgroundColor: Colors.green,
            ),
          );
          // Navigate to verify OTP screen
          Navigator.pushNamed(
            context,
            '/verify-otp',
            arguments: {
              'target': widget.target,
              'type': widget.type,
            },
          );
        }
      },
      child: BaseScaffold(
        title: _getTitle(),
        isLoading: context.watch<AuthBloc>().state is AuthLoading,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Icon(
                widget.type == RequestOtpType.forgotPassword
                    ? Icons.lock_reset
                    : Icons.phone_android,
                size: 56,
                color: theme.primaryColor,
              ),
              const SizedBox(height: 24),
              Text(
                _getTitle(),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'We have sent a verification code to \${widget.target}',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: 'Resend Code',
                  onPressed: controller.requestOtp,
                  variant: ButtonVariant.outlined,
                ),
              ),
              const SizedBox(height: 16),
              if (widget.type == RequestOtpType.forgotPassword) ...[                
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Use a different email address'),
                ),
              ] else ...[                
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Go back'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _getTitle() {
    switch (widget.type) {
      case RequestOtpType.email:
        return 'Verify Email';
      case RequestOtpType.phone:
        return 'Verify Phone';
      case RequestOtpType.forgotPassword:
        return 'Verify Your Identity';
    }
  }
}
''';

  // Verify OTP Screen
  String get verifyOtpScreen => '''
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../../../../navigation/navigation.dart';
import '../../data/enums/auth_enums.dart';
import '../controllers/controllers.dart';
import '../helpers/helpers.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({
    super.key, 
    required this.target,
    required this.type,
  });
  
  final String target; // Email or phone
  final RequestOtpType type; // Type of verification

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  late VerifyOtpController controller;
  int _remainingTime = 120; // 2 minutes
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    controller = VerifyOtpController(context, widget.target, widget.type);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  String get _formatTime {
    final minutes = (_remainingTime ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingTime % 60).toString().padLeft(2, '0');
    return '\$minutes:\$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is EmailVerified) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.response.message),
              backgroundColor: Colors.green,
            ),
          );
          // Handle success based on verification type
          _handleVerificationSuccess();
        } else if (state is PhoneNumberVerified) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.response.message),
              backgroundColor: Colors.green,
            ),
          );
          // Handle success based on verification type
          _handleVerificationSuccess();
        } else if (state is AuthConfirmed) {
          // Handle OTP resend confirmation
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.response.message),
              backgroundColor: Colors.green,
            ),
          );
          // Reset the timer
          _timer?.cancel();
          setState(() {
            _remainingTime = 120;
          });
          _startTimer();
        }
      },
      child: BaseScaffold(
        title: _getTitle(),
        isLoading: context.watch<AuthBloc>().state is AuthLoading,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                _getTitle(),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Enter the verification code sent to \${widget.target}',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              // OTP input fields
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        6,
                        (index) => SizedBox(
                          width: 48,
                          child: TextFormField(
                            controller: controller.controllers[index],
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleLarge,
                            maxLength: 1,
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                FocusScope.of(context).nextFocus();
                              }
                              if (index == 5 && value.isNotEmpty) {
                                // Auto-submit when all fields are filled
                                controller.verifyOtp();
                              }
                            },
                            validator: (value) => value?.isEmpty == true
                                ? 'Required'
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Timer display
              Center(
                child: Text(
                  'Code expires in \$_formatTime',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: _remainingTime < 30
                        ? Colors.red
                        : Colors.grey[600],
                    fontWeight: _remainingTime < 30
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Verify button
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: 'Verify',
                  onPressed: controller.verifyOtp,
                ),
              ),
              const SizedBox(height: 16),
              // Resend OTP button
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: 'Resend Code',
                  onPressed: _remainingTime > 0
                      ? null
                      : controller.resendOtp,
                  variant: ButtonVariant.outlined,
                ),
              ),
              const SizedBox(height: 16),
              // Go back button
              Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Go back'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTitle() {
    switch (widget.type) {
      case RequestOtpType.email:
        return 'Verify Email';
      case RequestOtpType.phone:
        return 'Verify Phone';
      case RequestOtpType.forgotPassword:
        return 'Verify Code';
    }
  }

  void _handleVerificationSuccess() {
    switch (widget.type) {
      case RequestOtpType.email:
      case RequestOtpType.phone:
        // For email/phone verification during registration
        Navigator.of(context).pushReplacementNamed('/login');
        break;
      case RequestOtpType.forgotPassword:
        // For password reset flow, navigate to reset password screen
        Navigator.pushNamed(
          context,
          '/reset-password',
          arguments: {
            'email': widget.target,
            'token': controller.getFullOtp(),
          },
        );
        break;
    }
  }
}
''';

  // Forgot Password Screen
  String get forgotPasswordScreen => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../../../../core/validators/input_field_validator.dart';
import '../../../../navigation/navigation.dart';
import '../../data/enums/auth_enums.dart';
import '../controllers/controllers.dart';
import '../helpers/helpers.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late ForgotPasswordController controller;

  @override
  void initState() {
    super.initState();
    controller = ForgotPasswordController(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is AuthConfirmed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.response.message),
              backgroundColor: Colors.green,
            ),
          );
          // Navigate to verify OTP screen for password reset
          Navigator.pushNamed(
            context,
            '/verify-otp',
            arguments: {
              'target': controller.email.text,
              'type': RequestOtpType.forgotPassword,
            },
          );
        }
      },
      child: BaseScaffold(
        title: 'Forgot Password',
        isLoading: context.watch<AuthBloc>().state is AuthLoading,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Icon(
                Icons.lock_reset,
                size: 56,
                color: theme.primaryColor,
              ),
              const SizedBox(height: 24),
              Text(
                'Forgot Password?',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Don\\'t worry! It happens. Please enter the email address associated with your account.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              Form(
                key: controller.formKey,
                child: BaseTextField(
                  label: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  validator: InputFieldValidator.email,
                  controller: controller.email,
                  onFieldSubmitted: (value) => controller.requestPasswordReset(),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: 'Send Reset Code',
                  onPressed: controller.requestPasswordReset,
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
                  child: const Text('Back to Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''';

  // Reset Password Screen
  String get resetPasswordScreen => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../../../../core/validators/input_field_validator.dart';
import '../../../../navigation/navigation.dart';
import '../controllers/controllers.dart';
import '../helpers/helpers.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.token,
  });
  
  final String email;
  final String token;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late ResetPasswordController controller;

  @override
  void initState() {
    super.initState();
    controller = ResetPasswordController(context, widget.email, widget.token);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is AuthConfirmed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.response.message),
              backgroundColor: Colors.green,
            ),
          );
          // Navigate to login screen after successful password reset
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/login',
            (route) => false,
          );
        }
      },
      child: BaseScaffold(
        title: 'Reset Password',
        isLoading: context.watch<AuthBloc>().state is AuthLoading,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Icon(
                Icons.lock_outline,
                size: 56,
                color: theme.primaryColor,
              ),
              const SizedBox(height: 24),
              Text(
                'Create New Password',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your new password must be different from previously used passwords.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    BaseTextField(
                      label: 'New Password',
                      obscureText: true,
                      validator: InputFieldValidator.password,
                      controller: controller.password,
                    ),
                    const SizedBox(height: 16),
                    BaseTextField(
                      label: 'Confirm Password',
                      obscureText: true,
                      validator: (value) => InputFieldValidator.confirmPassword(value, controller.password.text),
                      controller: controller.confirmPassword,
                      onFieldSubmitted: (value) => controller.resetPassword(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Password requirements
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password Requirements:',
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildPasswordRequirement('At least 8 characters'),
                    _buildPasswordRequirement('Contains uppercase and lowercase letters'),
                    _buildPasswordRequirement('Contains at least one number'),
                    _buildPasswordRequirement('Contains at least one special character'),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: 'Reset Password',
                  onPressed: controller.resetPassword,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 16,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
''';

  // Request OTP Controller
  String get requestOtpController => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/enums/auth_enums.dart';
import '../controllers/controllers.dart';

class RequestOtpController {
  RequestOtpController(this.context, this.target, this.type);
  final BuildContext context;
  final String target;
  final RequestOtpType type;

  void requestOtp() {
    final event = RequestOtp(
      target: target,
      type: type,
      load: true,
    );
    context.read<AuthBloc>().add(event);
  }

  void dispose() {
    // Clean up any resources if needed
  }
}
''';

  // Verify OTP Controller
  String get verifyOtpController => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/enums/auth_enums.dart';
import '../controllers/controllers.dart';

class VerifyOtpController {
  VerifyOtpController(this.context, this.target, this.type);
  final BuildContext context;
  final String target;
  final RequestOtpType type;

  final formKey = GlobalKey<FormState>();
  final List<TextEditingController> controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  void verifyOtp() {
    if (formKey.currentState!.validate()) {
      final otp = getFullOtp();
      
      if (type == RequestOtpType.email) {
        final event = VerifyEmail(
          email: target,
          value: otp,
        );
        context.read<AuthBloc>().add(event);
      } else if (type == RequestOtpType.phone) {
        final event = VerifyPhoneNumber(
          phoneNumber: target,
          value: otp,
        );
        context.read<AuthBloc>().add(event);
      } else {
        // For forgot password, we just verify the OTP
        final event = VerifyEmail(
          email: target,
          value: otp,
        );
        context.read<AuthBloc>().add(event);
      }
    }
  }

  void resendOtp() {
    final event = RequestOtp(
      target: target,
      type: type,
      load: true,
    );
    context.read<AuthBloc>().add(event);
  }

  String getFullOtp() {
    return controllers.map((controller) => controller.text).join();
  }

  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
  }
}
''';

  // Forgot Password Controller
  String get forgotPasswordController => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/enums/auth_enums.dart';
import '../controllers/controllers.dart';

class ForgotPasswordController {
  ForgotPasswordController(this.context);
  final BuildContext context;

  final email = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void requestPasswordReset() {
    if (formKey.currentState!.validate()) {
      final event = RequestOtp(
        target: email.text,
        type: RequestOtpType.forgotPassword,
        load: true,
      );
      context.read<AuthBloc>().add(event);
    }
  }

  void dispose() {
    email.dispose();
  }
}
''';

  // Reset Password Controller
  String get resetPasswordController => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/controllers.dart';

class ResetPasswordController {
  ResetPasswordController(this.context, this.email, this.token);
  final BuildContext context;
  final String email;
  final String token;

  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void resetPassword() {
    if (formKey.currentState!.validate()) {
      final event = ResetPassword(
        email: email,
        password: password.text,
        token: token,
      );
      context.read<AuthBloc>().add(event);
    }
  }

  void dispose() {
    password.dispose();
    confirmPassword.dispose();
  }
}
''';

  // Shared Type Definitions
  String get typeDefinitions => '''
/// Type definitions used across the application
typedef Json = Map<String, dynamic>;
''';
}
