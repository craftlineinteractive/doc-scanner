import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/dialogs/confirm_dialog.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../../../core/widgets/navigation/back_title_bar.dart';
import '../../application/settings_provider.dart';
import '../../domain/app_settings.dart';
import '../dialogs/date_format_dialog.dart';
import '../dialogs/recent_count_dialog.dart';
import '../dialogs/scan_quality_dialog.dart';
import '../dialogs/theme_select_dialog.dart';
import '../widgets/app_about_sections.dart';
import '../widgets/backup_appearance_sections.dart';
import '../widgets/document_camera_sections.dart';

/// Screen displaying and modifying Doc Scanner settings.
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({
    super.key,
    this.initialScroll,
    this.initialDialog,
    this.showHintOnStart = false,
  });

  final String? initialScroll;
  final String? initialDialog;
  final bool showHintOnStart;

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _handleInitialState();
    });
  }

  @override
  void didUpdateWidget(SettingsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showHintOnStart && !oldWidget.showHintOnStart) {
      _showHintToast();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleInitialState() async {
    if (widget.initialScroll == 'middle') {
      _scrollController.animateTo(
        420,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else if (widget.initialScroll == 'bottom') {
      _scrollController.animateTo(
        1800,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }

    if (widget.showHintOnStart) {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      if (mounted) _showHintToast();
    }

    switch (widget.initialDialog) {
      case 'theme':
        _showThemeDialog();
      case 'quality':
        _showQualityDialog();
      case 'count':
        _showCountDialog();
      case 'format':
        _showFormatDialog();
      case 'reset':
        _showResetDialog();
    }
  }

  void _showHintToast() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Symbols.info_rounded,
              color: Color(0xFFA5B4FC),
              size: 16,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                'Turn on Tags to use Favourite Documents',
                style: AppTypography.bodySm.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xE61E2340),
        shape: const StadiumBorder(),
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }

  Future<void> _showThemeDialog() async {
    final AppSettings settings = ref.read(settingsProvider);
    final ThemeChoice? choice = await ThemeSelectDialog.show(
      context,
      settings.themeChoice,
    );
    if (choice != null) {
      ref.read(settingsProvider.notifier).setThemeChoice(choice);
    }
  }

  Future<void> _showQualityDialog() async {
    final AppSettings settings = ref.read(settingsProvider);
    final SettingsScanQuality? quality = await ScanQualityDialog.show(
      context,
      settings.scanQuality,
    );
    if (quality != null) {
      ref.read(settingsProvider.notifier).setScanQuality(quality);
    }
  }

  Future<void> _showCountDialog() async {
    final AppSettings settings = ref.read(settingsProvider);
    final int? count = await RecentCountDialog.show(
      context,
      settings.recentOnHomeCount,
    );
    if (count != null) {
      ref.read(settingsProvider.notifier).setRecentOnHomeCount(count);
    }
  }

  Future<void> _showFormatDialog() async {
    final AppSettings settings = ref.read(settingsProvider);
    final SettingsDateTimeFormat? format = await DateFormatDialog.show(
      context,
      settings.dateTimeFormat,
    );
    if (format != null) {
      ref.read(settingsProvider.notifier).setDateTimeFormat(format);
    }
  }

  Future<void> _showResetDialog() async {
    final bool? confirmed = await ConfirmDialog.show(
      context: context,
      title: 'Reset all settings?',
      message: 'Your documents will not be deleted.',
      confirmLabel: 'Reset',
      cancelLabel: 'Cancel',
      isDestructive: true,
    );
    if (confirmed == true) {
      ref.read(settingsProvider.notifier).resetSettings();
      if (mounted) {
        showAppSnackbar(
          context: context,
          message: 'Settings reset',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackTitleBar(
        title: 'Settings',
      ),
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        children: <Widget>[
          BackupAppearanceSections(
            onShowHintToast: _showHintToast,
          ),
          const DocumentCameraSections(),
          const AppAboutSections(),
        ],
      ),
    );
  }
}
