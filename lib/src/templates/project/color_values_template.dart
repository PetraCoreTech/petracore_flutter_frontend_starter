import '../../generators/project_generator.dart';

String colorValuesTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';

/// Color Palette Class for ${config.projectName}
class AppColors {
  /// White color
  static const Color white = Color(0xffFFFFFF);

  /// Black color
  static const Color black = Colors.black;

  /// Brown color
  static const Color brown = Color(0xff6D3B01);

  /// Indigo color
  static const Color indigo = Color(0xff01196D);

  /// Primary color
  static const Color primaryGrading = Color(0xff3BEAB1);

  /// Main primary color
  static const Color primary = Color(0xff33FF9C);

  /// Primary pressed state
  static const Color primaryPressed = Color(0xff2CDB86);

  /// Primary disabled state
  static const Color primaryDisabled = Color(0xff24B56F);

  /// Primary dark variant
  static const Color primaryDark = Color(0xff016D4A);

  /// Neutral colors
  static const Color neutral50 = Color(0xFFF3F3F5);
  static const Color neutral100 = Color(0xffE6E5EA);
  static const Color neutral200 = Color(0xFFC6C5CD);
  static const Color neutral300 = Color(0xFF82818E);
  static const Color neutral400 = Color(0xFF4F4D59);
  static const Color neutral500 = Color(0xff2B2A31);
  static const Color neutral600 = Color(0xFF141417);

  /// Surface color
  static const Color surface001 = Color(0xff1B1B1B);

  /// Technical color
  static const Color technical100 = Color(0xFF535474);

  /// Warning color
  static const Color warning = Color(0xffCC7E0A);

  /// Error color
  static const Color error = Color(0xffC31B23);

  /// Shimmer effect color
  static const Color shimmer = Color.fromRGBO(219, 219, 219, 1);
}
''';
