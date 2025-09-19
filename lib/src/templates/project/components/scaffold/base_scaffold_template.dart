String baseScaffoldTemplate() => '''
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    required this.brightness,
    required this.backgroundColor,
    required this.body,
    required this.persistentFooterAlignment,
    super.key,
    this.systemNavigationBarColor,
    this.appBar,
    this.extendBody,
    this.extendBodyBehindAppBar,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.persistentFooterButtons,
  });

  final Brightness brightness;
  final Color backgroundColor;
  final Color? systemNavigationBarColor;
  final PreferredSizeWidget? appBar;
  final bool? extendBody;
  final bool? extendBodyBehindAppBar;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget body;
  final Widget? drawer;
  final Widget? endDrawer;
  final AlignmentDirectional persistentFooterAlignment;
  final List<Widget>? persistentFooterButtons;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: brightness,
        statusBarIconBrightness: brightness,
        systemNavigationBarColor: systemNavigationBarColor ?? backgroundColor,
        statusBarColor: Colors.transparent,
      ),
      child: DividerTheme(
        data: const DividerThemeData(color: Colors.transparent),
        child: Scaffold(
          appBar: appBar,
          extendBody: extendBody ?? false,
          extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
          backgroundColor: backgroundColor,
          drawer: drawer,
          endDrawer: endDrawer,
          body: SafeArea(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowIndicator();
                return true;
              },
              child: body,
            ),
          ),
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          bottomNavigationBar: bottomNavigationBar,
          bottomSheet: bottomSheet,
          persistentFooterAlignment: persistentFooterAlignment,
          persistentFooterButtons: persistentFooterButtons,
        ),
      ),
    );
  }
}
''';
