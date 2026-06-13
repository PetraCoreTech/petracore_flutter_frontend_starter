String surveyModeCubitTemplate(String projectName) => '''
import 'package:bloc/bloc.dart';
import 'package:$projectName/features/survey/presentation/enums/survey_mode.dart';

final surveyModeCubit = SurveyModeCubit();

class SurveyModeCubit extends Cubit<SurveyMode> {
  SurveyModeCubit() : super(SurveyMode.question);

  void setMode(SurveyMode value) => emit(value);
  void reset() => emit(SurveyMode.question);
}
''';
