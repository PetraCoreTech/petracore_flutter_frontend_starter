import '../../../generators/project_generator.dart';

String validationIndexTemplate(ProjectConfig config) => '''
// Validation utilities for ${config.projectName}
// 
// This file exports all validation-related utilities including:
// - InputFieldValidator: Comprehensive form validation methods
// - StringExtensions: String utility methods for validation and formatting

export 'input_field_validator.dart';
export 'string_extensions.dart';
''';
