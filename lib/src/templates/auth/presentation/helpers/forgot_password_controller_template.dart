import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String forgotPasswordControllerTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

class ForgotPasswordController {
  ForgotPasswordController(this.context);
  final BuildContext context;

  final email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  void initValues() {
      final user = context.read<UserCubit>().state;
      if(user?.email != null) {
      email.text = user!.email;
      }
  }

  void requestOtp() {
    if (formKey.currentState!.validate()) {
      context.read<EmailCubit>().setEmail(email.text);
      AuthHelper(context).requestOtp(email.text);
    }
  }

  void dispose() {
    email.dispose();
  }
}
''';
