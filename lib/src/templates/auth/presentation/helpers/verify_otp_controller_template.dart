import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String verifyOtpControllerTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

class VerifyOtpController {
  VerifyOtpController(this.context);
  final BuildContext context;

  final otp = TextEditingController();
  final count = ValueNotifier(40);
  final formKey = GlobalKey<FormState>();
  
  void initValues() {}

  void verifyOtp() {
    if (formKey.currentState!.validate()) {
      final email = context.read<EmailCubit>().state;      
      AuthHelper(context).verifyEmail(email, otp.text);
    }
  }

  void dispose() {
    otp.dispose();
  }
}
''';
