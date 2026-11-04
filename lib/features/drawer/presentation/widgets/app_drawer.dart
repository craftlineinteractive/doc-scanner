import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../app/routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../../../core/widgets/navigation/drawer_header_signed_in.dart';
import '../../../../core/widgets/navigation/drawer_header_signed_out.dart';
import '../../../../core/widgets/navigation/drawer_item.dart';
import '../../../../core/widgets/navigation/expandable_section.dart';
import '../../../../core/widgets/navigation/premium_upsell_card.dart';
import '../../application/drawer_providers.dart';
import '../../domain/drawer_user.dart';

/// Application navigation drawer containing user profile, premium upsell,
/// categorized feature destinations, and app version details.
class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({
    super.key,
    this.initialGeneralExpanded = true,
    this.initialToolsExpanded = false,
    this.initialOtherExpanded = false,
    this.initialMoreExpanded = false,
  });

  final bool initialGeneralExpanded;
  final bool initialToolsExpanded;
  final bool initialOtherExpanded;
  final bool initialMoreExpanded;

  @override
  ConsumerState<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  void _onAction(String label, {VoidCallback? customAction}) {
    Navigator.of(context).pop();
    if (customAction != null) {
      customAction();
    } else {
      showAppSnackbar(context: context, message: '$label is coming later');
    }
  }

  @override
  Widget build(BuildContext context) {
    final DrawerUser? user = ref.watch(drawerUserProvider);
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double drawerWidth = math.min(screenWidth * 0.85, 320.0);

    return SizedBox(
      width: drawerWidth,
      child: Drawer(
        backgroundColor: Theme.of(context).cardTheme.color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(24)),
        ),
        child: Column(
          children: <Widget>[
            // Header (signed in or signed out)
            if (user != null)
              DrawerHeaderSignedIn(
                name: user.name,
                email: user.email,
                avatarUrl: user.avatarUrl,
                backupSize: '${user.backupSizeMb} MB',
                isSynced: user.isSynced,
              )
            else
              DrawerHeaderSignedOut(
                onSignInTap: () =>
                    ref.read(drawerUserProvider.notifier).signIn(),
              ),

            // Scrollable menu body
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                children: <Widget>[
                  // Premium Upsell Banner
                  PremiumUpsellCard(
                    onTap: () => _onAction(
                      'Upgrade to Premium',
                      customAction: () => context.push(AppRoutes.premium),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),

                  // GENERAL Section
                  ExpandableSection(
                    title: 'General',
                    initiallyExpanded: widget.initialGeneralExpanded,
                    children: <Widget>[
                      DrawerItem(
                        icon: const Icon(Symbols.favorite_rounded),
                        label: 'Favourites',
                        iconColor: const Color(0xFFF43F5E),
                        backgroundColor: const Color(0xFFFFF1F2),
                        onTap: () => _onAction('Favourites'),
                      ),
                      DrawerItem(
                        icon: const Icon(Symbols.label_rounded),
                        label: 'Manage Tags',
                        iconColor: const Color(0xFFD97706),
                        backgroundColor: const Color(0xFFFFFBEB),
                        onTap: () => _onAction('Manage Tags'),
                      ),
                      DrawerItem(
                        icon: const Icon(Symbols.delete_rounded),
                        label: AppStrings.trash,
                        iconColor: const Color(0xFF64748B),
                        backgroundColor: const Color(0xFFF1F5F9),
                        onTap: () => _onAction(
                          AppStrings.trash,
                          customAction: () => context.push(AppRoutes.trash),
                        ),
                      ),
                      DrawerItem(
                        icon: const Icon(Symbols.settings_rounded),
                        label: AppStrings.settings,
                        iconColor: AppColors.primary,
                        backgroundColor: const Color(0xFFEEF0FF),
                        onTap: () => _onAction(
                          AppStrings.settings,
                          customAction: () => context.push(AppRoutes.settings),
                        ),
                      ),
                    ],
                  ),
                  _buildDivider(),

                  // TOOLS Section
                  ExpandableSection(
                    title: 'Tools',
                    initiallyExpanded: widget.initialToolsExpanded,
                    children: <Widget>[
                      DrawerItem(
                        icon: const Icon(Symbols.picture_as_pdf_rounded),
                        label: 'PDF Tools',
                        iconColor: const Color(0xFFE5484D),
                        backgroundColor: const Color(0xFFFFECEB),
                        onTap: () => _onAction('PDF Tools'),
                      ),
                      DrawerItem(
                        icon: const Icon(Symbols.edit_document_rounded),
                        label: 'Edit / Create PDF',
                        iconColor: const Color(0xFF7C3AED),
                        backgroundColor: const Color(0xFFF5F3FF),
                        onTap: () => _onAction('Edit / Create PDF'),
                      ),
                      DrawerItem(
                        icon: const Icon(Symbols.draw_rounded),
                        label: 'Signature',
                        iconColor: const Color(0xFF059669),
                        backgroundColor: const Color(0xFFECFDF5),
                        onTap: () => _onAction('Signature'),
                      ),
                      DrawerItem(
                        icon: const Icon(Symbols.qr_code_scanner_rounded),
                        label: 'QR Scanner',
                        iconColor: const Color(0xFF2563EB),
                        backgroundColor: const Color(0xFFEFF6FF),
                        onTap: () => _onAction('QR Scanner'),
                      ),
                      DrawerItem(
                        icon: const Icon(Symbols.qr_code_2_rounded),
                        label: 'QR Generator',
                        iconColor: const Color(0xFF0891B2),
                        backgroundColor: const Color(0xFFECFEFF),
                        onTap: () => _onAction('QR Generator'),
                      ),
                    ],
                  ),
                  _buildDivider(),

                  // OTHER Section
                  ExpandableSection(
                    title: 'Other',
                    initiallyExpanded: widget.initialOtherExpanded,
                    children: <Widget>[
                      DrawerItem(
                        icon: const Icon(Symbols.help_rounded),
                        label: 'Help & FAQ',
                        iconColor: const Color(0xFFD97706),
                        backgroundColor: const Color(0xFFFFFBEB),
                        onTap: () => _onAction('Help & FAQ'),
                      ),
                      DrawerItem(
                        icon: const Icon(Symbols.mail_rounded),
                        label: 'Contact Us',
                        iconColor: AppColors.primary,
                        backgroundColor: const Color(0xFFEEF0FF),
                        onTap: () => _onAction('Contact Us'),
                      ),
                    ],
                  ),
                  _buildDivider(),

                  // About Us Single Row
                  DrawerItem(
                    icon: const Icon(Symbols.info_rounded),
                    label: 'About Us',
                    iconColor: const Color(0xFF2563EB),
                    backgroundColor: const Color(0xFFEFF6FF),
                    onTap: () => _onAction('About Us'),
                  ),
                  _buildDivider(),

                  // MORE Section
                  ExpandableSection(
                    title: 'More',
                    initiallyExpanded: widget.initialMoreExpanded,
                    children: <Widget>[
                      DrawerItem(
                        icon: const Icon(Symbols.star_rounded),
                        label: 'Rate Us',
                        iconColor: const Color(0xFFF5B301),
                        backgroundColor: const Color(0xFFFFF6DD),
                        onTap: () => _onAction('Rate Us'),
                      ),
                      DrawerItem(
                        icon: const Icon(Symbols.share_rounded),
                        label: 'Share App',
                        iconColor: const Color(0xFF059669),
                        backgroundColor: const Color(0xFFECFDF5),
                        onTap: () => _onAction('Share App'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Footer note
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                border: const Border(
                  top: BorderSide(color: AppColors.hairline, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Doc Scanner v2.4.1',
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.textMuted,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    'Build 2026.09',
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.textMuted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      child: Divider(color: AppColors.hairline, height: 1),
    );
  }
}
