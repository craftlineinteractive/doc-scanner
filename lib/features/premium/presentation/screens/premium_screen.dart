import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../app/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../application/premium_provider.dart';
import '../../data/mock_plans.dart';
import '../../domain/premium_plan.dart';
import '../widgets/premium_features_card.dart';
import '../widgets/premium_hero_medallion.dart';
import '../widgets/premium_plan_card.dart';

/// Premium Paywall Screen matching mockup 10_premium/01_premium_paywall.
class PremiumScreen extends ConsumerStatefulWidget {
  const PremiumScreen({
    super.key,
    this.initialPlan = 'yearly',
  });

  /// Optional initial plan name ('yearly', 'monthly', 'weekly').
  final String? initialPlan;

  @override
  ConsumerState<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends ConsumerState<PremiumScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.initialPlan != null) {
      final PremiumPlan plan = PremiumPlan.fromString(widget.initialPlan);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(premiumPlanProvider.notifier).selectPlan(plan);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final PremiumPlan activePlan = ref.watch(premiumPlanProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: SafeArea(
          bottom: false,
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              color: Color(0xFFF8F9FF),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0x0A000000),
                  offset: Offset(0, 1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Close button
                IconButton(
                  tooltip: 'Close paywall',
                  icon: const Icon(
                    Symbols.close_rounded,
                    size: 24,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(AppRoutes.home);
                    }
                  },
                ),

                // Center title
                const Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Symbols.workspace_premium_rounded,
                        size: 20,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'Premium Paywall',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                // Trailing profile avatar
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Symbols.person_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Hero Medallion
              const PremiumHeroMedallion(),
              const SizedBox(height: 16),

              // Feature Checklist Card
              const PremiumFeaturesCard(),
              const SizedBox(height: 18),

              // Plan selection list
              for (int i = 0; i < mockPremiumPlans.length; i++) ...<Widget>[
                if (i > 0) const SizedBox(height: 10),
                PremiumPlanCard(
                  plan: mockPremiumPlans[i],
                  isSelected: activePlan == mockPremiumPlans[i],
                  onTap: () => ref
                      .read(premiumPlanProvider.notifier)
                      .selectPlan(mockPremiumPlans[i]),
                ),
              ],
              const SizedBox(height: 20),

              // CTA Button
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () => showAppSnackbar(
                    context: context,
                    message: 'Purchases are coming later',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          activePlan.ctaLabel,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Symbols.arrow_forward_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Subtext Fine Print
              Text(
                activePlan.finePrint,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Restore Purchase Button
              Center(
                child: TextButton(
                  onPressed: () => showAppSnackbar(
                    context: context,
                    message: 'Purchases are coming later',
                  ),
                  child: const Text(
                    'Restore Purchase',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),

              // Terms & Privacy Links
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 6,
                runSpacing: 4,
                children: <Widget>[
                  InkWell(
                    onTap: () => showAppSnackbar(
                      context: context,
                      message: 'Terms of Service is coming later',
                    ),
                    child: const Text(
                      'Terms of Service',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  const Text(
                    '•',
                    style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                  ),
                  InkWell(
                    onTap: () => showAppSnackbar(
                      context: context,
                      message: 'Privacy Policy is coming later',
                    ),
                    child: const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

