import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialPasswordStrengthCheckerTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';

class PasswordStrengthChecker extends StatelessWidget {
  const PasswordStrengthChecker({
    required this.password,
    super.key,
    this.spacing,
    this.runSpacing,
    this.iconSize,
    this.spacer,
    this.activeIconData,
    this.inactiveIconData,
    this.activeIconPath,
    this.inactiveIconPath,
    this.textColor,
    this.textStyle,
    this.activeColor,
    this.inactiveColor,
  });

  final double? spacing;
  final double? runSpacing;
  final ValueNotifier<String> password;
  final double? iconSize;
  final Widget? spacer;
  final IconData? activeIconData;
  final IconData? inactiveIconData;
  final String? activeIconPath;
  final String? inactiveIconPath;
  final Color? textColor;
  final TextStyle? textStyle;
  final Color? activeColor;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: password,
      builder: (context, value, _) {
        return Wrap(
          spacing: spacing ?? 16,
          runSpacing: runSpacing ?? 16,
          children: [
            _buildRequirement(passwordReq1, value.length >= 8),
            _buildRequirement(
              passwordReq2,
              uppercaseLetterRegExp.allMatches(value).isNotEmpty,
            ),
            _buildRequirement(
              passwordReq3,
              lowercaseLetterRegExp.allMatches(value).isNotEmpty,
            ),
            _buildRequirement(
              passwordReq4,
              specialCharacterRegExp.allMatches(value).isNotEmpty,
            ),
          ],
        );
      },
    );
  }

  Widget _buildRequirement(String text, bool isValid) {
    return PasswordRequirement(
      text: text,
      isValid: isValid,
      iconSize: iconSize,
      spacer: spacer,
      activeIconData: activeIconData,
      activeIconPath: activeIconPath,
      inactiveIconData: inactiveIconData,
      inactiveIconPath: inactiveIconPath,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      textColor: textColor,
      textStyle: textStyle,
    );
  }

  static final numberRegExp = RegExp('[0-9]');
  static final uppercaseLetterRegExp = RegExp('[A-Z]');
  static final lowercaseLetterRegExp = RegExp('[a-z]');
  static final specialCharacterRegExp = RegExp(r'[0-9_~`!@#\$%^&*()?.=-]');
  static const passwordReq1 = 'Minimum of 8 characters';
  static const passwordReq2 = 'Uppercase letters';
  static const passwordReq3 = 'Lowercase letters';
  static const passwordReq4 = 'At least a number or symbol ';
}


class PasswordRequirement extends StatelessWidget {
  const PasswordRequirement({
    required this.text,
    super.key,
    this.isValid = false,
    this.iconSize,
    this.spacer,
    this.activeIconData,
    this.inactiveIconData,
    this.activeIconPath,
    this.inactiveIconPath,
    this.textColor,
    this.textStyle,
    this.activeColor,
    this.inactiveColor,
  });

  final String text;
  final bool isValid;
  final double? iconSize;
  final Widget? spacer;
  final IconData? activeIconData;
  final IconData? inactiveIconData;
  final String? activeIconPath;
  final String? inactiveIconPath;
  final Color? textColor;
  final Color? activeColor;
  final Color? inactiveColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (activeIconData != null && inactiveIconData != null)
          Icon(
            isValid ? activeIconData : inactiveIconData,
            size: iconSize ?? 16,
            color: isValid ? activeColor : inactiveColor,
          )
        else if (activeIconPath != null && inactiveIconPath != null)
          CustomIcon(
            icon: isValid ? activeIconPath! : inactiveIconPath!,
            height: iconSize ?? 18,
            color: isValid ? activeColor : inactiveColor,
          ),
        spacer ?? const SizedBox(width: 6),
        Text(
          text,
          style: textStyle ??
              Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: textColor ?? Theme.of(context).colorScheme.outline,
                  ),
        ),
      ],
    );
  }
}
''';
