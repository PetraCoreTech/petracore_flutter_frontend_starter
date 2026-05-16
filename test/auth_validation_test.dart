import 'package:petracore_flutter_frontend_starter/src/generators/auth_flow_generator.dart';
import 'package:petracore_flutter_frontend_starter/src/utils/auth_validation.dart';
import 'package:test/test.dart';

void main() {
  group('AuthValidation', () {
    test('passes for valid config with login', () {
      final config = AuthFlowConfig(
        projectName: 'test_app',
        outputPath: '/tmp/test',
        includeLogin: true,
        includeSignup: false,
      );
      expect(() => AuthValidation.validateConfig(config), returnsNormally);
    });

    test('passes for valid config with signup only', () {
      final config = AuthFlowConfig(
        projectName: 'test_app',
        outputPath: '/tmp/test',
        includeLogin: false,
        includeSignup: true,
        includeForgotPassword: false,
        includeOtp: false,
      );
      expect(() => AuthValidation.validateConfig(config), returnsNormally);
    });

    test('throws when no core auth features enabled', () {
      final config = AuthFlowConfig(
        projectName: 'test_app',
        outputPath: '/tmp/test',
        includeLogin: false,
        includeSignup: false,
        includeForgotPassword: false,
        includeOtp: false,
        includeEmailVerification: false,
        includePhoneVerification: false,
      );
      expect(
        () => AuthValidation.validateConfig(config),
        throwsArgumentError,
      );
    });

    test('throws when email verification without login or signup', () {
      final config = AuthFlowConfig(
        projectName: 'test_app',
        outputPath: '/tmp/test',
        includeLogin: false,
        includeSignup: false,
        includeEmailVerification: true,
      );
      expect(
        () => AuthValidation.validateConfig(config),
        throwsArgumentError,
      );
    });

    test('throws when phone verification without login or signup', () {
      final config = AuthFlowConfig(
        projectName: 'test_app',
        outputPath: '/tmp/test',
        includeLogin: false,
        includeSignup: false,
        includePhoneVerification: true,
      );
      expect(
        () => AuthValidation.validateConfig(config),
        throwsArgumentError,
      );
    });

    test('throws when forgot password without login', () {
      final config = AuthFlowConfig(
        projectName: 'test_app',
        outputPath: '/tmp/test',
        includeLogin: false,
        includeForgotPassword: true,
      );
      expect(
        () => AuthValidation.validateConfig(config),
        throwsArgumentError,
      );
    });

    test('passes with all features enabled', () {
      final config = AuthFlowConfig(
        projectName: 'test_app',
        outputPath: '/tmp/test',
        includeLogin: true,
        includeSignup: true,
        includeEmailVerification: true,
        includePhoneVerification: true,
        includeForgotPassword: true,
        includeOtp: true,
      );
      expect(() => AuthValidation.validateConfig(config), returnsNormally);
    });
  });
}
