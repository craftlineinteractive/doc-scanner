import '../domain/premium_plan.dart';

/// Available subscription plans in display order.
const List<PremiumPlan> mockPremiumPlans = <PremiumPlan>[
  PremiumPlan.yearly,
  PremiumPlan.monthly,
  PremiumPlan.weekly,
];

/// 8 Premium features highlighted in the paywall 2-column checklist.
const List<String> mockPremiumFeatures = <String>[
  'No ads',
  'Unlimited OCR',
  'All OCR languages',
  'Cloud backup',
  'Advanced filters',
  'Batch export',
  'Password PDF',
  'Premium themes',
];
