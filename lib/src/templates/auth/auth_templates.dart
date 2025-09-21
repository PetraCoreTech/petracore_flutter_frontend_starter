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
  String get userModel => userModelTemplate(config);

  /// Auth/Data/Remote
  String get authRepository => authRepositoryTemplate(config);
  String get authService => authServiceTemplate(config);

  /// Auth/Data/Domain/UseCase
  String get authUseCases => authUseCasesTemplate(config);

  /// Auth/Presentation/Controllers
  String get authBlocEvents => authBlocEventTemplate();
  String get authBlocStates => authBlocStateTemplate();
  String get authBloc => authBlocTemplate(config);
  String get userCubit => userCubitTemplate(config);

  /// Auth/Presentation/Screens
  String get loginScreen => loginScreenTemplate(config);
  String get signupScreen => signupScreenTemplate(config);

  // Controllers
  String get loginController => loginControllerTemplate(config);

  String get signupController => signupControllerTemplate(config);

  String get authPresentationIndex => authPresentationIndexTemplate();

  String get authScreensIndex => '''
library auth_screens;

// Auth screens
export 'login/login_screen.dart';
export 'signup/signup_screen.dart';

// Password recovery screens
export 'password_recovery/forgot_password_screen.dart';
export 'password_recovery/reset_password_screen.dart';

// OTP screens
export 'otp/request_otp_screen.dart';
export 'otp/verify_otp_screen.dart';

// Onboarding screens
export 'onboarding/splash_screen.dart';
export 'onboarding/welcome_screen.dart';
export 'onboarding/get_started_screen.dart';
''';

  String get authControllersIndex => '''
library auth_controllers;

export 'blocs/auth_bloc/auth_bloc.dart';
''';

  String get authHelpersIndex => '''
library auth_helpers;

export 'login_controller.dart';
export 'signup_controller.dart';
export 'get_started_controller.dart';
export 'request_otp_controller.dart';
export 'verify_otp_controller.dart';
export 'forgot_password_controller.dart';
export 'reset_password_controller.dart';
''';

  // Splash Screen
  String get splashScreen => '''
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../navigation/navigation.dart';
import '../../data/data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Initialize any required services here
      Timer(const Duration(milliseconds: 2000), _navigate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo or Brand
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.flutter_dash,
                size: 64,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '${config.className}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Welcome to your app',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigate() async {
    // Check if user is already logged in
    final authDataSource = AuthDataSource();
    final token = await authDataSource.getToken();
    
    if (mounted) {
      if (token != null && token.isNotEmpty) {
        // User is logged in, navigate to main app
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // User is not logged in, navigate to welcome/onboarding
        Navigator.of(context).pushReplacementNamed('/welcome');
      }
    }
  }
}
''';

  // Welcome Screen
  String get welcomeScreen => '''
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../navigation/navigation.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    
    return BaseScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 48),
              // App Logo/Brand
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.flutter_dash,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              // Welcome Image/Illustration
              Container(
                height: size.height * 0.35,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.phone_android,
                  size: 120,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 32),
              // Welcome Text
              Text(
                'Welcome to ${config.className}!',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Your journey starts here. Sign up or log in to get started and explore amazing features.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // Get Started Button
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: 'Get Started',
                  onPressed: () {
                    Navigator.of(context).pushNamed('/get-started');
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Terms and Privacy
              RichText(
                text: TextSpan(
                  text: 'By continuing, you agree to our ',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms of Use',
                      style: TextStyle(
                        color: theme.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to terms
                          _showDialog(context, 'Terms of Use', 
                              'Terms of Use content goes here.');
                        },
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: theme.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to privacy policy
                          _showDialog(context, 'Privacy Policy', 
                              'Privacy Policy content goes here.');
                        },
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
''';

  // Get Started Screen (Email entry)
  String get getStartedScreen => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/validators/input_field_validator.dart';
