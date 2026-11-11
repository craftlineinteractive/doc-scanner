import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';

/// Card container grouping related settings tiles under a styled uppercase section header.
class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
    this.titleColor,
  });

  final String title;
  final List<Widget> children;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;
    final Color headerColor = titleColor ?? AppColors.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.sm,
          ),
          child: Text(
            title.toUpperCase(),
            style: AppTypography.labelSm.copyWith(
              color: headerColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenMargin,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: AppRadii.roundedCard,
            border: Border.all(color: docColors.hairline),
          ),
          clipBehavior: Clip.antiAlias,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: children.length,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(color: docColors.hairline, height: 1),
            itemBuilder: (BuildContext context, int index) => children[index],
          ),
        ),
      ],
    );
  }
}
