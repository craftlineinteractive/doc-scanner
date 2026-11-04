import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../constants/app_strings.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';

/// Clean empty state placeholder built from vector symbols, heading, body, and action hint rows.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    required this.description,
    this.primaryIcon = Symbols.document_scanner_rounded,
    this.hintRows = const <String>[
      AppStrings.hintCamera,
      AppStrings.hintPlus,
    ],
    this.action,
  });

  final String title;
  final String description;
  final IconData primaryIcon;
  final List<String> hintRows;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Multi-layered illustration circle
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: docColors.primaryTint,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                primaryIcon,
                color: AppColors.primary,
                size: 44,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              title,
              style: AppTypography.headlineMd.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              description,
              style: AppTypography.bodyMd.copyWith(
                color: AppColors.textMuted,
              ),
              textAlign: TextAlign.center,
            ),
            if (hintRows.isNotEmpty) ...<Widget>[
              const SizedBox(height: AppSpacing.xl),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: AppRadii.roundedCard,
                  border: Border.all(color: docColors.hairline),
                ),
                child: Column(
                  children: hintRows.map((String hint) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(
                            Symbols.check_circle_rounded,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            hint,
                            style: AppTypography.bodySm.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
            if (action != null) ...<Widget>[
              const SizedBox(height: AppSpacing.xl),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

