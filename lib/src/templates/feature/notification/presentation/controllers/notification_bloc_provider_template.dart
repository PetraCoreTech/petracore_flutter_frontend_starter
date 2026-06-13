String notificationBlocProviderTemplate(String projectName) => '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:$projectName/features/notification/presentation/controllers/cubits/notification_cubit/notification_cubit.dart';

final notificationBlocProvider = [
  BlocProvider<NotificationCubit>(create: (context) => NotificationCubit()),
];
''';
