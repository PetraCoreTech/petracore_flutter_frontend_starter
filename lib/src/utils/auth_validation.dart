import '../generators/auth_flow_generator.dart';

/// Validates [AuthFlowConfig] for consistency and completeness before
/// code generation.
class AuthValidation {
  /// Validates [config] to ensure at least one core auth capability is enabled
  /// and that dependent capabilities have their prerequisites satisfied.
  /// Throws [ArgumentError] on invalid configurations.
  static void validateConfig(AuthFlowConfig config) {
    final hasCoreAuthFeature = config.includeLogin ||
        config.includeSignup ||
        config.includeForgotPassword ||
        config.includeOtp ||
        config.includeEmailVerification ||
        config.includePhoneVerification;
    if (!hasCoreAuthFeature) {
      throw ArgumentError(
        'At least one core auth capability must be enabled (login, signup, forgot-password, otp, email-verification, phone-verification).',
      );
    }

    if (config.includeEmailVerification &&
        !config.includeLogin &&
        !config.includeSignup) {
      throw ArgumentError(
        'Email verification requires login or signup to be enabled.',
      );
    }

    if (config.includePhoneVerification &&
        !config.includeLogin &&
        !config.includeSignup) {
      throw ArgumentError(
        'Phone verification requires login or signup to be enabled.',
      );
    }

    if (config.includeForgotPassword && !config.includeLogin) {
      throw ArgumentError(
        'Forgot password requires login to be enabled.',
      );
    }
  }
}
