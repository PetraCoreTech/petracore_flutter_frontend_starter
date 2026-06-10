import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/template_index.dart';

class AuthTemplates {
  AuthTemplates(this.config);

  final ProjectConfig config;

  String get authIndex => authIndexTemplate();

  /// Auth/Data/Remote/Dtos
  String get authDataIndex => authDataIndexTemplate();
  String get loginDto => loginDtoTemplate();
  String get signUpDto => signupDtoTemplate();
  String get checkUserDto => checkUserDtoTemplate();
  String get verifyDto => verifyDtoTemplate();
  String get requestOtpDto => requestOtpDtoTemplate();
  String get resetPasswordDto => resetPasswordDtoTemplate();
  String get authDtosIndex => authDtosTemplate();

  /// Auth/Data/Models
  String get authHistoryModel => authHistoryModelTemplate(config);
  String get userModel => userModelTemplate(config);

  /// Auth/Data/Remote
  String get authRepository => authRepositoryTemplate(config);
  String get authService => authServiceTemplate(config);

  /// Auth/Data/Domain/UseCase
  String get authUseCases => authUseCasesTemplate(config);

  /// Auth/Presentation/Controllers
  String get authControllerIndex => authControllerIndexTemplate();
  String get authBlocEvents => authBlocEventTemplate();
  String get authBlocProvider => authBlocProviderTemplate(config);
  String get authBlocStates => authBlocStateTemplate();
  String get authBloc => authBlocTemplate(config);
  String get emailCubit => emailCubitTemplate(config);
  String get userCubit => userCubitTemplate(config);
  String get authHistoryCubit => authHistoryCubitTemplate(config);

  /// Auth/Presentation/Helpers
  String get authHelpersIndex => authHelperIndexTemplate();
  String get authHelper => authHelperTemplate(config);
  String get emailController => emailControllerTemplate(config);
  String get forgotPasswordController =>
      forgotPasswordControllerTemplate(config);
  String get resetPasswordController => resetPasswordControllerTemplate(config);
  String get loginController => loginControllerTemplate(config);
  String get signupController => signupControllerTemplate(config);
  String get verifyOtpController => verifyOtpControllerTemplate(config);
  String get authPresentationIndex => authPresentationIndexTemplate();

  /// Auth/Presentation/Screens
  String get authScreensIndex => authScreenIndexTemplate();
  String get splashScreen => materialSplashScreenTemplate(config);
  String get welcomeScreen => materialWelcomeScreenTemplate(config);
  String get getStartedScreen => materialGetStartedScreenTemplate(config);
  String get loginScreen => materialLoginScreenTemplate(config);
  String get signupScreen => materialSignupScreenTemplate(config);
  String get verifyOtpScreen => materialVerifyOtpScreenTemplate(config);
  String get forgotPasswordScreen => materialForgotPasswordScreenTemplate(config);
  String get forgotPwdVerifyScreen => materialForgotPwdVerifyScreenTemplate(config);
  String get resetPasswordScreen => materialResetPasswordScreenTemplate(config);

  /// Auth/Presentation/Widgets
  String get animatedSplashLogo => animatedSplashLogoTemplate(config);
  String get resendCodeDisplay => materialResendCodeDisplayTemplate(config);
  String get resendCodeText => materialResendCodeTextTemplate(config);

  /// Auth Routes
  String get authRoutes => authRoutesTemplate(config);
}
