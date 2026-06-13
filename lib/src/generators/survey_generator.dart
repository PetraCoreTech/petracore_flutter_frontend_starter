import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/feature_templates.dart';

class SurveyGenerator {
  SurveyGenerator(this.config);

  final FeatureConfig config;
  FeatureTemplates get templates => FeatureTemplates(config);

  Future<void> generate() async {
    Logger.step('Creating survey directory structure...');
    await _createDirectories();

    Logger.step('Generating survey feature files...');
    await _generateFiles();

    Logger.step('Updating bloc providers...');
    await _updateSharedBlocProvider();
  }

  Future<void> _createDirectories() async {
    final dirs = [
      path.join(config.featureRoot, 'presentation', 'controllers', 'cubits', 'survey_mode_cubit'),
      path.join(config.featureRoot, 'presentation', 'entities'),
      path.join(config.featureRoot, 'presentation', 'enums'),
      path.join(config.featureRoot, 'presentation', 'widgets'),
    ];
    for (final dir in dirs) {
      await Directory(dir).create(recursive: true);
    }
  }

  Future<void> _generateFiles() async {
    final files = {
      'survey_index.dart': templates.surveyIndex,
      'presentation/controllers/cubits/survey_mode_cubit/survey_mode_cubit.dart': templates.surveyModeCubit,
      'presentation/controllers/survey_bloc_provider.dart': templates.surveyBlocProvider,
      'presentation/controllers/survey_controller_index.dart': templates.surveyControllerIndex,
      'presentation/entities/survey_answer_entity.dart': templates.surveyAnswerEntity,
      'presentation/entities/survey_question_entity.dart': templates.surveyQuestionEntity,
      'presentation/enums/survey_mode.dart': templates.surveyModeEnum,
      'presentation/widgets/survey_builder.dart': templates.surveyBuilder,
      'presentation/widgets/overview_mode.dart': templates.surveyOverviewMode,
      'presentation/widgets/question_mode.dart': templates.surveyQuestionMode,
      'presentation/widgets/survey_answer_display.dart': templates.surveyAnswerDisplay,
      'presentation/widgets/survey_question_display.dart': templates.surveyQuestionDisplay,
      'presentation/widgets/survey_option_selector.dart': templates.surveyOptionSelector,
    };
    for (final entry in files.entries) {
      final filePath = path.join(config.featureRoot, entry.key);
      await FileUtils.writeFile(filePath, entry.value);
    }
  }

  Future<void> _updateSharedBlocProvider() async {
    final sharedPath = path.join(
      config.projectConfig.projectPath,
      'lib/features/shared/presentation/controllers/bloc_provider.dart',
    );
    final file = File(sharedPath);
    if (!await file.exists()) return;

    final importLine =
        "import 'package:${config.projectConfig.packageName}/${config.importRoot}/presentation/controllers/survey_bloc_provider.dart';";
    var content = await file.readAsString();

    if (!content.contains(importLine)) {
      content = content.replaceFirst(
        "import 'package:flutter_bloc/flutter_bloc.dart';",
        "import 'package:flutter_bloc/flutter_bloc.dart';\n$importLine",
      );
    }

    final spreadEntry = '  ...surveyBlocProvider,';
    if (!content.contains(spreadEntry)) {
      content = content.replaceFirst(
        '  // petracore:start:bloc_providers',
        '  // petracore:start:bloc_providers\n$spreadEntry',
      );
    }
    await FileUtils.writeFile(sharedPath, content);
  }
}
