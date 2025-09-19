import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String loginScreenTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';
import 'package:${config.projectName}/navigation/navigation_index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController controller;

  @override
  void initState() {
    super.initState();
    controller = LoginController(context)..initValues();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onSurfaceDark = colors.onSurfaceDark.resolve(context);
    final onSurfaceLight = colors.onSurfaceLight.resolve(context);
    final heading4 = \$token.textStyle.heading4.resolve(context);
    final paragraph2 = \$token.textStyle.paragraph2.resolve(context);
    final state = context.watch<AuthBloc>().state;
    return MultiBlocListener(
      listeners: [
        /// Auth Bloc Listener
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ToastHelper(context).showToastV2(
                toastType: ToastType.error,
                content: state.error.message,
              );
            } else if (state is UserLoggedIn) {
              AuthHelper(context).login(state.user);
            }
          },
        ),
      ],
      child: ScreenFrame.unbounded(
        isLoading: state is AuthLoading,
        appBar: const AppBarV1(),
        children: [
          Text(
            ContentString.login,
            style: heading4.copyWith(color: onSurfaceDark),
          ),
        //  const Gap(4),
         // Text(
          //  ContentString.enterPwdIns,
          //  style: paragraph2.copyWith(color: onSurfaceLight),
         // ),
         // const Gap(24),
           Form(
            key: controller.formKey,
            child: Column(
              children: [
                 BaseTextField(
                    controller: controller.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (_) => InputFieldValidator.requiredEmail(email),
                    textInputAction: TextInputAction.next,
                  ),
                  const Gap(16),
                PasswordField(
                  label: ContentString.password,
                  validator: InputFieldValidator.required,
                  controller: controller.password,
                  onFieldSubmitted: (value) => controller.login(),
                ),
              ],
            ),
          ),
          const Gap(8),
          Align(
            alignment: Alignment.centerLeft,
            child: HyperLinkText(
              text: ContentString.fpQ,
              onTap: () => context.goNamed(AppRoutes.forgotPassword.name),
            ),
          ),
          const Gap(48),
          AppButton(
            text: ContentString.login,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            onTap: controller.login,
          ),
          const Gap(32),
        ],
      ),
    );
  }
}
''';