import '../../../../navigation/navigation.dart';
import '../controllers/controllers.dart';
import '../helpers/helpers.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  late GetStartedController controller;

  @override
  void initState() {
    super.initState();
    controller = GetStartedController(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is UserConfirmed) {
          // User exists, go to login
          Navigator.of(context).pushNamed('/login');
        } else if (state is AuthConfirmed) {
          // User doesn't exist or needs verification, go to signup
          Navigator.of(context).pushNamed('/signup');
        }
      },
      child: BaseScaffold(
        title: 'Get Started',
        isLoading: context.watch<AuthBloc>().state is AuthLoading,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text(
                'Get Started',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your email address to continue',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              Form(
                key: controller.formKey,
                child: BaseTextField(
                  label: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  validator: InputFieldValidator.email,
                  controller: controller.email,
                  onFieldSubmitted: (value) => controller.checkUser(),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: 'Continue',
                  onPressed: controller.checkUser,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''';

  // Get Started Controller
  String get getStartedController => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/controllers.dart';

class GetStartedController {
  GetStartedController(this.context);
  final BuildContext context;

  final email = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void checkUser() {
    if (formKey.currentState!.validate()) {
      final event = CheckEmail(email.text);
      context.read<AuthBloc>().add(event);
    }
  }

  void dispose() {
    email.dispose();
  }
}
''';

  // Request OTP Screen
  String get requestOtpScreen => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../../../../navigation/navigation.dart';
import '../../data/enums/auth_enums.dart';
import '../controllers/controllers.dart';
import '../helpers/helpers.dart';

class RequestOtpScreen extends StatefulWidget {
  const RequestOtpScreen({super.key, required this.target, this.type = RequestOtpType.email});
  
  final String target; // Email or phone number
  final RequestOtpType type; // Type of OTP requested (email, phone, forgot password)

  @override
  State<RequestOtpScreen> createState() => _RequestOtpScreenState();
}

class _RequestOtpScreenState extends State<RequestOtpScreen> {
  late RequestOtpController controller;

  @override
  void initState() {
    super.initState();
    controller = RequestOtpController(context, widget.target, widget.type);
    // Automatically request OTP when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.requestOtp();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is AuthConfirmed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.response.message),
              backgroundColor: Colors.green,
            ),
          );
          // Navigate to verify OTP screen
          Navigator.pushNamed(
            context,
            '/verify-otp',
            arguments: {
              'target': widget.target,
              'type': widget.type,
            },
          );
        }
      },
      child: BaseScaffold(
        title: _getTitle(),
        isLoading: context.watch<AuthBloc>().state is AuthLoading,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Icon(
                widget.type == RequestOtpType.forgotPassword
                    ? Icons.lock_reset
                    : Icons.phone_android,
                size: 56,
                color: theme.primaryColor,
              ),
              const SizedBox(height: 24),
              Text(
                _getTitle(),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'We have sent a verification code to \${widget.target}',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: 'Resend Code',
                  onPressed: controller.requestOtp,
                  variant: ButtonVariant.outlined,
                ),
              ),
              const SizedBox(height: 16),
              if (widget.type == RequestOtpType.forgotPassword) ...[                
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Use a different email address'),
                ),
              ] else ...[                
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Go back'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _getTitle() {
    switch (widget.type) {
      case RequestOtpType.email:
        return 'Verify Email';
      case RequestOtpType.phone:
        return 'Verify Phone';
      case RequestOtpType.forgotPassword:
        return 'Verify Your Identity';
    }
  }
}
''';

  // Verify OTP Screen
  String get verifyOtpScreen => '''
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../../../../navigation/navigation.dart';
import '../../data/enums/auth_enums.dart';
import '../controllers/controllers.dart';
import '../helpers/helpers.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({
    super.key, 
    required this.target,
    required this.type,
  });
  
  final String target; // Email or phone
  final RequestOtpType type; // Type of verification

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  late VerifyOtpController controller;
  int _remainingTime = 120; // 2 minutes
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    controller = VerifyOtpController(context, widget.target, widget.type);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  String get _formatTime {
    final minutes = (_remainingTime ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingTime % 60).toString().padLeft(2, '0');
    return '\$minutes:\$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is EmailVerified) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.response.message),
              backgroundColor: Colors.green,
            ),
          );
          // Handle success based on verification type
          _handleVerificationSuccess();
        } else if (state is PhoneNumberVerified) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.response.message),
              backgroundColor: Colors.green,
            ),
          );
          // Handle success based on verification type
          _handleVerificationSuccess();
        } else if (state is AuthConfirmed) {
          // Handle OTP resend confirmation
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.response.message),
              backgroundColor: Colors.green,
            ),
          );
          // Reset the timer
          _timer?.cancel();
          setState(() {
            _remainingTime = 120;
          });
          _startTimer();
        }
      },
      child: BaseScaffold(
        title: _getTitle(),
        isLoading: context.watch<AuthBloc>().state is AuthLoading,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                _getTitle(),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Enter the verification code sent to \${widget.target}',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              // OTP input fields
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        6,
                        (index) => SizedBox(
                          width: 48,
                          child: TextFormField(
                            controller: controller.controllers[index],
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleLarge,
                            maxLength: 1,
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                FocusScope.of(context).nextFocus();
                              }
                              if (index == 5 && value.isNotEmpty) {
                                // Auto-submit when all fields are filled
                                controller.verifyOtp();
                              }
                            },
                            validator: (value) => value?.isEmpty == true
                                ? 'Required'
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Timer display
              Center(
                child: Text(
                  'Code expires in \$_formatTime',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: _remainingTime < 30
                        ? Colors.red
                        : Colors.grey[600],
                    fontWeight: _remainingTime < 30
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Verify button
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: 'Verify',
                  onPressed: controller.verifyOtp,
                ),
              ),
              const SizedBox(height: 16),
              // Resend OTP button
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: 'Resend Code',
                  onPressed: _remainingTime > 0
                      ? null
                      : controller.resendOtp,
                  variant: ButtonVariant.outlined,
                ),
              ),
              const SizedBox(height: 16),
              // Go back button
              Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Go back'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTitle() {
    switch (widget.type) {
      case RequestOtpType.email:
        return 'Verify Email';
      case RequestOtpType.phone:
        return 'Verify Phone';
      case RequestOtpType.forgotPassword:
        return 'Verify Code';
    }
  }

  void _handleVerificationSuccess() {
    switch (widget.type) {
      case RequestOtpType.email:
      case RequestOtpType.phone:
        // For email/phone verification during registration
        Navigator.of(context).pushReplacementNamed('/login');
        break;
      case RequestOtpType.forgotPassword:
        // For password reset flow, navigate to reset password screen
        Navigator.pushNamed(
          context,
          '/reset-password',
          arguments: {
            'email': widget.target,
            'token': controller.getFullOtp(),
          },
        );
        break;
    }
  }
}
''';

  // Forgot Password Screen
  String get forgotPasswordScreen => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../../../../core/validators/input_field_validator.dart';
import '../../../../navigation/navigation.dart';
import '../../data/enums/auth_enums.dart';
import '../controllers/controllers.dart';
import '../helpers/helpers.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late ForgotPasswordController controller;

  @override
  void initState() {
    super.initState();
    controller = ForgotPasswordController(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is AuthConfirmed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.response.message),
              backgroundColor: Colors.green,
            ),
          );
          // Navigate to verify OTP screen for password reset
          Navigator.pushNamed(
            context,
            '/verify-otp',
            arguments: {
              'target': controller.email.text,
              'type': RequestOtpType.forgotPassword,
            },
          );
        }
      },
      child: BaseScaffold(
        title: 'Forgot Password',
        isLoading: context.watch<AuthBloc>().state is AuthLoading,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Icon(
                Icons.lock_reset,
                size: 56,
                color: theme.primaryColor,
              ),
              const SizedBox(height: 24),
              Text(
                'Forgot Password?',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Don\\'t worry! It happens. Please enter the email address associated with your account.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              Form(
                key: controller.formKey,
                child: BaseTextField(
                  label: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  validator: InputFieldValidator.email,
                  controller: controller.email,
                  onFieldSubmitted: (value) => controller.requestPasswordReset(),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: 'Send Reset Code',
                  onPressed: controller.requestPasswordReset,
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
                  child: const Text('Back to Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''';

  // Reset Password Screen
  String get resetPasswordScreen => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../../../../core/validators/input_field_validator.dart';
