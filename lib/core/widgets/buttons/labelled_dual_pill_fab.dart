import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../constants/app_durations.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_shadows.dart';

/// Floating dual action capsule (56px high) with text labels: "Scan Page" and "Import".
class LabelledDualPillFab extends StatefulWidget {
  const LabelledDualPillFab({
    super.key,
    required this.onScanPageTap,
    required this.onImportTap,
    this.scanLabel = 'Scan Page',
    this.importLabel = 'Import',
  });

  final VoidCallback onScanPageTap;
  final VoidCallback onImportTap;
  final String scanLabel;
  final String importLabel;

  @override
  State<LabelledDualPillFab> createState() => _LabelledDualPillFabState();
}

class _LabelledDualPillFabState extends State<LabelledDualPillFab> {
  bool _isPressedScan = false;
  bool _isPressedImport = false;

  @override
  Widget build(BuildContext context) {
    final bool isAnyPressed = _isPressedScan || _isPressedImport;

    return AnimatedScale(
      scale: isAnyPressed ? 0.96 : 1.0,
      duration: AppDurations.fast,
      curve: Curves.easeOutCubic,
      child: Container(
        height: 56,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: AppRadii.roundedPill,
          boxShadow: AppShadows.level3,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: AppRadii.roundedPill,
          clipBehavior: Clip.antiAlias,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Left: Scan Page
              Semantics(
                button: true,
                label: widget.scanLabel,
                child: InkWell(
                  onTapDown: (_) => setState(() => _isPressedScan = true),
                  onTapUp: (_) => setState(() => _isPressedScan = false),
                  onTapCancel: () => setState(() => _isPressedScan = false),
                  onTap: widget.onScanPageTap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(
                          Symbols.photo_camera_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            widget.scanLabel,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Vertical Divider
              Container(
                width: 1,
                height: 24,
                color: Colors.white.withValues(alpha: 0.25),
              ),

              // Right: Import
              Semantics(
                button: true,
                label: widget.importLabel,
                child: InkWell(
                  onTapDown: (_) => setState(() => _isPressedImport = true),
                  onTapUp: (_) => setState(() => _isPressedImport = false),
                  onTapCancel: () => setState(() => _isPressedImport = false),
                  onTap: widget.onImportTap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(
                          Symbols.add_photo_alternate_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            widget.importLabel,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
