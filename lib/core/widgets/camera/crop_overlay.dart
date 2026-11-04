import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'crop_quadrilateral_painter.dart';

/// Quadrilateral document boundary adjustment overlay with 4 draggable corner and 4 midpoint handles.
class CropOverlay extends StatefulWidget {
  const CropOverlay({
    super.key,
    this.initialTopLeft = const Offset(0.12, 0.15),
    this.initialTopRight = const Offset(0.88, 0.12),
    this.initialBottomRight = const Offset(0.85, 0.85),
    this.initialBottomLeft = const Offset(0.15, 0.88),
    this.strokeColor = AppColors.cameraAccent,
    this.handleColor = Colors.white,
    this.onDragStateChanged,
  });

  final Offset initialTopLeft;
  final Offset initialTopRight;
  final Offset initialBottomRight;
  final Offset initialBottomLeft;
  final Color strokeColor;
  final Color handleColor;
  final void Function(Offset position, bool isDragging)? onDragStateChanged;

  @override
  State<CropOverlay> createState() => _CropOverlayState();
}

class _CropOverlayState extends State<CropOverlay> {
  late Offset _tl;
  late Offset _tr;
  late Offset _br;
  late Offset _bl;

  int? _activeHandleIndex;

  @override
  void initState() {
    super.initState();
    _tl = widget.initialTopLeft;
    _tr = widget.initialTopRight;
    _br = widget.initialBottomRight;
    _bl = widget.initialBottomLeft;
  }

  void _onPanUpdate(DragUpdateDetails details, Size size) {
    if (_activeHandleIndex == null) return;

    final double nx = (details.localPosition.dx / size.width).clamp(0.05, 0.95);
    final double ny =
        (details.localPosition.dy / size.height).clamp(0.05, 0.95);
    final Offset updated = Offset(nx, ny);

    setState(() {
      switch (_activeHandleIndex) {
        case 0:
          _tl = updated;
          break;
        case 1:
          _tr = updated;
          break;
        case 2:
          _br = updated;
          break;
        case 3:
          _bl = updated;
          break;
      }
    });

    widget.onDragStateChanged?.call(details.localPosition, true);
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() => _activeHandleIndex = null);
    widget.onDragStateChanged?.call(Offset.zero, false);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size size = Size(constraints.maxWidth, constraints.maxHeight);

        final Offset p0 = Offset(_tl.dx * size.width, _tl.dy * size.height);
        final Offset p1 = Offset(_tr.dx * size.width, _tr.dy * size.height);
        final Offset p2 = Offset(_br.dx * size.width, _br.dy * size.height);
        final Offset p3 = Offset(_bl.dx * size.width, _bl.dy * size.height);

        return GestureDetector(
          onPanStart: (details) {
            final Offset pos = details.localPosition;
            final List<Offset> points = <Offset>[p0, p1, p2, p3];

            int closest = 0;
            double minDist = double.infinity;
            for (int i = 0; i < points.length; i++) {
              final double dist = (points[i] - pos).distance;
              if (dist < minDist) {
                minDist = dist;
                closest = i;
              }
            }

            if (minDist < 48) {
              setState(() => _activeHandleIndex = closest);
              widget.onDragStateChanged?.call(pos, true);
            }
          },
          onPanUpdate: (details) => _onPanUpdate(details, size),
          onPanEnd: _onPanEnd,
          child: CustomPaint(
            size: size,
            painter: CropQuadrilateralPainter(
              points: <Offset>[p0, p1, p2, p3],
              strokeColor: widget.strokeColor,
              handleColor: widget.handleColor,
              activeIndex: _activeHandleIndex,
            ),
          ),
        );
      },
    );
  }
}
