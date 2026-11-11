import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../app/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../application/ocr_providers.dart';
import '../widgets/ocr_content_card.dart';
import '../widgets/ocr_summary_card.dart';

/// Extracted OCR text view with editing and copy/share capabilities matching Frame 11.
class OcrResultScreen extends ConsumerStatefulWidget {
  const OcrResultScreen({super.key, this.initialState = 'default'});

  final String initialState;

  @override
  ConsumerState<OcrResultScreen> createState() => _OcrResultScreenState();
}

class _OcrResultScreenState extends ConsumerState<OcrResultScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialState == 'editing') {
        ref.read(ocrProvider.notifier).setEditing(true);
      } else if (widget.initialState == 'preview') {
        ref.read(ocrProvider.notifier).setOriginalPreviewOpen(true);
      }
    });
  }

  void _copyToClipboard() {
    showAppSnackbar(context: context, message: 'Copied to Clipboard!');
  }

  @override
  Widget build(BuildContext context) {
    final OcrState state = ref.watch(ocrProvider);

    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Symbols.arrow_back_rounded,
            color: AppColors.textPrimary,
          ),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go(AppRoutes.home),
        ),
        centerTitle: true,
        title: const Text(
          'Extracted Text',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Symbols.content_copy_rounded,
              color: AppColors.primary,
              size: 20,
            ),
            onPressed: _copyToClipboard,
            tooltip: 'Copy text',
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Main content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    OcrSummaryCard(
                      result: state.result,
                      isExpanded: state.originalPreviewOpen,
                      onToggleExpand: () {
                        ref.read(ocrProvider.notifier).toggleOriginalPreview();
                      },
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: OcrContentCard(
                        text: state.result.text,
                        isEditing: state.isEditing,
                        onToggleEdit: () {
                          ref.read(ocrProvider.notifier).toggleEditing();
                        },
                        onSaveText: (String newText) {
                          ref.read(ocrProvider.notifier).updateText(newText);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Fixed Bottom Action Bar
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.hairline)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color.fromRGBO(15, 23, 42, 0.04),
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: <Widget>[
                  // Copy (Outlined Indigo)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _copyToClipboard,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.primary),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Symbols.content_copy_rounded, size: 16),
                      label: const Text(
                        'Copy',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Share (Filled Indigo)
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showAppSnackbar(
                          context: context,
                          message: 'Share is coming later',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Symbols.share_rounded, size: 16),
                      label: const Text(
                        'Share',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
