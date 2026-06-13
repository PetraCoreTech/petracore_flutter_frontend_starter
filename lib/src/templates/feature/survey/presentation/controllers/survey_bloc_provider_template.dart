String surveyBlocProviderTemplate(String projectName) => '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:$projectName/features/survey/presentation/controllers/cubits/survey_mode_cubit/survey_mode_cubit.dart';

final surveyBlocProvider = [
  BlocProvider<SurveyModeCubit>(create: (context) => surveyModeCubit),
];
''';
