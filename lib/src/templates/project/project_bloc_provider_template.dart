
String projectBlocProviderTemplate() => '''
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> blocProviders = [
  // Add your BLoC providers here
  // Example:
  // BlocProvider<AuthCubit>(
  //   create: (_) => AuthCubit(),
  // ),
];
''';
