import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String scaffoldV1Template(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';

class ScaffoldV1 extends StatelessWidget {
  const ScaffoldV1({
    required this.body,
    super.key,
    this.systemNavigationBarColor,
    this.appBar,
    this.logo,
    this.extendBody,
    this.isLoading,
    this.indicator,
    this.extendBodyBehindAppBar,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backgroundColor,
    this.drawer,
    this.endDrawer,
    this.brightness,
    this.persistentFooterAlignment = AlignmentDirectional.center,
    this.persistentFooterButtons,
  });

  final Color? systemNavigationBarColor;
  final Color? backgroundColor;
  final String? logo;
  final PreferredSizeWidget? appBar;
  final bool? extendBody;
  final bool? isLoading;
  final bool? extendBodyBehindAppBar;
  final Widget? bottomNavigationBar;
  final Widget? indicator;
  final Widget? floatingActionButton;
  final Widget? bottomSheet;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget body;
  final Brightness? brightness;
  final Widget? drawer;
  final Widget? endDrawer;
  final AlignmentDirectional persistentFooterAlignment;
  final List<Widget>? persistentFooterButtons;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayV1(
      isLoading: isLoading ?? false,
      child: BaseScaffold(
        appBar: appBar,
        brightness: Brightness.dark,
        backgroundColor: \$token.color.surface.resolve(context),
        body: body,
        drawer: drawer,
        endDrawer: endDrawer,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        extendBody: extendBody,
        bottomSheet: bottomSheet,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        systemNavigationBarColor: systemNavigationBarColor,
        bottomNavigationBar: bottomNavigationBar,
        persistentFooterAlignment: persistentFooterAlignment,
        persistentFooterButtons: persistentFooterButtons,
      ),
    );
  }
}
''';
