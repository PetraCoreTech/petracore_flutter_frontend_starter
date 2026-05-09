import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String listScreenTemplate(FeatureConfig config) {
  final screenName = config.featureName;
  final screenClass = config.pascalCase;
  final entityClass = config.pascalEntity;
  final cubitName = '${entityClass}Cubit';
  final modelName = '${entityClass}Model';

  return '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:${config.projectConfig.projectName}/core/core.dart';

import '../../controllers/cubits/${screenName}_cubit.dart';

class ${screenClass}ListScreen extends StatelessWidget {
  const ${screenClass}ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${screenClass} List'),
      ),
      body: BlocBuilder<${cubitName}, ${entityClass}?>(
        builder: (context, state) {
          if (state == null) {
            return const Center(child: Text('No ${modelName}s found.'));
          }
          return Center(
            child: Text('\${state.toJson()}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to add new ${screenClass} screen
          Logger.info('Add new ${screenClass}');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
''';
}