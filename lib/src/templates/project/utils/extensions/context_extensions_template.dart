String contextExtensionsTemplate() => '''
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
  
  
  void popDialog() {
    final context = this;
    Navigator.of(context, rootNavigator: true).pop();
  }

  void popDialogs({int count = 2}) {
    popDialog();
    var max = 1;
    while (max < count) {
      Future.delayed(const Duration(milliseconds: 200), popDialog);
      max++;
    }
  }

  Widget spacer(double mainAxisExtent) {
    final orientation = MediaQuery.of(this).orientation;
    return switch (orientation) {
      Orientation.portrait => const Spacer(),
      Orientation.landscape => Gap(mainAxisExtent),
    };
  }

  void unFocus() => FocusScope.of(this).unfocus();

  void requestFocus(FocusNode? focusNode) =>
      FocusScope.of(this).requestFocus(focusNode);

  void openDrawer() => Scaffold.of(this).openEndDrawer();

  void closeDrawer() => Scaffold.of(this).closeEndDrawer();
}
''';
