import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mapBlocProviderTemplate(ProjectConfig config) => '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:${config.packageName}/features/map/presentation/controllers/map_controllers_index.dart';

final mapBlocProvider = <BlocProvider>[
  BlocProvider<LocationBloc>(create: (context) => locationBloc),
  BlocProvider<NearbyPlacesBloc>(create: (context) => nearbyPlacesBloc),
  BlocProvider<LocationCubit>(create: (context) => locationCubit),
  BlocProvider<NearbyPlacesCubit>(create: (context) => nearbyPlacesCubit),
];
''';
