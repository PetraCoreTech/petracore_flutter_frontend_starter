import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String listScreenTemplate(FeatureConfig config) {
  final featureName = config.featureName;
  final className = config.pascalCase;
  final cubitName = '${className}Cubit';
  final modelName = '${className}Model';

  return '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

import '../../controllers/cubits/${featureName}_cubit.dart';

class ${className}ListScreen extends StatelessWidget {
  const ${className}ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${className} List'),
      ),
      body: BlocBuilder<${cubitName}, ${className}State>(
        builder: (context, state) {
          if (state is ${className}Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ${className}Loaded) {
            return ListView.builder(
              itemCount: state.${featureName}s.length,
              itemBuilder: (context, index) {
                final ${featureName} = state.${featureName}s[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(${featureName}.name), // Assuming a 'name' property
                    subtitle: Text('ID: \${\$${featureName}.id}'), // Assuming an 'id' property
                    onTap: () {
                      // TODO: Navigate to ${className} detail screen
                      Logger.info('Tapped on \${\$${featureName}.name}');
                    },
                  ),
                );
              },
            );
          } else if (state is ${className}Error) {
            return Center(child: Text('Error: \${state.message}'));
          }
          return const Center(child: Text('No ${modelName}s found.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to add new ${className} screen
          Logger.info('Add new ${className}');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
''';
}