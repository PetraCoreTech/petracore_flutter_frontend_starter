String appTextButtonTypeTemplate() => '''
part of 'app_text_button.dart';

class AppTextButtonType extends Variant {
  const AppTextButtonType._(super.name);

  static const primary = AppTextButtonType._('app.text.button.primary');
  static const secondary = AppTextButtonType._('app.text.button.secondary');
  static const tertiary = AppTextButtonType._('app.text.button.tertiary');
  static const error = AppTextButtonType._('app.text.button.error');
}
''';
