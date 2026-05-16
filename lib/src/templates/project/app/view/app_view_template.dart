import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String appViewTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/shared/presentation/controllers/bloc_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ScreenUtil.init(context, designSize: AppConstants.designSize);
        return MixTheme(
          data: lightTheme,
          child: MultiBlocProvider(
            providers: blocProviders,
            child: MaterialApp.router(
              title: AppConstants.appName,
              routerConfig: router,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: true,
                fontFamily: AppConstants.fontFamily,
                colorScheme: ColorScheme.fromSeed(seedColor: colors.primary.resolve(context)),
              ),
            ),
          ),
        );
      },
    );
  }
}
''';
