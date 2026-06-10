import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String resetPasswordControllerTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

class ResetPasswordController {
  ResetPasswordController(this.context);
  final BuildContext context;

  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void resetPassword() {
    if (formKey.currentState!.validate()) {
      if (password.text == confirmPassword.text) {
        final event = ResetPassword(
          email: context.read<EmailCubit>().state,
          password: password.text,
        );
        context.read<AuthBloc>().add(event);
      } else {
        ToastHelper.showInfo(context, 'Passwords must be the same!');
      }
    }
  }

  void dispose() {
    password.dispose();
    confirmPassword.dispose();
  }
}
''';
