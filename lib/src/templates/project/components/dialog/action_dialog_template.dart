import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String actionDialogTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/core/core.dart';

class ActionDialog extends StatelessWidget {
  const ActionDialog({
    super.key,
    this.width,
    this.title,
    this.subtitle,
    this.titleAlt,
    this.subtitleAlt,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.primaryButton,
    this.secondaryButton,
    this.primaryButtonAction,
    this.secondaryButtonAction,
    this.primaryTextStyle,
    this.secondaryTextStyle,
  });
  final double? width;
  final String? title;
  final String? subtitle;
  final Widget? titleAlt;
  final Widget? subtitleAlt;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final Widget? primaryButton;
  final Widget? secondaryButton;
  final TextStyle? primaryTextStyle;
  final TextStyle? secondaryTextStyle;
  final VoidCallback? primaryButtonAction;
  final VoidCallback? secondaryButtonAction;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final paragraph2 = \$token.textStyle.paragraph2.resolve(context);
    final paragraph3 = \$token.textStyle.paragraph4.resolve(context);
    return SizedBox(
      width: width ?? size.width,
      child: SeparatedColumn(
        mainAxisSize: MainAxisSize.min,
        separatorBuilder: () => const Gap(11),
        padding: const EdgeInsets.symmetric(horizontal: 24) +
            const EdgeInsets.only(top: 24, bottom: 12),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (titleAlt != null)
            titleAlt!
          else if (title != null)
            Text(
              title!,
              style: paragraph2.copyWith(
                color: colors.onSurface.resolve(context),
                fontWeight: FontWeight.w700,
              ),
            ),
          if (subtitleAlt != null)
            subtitleAlt!
          else if (subtitle != null)
            Text(
              subtitle!,
              style: paragraph2.copyWith(
                color: colors.onSurface.resolve(context),
                fontWeight: FontWeight.w500,
              ),
            ),
          const DividerV1(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (secondaryButton != null)
                secondaryButton!
              else ...[
                AppTextButton(
                  text: secondaryButtonText ?? ContentStrings.cancel,
                  height: 40,
                  padding: EdgeInsets.zero,
                  textStyle: secondaryTextStyle ??
                      paragraph3.copyWith(
                        color: colors.onSurface.resolve(context),
                        fontWeight: FontWeight.w700,
                      ),
                  onTap: secondaryButtonAction,
                ),
                const Gap(15),
              ],
              if (primaryButton != null)
                primaryButton!
              else
                AppTextButton(
                  text: primaryButtonText ?? ContentStrings.confirm,
                  height: 40,
                  padding: EdgeInsets.zero,
                  textStyle: primaryTextStyle ??
                      paragraph3.copyWith(
                        color: colors.onSurface.resolve(context),
                        fontWeight: FontWeight.w700,
                      ),
                  onTap: primaryButtonAction,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
''';
