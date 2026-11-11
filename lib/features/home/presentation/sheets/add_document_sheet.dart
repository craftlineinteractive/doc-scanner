import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/doc_colors.dart';
import '../../../../core/widgets/buttons/text_action_button.dart';
import '../../../../core/widgets/cards/option_card.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../../../core/widgets/sheets/app_bottom_sheet.dart';

/// Bottom modal sheet providing ingestion actions (Gallery, PDF as Image, Files).
class AddDocumentSheet extends StatelessWidget {
  const AddDocumentSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (_) => const AddDocumentSheet(),
    );
  }

  void _onOptionTap(BuildContext context, String optionName) {
    Navigator.of(context).pop();
    showAppSnackbar(context: context, message: '$optionName is coming later');
  }

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;

    return AppBottomSheet(
      title: 'Add Document',
      subtitle: 'Choose how you\'d like to add documents to Doc Scanner',
      onClose: () => Navigator.of(context).pop(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Option 1: Gallery
          OptionCard(
            title: 'From Gallery',
            subtitle: 'Import photos and existing images from device storage',
            tag: 'Fast',
            tagColor: docColors.success,
            icon: const Icon(Symbols.photo_library_rounded),
            iconColor: AppColors.primary,
            iconBackgroundColor: docColors.primaryTint,
            onTap: () => _onOptionTap(context, 'From Gallery'),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Option 2: PDF as Image
          OptionCard(
            title: 'PDF as Image',
            subtitle:
                'Convert & extract pages from existing PDF files as photos',
            icon: const Icon(Symbols.filter_frames_rounded),
            iconColor: docColors.categoryOrange,
            iconBackgroundColor: docColors.categoryOrangeTint,
            onTap: () => _onOptionTap(context, 'PDF as Image'),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Option 3: Import Documents
          OptionCard(
            title: 'Import Documents',
            subtitle: 'Browse files, cloud storage, Google Drive, or Word docs',
            tag: 'PDF, Word',
            tagColor: docColors.categoryOrange,
            icon: const Icon(Symbols.cloud_upload_rounded),
            iconColor: docColors.success,
            iconBackgroundColor: docColors.successTint,
            onTap: () => _onOptionTap(context, 'Import Documents'),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Footer note and cancel button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Symbols.auto_awesome_rounded,
                      color: AppColors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        'AI auto-cropping active for all imports',
                        style: AppTypography.bodySm.copyWith(
                          color: AppColors.textMuted,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              TextActionButton(
                label: AppStrings.cancel,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
