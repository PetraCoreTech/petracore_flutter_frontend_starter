import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String requestOtpControllerTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

class RequestOtpController {
  RequestOtpController(this.context);
  final BuildContext context;

  final otp = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  void initValues() {}

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
