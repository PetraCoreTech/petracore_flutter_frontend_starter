import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mediaBlocProviderTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/media/presentation/controllers/blocs/download_action_bloc/download_action_bloc.dart';
import 'package:${config.packageName}/features/media/presentation/controllers/blocs/upload_action_bloc/upload_action_bloc.dart';

final List<BlocProvider> mediaBlocProvider = [
  BlocProvider<DownloadActionBloc>(create: (context) => downloadActionBloc),
  BlocProvider<UploadActionBloc>(create: (context) => uploadActionBloc),
];
''';
