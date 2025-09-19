String baseThemeTemplate() => '''
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import '../design_tokens/theme_token.dart';

final defaultFont = TextStyle(
  fontFamily: 'Times New Roman',
);

/// Base theme: this houses all the text theme and Misc. styles
final baseTheme = MixThemeData(
  textStyles: {
    \$token.textStyle.heading1: defaultFont.copyWith(
      height: 1.44,
      fontSize: 36,
      fontWeight: FontWeight.w600,
    ),
    \$token.textStyle.heading2: defaultFont.copyWith(
      height: 1.44,
      fontSize: 32,
      fontWeight: FontWeight.w600,
    ),
    \$token.textStyle.heading3: defaultFont.copyWith(
      height: 1.44,
      fontSize: 28,
      fontWeight: FontWeight.w600,
    ),
    \$token.textStyle.heading4: defaultFont.copyWith(
      height: 1.44,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    \$token.textStyle.heading5: defaultFont.copyWith(
      height: 1.44,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    \$token.textStyle.paragraph1: defaultFont.copyWith(
      height: 1.5,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    \$token.textStyle.paragraph2: defaultFont.copyWith(
      height: 1.5,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    \$token.textStyle.paragraph3: defaultFont.copyWith(
      height: 1.5,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    \$token.textStyle.paragraph4: defaultFont.copyWith(
      height: 1.5,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    \$token.textStyle.paragraph5: defaultFont.copyWith(
      height: 1.5,
      fontSize: 10,
      fontWeight: FontWeight.w400,
    ),
    \$token.textStyle.label1: defaultFont.copyWith(
      height: 1.43,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    \$token.textStyle.label2: defaultFont.copyWith(
      height: 1.71,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    \$token.textStyle.label3: defaultFont.copyWith(
      height: 1.71,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    \$token.textStyle.label4: defaultFont.copyWith(
      height: 1.71,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  },
  radii: {
    \$token.radius.small: const Radius.circular(4),
    \$token.radius.medium: const Radius.circular(8),
    \$token.radius.large: const Radius.circular(100),
  },
);
''';
