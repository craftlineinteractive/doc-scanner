import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/mock/mock_document_page.dart';
import '../../application/scan_session_provider.dart';
import '../../domain/scan_page.dart';

/// Screen displaying a 2-column reorderable grid of scanned pages for resequencing.
class ArrangePagesScreen extends ConsumerWidget {
  const ArrangePagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(scanSessionProvider);

    return Theme(
      data: AppTheme.light,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6FA),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              // Top Bar
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: Color(0xFFE2E5EE))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: Color(0xFF1E2340)),
                      onPressed: () => context.pop(),
                    ),
                    const Text(
                      'Arrange pages',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E2340),
                        letterSpacing: -0.2,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.pop(),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Instruction Hint Banner
              Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: Color(0xFFEEF0FF),
                  border: Border(bottom: BorderSide(color: Color(0xFFD8DEFE))),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.touch_app_outlined,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Long press, then drag to reorder',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1E2340),
                      ),
                    ),
                  ],
                ),
              ),

              // 2-Column Grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: session.pageCount,
                  itemBuilder: (context, index) {
                    final page = session.pages[index];

                    return DragTarget<int>(
                      onAcceptWithDetails: (details) {
                        final fromIndex = details.data;
                        if (fromIndex != index) {
                          ref
                              .read(scanSessionProvider.notifier)
                              .movePage(fromIndex, index);
                        }
                      },
                      builder: (context, candidateData, rejectedData) {
                        final bool isTarget = candidateData.isNotEmpty;

                        return LongPressDraggable<int>(
                          data: index,
                          feedback: Material(
                            elevation: 12,
                            borderRadius: BorderRadius.circular(12),
                            child: Transform.rotate(
                              angle: 0.035, // ~ 2 degrees tilt
                              child: Transform.scale(
                                scale: 1.05,
                                child: Container(
                                  width: 160,
                                  height: 205,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.primary,
                                      width: 2,
                                    ),
                                  ),
                                  child: _ArrangeThumbnailCard(
                                    page: page,
                                    pageNumber: index + 1,
                                    isActive: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          childWhenDragging: Opacity(
                            opacity: 0.3,
                            child: _ArrangeThumbnailCard(
                              page: page,
                              pageNumber: index + 1,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: isTarget
                                  ? Border.all(
                                      color: AppColors.primary,
                                      width: 2,
                                    )
                                  : null,
                            ),
                            child: _ArrangeThumbnailCard(
                              page: page,
                              pageNumber: index + 1,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArrangeThumbnailCard extends StatelessWidget {
  const _ArrangeThumbnailCard({
    required this.page,
    required this.pageNumber,
    this.isActive = false,
  });

  final ScanPage page;
  final int pageNumber;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    Widget document = MockDocumentPage(
      variant: page.variant,
      showBorder: false,
    );

    final matrix = page.filter.colorFilter;
    if (matrix != null) {
      document = ColorFiltered(colorFilter: matrix, child: document);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? AppColors.primary : const Color(0xFFE2E5EE),
          width: isActive ? 2 : 1,
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x121E2340),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          // Page preview
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: RotatedBox(
                quarterTurns: page.rotationQuarterTurns,
                child: document,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Number badge
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : const Color(0xFF1E2340),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$pageNumber',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

