import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String signupControllerTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

class SignupController {
  SignupController(this.context);
  final BuildContext context;

  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void signup() {
    if (formKey.currentState!.validate()) {
      final event = RegisterUser(
        email: email.text,
        firstname: firstname.text,
        lastname: lastname.text,
        password: password.text,
      );
      context.read<AuthBloc>().add(event);
    }
  }

  void dispose() {
    firstname.dispose();
    lastname.dispose();
    email.dispose();
    password.dispose();
  }
}
''';
