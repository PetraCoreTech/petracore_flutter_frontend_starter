import '../../../generators/project_generator.dart';

String toastTypeTemplate(ProjectConfig config) => '''
/// Toast type enumeration for ${config.projectName}
enum ToastType {
  /// Error toast
  error,

  /// Success toast
  success,

  /// Info toast
  info,
}
''';
