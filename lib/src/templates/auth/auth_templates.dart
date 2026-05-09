import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/template_index.dart';

class AuthTemplates {
  AuthTemplates(this.config);

  final ProjectConfig config;
  bool get _isMaterial => config.themeType == ThemeType.material;

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
  String get splashScreen => _isMaterial
      ? materialSplashScreenTemplate(config)
      : splashScreenTemplate(config);
  String get welcomeScreen => _isMaterial
      ? materialWelcomeScreenTemplate(config)
      : welcomeScreenTemplate(config);
  String get getStartedScreen => _isMaterial
      ? materialGetStartedScreenTemplate(config)
      : getStartedScreenTemplate(config);
  String get loginScreen => _isMaterial
      ? materialLoginScreenTemplate(config)
      : loginScreenTemplate(config);
  String get signupScreen => _isMaterial
      ? materialSignupScreenTemplate(config)
      : signupScreenTemplate(config);
  String get verifyOtpScreen => _isMaterial
      ? materialVerifyOtpScreenTemplate(config)
      : verifyOtpScreenTemplate(config);
  String get forgotPasswordScreen => _isMaterial
      ? materialForgotPasswordScreenTemplate(config)
      : forgotPasswordScreenTemplate(config);
  String get forgotPwdVerifyScreen => _isMaterial
      ? materialForgotPwdVerifyScreenTemplate(config)
      : forgotPwdVerifyScreenTemplate(config);
  String get resetPasswordScreen => _isMaterial
      ? materialResetPasswordScreenTemplate(config)
      : resetPasswordScreenTemplate(config);

  /// Auth/Presentation/Widgets
  String get resendCodeDisplay => _isMaterial
      ? materialResendCodeDisplayTemplate(config)
      : resendCodeDisplayTemplate(config);
  String get resendCodeText => _isMaterial
      ? materialResendCodeTextTemplate(config)
      : resendCodeTextTemplate(config);
}
