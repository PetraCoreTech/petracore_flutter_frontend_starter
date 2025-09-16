#!/usr/bin/env dart

import 'dart:io';

/// Script to generate all remaining component templates from lena_core
/// Run this script to automatically create all missing component template files
void main() async {
  print('🚀 Generating all component templates...');

  await generateComponentTemplates();

  print('✅ All component templates generated successfully!');
  print('📁 Generated files in lib/src/templates/project/components/');
  print('🔧 Next step: Update project_templates.dart to include new imports and getters');
}

Future<void> generateComponentTemplates() async {
  final components = _getComponentList();
  
  for (final component in components) {
    await _createComponentTemplate(component);
  }
}

Future<void> _createComponentTemplate(ComponentInfo component) async {
  final file = File('lib/src/templates/project/components/${component.fileName}');
  await file.parent.create(recursive: true);
  
  final content = _generateTemplateContent(component);
  await file.writeAsString(content);
  
  print('📝 Generated: ${component.fileName}');
}

List<ComponentInfo> _getComponentList() {
  return [
    // App Bars
    ComponentInfo(
      fileName: 'app_bar_v1_template.dart',
      className: 'AppBarV1',
      description: 'Custom app bar with theming',
      category: 'app_bars',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    ComponentInfo(
      fileName: 'tab_bar_v1_template.dart',
      className: 'TabBarV1',
      description: 'Custom tab bar with theming',
      category: 'app_bars',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    
    // Button variants
    ComponentInfo(
      fileName: 'app_outline_button_style_template.dart',
      className: 'AppOutlineButtonStyle',
      description: 'Style for outline button',
      category: 'buttons',
      isPart: true,
      partOf: 'app_outline_button.dart',
    ),
    ComponentInfo(
      fileName: 'app_outline_button_type_template.dart',
      className: 'AppOutlineButtonType',
      description: 'Type variants for outline button',
      category: 'buttons',
      isPart: true,
      partOf: 'app_outline_button.dart',
    ),
    ComponentInfo(
      fileName: 'app_text_button_template.dart',
      className: 'AppTextButton',
      description: 'Text button component',
      category: 'buttons',
      dependencies: ['flutter/material.dart', 'package:mix/mix.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    
    // Dialog components
    ComponentInfo(
      fileName: 'action_dialog_template.dart',
      className: 'ActionDialog',
      description: 'Action dialog component',
      category: 'dialog',
      dependencies: ['flutter/material.dart', 'package:gap/gap.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    ComponentInfo(
      fileName: 'dialog_v1_template.dart',
      className: 'DialogV1',
      description: 'Basic dialog component',
      category: 'dialog',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    ComponentInfo(
      fileName: 'info_dialog_template.dart',
      className: 'InfoDialog',
      description: 'Info dialog component',
      category: 'dialog',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    ComponentInfo(
      fileName: 'toast_v2_template.dart',
      className: 'ToastV2',
      description: 'Alternative toast component',
      category: 'dialog/toast',
      dependencies: ['flutter/material.dart', 'package:gap/gap.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    ComponentInfo(
      fileName: 'content_container_template.dart',
      className: 'ContentContainer',
      description: 'Container for dialog content',
      category: 'dialog/utils',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    
    // Display components
    ComponentInfo(
      fileName: 'initials_display_template.dart',
      className: 'InitialsDisplay',
      description: 'Display user initials',
      category: 'displays',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    ComponentInfo(
      fileName: 'mark_down_display_template.dart',
      className: 'MarkDownDisplay',
      description: 'Markdown content display',
      category: 'displays',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    
    // Frame components
    ComponentInfo(
      fileName: 'icon_frame_template.dart',
      className: 'IconFrame',
      description: 'Frame for icons',
      category: 'frames',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    ComponentInfo(
      fileName: 'list_frame_template.dart',
      className: 'ListFrame',
      description: 'Frame for lists',
      category: 'frames',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    ComponentInfo(
      fileName: 'profile_frame_template.dart',
      className: 'ProfileFrame',
      description: 'Frame for profile content',
      category: 'frames',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    
    // Icon components
    ComponentInfo(
      fileName: 'custom_icon_template.dart',
      className: 'CustomIcon',
      description: 'Custom icon component',
      category: 'icon',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    ComponentInfo(
      fileName: 'dot_template.dart',
      className: 'Dot',
      description: 'Dot indicator component',
      category: 'icon',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    ComponentInfo(
      fileName: 'more_icon_template.dart',
      className: 'MoreIcon',
      description: 'More options icon',
      category: 'icon',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    
    // Input field components
    ComponentInfo(
      fileName: 'password_field_template.dart',
      className: 'PasswordField',
      description: 'Password input field',
      category: 'input_fields',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart', 'base_text_field.dart'],
    ),
    ComponentInfo(
      fileName: 'phone_field_template.dart',
      className: 'PhoneField',
      description: 'Phone number input field',
      category: 'input_fields',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    
    // Helper components
    ComponentInfo(
      fileName: 'toast_helper_template.dart',
      className: 'ToastHelper',
      description: 'Toast utility functions',
      category: 'helpers',
      dependencies: ['flutter/material.dart', '../dialog/toast/toast_v1.dart'],
    ),
    ComponentInfo(
      fileName: 'snackbar_helper_template.dart',
      className: 'SnackbarHelper',
      description: 'Snackbar utility functions',
      category: 'helpers',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    
    // State components
    ComponentInfo(
      fileName: 'info_display_template.dart',
      className: 'InfoDisplay',
      description: 'Info display component',
      category: 'states',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    ComponentInfo(
      fileName: 'loading_overlay_v1_template.dart',
      className: 'LoadingOverlayV1',
      description: 'Loading overlay component',
      category: 'states',
      dependencies: ['flutter/material.dart', 'loading_indicator.dart'],
    ),
    ComponentInfo(
      fileName: 'loading_shimmer_template.dart',
      className: 'LoadingShimmer',
      description: 'Shimmer loading effect',
      category: 'states',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    
    // Tile components
    ComponentInfo(
      fileName: 'expansion_tile_v1_template.dart',
      className: 'ExpansionTileV1',
      description: 'Custom expansion tile',
      category: 'tiles',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
    ComponentInfo(
      fileName: 'list_tile_v1_template.dart',
      className: 'ListTileV1',
      description: 'Custom list tile',
      category: 'tiles',
      dependencies: ['flutter/material.dart', '../../theme/design_tokens/theme_token.dart'],
    ),
  ];
}

String _generateTemplateContent(ComponentInfo component) {
  final imports = component.dependencies.map((dep) => "import '$dep';").join('\\n');
  final partLine = component.isPart ? "part of '${component.partOf}';" : '';
  
  return '''import '../../../generators/project_generator.dart';

String ${component.functionName}(ProjectConfig config) => \'\'\'
${partLine.isNotEmpty ? partLine + '\\n' : ''}$imports

/// ${component.description} for \${config.projectName}
class ${component.className} extends StatelessWidget {
  /// Constructor
  const ${component.className}({
    super.key,
    // Add component-specific properties here
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement ${component.className} with mixtheme integration
    final colors = \\\$token.color;
    
    return Container(
      // Implement component UI here
      child: const Placeholder(),
    );
  }
}
\'\'\';
''';
}

class ComponentInfo {
  final String fileName;
  final String className;
  final String description;
  final String category;
  final List<String> dependencies;
  final bool isPart;
  final String? partOf;

  ComponentInfo({
    required this.fileName,
    required this.className,
    required this.description,
    required this.category,
    this.dependencies = const [],
    this.isPart = false,
    this.partOf,
  });

  String get functionName => fileName.replaceAll('_template.dart', 'Template').replaceAll('_', '');
}
