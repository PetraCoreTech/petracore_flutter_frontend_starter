import '../../../generators/project_generator.dart';

String screenFrameTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'base_scaffold.dart';

/// Screen frame component with layout management for ${config.projectName}
class ScreenFrame extends StatelessWidget {
  /// Constructor
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

  /// Factory constructor for fixed layout
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
    AlignmentDirectional persistentFooterAlignment = AlignmentDirectional.center,
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
      children: children,
      bottomSheet: bottomSheet,
    );
  }

  /// Factory constructor for unbounded layout
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
    AlignmentDirectional persistentFooterAlignment = AlignmentDirectional.center,
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
    return BaseScaffold(
      brightness: Theme.of(context).brightness,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
    return BaseScaffold(
      brightness: Theme.of(context).brightness,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar,
      body: SingleChildScrollView(
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: 16) +
                EdgeInsets.only(bottom: bottomPadding ?? 16),
        child: SizedBox(
          height: switch (orientation) {
            Orientation.portrait => frameSize ?? _frameSize(context, framePadding ?? 32),
            Orientation.landscape => null,
          },
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
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

  double _frameSize(BuildContext context, double padding) {
    final size = MediaQuery.of(context).size.height - 
                  MediaQuery.of(context).viewInsets.vertical - 
                  padding;
    return size;
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
    return BaseScaffold(
      key: scaffoldKey,
      brightness: Theme.of(context).brightness,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar,
      body: useSlivers
          ? CustomScrollView(slivers: children!)
          : SingleChildScrollView(
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 16) +
                      EdgeInsets.only(bottom: bottomPadding ?? 16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
                  mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
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
''';
