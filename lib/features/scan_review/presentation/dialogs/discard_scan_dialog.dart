import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Confirmation dialog for discarding an entire multi-page scan session.
class DiscardScanDialog extends StatelessWidget {
  const DiscardScanDialog({
    super.key,
    required this.pageCount,
    required this.onConfirmDiscard,
  });

  final int pageCount;
  final VoidCallback onConfirmDiscard;

  static Future<bool?> show(
    BuildContext context, {
    required int pageCount,
    required VoidCallback onConfirmDiscard,
  }) {
    return showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (BuildContext ctx) => DiscardScanDialog(
        pageCount: pageCount,
        onConfirmDiscard: onConfirmDiscard,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 310),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Red alert icon circle
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFFFEF2F2),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: Color(0xFFE5484D),
                  size: 24,
                ),
              ),
              const SizedBox(height: 16),

              // Title
              const Text(
                'Discard this scan?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E2340),
                  letterSpacing: -0.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),

              // Subtitle
              Text(
                'All $pageCount pages will be lost.',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF8A90A6),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Keep & Discard buttons
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 42,
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Keep',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 42,
                      child: ElevatedButton(
                        onPressed: () {
                          onConfirmDiscard();
                          Navigator.of(context).pop(true);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE5484D),
                          foregroundColor: Colors.white,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Discard',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

