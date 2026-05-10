import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialScreenFrameTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';

class ScreenFrame extends StatelessWidget {
  const ScreenFrame({
    super.key,
    this.children,
    this.padding,
    this.formKey,
    this.appBar,
    this.body,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.bottomPadding,
    this.isLoading,
    this.persistentFooterAlignment = AlignmentDirectional.center,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomSheet,
  });

  factory ScreenFrame.fixed({
    required List<Widget> children,
    PreferredSizeWidget? appBar,
    EdgeInsets? padding,
    double? frameSize,
    double? bottomPadding,
    double? framePadding,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisAlignment? mainAxisAlignment,
    GlobalKey<FormState>? formKey,
    bool? isLoading,
    AlignmentDirectional persistentFooterAlignment =
        AlignmentDirectional.center,
    List<Widget>? persistentFooterButtons,
    Widget? drawer,
    Widget? endDrawer,
    Widget? bottomSheet,
  }) {
    return _FixedScreenFrame(
      appBar: appBar,
      padding: padding,
      frameSize: frameSize,
      framePadding: framePadding,
      bottomPadding: bottomPadding,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      formKey: formKey,
      isLoading: isLoading,
      persistentFooterAlignment: persistentFooterAlignment,
      persistentFooterButtons: persistentFooterButtons,
      drawer: drawer,
      endDrawer: endDrawer,
      bottomSheet: bottomSheet,
      children: children,
    );
  }

  factory ScreenFrame.unbounded({
    required List<Widget> children,
    PreferredSizeWidget? appBar,
    EdgeInsets? padding,
    double? bottomPadding,
    Key? key,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisAlignment? mainAxisAlignment,
    GlobalKey<FormState>? formKey,
    bool? isLoading,
    AlignmentDirectional persistentFooterAlignment =
        AlignmentDirectional.center,
    List<Widget>? persistentFooterButtons,
    bool useSlivers = false,
    Widget? drawer,
    Widget? endDrawer,
    Widget? floatingActionButton,
    Widget? bottomSheet,
    FloatingActionButtonLocation? floatingActionButtonLocation,
  }) {
    return _UnboundedScreenFrame(
      scaffoldKey: key,
      appBar: appBar,
      useSlivers: useSlivers,
      padding: padding,
      bottomPadding: bottomPadding,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      formKey: formKey,
      isLoading: isLoading,
      persistentFooterAlignment: persistentFooterAlignment,
      persistentFooterButtons: persistentFooterButtons,
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomSheet: bottomSheet,
      children: children,
    );
  }

  final bool? isLoading;
  final double? bottomPadding;
  final Widget? body;
  final EdgeInsets? padding;
  final GlobalKey<FormState>? formKey;
  final List<Widget>? children;
  final PreferredSizeWidget? appBar;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final AlignmentDirectional persistentFooterAlignment;
  final List<Widget>? persistentFooterButtons;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? floatingActionButton;
  final Widget? bottomSheet;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    return ScaffoldV1(
      isLoading: isLoading,
      appBar: appBar,
      body: body ?? const Placeholder(),
      persistentFooterAlignment: persistentFooterAlignment,
      persistentFooterButtons: persistentFooterButtons,
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}

class _FixedScreenFrame extends ScreenFrame {
  const _FixedScreenFrame({
    required super.children,
    super.isLoading,
    super.bottomPadding,
    super.padding,
    super.formKey,
    super.appBar,
    super.crossAxisAlignment,
    super.mainAxisAlignment,
    super.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    super.persistentFooterButtons,
    super.drawer,
    super.endDrawer,
    super.bottomSheet,
    this.framePadding,
    this.frameSize,
  });

  final double? framePadding;
  final double? frameSize;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return ScaffoldV1(
      isLoading: isLoading,
      appBar: appBar,
      body: SingleChildScrollView(
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: 16) +
                EdgeInsets.only(bottom: bottomPadding ?? 16.h),
        child: SizedBox(
          height: switch (orientation) {
            Orientation.portrait =>
              frameSize ?? context.frameSize(padding: framePadding ?? 32),
            Orientation.landscape => null,
          },
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  crossAxisAlignment ?? CrossAxisAlignment.start,
              mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
              children: children!,
            ),
          ),
        ),
      ),
      bottomSheet: bottomSheet,
      persistentFooterAlignment: persistentFooterAlignment,
      persistentFooterButtons: persistentFooterButtons,
      drawer: drawer,
      endDrawer: endDrawer,
    );
  }
}

class _UnboundedScreenFrame extends ScreenFrame {
  const _UnboundedScreenFrame({
    required super.children,
    required this.useSlivers,
    super.isLoading,
    super.bottomPadding,
    super.padding,
    super.formKey,
    super.appBar,
    super.crossAxisAlignment,
    super.mainAxisAlignment,
    super.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    super.persistentFooterButtons,
    super.drawer,
    super.endDrawer,
    super.bottomSheet,
    super.floatingActionButton,
    super.floatingActionButtonLocation,
    this.scaffoldKey,
  });
  final Key? scaffoldKey;
  final bool useSlivers;

  @override
  Widget build(BuildContext context) {
    return ScaffoldV1(
      key: scaffoldKey,
      appBar: appBar,
      isLoading: isLoading,
      body: useSlivers
          ? CustomScrollView(slivers: children!)
          : SingleChildScrollView(
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 16) +
                      EdgeInsets.only(bottom: bottomPadding ?? 16.h),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment:
                      crossAxisAlignment ?? CrossAxisAlignment.start,
                  mainAxisAlignment:
                      mainAxisAlignment ?? MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: children!,
                ),
              ),
            ),
      bottomSheet: bottomSheet,
      persistentFooterAlignment: persistentFooterAlignment,
      persistentFooterButtons: persistentFooterButtons,
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}

extension WidgetCtxExt on BuildContext {
  double frameSize({double? padding}) {
    final context = this;
    final size =
        1.sh - MediaQuery.viewInsetsOf(context).vertical - (padding ?? 32).h;
    return size;
  }
}
''';