import '../../../../navigation/navigation.dart';
import '../controllers/controllers.dart';
import '../helpers/helpers.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.token,
  });
  
  final String email;
  final String token;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late ResetPasswordController controller;

  @override
  void initState() {
    super.initState();
    controller = ResetPasswordController(context, widget.email, widget.token);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is AuthConfirmed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.response.message),
              backgroundColor: Colors.green,
            ),
          );
          // Navigate to login screen after successful password reset
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/login',
            (route) => false,
          );
        }
      },
      child: BaseScaffold(
        title: 'Reset Password',
        isLoading: context.watch<AuthBloc>().state is AuthLoading,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Icon(
                Icons.lock_outline,
                size: 56,
                color: theme.primaryColor,
              ),
              const SizedBox(height: 24),
              Text(
                'Create New Password',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your new password must be different from previously used passwords.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    BaseTextField(
                      label: 'New Password',
                      obscureText: true,
                      validator: InputFieldValidator.password,
                      controller: controller.password,
                    ),
                    const SizedBox(height: 16),
                    BaseTextField(
                      label: 'Confirm Password',
                      obscureText: true,
                      validator: (value) => InputFieldValidator.confirmPassword(value, controller.password.text),
                      controller: controller.confirmPassword,
                      onFieldSubmitted: (value) => controller.resetPassword(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Password requirements
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password Requirements:',
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildPasswordRequirement('At least 8 characters'),
                    _buildPasswordRequirement('Contains uppercase and lowercase letters'),
                    _buildPasswordRequirement('Contains at least one number'),
                    _buildPasswordRequirement('Contains at least one special character'),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: 'Reset Password',
                  onPressed: controller.resetPassword,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 16,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
''';

  // Request OTP Controller
  String get requestOtpController => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/enums/auth_enums.dart';
import '../controllers/controllers.dart';

class RequestOtpController {
  RequestOtpController(this.context, this.target, this.type);
  final BuildContext context;
  final String target;
  final RequestOtpType type;

  void requestOtp() {
    final event = RequestOtp(
      target: target,
      type: type,
      load: true,
    );
    context.read<AuthBloc>().add(event);
  }

  void dispose() {
    // Clean up any resources if needed
  }
}
''';

  // Verify OTP Controller
  String get verifyOtpController => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/enums/auth_enums.dart';
import '../controllers/controllers.dart';

class VerifyOtpController {
  VerifyOtpController(this.context, this.target, this.type);
  final BuildContext context;
  final String target;
  final RequestOtpType type;

  final formKey = GlobalKey<FormState>();
  final List<TextEditingController> controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  void verifyOtp() {
    if (formKey.currentState!.validate()) {
      final otp = getFullOtp();
      
      if (type == RequestOtpType.email) {
        final event = VerifyEmail(
          email: target,
          value: otp,
        );
        context.read<AuthBloc>().add(event);
      } else if (type == RequestOtpType.phone) {
        final event = VerifyPhoneNumber(
          phoneNumber: target,
          value: otp,
        );
        context.read<AuthBloc>().add(event);
      } else {
        // For forgot password, we just verify the OTP
        final event = VerifyEmail(
          email: target,
          value: otp,
        );
        context.read<AuthBloc>().add(event);
      }
    }
  }

  void resendOtp() {
    final event = RequestOtp(
      target: target,
      type: type,
      load: true,
    );
    context.read<AuthBloc>().add(event);
  }

  String getFullOtp() {
    return controllers.map((controller) => controller.text).join();
  }

  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
  }
}
''';

  // Forgot Password Controller
  String get forgotPasswordController => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/enums/auth_enums.dart';
import '../controllers/controllers.dart';

class ForgotPasswordController {
  ForgotPasswordController(this.context);
  final BuildContext context;

  final email = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void requestPasswordReset() {
    if (formKey.currentState!.validate()) {
      final event = RequestOtp(
        target: email.text,
        type: RequestOtpType.forgotPassword,
        load: true,
      );
      context.read<AuthBloc>().add(event);
    }
  }

  void dispose() {
    email.dispose();
  }
}
''';

  // Reset Password Controller
  String get resetPasswordController => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/controllers.dart';

class ResetPasswordController {
  ResetPasswordController(this.context, this.email, this.token);
  final BuildContext context;
  final String email;
  final String token;

  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void resetPassword() {
    if (formKey.currentState!.validate()) {
      final event = ResetPassword(
        email: email,
        password: password.text,
        token: token,
      );
      context.read<AuthBloc>().add(event);
    }
  }

  void dispose() {
    password.dispose();
    confirmPassword.dispose();
  }
}
''';
}
