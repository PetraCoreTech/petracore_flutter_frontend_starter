import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String sliverHelperTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/core/components/app_bar/persistent_header_v1.dart';

class SliverHelper {
  SliverHelper(this.context);
  final BuildContext context;

  static Widget buildSliverFillRemaining({
    bool hasScrollBody = false,
    Widget? child,
  }) {
    return SliverFillRemaining(
      hasScrollBody: hasScrollBody,
      child: child,
    );
  }

  static Widget buildScrollable(Widget child) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(right: 16),
      child: child,
    );
  }

  static Widget buildCustomScrollWidget({required Widget child}) {
    return CustomScrollView(
      slivers: [SliverFillRemaining(hasScrollBody: false, child: child)],
    );
  }

  static Widget buildSliverSeparatedList({
    required int itemCount,
    required Widget? Function(BuildContext, int) itemBuilder,
    required Widget? Function(BuildContext, int) separatorBuilder,
    EdgeInsets? padding,
  }) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: padding ?? EdgeInsets.zero,
          sliver: SliverList.separated(
            separatorBuilder: separatorBuilder,
            itemBuilder: itemBuilder,
            itemCount: itemCount,
          ),
        ),
      ],
    );
  }

  Widget buildPageBreadCrumb({required String text, bool pinned = true}) {
    final label4 = \$token.textStyle.label4.resolve(context);
    const height = 32.0;
    return SliverPersistentHeader(
      pinned: pinned,
      delegate: PersistentHeaderV1(
        toolbarHeight: height,
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(color: colors.hover.resolve(context)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: label4.copyWith(
                  color: colors.onSurfaceLight.resolve(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
''';
