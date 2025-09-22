String authControllerIndexTemplate() => '''
export 'auth_bloc_provider.dart';
export 'blocs/auth_bloc/auth_bloc.dart';
export 'cubits/auth_history_cubit/auth_history_cubit.dart';
export 'cubits/email_cubit/email_cubit.dart';
export 'cubits/user_cubit/user_cubit.dart';
''';
