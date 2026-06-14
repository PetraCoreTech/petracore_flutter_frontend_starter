import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String locationBlocListenerTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:${config.packageName}/features/map/presentation/controllers/map_controllers_index.dart';

final locationBlocListener = BlocListener<LocationBloc, LocationState>(
  listener: (context, state) {
    if (state is LocationError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error.message)),
      );
    } else if (state is LocationLoaded) {
      context.read<LocationCubit>().setLocation(state.location);
    }
  },
);
''';
