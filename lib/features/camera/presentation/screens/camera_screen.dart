import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/camera/camera_top_bar.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../application/book_scan_type_provider.dart';
import '../../application/camera_mode.dart';
import '../../application/camera_mode_provider.dart';
import '../../application/camera_settings_provider.dart';
import '../../application/flash_mode.dart';
import '../../application/flash_provider.dart';
import '../../application/id_scan_sides.dart';
import '../../application/id_scan_sides_provider.dart';
import '../../application/photo_size_provider.dart';
import '../dialogs/book_mode_dialog.dart';
import '../dialogs/id_card_mode_dialog.dart';
import '../dialogs/ocr_mode_dialog.dart';
import '../dialogs/photo_size_dialog.dart';
import '../sheets/scan_quality_sheet.dart';
import '../widgets/camera_bottom_controls.dart';
import '../widgets/camera_settings_panel.dart';
import '../widgets/camera_viewfinder.dart';

/// Fullscreen dark camera screen supporting multiple scan modes, live overlays, and settings.
class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({
    super.key,
    this.initialMode,
    this.initialPanel,
    this.initialDialog,
    this.initialFlash,
  });

  final String? initialMode;
  final String? initialPanel;
  final String? initialDialog;
  final String? initialFlash;

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen> {
  bool _idCardFlipped = false;
  bool _isSettingsOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _applyInitialParams();
    });
  }

  void _applyInitialParams() {
    if (widget.initialMode != null) {
      final mode = CameraMode.values.firstWhere(
        (m) => m.name.toLowerCase() == widget.initialMode!.toLowerCase(),
        orElse: () => CameraMode.document,
      );
      ref.read(cameraModeProvider.notifier).setMode(mode);
    }
    if (widget.initialFlash != null) {
      final f = widget.initialFlash!.toLowerCase();
      if (f == 'auto') {
        ref.read(flashModeProvider.notifier).setMode(FlashMode.auto);
      } else if (f == 'on') {
        ref.read(flashModeProvider.notifier).setMode(FlashMode.on);
      } else if (f == 'off') {
        ref.read(flashModeProvider.notifier).setMode(FlashMode.off);
      }
    }
    if (widget.initialPanel == 'settings') {
      setState(() => _isSettingsOpen = true);
    } else if (widget.initialPanel == 'quality') {
      ScanQualitySheet.show(
        context,
        initialQuality: ref.read(cameraSettingsProvider).scanQuality,
        onSelected: ref.read(cameraSettingsProvider.notifier).setScanQuality,
      );
    }
    if (widget.initialDialog != null) {
      final d = widget.initialDialog!.toLowerCase();
      if (d == 'idcard' || d == 'id_card') {
        _openDialogForMode(CameraMode.idCard);
      } else if (d == 'book') {
        _openDialogForMode(CameraMode.book);
      } else if (d == 'photo') {
        _openDialogForMode(CameraMode.photo);
      } else if (d == 'ocr' || d == 'ocrtext' || d == 'ocr_text') {
        _openDialogForMode(CameraMode.ocrText);
      }
    }
  }

  void _openDialogForMode(CameraMode mode) {
    switch (mode) {
      case CameraMode.idCard:
        IdCardModeDialog.show(
          context,
          currentSides: ref.read(idScanSidesProvider),
          onSelected: ref.read(idScanSidesProvider.notifier).setSides,
        );
        break;
      case CameraMode.book:
        BookModeDialog.show(
          context,
          currentType: ref.read(bookScanTypeProvider),
          onSelected: ref.read(bookScanTypeProvider.notifier).setType,
        );
        break;
      case CameraMode.photo:
        final photoState = ref.read(photoSizeProvider);
        PhotoSizeDialog.show(
          context,
          initialSelectedSize: photoState.selectedSize,
          initialSizes: photoState.sizes,
          onSizeSelected: ref.read(photoSizeProvider.notifier).selectSize,
          onSizesUpdated: ref.read(photoSizeProvider.notifier).setSizes,
        );
        break;
      case CameraMode.ocrText:
        OcrModeDialog.show(context);
        break;
      default:
        break;
    }
  }

  void _onModeSelected(CameraMode mode) {
    ref.read(cameraModeProvider.notifier).setMode(mode);
    setState(() => _idCardFlipped = false);
    _openDialogForMode(mode);
  }

  void _onShutterTap() {
    final mode = ref.read(cameraModeProvider);
    final idSides = ref.read(idScanSidesProvider);

    if (mode == CameraMode.idCard &&
        idSides == IdScanSides.both &&
        !_idCardFlipped) {
      setState(() => _idCardFlipped = true);
      return;
    }

    // Navigate to Adjust screen
    context.push(AppRoutes.adjust);
  }

  CameraFlashMode _mapFlashMode(FlashMode mode) {
    switch (mode) {
      case FlashMode.off:
        return CameraFlashMode.off;
      case FlashMode.on:
        return CameraFlashMode.on;
      case FlashMode.auto:
        return CameraFlashMode.auto;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mode = ref.watch(cameraModeProvider);
    final flash = ref.watch(flashModeProvider);
    final settings = ref.watch(cameraSettingsProvider);
    final bookScanType = ref.watch(bookScanTypeProvider);
    final idScanSides = ref.watch(idScanSidesProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Theme(
        data: AppTheme.camera,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              // 1. Viewfinder Layer
              CameraViewfinder(
                mode: mode,
                gridEnabled: settings.gridEnabled,
                spiritLevel: settings.spiritLevel,
                bookScanType: bookScanType,
                idScanSides: idScanSides,
                idCardFlipped: _idCardFlipped,
              ),

              // 2. Top Bar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CameraTopBar(
                  flashMode: _mapFlashMode(flash),
                  isGridEnabled: settings.gridEnabled,
                  isSettingsOpen: _isSettingsOpen,
                  onBack: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(AppRoutes.home);
                    }
                  },
                  onFlashCycle: () {
                    ref.read(flashModeProvider.notifier).cycle();
                  },
                  onGridToggle: () {
                    ref.read(cameraSettingsProvider.notifier).toggleGrid();
                  },
                  onFlipCamera: () {
                    showAppSnackbar(
                      context: context,
                      message:
                          'Camera switch is not available in the UI preview',
                    );
                  },
                  onSettingsTap: () {
                    setState(() => _isSettingsOpen = !_isSettingsOpen);
                  },
                ),
              ),

              // 3. Bottom Controls Layer
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CameraBottomControls(
                  selectedMode: mode,
                  onModeSelected: _onModeSelected,
                  onShutterTap: _onShutterTap,
                  onGalleryTap: () {
                    showAppSnackbar(
                      context: context,
                      message: 'Gallery import is coming later',
                    );
                  },
                  onOptionsTap: () {
                    showAppSnackbar(
                      context: context,
                      message: '${mode.label} options are coming later',
                    );
                  },
                ),
              ),

              // 4. Settings Panel Overlay
              if (_isSettingsOpen)
                Positioned(
                  top: 56 + MediaQuery.paddingOf(context).top,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CameraSettingsPanel(
                    onClose: () => setState(() => _isSettingsOpen = false),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
