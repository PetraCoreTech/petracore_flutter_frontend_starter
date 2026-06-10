import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String appBarrelTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/shared/presentation/controllers/bloc_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final themes = AppUiKit.themes;
        ScreenUtil.init(context, designSize: AppConstants.designSize);
        return MultiBlocProvider(
          providers: blocProviders,
          child: MaterialApp.router(
            title: AppConstants.appName,
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            theme: themes.lightTheme,
            darkTheme: themes.darkTheme,
            themeMode: themes.themeMode,
          ),
        );
      },
    );
  }
}
''';
