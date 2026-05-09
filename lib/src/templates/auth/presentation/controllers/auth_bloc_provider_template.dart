import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String authBlocProviderTemplate(ProjectConfig config) => '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:${config.projectName}/features/auth/presentation/controllers/auth_controller_index.dart';

final List<BlocProvider> authBlocProvider = [
  /** Blocs */
  BlocProvider<AuthBloc>(create: (context) => authBloc),

  /** Cubits */
  BlocProvider<AuthHistoryCubit>(create: (context) => authHistoryCubit),
  BlocProvider<EmailCubit>(create: (context) => emailCubit),
  BlocProvider<UserCubit>(create: (context) => userCubit),
];
''';
