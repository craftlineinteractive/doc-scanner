import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/premium_plan.dart';

/// State notifier managing the currently selected subscription plan.
class PremiumPlanNotifier extends Notifier<PremiumPlan> {
  @override
  PremiumPlan build() => PremiumPlan.yearly;

  /// Select a plan by enum value.
  void selectPlan(PremiumPlan plan) {
    state = plan;
  }
}

/// Provider for the active subscription plan on the paywall screen.
final NotifierProvider<PremiumPlanNotifier, PremiumPlan> premiumPlanProvider =
    NotifierProvider<PremiumPlanNotifier, PremiumPlan>(PremiumPlanNotifier.new);
