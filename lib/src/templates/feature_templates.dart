import '../generators/feature_generator.dart';

class FeatureTemplates {
  final FeatureConfig config;

  FeatureTemplates(this.config);

  String get featureIndex => '''
// Data Layer
${config.includeModels ? "export 'data/models/models.dart';" : ''}
${config.includeRepository ? "export 'data/remote/remote.dart';" : ''}
${config.includeUseCases ? "export 'data/use_cases/use_cases.dart';" : ''}

// Presentation Layer
export 'presentation/presentation.dart';
''';

  String get dataModel => '''
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';

part '${config.featureName}_model.freezed.dart';
part '${config.featureName}_model.g.dart';

@freezed
class ${config.pascalCase}Model with _\$${config.pascalCase}Model {
  const factory ${config.pascalCase}Model({
    required String id,
    required String name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _${config.pascalCase}Model;

  factory ${config.pascalCase}Model.fromJson(Map<String, dynamic> json) =>
      _\$${config.pascalCase}ModelFromJson(json);
}

// Alternative: Using Equatable instead of Freezed
/*
class ${config.pascalCase}Model extends Equatable {
  final String id;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ${config.pascalCase}Model({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory ${config.pascalCase}Model.fromJson(Map<String, dynamic> json) {
    return ${config.pascalCase}Model(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }

  ${config.pascalCase}Model copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ${config.pascalCase}Model(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, name, createdAt, updatedAt];
}
*/
''';

  String get modelsBarrel => '''
export '${config.featureName}_model.dart';
''';

  String get repository => '''
import 'package:dartz/dartz.dart';
import '../models/models.dart';

abstract class ${config.pascalCase}Repository {
  Future<Either<String, List<${config.pascalCase}Model>>> get${config.pascalCase}List();
  Future<Either<String, ${config.pascalCase}Model>> get${config.pascalCase}ById(String id);
  Future<Either<String, ${config.pascalCase}Model>> create${config.pascalCase}(${config.pascalCase}Model model);
  Future<Either<String, ${config.pascalCase}Model>> update${config.pascalCase}(${config.pascalCase}Model model);
  Future<Either<String, bool>> delete${config.pascalCase}(String id);
}

class ${config.pascalCase}RepositoryImpl implements ${config.pascalCase}Repository {
  // Add your data sources here (API, local storage, etc.)
  
  @override
  Future<Either<String, List<${config.pascalCase}Model>>> get${config.pascalCase}List() async {
    try {
      // TODO: Implement API call or data fetching logic
      final List<${config.pascalCase}Model> items = [];
      return Right(items);
    } catch (e) {
      return Left('Failed to fetch ${config.featureName} list: \$e');
    }
  }

  @override
  Future<Either<String, ${config.pascalCase}Model>> get${config.pascalCase}ById(String id) async {
    try {
      // TODO: Implement get by ID logic
      throw UnimplementedError('get${config.pascalCase}ById not implemented');
    } catch (e) {
      return Left('Failed to fetch ${config.featureName}: \$e');
    }
  }

  @override
  Future<Either<String, ${config.pascalCase}Model>> create${config.pascalCase}(${config.pascalCase}Model model) async {
    try {
      // TODO: Implement create logic
      return Right(model);
    } catch (e) {
      return Left('Failed to create ${config.featureName}: \$e');
    }
  }

  @override
  Future<Either<String, ${config.pascalCase}Model>> update${config.pascalCase}(${config.pascalCase}Model model) async {
    try {
      // TODO: Implement update logic
      return Right(model);
    } catch (e) {
      return Left('Failed to update ${config.featureName}: \$e');
    }
  }

  @override
  Future<Either<String, bool>> delete${config.pascalCase}(String id) async {
    try {
      // TODO: Implement delete logic
      return const Right(true);
    } catch (e) {
      return Left('Failed to delete ${config.featureName}: \$e');
    }
  }
}
''';

  String get repositoriesBarrel => '''
export '${config.featureName}_repository.dart';
''';

