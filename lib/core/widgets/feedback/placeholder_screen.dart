import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';

/// Reusable placeholder screen displayed for routes pending implementation.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final bool canPop = context.canPop();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: canPop
            ? IconButton(
                icon: const Icon(Symbols.arrow_back_rounded),
                onPressed: () => context.pop(),
              )
            : null,
      ),
      body: Center(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Container(
            padding: AppSpacing.cardPaddingLg,
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: AppRadii.roundedCard,
              border: Border.all(
                color: context.docColors.hairline,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: context.docColors.primaryTint,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Symbols.construction_rounded,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  title,
                  style: AppTypography.headlineSm.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  subtitle ?? 'UI layout implementation in progress',
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.textMuted,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (canPop) ...<Widget>[
                  const SizedBox(height: AppSpacing.lg),
                  OutlinedButton.icon(
                    onPressed: () => context.pop(),
                    icon: const Icon(Symbols.arrow_back_rounded, size: 18),
                    label: const Text('Go Back'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

