import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/mock_plans.dart';

/// 2-column checklist card displaying 8 premium features with green check icons.
class PremiumFeaturesCard extends StatelessWidget {
  const PremiumFeaturesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDCE9FF)),
      ),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < mockPremiumFeatures.length; i += 2) ...<Widget>[
            if (i > 0) const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: _FeatureItem(label: mockPremiumFeatures[i]),
                ),
                const SizedBox(width: 12),
                if (i + 1 < mockPremiumFeatures.length)
                  Expanded(
                    child: _FeatureItem(label: mockPremiumFeatures[i + 1]),
                  )
                else
                  const Spacer(),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Color(0xFF6CF8BB),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Symbols.check_rounded,
              color: Color(0xFF00714D),
              size: 14,
              weight: 700,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