  String get getUseCase => '''
import 'package:dartz/dartz.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

class Get${config.pascalCase}UseCase {
  final ${config.pascalCase}Repository repository;

  const Get${config.pascalCase}UseCase(this.repository);

  Future<Either<String, List<${config.pascalCase}Model>>> call() async {
    return await repository.get${config.pascalCase}List();
  }
}

class Get${config.pascalCase}ByIdUseCase {
  final ${config.pascalCase}Repository repository;

  const Get${config.pascalCase}ByIdUseCase(this.repository);

  Future<Either<String, ${config.pascalCase}Model>> call(String id) async {
    return await repository.get${config.pascalCase}ById(id);
  }
}
''';

  String get useCasesBarrel => '''
export 'get_${config.featureName}_use_case.dart';
''';

  String get cubit => '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
${config.includeModels ? "import '../../data/models/models.dart';" : ''}
${config.includeUseCases ? "import '../../data/use_cases/use_cases.dart';" : ''}
import '${config.featureName}_state.dart';

class ${config.pascalCase}Cubit extends Cubit<${config.pascalCase}State> {
${config.includeUseCases ? '  final Get${config.pascalCase}UseCase _get${config.pascalCase}UseCase;' : ''}

  ${config.pascalCase}Cubit(${config.includeUseCases ? 'this._get${config.pascalCase}UseCase' : ''}) : super(const ${config.pascalCase}State.initial());

  Future<void> load${config.pascalCase}Data() async {
    emit(const ${config.pascalCase}State.loading());
    
    try {
${config.includeUseCases ? '''      final result = await _get${config.pascalCase}UseCase();
      
      result.fold(
        (error) => emit(${config.pascalCase}State.error(error)),
        (data) => emit(${config.pascalCase}State.loaded(data)),
      );''' : '''      // TODO: Implement data loading logic
      emit(const ${config.pascalCase}State.loaded([]));'''}
    } catch (e) {
      emit(${config.pascalCase}State.error('Failed to load ${config.featureName}: \$e'));
    }
  }

  void refresh() {
    load${config.pascalCase}Data();
  }
}
''';

  String get state => '''
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
${config.includeModels ? "import '../../data/models/models.dart';" : ''}

part '${config.featureName}_state.freezed.dart';

@freezed
class ${config.pascalCase}State with _\$${config.pascalCase}State {
  const factory ${config.pascalCase}State.initial() = _Initial;
  const factory ${config.pascalCase}State.loading() = _Loading;
  const factory ${config.pascalCase}State.loaded(${config.includeModels ? 'List<${config.pascalCase}Model>' : 'List<dynamic>'} data) = _Loaded;
  const factory ${config.pascalCase}State.error(String message) = _Error;
}

// Alternative: Using Equatable instead of Freezed
/*
abstract class ${config.pascalCase}State extends Equatable {
  const ${config.pascalCase}State();

  @override
  List<Object?> get props => [];
}

class ${config.pascalCase}Initial extends ${config.pascalCase}State {
  const ${config.pascalCase}Initial();
}

class ${config.pascalCase}Loading extends ${config.pascalCase}State {
  const ${config.pascalCase}Loading();
}

class ${config.pascalCase}Loaded extends ${config.pascalCase}State {
  final ${config.includeModels ? 'List<${config.pascalCase}Model>' : 'List<dynamic>'} data;

  const ${config.pascalCase}Loaded(this.data);

  @override
  List<Object?> get props => [data];
}

class ${config.pascalCase}Error extends ${config.pascalCase}State {
  final String message;

  const ${config.pascalCase}Error(this.message);

  @override
  List<Object?> get props => [message];
}
*/
''';

  String get blocProvider => '''
import 'package:flutter_bloc/flutter_bloc.dart';
import '${config.featureName}_cubit.dart';
${config.includeRepository ? "import '../../data/repositories/repositories.dart';" : ''}
${config.includeUseCases ? "import '../../data/use_cases/use_cases.dart';" : ''}

final List<BlocProvider> ${config.camelCase}BlocProvider = [
  BlocProvider<${config.pascalCase}Cubit>(
    create: (context) => ${config.pascalCase}Cubit(
${config.includeUseCases ? '      Get${config.pascalCase}UseCase(${config.pascalCase}RepositoryImpl()),' : ''}
    ),
  ),
];
''';

  String get controllersBarrel => '''
export '${config.featureName}_cubit.dart';
export '${config.featureName}_state.dart';
export '${config.featureName}_bloc_provider.dart';
''';

  String get screen => '''
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

