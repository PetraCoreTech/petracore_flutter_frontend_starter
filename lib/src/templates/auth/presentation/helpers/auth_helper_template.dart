import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String authHelperTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

class AuthHelper {
  AuthHelper(this.context);
  final BuildContext context;

  void requestOtp(
    String target, {
    bool load = true,
  }) {
    final event = RequestOtp(target: target, load: load);
    context.read<AuthBloc>().add(event);
  }

  void verifyEmail(String email, String otp) {
    final event = VerifyEmail(email: email, value: otp);
    context.read<AuthBloc>().add(event);
  }

  void verifyPhoneNumber(String value, String otp) {
    final event = VerifyPhoneNumber(phoneNumber: value, value: otp);
    context.read<AuthBloc>().add(event);
  }
  
    void login(User user, AppRoute route, {bool push = false}) {
    final history = AuthHistory(
      authStatus: AuthStatus.loggedIn,
      timeStamp: DateTime.now(),
    );
    context.read<AuthHistoryCubit>().record(history);
    context.read<UserCubit>().setUser(user);
    if (push) {
      context.pushNamed(route.name);
    } else {
      context.goNamed(route.name);
    }
  }

  void logout() {
    final history = AuthHistory(
      authStatus: AuthStatus.loggedOut,
      timeStamp: DateTime.now(),
    );
    context.read<AuthHistoryCubit>().record(history);
    context.goNamed('login');
  }
}
''';
