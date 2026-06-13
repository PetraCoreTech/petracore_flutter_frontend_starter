String surveyIndexTemplate(String projectName) => '''
export 'presentation/controllers/survey_controller_index.dart';
export 'presentation/entities/survey_answer_entity.dart';
export 'presentation/entities/survey_question_entity.dart';
export 'presentation/enums/survey_mode.dart';
export 'presentation/widgets/survey_answer_display.dart';
export 'presentation/widgets/survey_builder.dart';
export 'presentation/widgets/survey_question_display.dart';
''';