  String get widget => '''
import 'package:flutter/material.dart';

class ${config.pascalCase}Widget extends StatelessWidget {
  const ${config.pascalCase}Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${config.className} Widget',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This is a reusable widget for the ${config.featureName} feature.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          // TODO: Add your widget implementation here
        ],
      ),
    );
  }
}
''';

  String get screensBarrel => '''
export '${config.featureName}_screen.dart';
''';

  String get widgetsBarrel => '''
export '${config.featureName}_widget.dart';
''';

  String get presentationBarrel => '''
export 'screens/screens.dart';
export 'widgets/widgets.dart';
${config.includeBloc ? "export 'controllers/controllers.dart';" : ''}
''';

  String get service => '''
import 'package:dio/dio.dart';
import 'dto/dto.dart';

class ${config.pascalCase}Service {
  final Dio dio;
  
  ${config.pascalCase}Service(this.dio);
  
  Future<List<${config.pascalCase}Dto>> get${config.pascalCase}List() async {
    try {
      final response = await dio.get('/${config.featureName}');
      final List<dynamic> data = response.data;
      return data.map((json) => ${config.pascalCase}Dto.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch ${config.featureName} list: \$e');
    }
  }
  
  Future<${config.pascalCase}Dto> get${config.pascalCase}ById(String id) async {
    try {
      final response = await dio.get('/${config.featureName}/\$id');
      return ${config.pascalCase}Dto.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch ${config.featureName}: \$e');
    }
  }
  
  Future<${config.pascalCase}Dto> create${config.pascalCase}(${config.pascalCase}Dto dto) async {
    try {
      final response = await dio.post(
        '/${config.featureName}',
        data: dto.toJson(),
      );
      return ${config.pascalCase}Dto.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create ${config.featureName}: \$e');
    }
  }
  
  Future<${config.pascalCase}Dto> update${config.pascalCase}(String id, ${config.pascalCase}Dto dto) async {
    try {
      final response = await dio.put(
        '/${config.featureName}/\$id',
        data: dto.toJson(),
      );
      return ${config.pascalCase}Dto.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update ${config.featureName}: \$e');
    }
  }
  
  Future<bool> delete${config.pascalCase}(String id) async {
    try {
      await dio.delete('/${config.featureName}/\$id');
      return true;
    } catch (e) {
      throw Exception('Failed to delete ${config.featureName}: \$e');
    }
  }
}
''';

  String get dto => '''
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/models.dart';

part '${config.featureName}_dto.freezed.dart';
part '${config.featureName}_dto.g.dart';

@freezed
class ${config.pascalCase}Dto with _\$${config.pascalCase}Dto {
  const factory ${config.pascalCase}Dto({
    required String id,
    required String name,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _${config.pascalCase}Dto;

  factory ${config.pascalCase}Dto.fromJson(Map<String, dynamic> json) =>
      _\$${config.pascalCase}DtoFromJson(json);
}

extension ${config.pascalCase}DtoX on ${config.pascalCase}Dto {
  ${config.pascalCase}Model toModel() {
    return ${config.pascalCase}Model(
      id: id,
      name: name,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension ${config.pascalCase}ModelX on ${config.pascalCase}Model {
  ${config.pascalCase}Dto toDto() {
    return ${config.pascalCase}Dto(
      id: id,
      name: name,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
''';

  String get dtoBarrel => '''
export '${config.featureName}_dto.dart';
''';

  String get remoteBarrel => '''
export '${config.featureName}_repository.dart';
export '${config.featureName}_service.dart';
export 'dto/dto.dart';
''';
}
