import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/camera/crop_magnifier.dart';
import '../../../../core/widgets/camera/crop_overlay.dart';
import '../../../../core/widgets/mock/mock_document_page.dart';
import '../../domain/crop_quad.dart';
import '../../domain/scan_page.dart';

/// Canvas presenting the scanned document preview with interactive crop quad and magnifier loupe.
class AdjustCanvas extends StatefulWidget {
  const AdjustCanvas({
    super.key,
    required this.page,
    this.forceShowMagnifier = false,
    this.onCropChanged,
  });

  final ScanPage page;
  final bool forceShowMagnifier;
  final ValueChanged<CropQuad>? onCropChanged;

  @override
  State<AdjustCanvas> createState() => _AdjustCanvasState();
}

class _AdjustCanvasState extends State<AdjustCanvas> {
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final bool showLoupe = widget.forceShowMagnifier || _isDragging;
    final ColorFilter? filter = widget.page.filter.colorFilter;

    Widget pagePreview = MockDocumentPage(
      variant: widget.page.variant,
      showBorder: false,
    );

    if (filter != null) {
      pagePreview = ColorFiltered(
        colorFilter: filter,
        child: pagePreview,
      );
    }

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxHeight: 360, minHeight: 280),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF171B2F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.none,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: <Widget>[
          // Background desk gradient
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xFF1A1F36), Color(0xFF121526)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),

          // Tilted paper document representation
          Center(
            child: Transform.rotate(
              angle: -0.035, // ~ -2 degrees tilt
              child: SizedBox(
                width: 240,
                height: 290,
                child: RotatedBox(
                  quarterTurns: widget.page.rotationQuarterTurns,
                  child: pagePreview,
                ),
              ),
            ),
          ),

          // Crop overlay with 4 corner and midpoint handles
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CropOverlay(
                initialTopLeft: widget.page.crop.topLeft,
                initialTopRight: widget.page.crop.topRight,
                initialBottomRight: widget.page.crop.bottomRight,
                initialBottomLeft: widget.page.crop.bottomLeft,
                strokeColor: AppColors.cameraAccent,
                onDragStateChanged: (Offset pos, bool dragging) {
                  setState(() {
                    _isDragging = dragging;
                  });
                },
                onQuadChanged: (Offset tl, Offset tr, Offset br, Offset bl) {
                  widget.onCropChanged?.call(
                    CropQuad(
                      topLeft: tl,
                      topRight: tr,
                      bottomRight: br,
                      bottomLeft: bl,
                    ),
                  );
                },
              ),
            ),
          ),

          // Floating Magnifier Loupe above corner when dragging or forced
          if (showLoupe)
            Positioned(
              top: -40,
              right: 12,
              child: IgnorePointer(
                child: CropMagnifier(
                  size: 96,
                  strokeColor: AppColors.cameraAccent,
                  borderColor: Colors.white,
                  zoomText: '2.5×',
                ),
              ),
            ),
        ],
      ),
    );
  }
}
