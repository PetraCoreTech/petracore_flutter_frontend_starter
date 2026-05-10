import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialThemeTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:${config.projectName}/app/constants/app_constants.dart';
import 'package:${config.projectName}/app/theme/color_values.dart';

/// Central theme configuration for the app.
///
/// To customize the app's appearance, modify [AppColors] in color_values.dart.
/// Both light and dark themes are derived from the same color palette.
///
/// Usage in widgets:
///   Theme.of(context).colorScheme.primary
///   Theme.of(context).textTheme.headlineLarge
///   Theme.of(context).elevatedButtonTheme
class AppTheme {
  AppTheme._();


  /// Light theme configuration
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: AppConstants.fontFamily,
        colorScheme: _lightColorScheme,
        appBarTheme: _lightAppBarTheme,
        textTheme: _textTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textButtonTheme: _textButtonTheme,
        inputDecorationTheme: _inputDecorationTheme,
        cardTheme: _cardTheme,
        dialogTheme: _lightDialogTheme,
        snackBarTheme: _snackBarTheme,
        dividerTheme: _lightDividerTheme,
        bottomSheetTheme: _lightBottomSheetTheme,
        navigationBarTheme: _lightNavigationBarTheme,
        floatingActionButtonTheme: _floatingActionButtonTheme,
        chipTheme: _chipTheme,
        switchTheme: _switchTheme,
        checkboxTheme: _checkboxTheme,
        radioTheme: _radioTheme,
        progressIndicatorTheme: _progressIndicatorTheme,
        sliderTheme: _sliderTheme,
      );

  /// Dark theme configuration
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: AppConstants.fontFamily,
        colorScheme: _darkColorScheme,
        appBarTheme: _darkAppBarTheme,
        textTheme: _textTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textButtonTheme: _textButtonTheme,
        inputDecorationTheme: _inputDecorationTheme,
        cardTheme: _cardTheme,
        dialogTheme: _darkDialogTheme,
        snackBarTheme: _snackBarTheme,
        dividerTheme: _darkDividerTheme,
        bottomSheetTheme: _darkBottomSheetTheme,
        navigationBarTheme: _darkNavigationBarTheme,
        floatingActionButtonTheme: _floatingActionButtonTheme,
        chipTheme: _chipTheme,
        switchTheme: _switchTheme,
        checkboxTheme: _checkboxTheme,
        radioTheme: _radioTheme,
        progressIndicatorTheme: _progressIndicatorTheme,
        sliderTheme: _sliderTheme,
      );

  // ==================== COLOR SCHEMES ====================

  /// Light mode ColorScheme derived from the seed color
  static final _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.surface001,
    primaryContainer: AppColors.primaryGrading,
    onPrimaryContainer: AppColors.primaryDark,
    secondary: AppColors.neutral400,
    onSecondary: AppColors.white,
    secondaryContainer: AppColors.neutral100,
    onSecondaryContainer: AppColors.neutral600,
    tertiary: AppColors.technical100,
    onTertiary: AppColors.white,
    tertiaryContainer: AppColors.technical100.withAlpha(40),
    onTertiaryContainer: AppColors.indigo,
    error: AppColors.error,
    onError: AppColors.white,
    errorContainer: AppColors.error.withAlpha(30),
    onErrorContainer: AppColors.error,
    surface: AppColors.white,
    onSurface: AppColors.neutral500,
    surfaceDim: AppColors.neutral50,
    surfaceBright: AppColors.white,
    surfaceContainerLowest: AppColors.white,
    surfaceContainerLow: AppColors.neutral50,
    surfaceContainer: AppColors.neutral50,
    surfaceContainerHigh: AppColors.neutral100,
    surfaceContainerHighest: AppColors.neutral100,
    onSurfaceVariant: AppColors.neutral400,
    outline: AppColors.neutral200,
    outlineVariant: AppColors.neutral100,
    shadow: AppColors.black.withAlpha(60),
    scrim: AppColors.black.withAlpha(100),
    inverseSurface: AppColors.neutral600,
    onInverseSurface: AppColors.white,
    inversePrimary: AppColors.primaryGrading,
    surfaceTint: AppColors.primary,
  );

  /// Dark mode ColorScheme derived from the same palette
  static final _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primaryGrading,
    onPrimary: AppColors.primaryDark,
    primaryContainer: AppColors.primaryDark,
    onPrimaryContainer: AppColors.primaryGrading,
    secondary: AppColors.neutral300,
    onSecondary: AppColors.neutral600,
    secondaryContainer: AppColors.neutral500,
    onSecondaryContainer: AppColors.neutral100,
    tertiary: AppColors.technical100,
    onTertiary: AppColors.white,
    tertiaryContainer: AppColors.technical100.withAlpha(60),
    onTertiaryContainer: AppColors.white,
    error: AppColors.error.withAlpha(200),
    onError: AppColors.white,
    errorContainer: AppColors.error,
    onErrorContainer: AppColors.white,
    surface: AppColors.neutral600,
    onSurface: AppColors.neutral100,
    surfaceDim: AppColors.neutral600,
    surfaceBright: AppColors.neutral500,
    surfaceContainerLowest: AppColors.black,
    surfaceContainerLow: AppColors.neutral600,
    surfaceContainer: AppColors.neutral600.withAlpha(240),
    surfaceContainerHigh: AppColors.neutral500,
    surfaceContainerHighest: AppColors.neutral400,
    onSurfaceVariant: AppColors.neutral200,
    outline: AppColors.neutral400,
    outlineVariant: AppColors.neutral500,
    shadow: AppColors.black.withAlpha(100),
    scrim: AppColors.black.withAlpha(150),
    inverseSurface: AppColors.neutral100,
    onInverseSurface: AppColors.neutral600,
    inversePrimary: AppColors.primary,
    surfaceTint: AppColors.primaryGrading,
  );

  // ==================== TYPOGRAPHY ====================

  /// Text theme mapped to the project's design token scale
  static const _textTheme = TextTheme(
    // Mapping: heading1 → headlineLarge
    headlineLarge: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w600,
      height: 1.44,
      letterSpacing: -0.25,
    ),
    // Mapping: heading2 → headlineMedium
    headlineMedium: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      height: 1.44,
      letterSpacing: -0.25,
    ),
    // Mapping: heading3 → titleLarge
    titleLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      height: 1.44,
      letterSpacing: -0.15,
    ),
    // Mapping: heading4 → titleMedium
    titleMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.44,
      letterSpacing: -0.15,
    ),
    // Mapping: heading5 → titleSmall
    titleSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.44,
      letterSpacing: -0.1,
    ),
    // Mapping: paragraph1 → bodyLarge
    bodyLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: -0.1,
    ),
    // Mapping: paragraph2 → bodyMedium
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: -0.1,
    ),
    // Mapping: paragraph3 → bodySmall
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: -0.1,
    ),
    // Mapping: paragraph4 → labelLarge
    labelLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      height: 1.43,
      letterSpacing: -0.1,
    ),
    // Mapping: paragraph5/label2 → labelMedium
    labelMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.71,
      letterSpacing: -0.1,
    ),
    // Mapping: label3/label4 → labelSmall
    labelSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.71,
      letterSpacing: -0.1,
    ),
    // Mapping: paragraph4 → displaySmall (for large displays)
    displaySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: -0.1,
    ),
  );

  // ==================== BUTTON THEMES ====================

  static final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _lightColorScheme.primary,
      foregroundColor: _lightColorScheme.onPrimary,
      disabledBackgroundColor: _lightColorScheme.onSurface.withValues(alpha: 0.12),
      disabledForegroundColor: _lightColorScheme.onSurface.withValues(alpha: 0.38),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 1,
      textStyle: _textTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
    ),
  );

  static final _outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: _lightColorScheme.primary,
      side: BorderSide(
        color: _lightColorScheme.outline,
        width: 1,
      ),
      disabledForegroundColor: _lightColorScheme.onSurface.withValues(alpha: 0.38),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: _textTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
    ),
  );

  static final _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: _lightColorScheme.primary,
      disabledForegroundColor: _lightColorScheme.onSurface.withValues(alpha: 0.38),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: _textTheme.labelSmall?.copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
    ),
  );

  static final _floatingActionButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: _lightColorScheme.primaryContainer,
    foregroundColor: _lightColorScheme.onPrimaryContainer,
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );

  // ==================== INPUT THEME ====================

  static final _inputDecorationTheme = InputDecorationTheme(
    filled: false,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: _lightColorScheme.outline),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: _lightColorScheme.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: _lightColorScheme.primary,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: _lightColorScheme.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: _lightColorScheme.error,
        width: 2,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: _lightColorScheme.onSurface.withValues(alpha: 0.12)),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    labelStyle: _textTheme.bodySmall,
    hintStyle: _textTheme.bodySmall?.copyWith(
      color: _lightColorScheme.onSurfaceVariant,
    ),
    errorStyle: _textTheme.labelSmall?.copyWith(
      color: _lightColorScheme.error,
      fontSize: 12,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.never,
  );

  // ==================== CARD THEME ====================

  static const _cardTheme = CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    clipBehavior: Clip.antiAlias,
  );

  // ==================== DIALOG THEMES ====================

  static const _lightDialogTheme = DialogTheme(
    backgroundColor: AppColors.white,
    surfaceTintColor: AppColors.white,
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(28)),
    ),
  );

  static const _darkDialogTheme = DialogTheme(
    backgroundColor: AppColors.neutral500,
    surfaceTintColor: Colors.transparent,
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(28)),
    ),
  );

  // ==================== BOTTOM SHEET THEMES ====================

  static const _lightBottomSheetTheme = BottomSheetThemeData(
    backgroundColor: AppColors.white,
    surfaceTintColor: AppColors.white,
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
  );

  static const _darkBottomSheetTheme = BottomSheetThemeData(
    backgroundColor: AppColors.neutral500,
    surfaceTintColor: Colors.transparent,
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
  );

  // ==================== DIVIDER THEMES ====================

  static const _lightDividerTheme = DividerThemeData(
    color: AppColors.neutral100,
    thickness: 1,
    space: 1,
  );

  static const _darkDividerTheme = DividerThemeData(
    color: AppColors.neutral400,
    thickness: 1,
    space: 1,
  );

  // ==================== SNACKBAR THEME ====================

  static SnackBarThemeData get _snackBarTheme => SnackBarThemeData(
        backgroundColor: _lightColorScheme.inverseSurface,
        contentTextStyle: _textTheme.bodyMedium?.copyWith(
          color: _lightColorScheme.onInverseSurface,
        ),
        actionTextColor: _lightColorScheme.inversePrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 3,
      );

  // ==================== NAVIGATION BAR THEMES ====================

  static const _lightNavigationBarTheme = NavigationBarThemeData(
    backgroundColor: AppColors.white,
    surfaceTintColor: AppColors.white,
    elevation: 3,
    indicatorColor: AppColors.primary,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
  );

  static const _darkNavigationBarTheme = NavigationBarThemeData(
    backgroundColor: AppColors.neutral600,
    surfaceTintColor: Colors.transparent,
    elevation: 3,
    indicatorColor: AppColors.primaryGrading,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
  );

  // ==================== CHIP THEME ====================

  static final _chipTheme = ChipThemeData(
    backgroundColor: _lightColorScheme.surfaceContainerHigh,
    selectedColor: _lightColorScheme.secondaryContainer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  // ==================== SWITCH THEME ====================

  static final _switchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return _lightColorScheme.primary;
      }
      return _lightColorScheme.outline;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return _lightColorScheme.primary.withValues(alpha: 0.5);
      }
      return _lightColorScheme.surfaceContainerHighest;
    }),
  );

  // ==================== CHECKBOX THEME ====================

  static final _checkboxTheme = CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return _lightColorScheme.primary;
      }
      return null;
    }),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );

  // ==================== RADIO THEME ====================

  static final _radioTheme = RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return _lightColorScheme.primary;
      }
      return _lightColorScheme.onSurfaceVariant;
    }),
  );

  // ==================== PROGRESS INDICATOR THEME ====================

  static final _progressIndicatorTheme = ProgressIndicatorThemeData(
    color: _lightColorScheme.primary,
    linearTrackColor: _lightColorScheme.surfaceContainerHighest,
  );

  // ==================== SLIDER THEME ====================

  static final _sliderTheme = SliderThemeData(
    activeTrackColor: _lightColorScheme.primary,
    inactiveTrackColor: _lightColorScheme.primary.withValues(alpha: 0.24),
    thumbColor: _lightColorScheme.primary,
    overlayColor: _lightColorScheme.primary.withValues(alpha: 0.12),
    activeTickMarkColor: _lightColorScheme.onPrimary,
    inactiveTickMarkColor: _lightColorScheme.primary.withValues(alpha: 0.38),
  );

  // ==================== APP BAR THEMES ====================

  static const _lightAppBarTheme = AppBarTheme(
    backgroundColor: AppColors.white,
    surfaceTintColor: AppColors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.neutral600),
    titleTextStyle: TextStyle(
      color: AppColors.neutral600,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.1,
    ),
  );

  static const _darkAppBarTheme = AppBarTheme(
    backgroundColor: AppColors.neutral600,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.neutral100),
    titleTextStyle: TextStyle(
      color: AppColors.neutral100,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.1,
    ),
  );
}
''';
