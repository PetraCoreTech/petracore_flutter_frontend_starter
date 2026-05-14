import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String inputFieldValidatorTemplate(ProjectConfig config) => '''
import 'package:flutter/widgets.dart';
import 'package:${config.projectName}/core/utils/extensions/string_extension.dart';
 
/// This validator provides common validation methods for form inputs including:
/// - [required] - Basic required field validation
/// - [email] - Email format validation
/// - [text] - Text with minimum length validation
/// - [password] - Strong password validation
/// - [phoneNumber] - Phone number validation
/// - [otp] - OTP/PIN validation
/// - [url] - URL format validation
/// - [multipleSelection] - List selection validation
/// - [requiredSearch] - Search field validation
/// - [requiredEntity] - Entity object validation
/// - [requiredReadOnly] - Read-only field validation
/// - [requiredText] - Text field with controller validation
/// - [requiredEmail] - Email field with controller validation
/// - [requiredPassword] - Password field with controller validation
/// - [requiredListenable] - ValueNotifier validation
class InputFieldValidator {
  InputFieldValidator._();

  /// Maximum character length for text inputs
  static const maxCharacterLength = 120;

  /// Error message for character length exceeded
  static const maxCharacterError =
      "Input can't be more than \$maxCharacterLength characters";

  /// Basic required field validation
  /// Returns null if valid, error message if invalid
  static String? required(String? value) {
    final input = value ?? '';
    if (input.isEmpty) return 'Required';
    return null;
  }

  /// Email validation with format checking
  /// Validates email format and length constraints
  static String? email(String? value) {
    final input = value ?? '';
    if (input.isEmpty) {
      return 'Required';
    } else if (input.isEmail()) {
      return 'Email is invalid';
    } else if (input.length > maxCharacterLength) {
      return maxCharacterError;
    }
    return null;
  }

  /// URL/Link validation
  /// Validates URL format and protocol
  static String? url(String? value) {
    final input = value ?? '';
    if (input.isEmpty) {
      return 'Required';
    } else if (!input.isLink()) {
      return 'URL is invalid';
    }
    return null;
  }

  /// Text validation with minimum length requirement
  /// Default minimum length is 3 characters
  static String? text(String? value, {int minLength = 3}) {
    final input = value ?? '';
    if (input.isEmpty) {
      return 'Required';
    } else if (input.length < minLength) {
      return 'Must be at least \$minLength characters.';
    } else if (input.length > maxCharacterLength) {
      return maxCharacterError;
    }
    return null;
  }

  /// Strong password validation
  /// Requires at least 8 characters, uppercase, lowercase, and number/symbol
  static String? password(String? value) {
    final input = value ?? '';
    if (input.isEmpty) {
      return 'Required';
    } else if (input.length < 8) {
      return 'Password should be at least 8 characters';
    } else if (!input.contains(RegExp(r'(?=.*[a-z])(?=.*[A-Z])\\w+'))) {
      return 'Password should contain upper and lowercase letters';
    } else if (!input.contains(RegExp(r'[0-9_~`!@#\$%^&*()?.=-]'))) {
      return 'Password should contain at least a number or symbol';
    }
    return null;
  }

  /// OTP/PIN validation
  /// [otpLength] - Expected length of OTP (default: 6)
  static String? otp(String? value, {int otpLength = 6}) {
    final input = value ?? '';
    if (input.isEmpty) return 'Required';
    if (input.length != otpLength) return 'Invalid OTP';
    if (!RegExp(r'^[0-9]+\$').hasMatch(input)) return 'OTP must contain only numbers';
    return null;
  }

  /// Phone number validation
  /// [minLength] - Minimum phone number length (default: 10)
  /// [maxLength] - Maximum phone number length (default: 15)
  static String? phoneNumber(String? value, {int minLength = 10, int maxLength = 15}) {
    final input = value ?? '';
    if (input.isEmpty) return 'Required';
    
    // Remove common phone number formatting characters
    final cleanedInput = input.replaceAll(RegExp(r'[()\\s-+]'), '');
    
    if (!RegExp(r'^[0-9]+\$').hasMatch(cleanedInput)) {
      return 'Invalid phone number format';
    }
    
    if (cleanedInput.length < minLength || cleanedInput.length > maxLength) {
      return 'Phone number must be between \$minLength and \$maxLength digits';
    }
    
    return null;
  }

  /// Credit card number validation
  /// Basic Luhn algorithm validation
  static String? creditCard(String? value) {
    final input = value ?? '';
    if (input.isEmpty) return 'Required';
    
    final cleanedInput = input.replaceAll(RegExp(r'\\s'), '');
    
    if (!RegExp(r'^[0-9]+\$').hasMatch(cleanedInput)) {
      return 'Card number must contain only numbers';
    }
    
    if (cleanedInput.length < 13 || cleanedInput.length > 19) {
      return 'Invalid card number length';
    }
    
    // Luhn algorithm check
    if (!_isValidLuhn(cleanedInput)) {
      return 'Invalid card number';
    }
    
    return null;
  }

  /// Multiple selection validation (for lists)
  static String? multipleSelection<T>(List<T>? value) {
    final input = value ?? [];
    if (input.isEmpty) return 'Required';
    return null;
  }

  /// Search field validation with selected entity
  /// Validates both search text and selected entity
  static String? requiredSearch<T>(String? searchText, T? selectedEntity) {
    final input = searchText ?? '';
    if (input.isEmpty) return 'Required';
    if (selectedEntity == null) return 'Please select an option';
    return null;
  }

  /// Entity validation (for dropdowns, selections)
  static String? requiredEntity<T>(T? value) {
    if (value == null) return 'Required';
    return null;
  }

  /// Read-only field validation using TextEditingController
  static String? requiredReadOnly(TextEditingController controller) {
    final input = controller.text;
    if (input.isEmpty) {
      return 'Required';
    } else if (input.length > maxCharacterLength) {
      return maxCharacterError;
    }
    return null;
  }

  /// Text field validation using TextEditingController
  static String? requiredText(TextEditingController controller, {int minLength = 3}) {
    final input = controller.text;
    if (input.isEmpty) {
      return 'Required';
    } else if (input.length < minLength) {
      return 'Must be at least \$minLength characters.';
    } else if (input.length > maxCharacterLength) {
      return maxCharacterError;
    }
    return null;
  }

  /// Email field validation using TextEditingController
  static String? requiredEmail(TextEditingController controller, {int? maxLength}) {
    final input = controller.text;
    final max = maxLength ?? maxCharacterLength;
    
    if (input.isEmpty) {
      return 'Required';
    } else if (input.isEmail()) {
      return 'Email is invalid';
    } else if (input.length > max) {
      return "Email can't be more than \$max characters";
    }
    return null;
  }

  /// Password field validation using TextEditingController
  static String? requiredPassword(TextEditingController controller) {
    return password(controller.text);
  }

  /// ValueNotifier validation for reactive forms
  static String? requiredListenable<T>(ValueNotifier<T?> valueNotifier) {
    if (valueNotifier.value == null) return 'Required';
    return null;
  }

  /// Confirm password validation
  /// Validates that password and confirm password match
  static String? confirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Required';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Age validation
  /// [minAge] - Minimum age requirement (default: 13)
  /// [maxAge] - Maximum age limit (default: 120)
  static String? age(String? value, {int minAge = 13, int maxAge = 120}) {
    final input = value ?? '';
    if (input.isEmpty) return 'Required';
    
    final age = int.tryParse(input);
    if (age == null) return 'Please enter a valid age';
    
    if (age < minAge) return 'Must be at least \$minAge years old';
    if (age > maxAge) return 'Must be less than \$maxAge years old';
    
    return null;
  }

  /// Postal/ZIP code validation
  /// Supports various international formats
  static String? postalCode(String? value, {String? countryCode}) {
    final input = value ?? '';
    if (input.isEmpty) return 'Required';
    
    // Default validation (alphanumeric, spaces, hyphens)
    if (!RegExp(r'^[a-zA-Z0-9\\s-]+\$').hasMatch(input)) {
      return 'Invalid postal code format';
    }
    
    // Country-specific validation
    switch (countryCode?.toUpperCase()) {
      case 'US':
        if (!RegExp(r'^\\d{5}(-\\d{4})?\$').hasMatch(input)) {
          return 'Invalid US ZIP code format';
        }
        break;
      case 'CA':
        if (!RegExp(r'^[A-Za-z]\\d[A-Za-z] \\d[A-Za-z]\\d\$').hasMatch(input)) {
          return 'Invalid Canadian postal code format';
        }
        break;
      case 'UK':
        if (!RegExp(r'^[A-Za-z]{1,2}\\d[A-Za-z\\d]? \\d[A-Za-z]{2}\$').hasMatch(input)) {
          return 'Invalid UK postal code format';
        }
        break;
    }
    
    return null;
  }

  /// Custom validation with custom regex pattern
  /// [pattern] - Regular expression pattern to match
  /// [errorMessage] - Custom error message
  static String? custom(String? value, RegExp pattern, String errorMessage) {
    final input = value ?? '';
    if (input.isEmpty) return 'Required';
    if (!pattern.hasMatch(input)) return errorMessage;
    return null;
  }

  /// Luhn algorithm implementation for credit card validation
  static bool _isValidLuhn(String cardNumber) {
    int sum = 0;
    bool alternate = false;
    
    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);
      
      if (alternate) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }
      
      sum += digit;
      alternate = !alternate;
    }
    
    return sum % 10 == 0;
  }
}
''';
