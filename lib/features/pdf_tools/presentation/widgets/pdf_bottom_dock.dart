import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';

/// 68px persistent bottom dock for PDF actions matching Frame 1.
class PdfBottomDock extends StatelessWidget {
  const PdfBottomDock({
    super.key,
    required this.onToolkitTap,
    required this.onToolTap,
  });

  final VoidCallback onToolkitTap;
  final ValueChanged<String> onToolTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(15, 23, 42, 0.06),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          // 1. PDF Toolkit (Special highlighted pill)
          Semantics(
            button: true,
            label: 'PDF Toolkit',
            child: Tooltip(
              message: 'PDF Toolkit',
              child: InkWell(
                onTap: onToolkitTap,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  constraints: const BoxConstraints(minWidth: 66),
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryTint,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Symbols.home_repair_service_rounded,
                        size: 20,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Toolkit',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),

          // 2. Share
          _DockItem(
            icon: Symbols.share_rounded,
            label: 'Share',
            onTap: () => onToolTap('Share'),
          ),

          // 3. Save
          _DockItem(
            icon: Symbols.download_rounded,
            label: 'Save',
            onTap: () => onToolTap('Save'),
          ),

          // 4. Watermark
          _DockItem(
            icon: Symbols.verified_rounded,
            label: 'Watermark',
            onTap: () => onToolTap('Watermark'),
          ),

          // 5. Compress
          _DockItem(
            icon: Symbols.compress_rounded,
            label: 'Compress',
            onTap: () => onToolTap('Compress'),
          ),

          // 6. Adjust
          _DockItem(
            icon: Symbols.tune_rounded,
            label: 'Adjust',
            onTap: () => onToolTap('Adjust'),
          ),

          // 7. Edit
          _DockItem(
            icon: Symbols.edit_rounded,
            label: 'Edit',
            onTap: () => onToolTap('Edit'),
          ),

          // 8. Open In
          _DockItem(
            icon: Symbols.open_in_new_rounded,
            label: 'Open In',
            onTap: () => onToolTap('Open In'),
          ),

          // 9. Print
          _DockItem(
            icon: Symbols.print_rounded,
            label: 'Print',
            onTap: () => onToolTap('Print'),
          ),
        ],
      ),
    );
  }
}

class _DockItem extends StatelessWidget {
  const _DockItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: Tooltip(
        message: label,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            constraints: const BoxConstraints(minWidth: 58),
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, size: 20, color: AppColors.textMuted),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
