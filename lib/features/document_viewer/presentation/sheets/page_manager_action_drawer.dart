import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../app/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../domain/saved_document.dart';
import 'document_details_sheet.dart';

/// Modal action drawer for Multi-Page Manager matching Frame 2.
class PageManagerActionDrawer extends StatelessWidget {
  const PageManagerActionDrawer({
    super.key,
    required this.document,
    required this.onRenameTap,
    required this.onFavoriteToggle,
    required this.onDeleteDoc,
  });

  final SavedDocument document;
  final VoidCallback onRenameTap;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onDeleteDoc;

  static Future<void> show(
    BuildContext context, {
    required SavedDocument document,
    required VoidCallback onRenameTap,
    required VoidCallback onFavoriteToggle,
    required VoidCallback onDeleteDoc,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext ctx) => PageManagerActionDrawer(
        document: document,
        onRenameTap: onRenameTap,
        onFavoriteToggle: onFavoriteToggle,
        onDeleteDoc: onDeleteDoc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.88,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Handle
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 8),
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.hairline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryTint,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Symbols.description_rounded,
                      color: AppColors.primary,
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        document.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${document.pageCount} Pages • ${document.sizeMb.toStringAsFixed(1)} MB • PDF Ready',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Symbols.edit_rounded, color: AppColors.primary),
                  onPressed: onRenameTap,
                  tooltip: 'Quick Rename',
                ),
              ],
            ),
          ),

          const Divider(color: AppColors.hairline, height: 1),

          // Scrollable content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Document Actions Header
                  const Text(
                    'DOCUMENT ACTIONS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMuted,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 3x2 Action Matrix
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.0,
                    children: <Widget>[
                      _ActionTile(
                        icon: Symbols.picture_as_pdf_rounded,
                        label: 'PDF / JPG',
                        iconColor: AppColors.primary,
                        iconBg: AppColors.primaryTint,
                        onTap: () {
                          Navigator.of(context).pop();
                          showAppSnackbar(context: context, message: 'PDF format active');
                        },
                      ),
                      _ActionTile(
                        icon: Symbols.share_rounded,
                        label: 'Share',
                        onTap: () {
                          Navigator.of(context).pop();
                          showAppSnackbar(context: context, message: 'Preparing share...');
                        },
                      ),
                      _ActionTile(
                        icon: Symbols.mail_rounded,
                        label: 'To Email',
                        onTap: () {
                          Navigator.of(context).pop();
                          showAppSnackbar(context: context, message: 'Attached to new email draft');
                        },
                      ),
                      _ActionTile(
                        icon: Symbols.compress_rounded,
                        label: 'Compress',
                        onTap: () {
                          Navigator.of(context).pop();
                          showAppSnackbar(context: context, message: 'Compressed by 35%');
                        },
                      ),
                      _ActionTile(
                        icon: Symbols.download_rounded,
                        label: 'Save Gallery',
                        onTap: () {
                          Navigator.of(context).pop();
                          showAppSnackbar(context: context, message: 'Saved pages to photo gallery');
                        },
                      ),
                      _ActionTile(
                        icon: Symbols.delete_rounded,
                        label: 'Delete',
                        iconColor: AppColors.destructive,
                        iconBg: AppColors.destructiveTint,
                        textColor: AppColors.destructive,
                        onTap: () {
                          Navigator.of(context).pop();
                          onDeleteDoc();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // File Management Header
                  const Text(
                    'FILE MANAGEMENT',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMuted,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),

                  _DrawerListTile(
                    icon: Symbols.drive_file_move_rounded,
                    label: 'Move to Folder',
                    onTap: () {
                      Navigator.of(context).pop();
                      showAppSnackbar(context: context, message: 'Moved to Folder: Scans');
                    },
                  ),
                  _DrawerListTile(
                    icon: Symbols.content_copy_rounded,
                    label: 'Make a Copy',
                    onTap: () {
                      Navigator.of(context).pop();
                      showAppSnackbar(context: context, message: 'Created duplicate copy');
                    },
                  ),
                  _DrawerListTile(
                    icon: Symbols.dashboard_rounded,
                    label: 'MultiSide Doc / Collage',
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.goldTint,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'PRO',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: AppColors.gold,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      showAppSnackbar(context: context, message: 'Collage tool available with Pro');
                    },
                  ),
                  _DrawerListTile(
                    icon: document.isFavorite
                        ? Symbols.star_rounded
                        : Symbols.star_outline_rounded,
                    iconColor: document.isFavorite ? AppColors.gold : null,
                    label: 'Mark as Favorite',
                    trailing: Icon(
                      document.isFavorite
                          ? Symbols.check_box_rounded
                          : Symbols.check_box_outline_blank_rounded,
                      size: 20,
                      color: document.isFavorite ? AppColors.primary : AppColors.textMuted,
                    ),
                    onTap: onFavoriteToggle,
                  ),
                  _DrawerListTile(
                    icon: Symbols.text_fields_rounded,
                    iconColor: AppColors.primary,
                    label: 'OCR Extract All Text',
                    onTap: () {
                      Navigator.of(context).pop();
                      context.push(AppRoutes.ocrResult);
                    },
                  ),
                  _DrawerListTile(
                    icon: Symbols.info_rounded,
                    label: 'Storage & Resolution Details',
                    trailing: const Text(
                      '300 DPI',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext ctx) =>
                            DocumentDetailsSheet(document: document),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Safe Footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.canvas,
              border: Border(top: BorderSide(color: AppColors.hairline)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Storage Location: Device Internal / Scans',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: AppColors.hairline),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.iconBg,
    this.textColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? iconBg;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.canvas,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconBg ?? Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 20,
                    color: iconColor ?? AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: textColor ?? AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerListTile extends StatelessWidget {
  const _DrawerListTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: 20,
              color: iconColor ?? AppColors.textPrimary,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            if (trailing != null)
              trailing!
            else
              const Icon(
                Symbols.chevron_right_rounded,
                size: 18,
                color: AppColors.textMuted,
              ),
          ],
        ),
      ),
    );
  }
}

