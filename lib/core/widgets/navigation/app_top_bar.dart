import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../buttons/icon_circle_button.dart';
import 'pro_pill.dart';

/// Top application bar implementing the primary navigation row from the Home mockup.
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({
    super.key,
    this.title = 'Doc Scanner',
    this.onMenuTap,
    this.onProTap,
    this.onSearchTap,
    this.onMoreTap,
    this.onAvatarTap,
    this.showProPill = true,
    this.showAvatar = true,
    this.avatarUrl,
  });

  final String title;
  final VoidCallback? onMenuTap;
  final VoidCallback? onProTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onMoreTap;
  final VoidCallback? onAvatarTap;
  final bool showProPill;
  final bool showAvatar;
  final String? avatarUrl;

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardTheme.color,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          child: Row(
            children: <Widget>[
              if (onMenuTap != null)
                IconCircleButton(
                  icon: const Icon(Symbols.menu_rounded),
                  onPressed: onMenuTap,
                  tooltip: 'Menu',
                )
              else
                const SizedBox(width: AppSpacing.sm),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.headlineMd.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (showProPill) ...<Widget>[
                ProPill(onTap: onProTap),
                const SizedBox(width: AppSpacing.xs),
              ],
              if (onSearchTap != null)
                IconCircleButton(
                  icon: const Icon(Symbols.search_rounded),
                  onPressed: onSearchTap,
                  tooltip: 'Search',
                ),
              if (onMoreTap != null)
                IconCircleButton(
                  icon: const Icon(Symbols.more_vert_rounded),
                  onPressed: onMoreTap,
                  tooltip: 'More options',
                ),
              if (showAvatar) ...<Widget>[
                const SizedBox(width: AppSpacing.xs),
                GestureDetector(
                  onTap: onAvatarTap,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: avatarUrl != null
                        ? Image.network(
                            avatarUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Symbols.person_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          )
                        : const Icon(
                            Symbols.person_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

