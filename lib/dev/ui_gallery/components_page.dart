import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/doc_colors.dart';
import '../../core/widgets/inputs/segmented_pill.dart';
import '../../core/widgets/navigation/app_top_bar.dart';
import '../../core/widgets/navigation/drawer_header_signed_in.dart';
import '../../core/widgets/navigation/drawer_header_signed_out.dart';
import '../../core/widgets/navigation/drawer_item.dart';
import '../../core/widgets/navigation/expandable_section.dart';
import '../../core/widgets/navigation/premium_upsell_card.dart';
import 'components_buttons_section.dart';
import 'components_camera_section.dart';
import 'components_cards_section.dart';
import 'components_inputs_section.dart';

/// Interactive UI Kit gallery page demonstrating all shared widgets with live theme switching.
class ComponentsPage extends StatefulWidget {
  const ComponentsPage({super.key});

  @override
  State<ComponentsPage> createState() => _ComponentsPageState();
}

class _ComponentsPageState extends State<ComponentsPage> {
  String _activeTheme = 'Light';

  ThemeData get _selectedThemeData {
    switch (_activeTheme) {
      case 'Dark':
        return AppTheme.dark;
      case 'Camera':
        return AppTheme.camera;
      default:
        return AppTheme.light;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _selectedThemeData,
      child: Builder(
        builder: (BuildContext themedContext) {
          final DocColors docColors = themedContext.docColors;

          return Scaffold(
            backgroundColor: Theme.of(themedContext).scaffoldBackgroundColor,
            appBar: AppBar(
              title: const Text('UI Components Kit'),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.md),
                  child: Center(
                    child: SegmentedPill<String>(
                      items: const <String>['Light', 'Dark', 'Camera'],
                      selectedItem: _activeTheme,
                      onSelected: (val) => setState(() => _activeTheme = val),
                    ),
                  ),
                ),
              ],
            ),
            body: ListView(
              padding: AppSpacing.screenListPadding,
              children: <Widget>[
                // Navigation previews
                Text('Navigation Primitives', style: AppTypography.headlineSm),
                const SizedBox(height: AppSpacing.sm),
                const AppTopBar(),
                const SizedBox(height: AppSpacing.md),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(themedContext).cardTheme.color,
                    borderRadius: AppRadii.roundedCard,
                    border: Border.all(color: docColors.hairline),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: <Widget>[
                      const DrawerHeaderSignedIn(
                        name: 'Prince Patel',
                        email: 'patelprince2598@gmail.com',
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      const PremiumUpsellCard(),
                      ExpandableSection(
                        title: 'General',
                        children: <Widget>[
                          DrawerItem(
                            icon: const Icon(Symbols.star_rounded),
                            label: 'Favourites',
                            onTap: () {},
                          ),
                          DrawerItem(
                            icon: const Icon(Symbols.delete_rounded),
                            label: 'Trash',
                            onTap: () {},
                          ),
                        ],
                      ),
                      const Divider(height: 1),
                      const DrawerHeaderSignedOut(),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                const ComponentsButtonsSection(),
                const SizedBox(height: AppSpacing.xl),
                const ComponentsInputsSection(),
                const SizedBox(height: AppSpacing.xl),
                const ComponentsCardsSection(),
                const SizedBox(height: AppSpacing.xl),
                const ComponentsCameraSection(),
              ],
            ),
          );
        },
      ),
    );
  }
}
