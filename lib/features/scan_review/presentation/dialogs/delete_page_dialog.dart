import 'package:flutter/material.dart';

/// Confirmation dialog for deleting an individual page from the active scan session.
class DeletePageDialog extends StatelessWidget {
  const DeletePageDialog({
    super.key,
    required this.pageNumber,
    required this.onConfirmDelete,
  });

  final int pageNumber;
  final VoidCallback onConfirmDelete;

  static Future<bool?> show(
    BuildContext context, {
    required int pageNumber,
    required VoidCallback onConfirmDelete,
  }) {
    return showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (BuildContext ctx) => DeletePageDialog(
        pageNumber: pageNumber,
        onConfirmDelete: onConfirmDelete,
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
              // Red trash icon circle
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFFFEF2F2),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: Color(0xFFE5484D),
                  size: 24,
                ),
              ),
              const SizedBox(height: 16),

              // Title
              const Text(
                'Delete this page?',
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
                'Page $pageNumber will be removed from this scan.',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF8A90A6),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Cancel & Delete buttons
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 42,
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF8A90A6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
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
                          onConfirmDelete();
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
                          'Delete',
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
