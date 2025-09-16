import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

class CoreTemplates {
  final ProjectConfig config;

  CoreTemplates(this.config);

  // Input Field Validator Template
  String get inputFieldValidator => """
import 'package:flutter/widgets.dart';

/// String validation extensions
extension StringValidationExtension on String {
  /// Check if string is a valid email
  bool isEmail() {
    const usernamePrefix = r'[^<>()[\\\\]\\\\\\\\.,;:\\\\s@"]';
    const usernameSuffix = r'(\\\\.[^<>()[\\\\]\\\\\\\\.,;:\\\\s@"]+)*';
    const quotedString = r'(".+")';
    const ipAddress = r'(\\\\[[0-9]{1,3}\\\\.[0-9]{1,3}\\\\.[0-9]{1,3}\\\\.[0-9]{1,3}\\\\])';
    const domainName = r'([a-zA-Z\\\\-0-9]+\\\\.)';
    const topDomainName = '[a-zA-Z]{2,}';
    const symbol = '@';

   const emailRegExpString =
        '''^((\$usernamePrefix+\$usernameSuffix|\$quotedString)\$symbol(\$ipAddress|(\$domainName+\$topDomainName)))\\\\\\\$''';
  final emailRegExp = RegExp(emailRegExpString);
    return emailRegExp.hasMatch(this);
  }

  /// Check if string is a valid URL/Link
  bool isLink() {
    const protocol1 = r'(https?:www\\\\.)';
    const protocol2 = r'(https?://)';
    const protocol3 = r'(www\\\\.)';
    const protocol4 = r'(http?://)';
    const domainName = r'[-a-zA-Z0-9@:%._\\\\+~#=]{1,256}';
    const symbol = r'\\\\.';
    const topDomainName = '[a-zA-Z0-9]{1,6}';
    const optionalPath = r'(/[-a-zA-Z0-9()@:%_\\\\+.~#?&/=]*)?';

    const linkRegExpString =
        '''(\$protocol1|\$protocol2|\$protocol3|\$protocol4)\$domainName\$symbol\$topDomainName\$optionalPath''';
    final linkRegExp = RegExp(linkRegExpString);
    return linkRegExp.hasMatch(this);
  }

  /// Check if string is valid text (more than 3 characters)
  bool isValidText() {
    return length >= 3;
  }
}

/// Comprehensive field validator for input fields
/// Includes validation methods for:
/// - [required] - Required field validation
/// - [email] - Email validation
/// - [text] - Text validation (minimum 3 characters)
/// - [password] - Strong password validation
/// - [confirmPassword] - Password confirmation validation
/// - [phoneNumber] - Phone number validation
/// - [otp] - OTP validation
/// - [link] - URL/Link validation
/// - [multipleSelection] - List/array validation
/// - [requiredSearch] - Search field validation
/// - [requiredEntity] - Entity/object validation
class InputFieldValidator {
  InputFieldValidator._();

  static const int maxCharacterLength = 120;
  static const String maxCharacterError =
      "Input can't be more than \$maxCharacterLength characters";

  /// Basic required field validation
  static String? required(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) return 'Required';
    return null;
  }

  /// Email validation with format checking
  static String? email(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Required';
    } else if (!input.isEmail()) {
      return 'Please enter a valid email address';
    } else if (input.length > maxCharacterLength) {
      return maxCharacterError;
    }
    return null;
  }

  /// URL/Link validation
  static String? link(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Required';
    } else if (!input.isLink()) {
      return 'Please enter a valid URL';
    }
    return null;
  }

  /// Text validation (minimum 3 characters)
  static String? text(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Required';
    } else if (input.length < 3) {
      return 'Must be at least 3 characters';
    }
    return null;
  }

  /// Name validation (minimum 2 characters, only letters and spaces)
  static String? name(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Required';
    } else if (input.length < 2) {
      return 'Name must be at least 2 characters';
    } else if (!RegExp(r'^[a-zA-Z\\\\s]+\\\$').hasMatch(input)) {
      return 'Name can only contain letters and spaces';
    }
    return null;
  }

  /// Strong password validation
  static String? password(String? value) {
    final input = value ?? '';
    if (input.isEmpty) {
      return 'Required';
    } else if (input.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (!RegExp(r'(?=.*[a-z])(?=.*[A-Z])').hasMatch(input)) {
      return 'Password must contain uppercase and lowercase letters';
    } else if (!RegExp(r'[0-9_~`!@#\$%^&*()?.\\\\-=]').hasMatch(input)) {
      return 'Password must contain at least one number or symbol';
    }
    return null;
  }

  /// Password confirmation validation
  static String? confirmPassword(String? value, String? originalPassword) {
    final input = value ?? '';
    final original = originalPassword ?? '';
    
    if (input.isEmpty) {
      return 'Please confirm your password';
    } else if (input != original) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// OTP validation
  static String? otp(String? value, {int length = 6}) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Required';
    } else if (input.length != length) {
      return 'Please enter a valid \$length-digit OTP';
    } else if (!RegExp(r'^\\\\d+\\\$').hasMatch(input)) {
      return 'OTP can only contain numbers';
    }
    return null;
  }

  /// Phone number validation (basic)
  static String? phoneNumber(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Required';
    } else if (input.length < 10) {
      return 'Please enter a valid phone number';
    } else if (!RegExp(r'^\\\\+?[\\\\d\\\\s\\\\-\\\\(\\\\)]+\\\$').hasMatch(input)) {
      return 'Phone number format is invalid';
    }
    return null;
  }

  /// Multiple selection validation
  static String? multipleSelection<T>(List<T>? value) {
    final input = value ?? [];
    if (input.isEmpty) return 'Please select at least one option';
    return null;
  }

  /// Search field validation
  static String? requiredSearch<T>(String? searchText, T? selectedValue) {
    final input = searchText?.trim() ?? '';
    if (input.isEmpty) return 'Required';
    if (selectedValue == null) return 'Please select a valid option';
    return null;
  }

  /// Entity/object validation
  static String? requiredEntity<T>(T? value) {
    if (value == null) return 'Required';
    return null;
  }

  /// TextEditingController-based validations for reactive forms
  
  /// Required validation for TextEditingController
  static String? requiredController(TextEditingController? controller) {
    final input = controller?.text.trim() ?? '';
    if (input.isEmpty) {
      return 'Required';
    } else if (input.length > maxCharacterLength) {
      return maxCharacterError;
    }
    return null;
  }

  /// Text validation for TextEditingController
  static String? textController(TextEditingController? controller) {
    final input = controller?.text.trim() ?? '';
    if (input.isEmpty) {
      return 'Required';
    } else if (input.length < 3) {
      return 'Must be at least 3 characters';
    }
    return null;
  }

  /// Email validation for TextEditingController
  static String? emailController(TextEditingController? controller) {
    final input = controller?.text.trim() ?? '';
    if (input.isEmpty) {
      return 'Required';
    } else if (!input.isEmail()) {
      return 'Please enter a valid email address';
    } else if (input.length > maxCharacterLength) {
      return maxCharacterError;
    }
    return null;
  }

  /// Password validation for TextEditingController
  static String? passwordController(TextEditingController? controller) {
    final input = controller?.text ?? '';
    return password(input);
  }

  /// Confirm password validation for TextEditingController
  static String? confirmPasswordController(
    TextEditingController? controller,
    TextEditingController? originalController,
  ) {
    final input = controller?.text ?? '';
    final original = originalController?.text ?? '';
    return confirmPassword(input, original);
  }

  /// ValueNotifier validation
  static String? requiredValueNotifier<T>(ValueNotifier<T?>? notifier) {
    if (notifier?.value == null) return 'Required';
    return null;
  }

  /// Custom validation with error message
  static String? custom(String? value, bool Function(String) validator, String errorMessage) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) return 'Required';
    if (!validator(input)) return errorMessage;
    return null;
  }

  /// Optional field validation (only validates if not empty)
  static String? optional(String? value, String? Function(String) validator) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) return null; // Optional fields can be empty
    return validator(input);
  }

  /// Combined validations - runs multiple validators
  static String? combine(String? value, List<String? Function(String?)> validators) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) return result;
    }
    return null;
  }
}
""";

  // Validators index file
  String get validatorsIndex => '''
library validators;

export 'input_field_validator.dart';
''';
}
