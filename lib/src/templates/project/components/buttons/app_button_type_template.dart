String appButtonTypeTemplate() => '''
part of 'app_button.dart';

class AppButtonType extends Variant {
  const AppButtonType._(super.name);

  static const primary = AppButtonType._('app.button.primary');
  static const secondary = AppButtonType._('app.button.secondary');
  static const tertiary = AppButtonType._('app.button.tertiary');
  static const error = AppButtonType._('app.button.error');
}
''';
