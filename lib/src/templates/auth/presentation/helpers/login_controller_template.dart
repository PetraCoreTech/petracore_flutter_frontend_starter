import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String loginControllerTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

class LoginController {
  LoginController(this.context);
  final BuildContext context;

  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  void initValues() {
      final user = context.read<UserCubit>().state;
      if(user?.email != null) {
      email.text = user!.email!;
      }
  }

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
