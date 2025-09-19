import '../../../../generators/feature_generator.dart';

String screenTemplate(FeatureConfig config) => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/core.dart';
${config.includeBloc ? "import '../controllers/${config.featureName}_cubit.dart';" : ''}
${config.includeBloc ? "import '../controllers/${config.featureName}_state.dart';" : ''}

class ${config.pascalCase}Screen extends StatefulWidget {
  const ${config.pascalCase}Screen({super.key});

  @override
  State<${config.pascalCase}Screen> createState() => _${config.pascalCase}ScreenState();
}

class _${config.pascalCase}ScreenState extends State<${config.pascalCase}Screen> {
  @override
  void initState() {
    super.initState();
${config.includeBloc ? '    context.read<${config.pascalCase}Cubit>().load${config.pascalCase}Data();' : ''}
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        title: Text('${config.className}'),
        centerTitle: true,
      ),
      body: ${config.includeBloc ? '_buildBody()' : '_buildStaticBody()'},
    );
  }

${config.includeBloc ? '''  Widget _buildBody() {
    return BlocBuilder<${config.pascalCase}Cubit, ${config.pascalCase}State>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(
            child: Text('Welcome to ${config.className}'),
          ),
          loading: () => const LoadingIndicator(
            message: 'Loading ${config.featureName}...',
          ),
          loaded: (data) => _buildLoadedContent(data),
          error: (message) => _buildErrorContent(message),
        );
      },
    );
  }

  Widget _buildLoadedContent(${config.includeModels ? 'List<${config.pascalCase}Model>' : 'List<dynamic>'} data) {
    if (data.isEmpty) {
      return _buildEmptyContent();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<${config.pascalCase}Cubit>().refresh();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(${config.includeModels ? 'item.name' : 'item.toString()'}),
              subtitle: Text(${config.includeModels ? 'item.id' : '"Item #\$index"'}),
              onTap: () {
                // TODO: Navigate to detail screen or handle tap
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const Gap(16),
          Text(
            'No ${config.featureName} found',
            style: context.textTheme.titleMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const Gap(8),
          Text(
            'Pull to refresh or add new items',
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorContent(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[400],
          ),
          const Gap(16),
          Text(
            'Something went wrong',
            style: context.textTheme.titleMedium,
          ),
          const Gap(8),
          Text(
            message,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(24),
          AppButton(
            text: 'Try Again',
            onPressed: () {
              context.read<${config.pascalCase}Cubit>().refresh();
            },
          ),
        ],
      ),
    );
  }''' : '''  Widget _buildStaticBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.dashboard,
            size: 100,
            color: context.colorScheme.primary,
          ),
          const Gap(24),
          Text(
            '${config.className} Screen',
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(16),
          Text(
            'This is your ${config.featureName} feature screen.',
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(32),
          AppButton(
            text: 'Get Started',
            onPressed: () {
              context.showSnackBar('${config.className} feature is ready!');
            },
          ),
        ],
      ),
    );
  }'''}
}
''';
