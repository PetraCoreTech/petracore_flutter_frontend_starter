import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialAppViewTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/app/app.dart';
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/shared/presentation/controllers/bloc_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ScreenUtil.init(context, designSize: AppConstants.designSize);
        return MultiBlocProvider(
          providers: blocProviders,
          child: MaterialApp.router(
            title: AppConstants.appName,
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
          ),
        );
      },
    );
  }
}
''';
