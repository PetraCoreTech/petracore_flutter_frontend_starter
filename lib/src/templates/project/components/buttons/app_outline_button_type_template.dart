String appOutlineButtonTypeTemplate() => '''
part of 'app_outline_button.dart';

class AppOutlineButtonType extends Variant {
  const AppOutlineButtonType._(super.name);

  static const primary = AppOutlineButtonType._('app.outline.button.primary');
  static const secondary =
      AppOutlineButtonType._('app.outline.button.secondary');
  static const tertiary = AppOutlineButtonType._('app.outline.button.tertiary');
  static const error = AppOutlineButtonType._('app.outline.button.error');
}
''';
