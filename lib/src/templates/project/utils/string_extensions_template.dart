import '../../../generators/project_generator.dart';

String stringExtensionsTemplate(ProjectConfig config) => """
/// String extension methods for ${config.projectName}
/// 
/// Provides utility methods for string validation, formatting, and manipulation
extension StringExtensions on String {
  
  /// Validates if the string is a valid email address
  /// Uses comprehensive regex pattern to match RFC-compliant email addresses
  bool isValidEmail() {
    const usernamePrefix = r'[^<>()[\\\\]\\\\\\\\.,;:\\\\s@\\\\\"]';
    const usernameSuffix = r'(\\\\.[^<>()[\\\\]\\\\\\\\.,;:\\\\s@\\\\\"]+)*';
    const quotedString = r'(\\\\\".+\\\\\")';
    const ipAddress = r'(\\\\[[0-9]{1,3}\\\\.[0-9]{1,3}\\\\.[0-9]{1,3}\\\\.[0-9]{1,3}\\\\])';
    const domainName = r'([a-zA-Z\\\\-0-9]+\\\\.)';
    const topDomainName = '[a-zA-Z]{2,}';
    const symbol = '@';

    final emailRegExpString = r'^((' + usernamePrefix + r'+' + usernameSuffix + r'|' + quotedString + ')@(' + ipAddress + r'|(' + domainName + r'+' + topDomainName + r')))\$';
    final emailRegExp = RegExp(emailRegExpString);
    return emailRegExp.hasMatch(this);
  }

  /// Validates if the string is a valid URL
  /// Supports http, https, and www protocols
  bool isValidUrl() {
    const protocol1 = r'(https?:www\\\\.)';
    const protocol2 = r'(https?:\\\\/\\\\/\\\\/)';
    const protocol3 = r'(www\\\\.)';
    const protocol4 = r'(http?:\\\\/\\\\/\\\\/)';
    const domainName = r'[-a-zA-Z0-9@:%._\\\\+~#=]{1,256}';
    const symbol = r'\\\\.';
    const topDomainName = '[a-zA-Z0-9]{1,6}';
    const optionalPath = r'(\\\\/[-a-zA-Z0-9()@:%_\\\\+.~#?&\\\\/=]*)?';

    final linkRegExpString = r'(' + protocol1 + r'|' + protocol2 + r'|' + protocol3 + r'|' + protocol4 + r')' + 
        domainName + symbol + topDomainName + optionalPath;
    final linkRegExp = RegExp(linkRegExpString);
    return linkRegExp.hasMatch(this);
  }

  /// Validates if the string is valid text (more than 3 characters)
  bool isValidText() {
    return length > 3;
  }

  /// Converts http:// to https:// for secure protocol
  String toSecureProtocol() {
    return replaceFirst('http://', 'https://');
  }

  /// Adds http:// protocol if no protocol is present
  String addProtocol() {
    final hasHttp = contains('http://') || contains('https://');
    if (!hasHttp) return 'http://\$this';
    return this;
  }

  /// Capitalizes the first letter of the string
  String capitalize() {
    if (isEmpty) return this;
    return '\${this[0].toUpperCase()}\${substring(1)}';
  }

  /// Capitalizes the first letter of each word
  String capitalizeWords() {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word.isEmpty ? word : word.capitalize())
        .join(' ');
  }

  /// Adds another string with optional separator
  String add(String value, {String? separator = ' '}) {
    return '\$this\$separator\$value';
  }

  /// Converts snake_case to normal text with spaces
  String formatFromSnakeCase() => split('_').join(' ');

  /// Converts normal text to snake_case
  String toSnakeCase() => toLowerCase().split(' ').join('_');

  /// Converts text to kebab-case
  String toKebabCase() => toLowerCase().split(' ').join('-');

  /// Converts text to camelCase
  String toCamelCase() {
    if (isEmpty) return this;
    final words = split(' ');
    if (words.length == 1) return words[0].toLowerCase();
    
    final firstWord = words[0].toLowerCase();
    final capitalizedWords = words
        .skip(1)
        .map((word) => word.capitalize())
        .join('');
    
    return '\$firstWord\$capitalizedWords';
  }

  /// Converts text to PascalCase
  String toPascalCase() {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word.capitalize())
        .join('');
  }

  /// Shortens text with ellipsis in the middle
  /// [start] - Characters to keep at start
  /// [end] - Characters to keep at end  
  /// [max] - Maximum total length before shortening
  String shortenWithEllipsis({int? start, int? end, int? max}) {
    final inputMax = max ?? 20;
    final inputStart = start ?? (inputMax ~/ 2);
    final inputEnd = end ?? (length - (inputMax ~/ 2));
    
    return length > inputMax
        ? replaceRange(inputStart, inputEnd, '...')
        : this;
  }

  /// Truncates text with ellipsis at the end
  /// [max] - Maximum length before truncation
  String truncate({int max = 20}) {
    return length > max ? '\${substring(0, max)}...' : this;
  }

  /// Returns the string if not empty, null otherwise
  String? get nullIfEmpty => isEmpty ? null : this;

  /// Pluralizes a word based on count
  /// [count] - Number to determine if plural is needed
  String pluralize({int? count}) {
    if (count != null) {
      return count == 1 ? this : _getPluralForm();
    }
    return endsWith('s') ? this : _getPluralForm();
  }

  /// Gets the plural form of a word using basic English rules
  String _getPluralForm() {
    if (endsWith('y') &&
        !endsWith('ay') &&
        !endsWith('ey') &&
        !endsWith('oy') &&
        !endsWith('uy')) {
      return '\${substring(0, length - 1)}ies';
    } else if (endsWith('s') ||
        endsWith('x') ||
        endsWith('z') ||
        endsWith('ch') ||
        endsWith('sh')) {
      return '\${this}es';
    } else if (endsWith('f')) {
      return '\${substring(0, length - 1)}ves';
    } else if (endsWith('fe')) {
      return '\${substring(0, length - 2)}ves';
    } else {
      return '\${this}s';
    }
  }

  /// Removes all whitespace from the string
  String removeWhitespace() => replaceAll(RegExp(r'\\\\s+'), '');

  /// Removes extra spaces (multiple spaces become single space)
  String normalizeSpaces() => replaceAll(RegExp(r'\\\\s+'), ' ').trim();

  /// Checks if string contains only letters
  bool get isAlphabetic => RegExp(r'^[a-zA-Z]+\$').hasMatch(this);

  /// Checks if string contains only numbers
  bool get isNumeric => RegExp(r'^[0-9]+\$').hasMatch(this);

  /// Checks if string contains only letters and numbers
  bool get isAlphanumeric => RegExp(r'^[a-zA-Z0-9]+\$').hasMatch(this);

  /// Masks email address (shows first 2 chars and domain)
  /// Example: john.doe@example.com -> jo***@example.com
  String maskEmail() {
    if (!isValidEmail()) return this;
    
    final parts = split('@');
    if (parts.length != 2) return this;
    
    final username = parts[0];
    final domain = parts[1];
    
    if (username.length <= 2) return this;
    
    final maskedUsername = '\${username.substring(0, 2)}***';
    return '\$maskedUsername@\$domain';
  }

  /// Masks phone number (shows last 4 digits)
  /// Example: 1234567890 -> ******7890
  String maskPhone() {
    if (length < 4) return this;
    final lastFour = substring(length - 4);
    final masked = '*' * (length - 4);
    return '\$masked\$lastFour';
  }

  /// Formats phone number with common pattern
  /// Example: 1234567890 -> (123) 456-7890
  String formatPhoneNumber() {
    final cleaned = replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cleaned.length == 10) {
      return '(\${cleaned.substring(0, 3)}) \${cleaned.substring(3, 6)}-\${cleaned.substring(6)}';
    } else if (cleaned.length == 11 && cleaned.startsWith('1')) {
      return '+1 (\${cleaned.substring(1, 4)}) \${cleaned.substring(4, 7)}-\${cleaned.substring(7)}';
    }
    
    return this; // Return original if not standard format
  }

  /// Formats credit card number with spaces
  /// Example: 1234567890123456 -> 1234 5678 9012 3456
  String formatCreditCard() {
    final cleaned = replaceAll(RegExp(r'[^0-9]'), '');
    final buffer = StringBuffer();
    
    for (int i = 0; i < cleaned.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(cleaned[i]);
    }
    
    return buffer.toString();
  }

  /// Generates initials from full name
  /// Example: "John Doe Smith" -> "JDS"
  String generateInitials({int maxInitials = 2}) {
    final words = trim().split(RegExp(r'\\\\s+'));
    final initials = words
        .where((word) => word.isNotEmpty)
        .take(maxInitials)
        .map((word) => word[0].toUpperCase())
        .join();
    
    return initials;
  }

  /// Converts string to title case
  /// Example: "hello world" -> "Hello World"
  String toTitleCase() {
    return split(' ')
        .map((word) => word.isEmpty ? word : word.capitalize())
        .join(' ');
  }

  /// Reverses the string
  String reverse() {
    return split('').reversed.join('');
  }

  /// Checks if the string is a palindrome
  bool get isPalindrome {
    final normalized = toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    return normalized == normalized.reverse();
  }

  /// Word count in the string
  int get wordCount => trim().split(RegExp(r'\\\\s+')).where((word) => word.isNotEmpty).length;

  /// Character count excluding spaces
  int get characterCountNoSpaces => replaceAll(' ', '').length;
}
""";
