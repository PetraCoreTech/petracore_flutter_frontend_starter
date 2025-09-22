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
  String get authModelsIndex => modelTemplate();
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
  String get splashScreen => splashScreenTemplate(config);
  String get welcomeScreen => welcomeScreenTemplate(config);
  String get getStartedScreen => getStartedScreenTemplate(config);
  String get loginScreen => loginScreenTemplate(config);
  String get signupScreen => signupScreenTemplate(config);
  String get verifyOtpScreen => verifyOtpScreenTemplate(config);
  String get forgotPasswordScreen => forgotPasswordScreenTemplate(config);
  String get forgotPwdVerifyScreen => forgotPwdVerifyScreenTemplate(config);
  String get resetPasswordScreen => resetPasswordScreenTemplate(config);

  /// Auth/Presentation/Widgets
  String get resendCodeDisplay => resendCodeDisplayTemplate(config);
  String get resendCodeText => resendCodeTextTemplate(config);
}
