import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/cards/document_grid_card.dart';
import '../../core/widgets/cards/document_list_card.dart';
import '../../core/widgets/cards/folder_tile.dart';
import '../../core/widgets/cards/info_banner.dart';
import '../../core/widgets/cards/option_card.dart';
import '../../core/widgets/cards/page_thumbnail_card.dart';
import '../../core/widgets/cards/plan_card.dart';
import '../../core/widgets/chips/count_badge.dart';
import '../../core/widgets/chips/days_left_chip.dart';
import '../../core/widgets/chips/filter_preset_thumb.dart';
import '../../core/widgets/chips/status_chip.dart';
import '../../core/widgets/mock/mock_document_page.dart';
import '../../core/widgets/navigation/pro_pill.dart';

/// Section showcasing all cards, chips, badges, and document preview tiles.
class ComponentsCardsSection extends StatefulWidget {
  const ComponentsCardsSection({super.key});

  @override
  State<ComponentsCardsSection> createState() =>
      _ComponentsCardsSectionState();
}

class _ComponentsCardsSectionState extends State<ComponentsCardsSection> {
  String _selectedFilter = 'Vivid Light';
  String _selectedPlan = 'Yearly';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Chips & Badges', style: AppTypography.headlineSm),
        const SizedBox(height: AppSpacing.md),
        const Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            ProPill(),
            StatusChip(label: 'Synced', variant: StatusChipVariant.success),
            StatusChip(label: '100% On-Device', variant: StatusChipVariant.primary),
            StatusChip(label: 'Expiring', variant: StatusChipVariant.warning),
            CountBadge(count: 7),
            DaysLeftChip(daysRemaining: 18),
            DaysLeftChip(daysRemaining: 2),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Filter Preset Thumbnails', style: AppTypography.labelMd),
        const SizedBox(height: AppSpacing.sm),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <String>['Original', 'Auto Enhance', 'Vivid Light', 'Grayscale', 'B&W']
                .map((name) => Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.md),
                      child: FilterPresetThumb(
                        name: name,
                        isSelected: _selectedFilter == name,
                        onTap: () => setState(() => _selectedFilter = name),
                      ),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Info Banner & Option Cards', style: AppTypography.labelMd),
        const SizedBox(height: AppSpacing.sm),
        const InfoBanner(
          title: AppStrings.edgeOcrActive,
          subtitle: AppStrings.edgeOcrSubtitle,
          icon: Icon(Symbols.auto_read_play_rounded),
          trailingChip: StatusChip(label: AppStrings.onDeviceBadge),
        ),
        const SizedBox(height: AppSpacing.sm),
        OptionCard(
          title: 'From Gallery',
          subtitle: 'Import existing pictures or documents',
          tag: 'Fast',
          icon: const Icon(Symbols.photo_library_rounded),
          onTap: () {},
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Folder & Document Tiles', style: AppTypography.labelMd),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: <Widget>[
            Expanded(
              child: FolderTile(
                title: 'Client Files',
                itemCountText: '4 items · 12 Oct',
                icon: const Icon(Symbols.folder_rounded),
                accentColor: AppColors.categoryIndigo,
                pastelBackgroundColor: AppColors.categoryIndigoTint,
                onTap: () {},
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: FolderTile(
                title: 'Property Docs',
                itemCountText: '8 items · 04 Oct',
                icon: const Icon(Symbols.folder_special_rounded),
                accentColor: AppColors.categoryOrange,
                pastelBackgroundColor: AppColors.categoryOrangeTint,
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        DocumentListCard(
          title: 'Quarterly_Tax_Invoice_2026.pdf',
          dateText: 'Yesterday, 3:45 PM',
          pageCount: 3,
          isFavorite: true,
          isSynced: true,
          onTap: () {},
          onMoreTap: () {},
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 180,
          child: Row(
            children: <Widget>[
              Expanded(
                child: DocumentGridCard(
                  title: 'Medical_Insurance_Card',
                  dateText: '28 Sep',
                  pageCount: 2,
                  variant: MockDocumentVariant.idCard,
                  onTap: () {},
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: PageThumbnailCard(
                  pageNumber: 1,
                  filterLabel: 'Vivid Light',
                  variant: MockDocumentVariant.contract,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Premium Subscription Plan Card', style: AppTypography.labelMd),
        const SizedBox(height: AppSpacing.sm),
        PlanCard(
          title: 'Yearly Plan',
          priceText: '\$29.99 / yr',
          secondaryPriceText: 'Just \$2.50 per month',
          badgeText: 'BEST VALUE - SAVE 60%',
          isSelected: _selectedPlan == 'Yearly',
          onTap: () => setState(() => _selectedPlan = 'Yearly'),
        ),
      ],
    );
  }
}

