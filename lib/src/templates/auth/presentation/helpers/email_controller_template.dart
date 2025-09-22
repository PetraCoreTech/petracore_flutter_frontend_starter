import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String emailControllerTemplate(ProjectConfig config) => """
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

class EmailController {
  EmailController(this.context);
  final BuildContext context;

  final email = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void initValues() {
    email.text = context.read<EmailCubit>().state;
  }

  void checkUser() {
    if (formKey.currentState!.validate()) {
      context.read<EmailCubit>().setEmail(email.text);
      context.read<AuthBloc>().add(CheckEmail(email.text));
    }
  }

  void requestResetOtp() {
    if (formKey.currentState!.validate()) {
      context.read<EmailCubit>().setEmail(email.text);
      AuthHelper(context).requestOtp(email.text);
    }
  }
  
  
  void dispose() {
    email.dispose();
  }
}
""";
