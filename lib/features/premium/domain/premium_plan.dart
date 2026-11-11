/// The three subscription plans available in Doc Scanner Pro.
enum PremiumPlan {
  yearly,
  monthly,
  weekly;

  /// String identifier matching deep link / query parameters.
  String get id => name;

  /// Display title for the plan card.
  String get title {
    switch (this) {
      case PremiumPlan.yearly:
        return 'Yearly Access';
      case PremiumPlan.monthly:
        return 'Monthly Access';
      case PremiumPlan.weekly:
        return 'Weekly Access';
    }
  }

  /// Optional chip label next to title (e.g. '3-Day Trial').
  String? get trialChip {
    switch (this) {
      case PremiumPlan.yearly:
        return '3-Day Trial';
      case PremiumPlan.monthly:
      case PremiumPlan.weekly:
        return null;
    }
  }

  /// Optional badge overlapping top-right of the card.
  String? get badgeLabel {
    switch (this) {
      case PremiumPlan.yearly:
        return 'Best Value · Save 60%';
      case PremiumPlan.monthly:
      case PremiumPlan.weekly:
        return null;
    }
  }

  /// Feature description under the title.
  String get description {
    switch (this) {
      case PremiumPlan.yearly:
        return 'Includes 3-day free trial, then \$29.99/yr';
      case PremiumPlan.monthly:
        return 'Flexible billing, cancel anytime';
      case PremiumPlan.weekly:
        return 'Short-term priority scanning';
    }
  }

  /// Prominent price amount.
  String get price {
    switch (this) {
      case PremiumPlan.yearly:
        return '\$2.50';
      case PremiumPlan.monthly:
        return '\$6.99';
      case PremiumPlan.weekly:
        return '\$2.99';
    }
  }

  /// Inline period label appended to price (e.g. '/mo').
  String get periodLabel {
    switch (this) {
      case PremiumPlan.yearly:
        return '/mo';
      case PremiumPlan.monthly:
      case PremiumPlan.weekly:
        return '';
    }
  }

  /// Subtitle under the price.
  String get subtext {
    switch (this) {
      case PremiumPlan.yearly:
        return '\$29.99/yr';
      case PremiumPlan.monthly:
        return 'per month';
      case PremiumPlan.weekly:
        return 'per week';
    }
  }

  /// Derived main CTA button label for this plan.
  String get ctaLabel {
    switch (this) {
      case PremiumPlan.yearly:
        return 'Start 3-Day Free Trial';
      case PremiumPlan.monthly:
        return 'Subscribe Monthly';
      case PremiumPlan.weekly:
        return 'Subscribe Weekly';
    }
  }

  /// Derived fine print text displayed under the CTA button.
  String get finePrint {
    switch (this) {
      case PremiumPlan.yearly:
        return 'Free for 3 days, then \$29.99/year. Cancel anytime.';
      case PremiumPlan.monthly:
        return 'Billed \$6.99 every month. Cancel anytime.';
      case PremiumPlan.weekly:
        return 'Billed \$2.99 every week. Cancel anytime.';
    }
  }

  /// Parse from query parameter with fallback to yearly.
  static PremiumPlan fromString(String? value) {
    if (value == null) return PremiumPlan.yearly;
    switch (value.toLowerCase().trim()) {
      case 'monthly':
        return PremiumPlan.monthly;
      case 'weekly':
        return PremiumPlan.weekly;
      case 'yearly':
      default:
        return PremiumPlan.yearly;
    }
  }
}
