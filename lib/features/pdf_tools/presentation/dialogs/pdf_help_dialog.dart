import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';

/// Contextual Help Modal explaining key PDF tool operations matching Frame 4.
class PdfHelpDialog extends StatelessWidget {
  const PdfHelpDialog({
    super.key,
    required this.onGotIt,
  });

  final VoidCallback onGotIt;

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onGotIt,
  }) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) => PdfHelpDialog(
        onGotIt: () {
          Navigator.of(context).pop();
          onGotIt();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 680),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Top Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primaryTint,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Symbols.help_center_rounded,
                  size: 30,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),

              // Title & Subtitle
              const Text(
                'How to Use PDF Tools',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              const Text(
                'Master key operations in your Doc Scanner mobile suite',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // 5 Guide Items
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: const <Widget>[
                    _HelpItem(
                      number: '1',
                      title: 'View & Navigate',
                      desc:
                          'Swipe pages smoothly or pinch with two fingers to zoom up to 400%.',
                    ),
                    _HelpItem(
                      number: '2',
                      title: 'PDF Toolkit Hub',
                      desc:
                          'Tap ‘Toolkit’ on the bottom dock to merge multiple PDFs, extract pages, or reorder sheets.',
                    ),
                    _HelpItem(
                      number: '3',
                      title: 'Convert & Export',
                      desc:
                          'Transform PDFs to high-res PNGs or raw OCR text, or package entire books into ZIP files.',
                    ),
                    _HelpItem(
                      number: '4',
                      title: 'Search in Document',
                      desc:
                          'Tap the magnifying glass on top to highlight text occurrences with forward/backward jumps.',
                    ),
                    _HelpItem(
                      number: '5',
                      title: '256-Bit Encryption',
                      desc:
                          'Protect proprietary contracts by tapping ‘Add Password’ before distributing externally.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Full-width primary CTA
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onGotIt,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Got It, Let’s Start',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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

class _HelpItem extends StatelessWidget {
  const _HelpItem({
    required this.number,
    required this.title,
    required this.desc,
  });

  final String number;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 22,
            height: 22,
            margin: const EdgeInsets.only(top: 2),
            decoration: const BoxDecoration(
              color: AppColors.canvas,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 11,
                    height: 1.4,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

