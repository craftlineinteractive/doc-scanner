import 'package:flutter/material.dart';

/// Top bar for Review Scan screen with back button, editable document title, and rename trigger.
class ReviewTopBar extends StatelessWidget {
  const ReviewTopBar({
    super.key,
    required this.docName,
    required this.onBack,
    required this.onRename,
  });

  final String docName;
  final VoidCallback onBack;
  final VoidCallback onRename;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFE2E5EE).withValues(alpha: 0.6),
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: onBack,
            borderRadius: BorderRadius.circular(20),
            child: const SizedBox(
              width: 36,
              height: 36,
              child: Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFF1E2340),
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: InkWell(
              onTap: onRename,
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        docName,
                        style: const TextStyle(
                          color: Color(0xFF1E2340),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.edit_outlined,
                      size: 14,
                      color: Color(0xFF8A90A6),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

