
String contextExtensionsTemplate() => '''
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  
  TextTheme get textTheme => theme.textTheme;
  
  ColorScheme get colorScheme => theme.colorScheme;
  
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  
  Size get screenSize => MediaQuery.sizeOf(this);
  
  double get screenHeight => screenSize.height;
  
  double get screenWidth => screenSize.width;
    
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);
  
  void showSnackBar(String message, {TextStyle? style}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message, style: style)),
    );
  }
}
''';
